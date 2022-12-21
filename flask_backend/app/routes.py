## importing libraries
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import LabelEncoder#for train test splitting
from sklearn.model_selection import train_test_split#for decision tree object
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.metrics import classification_report, confusion_matrix#for visualizing tree 
from sklearn.tree import plot_tree,DecisionTreeClassifier
# importing flask
from flask import Flask, jsonify, request, Response, send_file
# importing pickle
import pickle
# importing the pre processing module
from get_the_rec import recomendation
# import image processing library
from PIL import Image
import jsonpickle
from models.activity_pools import selecting_pool
from models.result import Selecting_Results
import os


print(os.getcwd())


## initialiing the Flask application
## comment 001
app = Flask(__name__)

# -----------------------------------------------------------------------------------------------------------

# get the pickl model object
# Load the pickled model
#pickled_model = pickle.load(open('models/model.pkl', 'rb'))
# pickled_model_j = pickle.load(open('models/model_risk.pkl', 'rb'))
# pickled_model_h = pickle.load(open('models/model_dpn.pkl', 'rb'))
pickled_model_i = pickle.load(open('models/model_dpn.pkl', 'rb'))


# test the prediction
# person_01 = [50,0,45,132,65,150,100,0,0,0,0,0]
# arr = np.array(person_01)
# arr = arr.reshape(1,12)
# prediction = pickled_model.predict(arr)
# print(str(prediction[0]))


# @app.route('/get_prediction/', methods=['GET'])
# def get_static_prediction():
#     person_01 = [50,0,45,132,65,150,100,0,0,0,0,0]
#     arr = np.array(person_01)
#     arr = arr.reshape(1,12)
#     prediction = pickled_model.predict(arr)
    
#     return str(prediction[0])


# ## this api endpoint will be used to get the predition of the physical activities
# @app.route('/get_pred_params/', methods=['POST'])
# def get_prediction_by_params():

#     # get data come to the api endpoint
#     request_data = request.get_json()

#     # convert python dictionary to a numpy array
#     value_data = np.array(list(request_data.values()))
#     value_data = value_data.reshape(1,12)

#     # predict the data using the seleted model
#     prediction = pickled_model.predict(value_data)

#     # get the recommendation
#     recomendation = str(selecting_pool(prediction[0]))



#     return jsonify(recomendation)


# @app.route("/im_size", methods=["POST"])
# def process_image():
#     file = request.files['image']
#     # Read the image via file.stream
#     img = Image.open(file.stream)

#     return jsonify({'msg': 'success', 'size': [img.width, img.height]})


# @app.route("/img_return", methods=["POST"])
# def return_image():
#     file = request.files['image']
#     # Read the image via file.stream
#     img = Image.open(file.stream)

#     response_pickled = jsonpickle.encode(img)

#     return Response(response=response_pickled, status=200, mimetype="application/json")

## this api endpoint will be used to get the predition of the physical activities
# @app.route('/get_symptoms/', methods=['POST'])
# def get_symptoms():

#     # get data come to the api endpoint
#     request_data = request.get_json()

#     # convert python dictionary to a numpy array
#     value_data_j = np.array(list(request_data.values()))
#     value_data_j = value_data_j.reshape(1,16)

#     # predict the data using the seleted model
#     prediction = pickled_model_j.predict(value_data_j)

#     # get the recommendation
#     result = str(Selecting_Results(prediction[0]))



 #   return jsonify(result)

## this api endpoint will be used to get the predition of chances of having a higher risk in diabetes
# @app.route('/get_symptoms_dpn/', methods=['POST'])
# def get_symptoms_dpn():

#     # get data come to the api endpoint
#     request_data = request.get_json()

#     # convert python dictionary to a numpy array
#     value_data_j = np.array(list(request_data.values()))
#     value_data_j = value_data_j.reshape(1,12)

#     # predict the data using the seleted model
#     prediction = pickled_model_h.predict(value_data_j)

#     # get the recommendation
#     result = str(Selecting_Results(prediction[0]))



#     return jsonify(result)

## this api endpoint will be used to get the predition of chances of having a DPN
@app.route('/get_symptoms_dpn/', methods=['POST'])
def get_symptoms_dpn():

    # get data come to the api endpoint
    request_data = request.get_json()

    # convert python dictionary to a numpy array
    value_data_i = np.array(list(request_data.values()))
    value_data_i = value_data_i.reshape(1,12)

    # predict the data using the seleted model
    prediction = pickled_model_i.predict(value_data_i)

    # get the recommendation
    result = str(Selecting_Results(prediction[0]))




    return jsonify(result)





if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)