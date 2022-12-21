## importing libraries
from psycopg2 import sql
import urllib.parse
from psycopg2.extensions import AsIs
import requests
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import LabelEncoder  # for train test splitting
from sklearn.model_selection import train_test_split  # for decision tree object
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.metrics import classification_report, confusion_matrix  # for visualizing tree
from sklearn.tree import plot_tree, DecisionTreeClassifier
# importing flask
from flask import Flask, jsonify, request, Response, send_file
# importing pickle
import pickle
# importing the pre processing module
from optimiation_module.Base import Base
from get_the_rec import recomendation
# import image processing library
from PIL import Image
import jsonpickle
from models.activity_pools import selecting_pool
from models.result import Selecting_Results
from optimiation_module.db_conn import DB_CONN
import logging
import json
# importing the routine module
from optimiation_module.Base import Base
import os
os.getcwd()## initialiing the Flask application
## comment 001
app = Flask(__name__)

db_instance = DB_CONN()

# crreating the logger to log exception and errors encounters
formatter = logging.Formatter(
    '%(asctime)s %(levelname)s %(message)s', datefmt="%Y-%m-%d %H:%M:%S"
)
handler = logging.FileHandler("./errors/backend_errors.log", mode='a')
handler.setFormatter(formatter)
logger = logging.getLogger("logger_name")
logger.setLevel(logging.INFO)
logger.addHandler(handler)

# -----------------------------------------------------------------------------------------------------------

phy_actrate = {
    "act_1" : 1,
    "act_2" : 2,
    "act_3" : 3
}

# get the pickl model object
# Load the pickled model
pickled_model = pickle.load(open('./models/model.pkl', 'rb'))
#pickled_model_j = pickle.load(open('models/model_risk.pkl', 'rb'))

# test the prediction
person_01 = [50, 0, 45, 132, 65, 150, 100, 0, 0, 0, 0, 0]
arr = np.array(person_01)
arr = arr.reshape(1, 12)
prediction = pickled_model.predict(arr)
print(str(prediction[0]))

#____________________________________________________________________________________________________________________
@app.route('/get_prediction/', methods=['GET'])
def get_static_prediction():
    person_01 = [50, 0, 45, 132, 65, 150, 100, 0, 0, 0, 0, 0]
    arr = np.array(person_01)
    arr = arr.reshape(1, 12)
    prediction = pickled_model.predict(arr)

    return str(prediction[0])


pickled_model_i = pickle.load(open('./models/model_dpn.pkl', 'rb'))







## this api endpoint will be used to get the predition of the physical activities
#_____________________________________________________________________________________________________________________
@app.route('/get_pred_params/', methods=['POST'])
def get_prediction_by_params():
    # get data come to the api endpoint
    global connection
    request_data = request.get_json()
    print(request_data)

    # convert python dictionary to a numpy array
    value_data = np.array(list(request_data.values()))
    value_data = value_data.reshape(1, 12).astype(float)

    # predict the data using the seleted model
    prediction = pickled_model.predict(value_data)

    # get the recommendation
    recomendation = selecting_pool(prediction[0])

    dictionary_01 = []
    # convert to a json object
    for activity in recomendation:
        dictionary_01.append({"activity": activity})




    # insert data to db
    try:
        connection = db_instance.open_mysql_connection()
        cursor = connection.cursor()
        statement = "CALL GetAllProducts (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        cursor.execute(statement,
                       (value_data[0][0], value_data[0][1], value_data[0][2], value_data[0][3], value_data[0][4],
                        value_data[0][5], value_data[0][6], value_data[0][7], value_data[0][8], value_data[0][9],
                        value_data[0][10], value_data[0][11], prediction[0], 1))
        connection.commit()
        return_msg = cursor.fetchone()[0]
        print(return_msg)
        logger.info(return_msg)
        connection.close()

    except Exception as error:
        print("Something went wrong: {}".format(error))
        logger.error("message :{0}\n".format(str(error)))

        print("clossing the connection")
        connection.close()


    return jsonify(dictionary_01)










## get the recommended activities from the database using user_id or customer_id
#______________________________________________________________________________________________________________________
@app.route('/get_activities_key/', methods=['GET'])
def get_activities_for_key():

    u_id = request.args.get("u_id")

    # fetch recommended class from the database
    try:
        connection = db_instance.open_mysql_connection()
        cursor = connection.cursor()
        statement = "SELECT prediction_pool FROM classification WHERE cus_id=%s"
        cursor.execute(statement,
                       (u_id))
        connection.commit()
        prediction_pool = cursor.fetchone()[0]
        print(prediction_pool)
        logger.info(prediction_pool)
        connection.close()

    except Exception as error:
        print("Something went wrong: {}".format(error))
        logger.error("message :{0}\n".format(str(error)))

        print("clossing the connection")
        connection.close()

    recomendation = selecting_pool(prediction_pool)

    dictionary_02 = []
    # convert to a json object
    for count,activity in enumerate(recomendation,1):
        dictionary_02.append({"activity": activity, "isChecked":False})

    return jsonify(dictionary_02)








## get the created routine plane for customer_id
#______________________________________________________________________________________________________________________
@app.route('/get_routines_from_db_weeks/', methods=['GET'])
def get_routine_db_weeks():
    u_id = request.args.get("u_id")


    try:
        connection = db_instance.open_mysql_connection()
        cursor = connection.cursor()
        statement = "select distinct(week_no) from fetch_routine_data where cus = %s order by week_no;"
        cursor.execute(statement,
                       (u_id))
        connection.commit()
        no_weeks = cursor.fetchall()
        print(no_weeks)
        logger.info(no_weeks)
        connection.close()

    except Exception as error:
        print("Something went wrong: {}".format(error))
        logger.error("message :{0}\n".format(str(error)))

        print("clossing the connection")
        connection.close()

    df_noweeks = pd.DataFrame(no_weeks,
                               columns=["week_no"])

    results = df_noweeks.to_json(orient="records")


    return results



