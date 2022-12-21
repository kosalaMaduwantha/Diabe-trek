import datetime
import json

from json import JSONEncoder

import numpy
from flask import Flask, jsonify, request
from keras.models import load_model
from keras.utils.generic_utils import CustomObjectScope

from mongoDB.db_connection import db_connection, close_connection
from modelDefinitions.fcn_model import fcn_vgg16_16s
from imageProcessing.data_generator import DataGenerator
from imageProcessing.calculate_wound_area import calculate_area
from imageProcessing.bilinear_upsampling import BiLinearUpSampling
from imageProcessing.bilinear_upsampling_2d import BiLinearUpSampling2D
from imageProcessing.functions_for_pre_processing import dice_coefficient_fcn
from wound_severity_detection.severity_detection import infection_ischaemia, wound_score, wound_stage, \
    healing_prediction

# Initializing the Flask application  ----------------------------------------------------------------------------------
app = Flask(__name__)


# Methods to connect with MongoDB Collection ---------------------------------------------------------------------------

# This method will READ all the wound data in the MongoDB collection --------------------------------------------
@app.route('/get_wound_history/')
def get_wound_history():
    __conn = db_connection()  # New connection object

    all_wound_data = __conn.find()  # Fetch all the wound data entries

    close_connection()

    return jsonify([wound for wound in all_wound_data])


# This method will READ the recent wound data entry in the MongoDB collection -----------------------------------
def get_recent_wound_data():
    __conn = db_connection()  # New connection object

    wound_data = __conn.find().sort([('timestamp', -1)]).limit(1)  # Fetch the recent wound data entry

    close_connection()

    return wound_data


# This method will WRITE the wound data to the MongoDB collection -----------------------------------------------
def add_image(file, img_state, area, img_score, img_stage):
    __conn = db_connection()  # New connection object

    time = datetime.datetime.now().timestamp()  # Get the timestamp

    # Insert this record to the collection
    __conn.insert_one(
        {'file': file, 'state': img_state, 'area': area, 'score': img_score, 'stage': img_stage, 'timestamp': time}
    )

    close_connection()


# ----------------------------------------------------------------------------------------------------------------------


# Methods to process images --------------------------------------------------------------------------------------------

# This method can load the FCN model ----------------------------------------------------------------------------
def load_segmentation_model():
    input_dim_x = 224
    input_dim_y = 224

    model_fcn, model_name_fcn = fcn_vgg16_16s(
        input_shape=(input_dim_x, input_dim_y, 3))  # load the trained FCN model definition

    with CustomObjectScope({'BilinearUpSampling2D': BiLinearUpSampling2D}):
        model_fcn = load_model('trainedModels/segmentation_model.hdf5',
                               custom_objects={'dice_coef': dice_coefficient_fcn,
                                               'BilinearUpsampling': BiLinearUpSampling})

    return model_fcn


# This method can load the CNN model ----------------------------------------------------------------------------
def load_classification_model():
    model_cnn = load_model('./trainedModels/classification_model.hdf5')

    return model_cnn


# This method can identify the wound area of an image -----------------------------------------------------------
def identify_wound_area(image):
    new_data_generator = DataGenerator()  # Create new DataGenerator object

    image_data = new_data_generator.generate_data(image)

    model = load_segmentation_model()

    wound_area_img = model.predict(image_data)

    return wound_area_img


# This method can identify infection or ischaemic conditions in a wound -----------------------------------------
def identify_ischaemia_infection(image):
    new_data_generator = DataGenerator()  # Create new DataGenerator object

    image_data = new_data_generator.generate_data(image)

    model = load_classification_model()

    classification = model.predict(image_data)

    return classification


# This function is to encode a numpy array to json --------------------------------------------------------------
class NumpyArrayEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, numpy.ndarray):
            return obj.tolist()
        return JSONEncoder.default(self, obj)


# This method can analyze the wound -----------------------------------------------------------------------------
@app.route('/get_wound_state/', methods=['POST'])
def get_wound_state():
    img_file = request.files['image']

    segmentation_data = identify_wound_area(img_file)

    classification_data = identify_ischaemia_infection(img_file)

    area_of_the_wound = calculate_area(segmentation_data[0] * 255.)

    conditions = infection_ischaemia(classification_data)

    infection, ischaemia = 0, 0

    if conditions is 'infection':
        infection = 1
    elif conditions is 'ischaemia':
        ischaemia = 1
    elif conditions is 'both':
        infection, ischaemia = 1, 1

    last_entry = get_recent_wound_data()
    last_record = json.load(last_entry)

    stage = wound_stage(ischaemia, infection)
    score = wound_score(ischaemia, infection, area_of_the_wound, last_record['area'])

    state = healing_prediction(last_record['stage'], stage, last_record['score'], score, last_record['state'])

    segmented_image = {'segmented_img_array': segmentation_data[0] * 255.}
    encoded_json_img = json.dumps(segmented_image, cls=NumpyArrayEncoder)

    return {'segmented image': encoded_json_img, 'state': state, 'stage': stage, 'score': score}


# Main method ----------------------------------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
