import os
import pymongo
from flask.cli import load_dotenv

load_dotenv()  # Load .env file

global client


# This function will create a connection object with the mongodb database ----------------------------------------------
def db_connection():
    global client

    user = os.environ.get("MONGODB_USERNAME")  # Get username from environment variables
    pwd = os.environ.get("MONGODB_PASSWORD")  # Get password from environment variables

    mongodb_url = f"mongodb+srv://" + user + ":" + pwd + "@dfu-wound-data.r6lvaaa.mongodb.net/?retryWrites=true&w" \
                                                         "=majority"

    client = pymongo.MongoClient(mongodb_url)  # Establish connection with the db

    mongodb = client.get_database('diabetrek-dfu-feature')  # Assign db to mongodb

    collection = pymongo.collection.Collection(mongodb, 'dfu-data')

    return collection


# This function will close any mongodb connection ----------------------------------------------------------------------
def close_connection():
    client.close()