@app.route('/post_routines_per_day/', methods=['POST'])
def post_routines_per_day():

    data = request.get_json()
    print(data)

    # get the caloric burning rates
    try:
        connection = db_instance.open_mysql_connection()
        cursor = connection.cursor()
        statement = "select * from physicalact.exercise_dataset \
                    where activity in (%s,%s,%s);"
        cursor.execute(statement,data['ac01'],data['ac02'],data['ac02'])
        connection.commit()
        return_activity_rate = cursor.fetchall()
        print(return_msg)
        logger.info(return_msg)
        connection.close()

    except Exception as error:
        print("Something went wrong: {}".format(error))
        logger.error("message :{0}\n".format(str(error)))

        print("clossing the connection")
        connection.close()



    new_routine = Base(phy_actrate["act_1"], phy_actrate["act_2"], phy_actrate["act_3"], data["target_calories"], data["no_hours"] * 60)
    routine = new_routine.print()
    df = pd.DataFrame(routine.items(), columns=['activity', 'no_min'])
    df.at[0, 'activity'] = data['ac01']
    df.at[1, 'activity'] = data['ac02']
    df.at[2, 'activity'] = data['ac03']




    for index, row in df.iterrows():

        try:
            connection = db_instance.open_mysql_connection()
            cursor = connection.cursor()
            statement = "CALL post_routines_day(%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(statement,
                           (data["week_no"],data["month_of"],data["year_of"], data["day_no"],
                            row["activity"], row["no_min"], 1))
            connection.commit()
            return_msg = cursor.fetchone()[0]
            print(return_msg)
            logger.info(return_msg)
            connection.close()

        except Exception as error:
            print("Something went wrong: {}".format(error))
            logger.error("message :{0}\n".format(str(error)))

            print("clossing the connection")
            connection.close()

    # insert data to db


    return routine






## get the created routine plane for customer_id
#______________________________________________________________________________________________________________________
@app.route('/get_routines_from_db/', methods=['GET'])
def get_routine_db():
    u_id = request.args.get("u_id")
    no_week = request.args.get("no_week")

    try:
        connection = db_instance.open_mysql_connection()
        cursor = connection.cursor()
        statement = "select * from fetch_routine_data where cus =%s and week_no = %s"
        cursor.execute(statement,
                       (u_id,no_week))
        connection.commit()
        routines = cursor.fetchall()
        print(routines)
        logger.info(routines)
        connection.close()

    except Exception as error:
        print("Something went wrong: {}".format(error))
        logger.error("message :{0}\n".format(str(error)))

        print("clossing the connection")
        connection.close()


    df_routines = pd.DataFrame(routines, columns=["week_no", "month_of","year_of","day_no","activity","no_min","cus_id"])

    results = df_routines.to_json(orient="records")



    return results




## create activity routine
#____________________________________________________________________________________________________________________
@app.route('/get_routines/', methods=['POST'])
def get_routine():
    # get incoming data
    data = request.get_json()
    print(data)

    # get the caloric burning rates


    new_routine = Base(1, 2, 3, data["target_calories"], data["no_hours"]*60)
    routine = new_routine.print()


    # fetch the detailes of the physica activities from database

    return routine



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




    return jsonify({"prediction":result})



@app.route('/put_entry_rec/', methods=['post'])
def put_entry_rec():
    request_data = request.get_json()


    try:
        connection = db_instance.open_mysql_connection()
        cursor = connection.cursor()


        for key,val in request_data.items():

            statement = "UPDATE DPNClassification SET %s = %s WHERE Patient_id = 2"
            column_name = str(key).replace('"', '')
            cursor.execute(statement,
                           (column_name,val))
            connection.commit()
            output = cursor.fetchall()

        logger.info(output)
        connection.close()

    except Exception as error:
        print("Something went wrong: {}".format(error))
        logger.error("message :{0}\n".format(str(error)))

        print("clossing the connection")
        connection.close()




    return "Okay"

## Kosala_dkk
@app.route('/food', methods=['POST'])
def foodfunc():
    object_q = request.get_json(force=True)

    arrayDict = {"akey": []}
    array = []

    for key, value in object_q.items():
        url = "https://api.nutritionix.com/v1_1/search"
        data = {
            "appId": "e3424dca",
            "appKey": "726cc8fe9cc262c5bdc77e761b33615c",
            "fields": [
                "item_name",
                "brand_name",
                "nf_calories",
                "nf_sodium",
                "nf_sugars",
                "serving_size",
                "item_type"
            ],
            "query": value
        }
        headers = {'Content-type': 'application/json'}

        r = requests.post(url, data=json.dumps(data), headers=headers)

        rcDest = r.json()['hits'][2]['fields']['item_name']
        rcDest2 = r.json()['hits'][2]['fields']['nf_sugars']

        tempObject = {
            value: rcDest2
        }
        arrayDict['akey'].append(tempObject)

    return arrayDict



## end or the script
#____________________________________________________________________________________________________________________
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

"""INSERT INTO `classification` (`Age`,`gender`,`weight`,`height`,`BloodPressure`,`cholestrol`, \
                                            `Glucose`,`diabetes`,`discomfirt_chest`,`current_physical_activity_status`,\
                                            `family_history_heart_disease`,`cigerette_consumption`,`prediction_pool`, \
                                            `cus_id`) """
