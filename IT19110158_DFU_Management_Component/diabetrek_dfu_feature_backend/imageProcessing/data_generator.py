import cv2
import numpy as np
from functions_for_pre_processing import normalize


# Data Generator -------------------------------------------------------------------------------------------------------
class DataGenerator:
    # Constructor
    def __init__(self, color_space='rgb'):
        self.x = 224
        self.y = 224
        self.color_space = color_space

    # Custom Image Data Generator
    def generate_data(self, image_array):
        image_batch = []

        # resize image
        dimensions = (self.x, self.y)

        resized_image = cv2.resize(image_array, dimensions, interpolation=cv2.INTER_AREA)

        image_batch.append(resized_image.astype("float32"))

        image_batch = normalize(np.array(image_batch))

        return image_batch
