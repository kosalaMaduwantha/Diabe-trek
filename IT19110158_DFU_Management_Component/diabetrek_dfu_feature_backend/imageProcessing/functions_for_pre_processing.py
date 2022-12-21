import numpy as np
import keras.backend as k
import tensorflow as tf


# Function to resize images --------------------------------------------------------------------------------------------
def resize_images_bi_linear(x, height_factor=1, width_factor=1, target_height=None, target_width=None,
                            data_format='default'):
    if data_format == 'default':
        data_format = k.image_data_format()

    if data_format == 'channels_first':
        original_shape = k.int_shape(x)

        if target_height and target_width:
            new_shape = tf.constant(np.array((target_height, target_width)).astype('int32'))
        else:
            new_shape = tf.shape(x)[2:]
            new_shape *= tf.constant(np.array([height_factor, width_factor]).astype('int32'))

        x = k.permute_dimensions(x, [0, 2, 3, 1])
        # X = tf.image.resize_bi_linear(X, new_shape)
        x = tf.compat.v1.image.resize_bilinear(x, new_shape)
        x = k.permute_dimensions(x, [0, 3, 1, 2])

        if target_height and target_width:
            x.set_shape((None, None, target_height, target_width))
        else:
            x.set_shape((None, None, original_shape[2] * height_factor, original_shape[3] * width_factor))
        return x

    elif data_format == 'channels_last':
        original_shape = k.int_shape(x)
        if target_height and target_width:
            new_shape = tf.constant(np.array((target_height, target_width)).astype('int32'))
        else:
            new_shape = tf.shape(x)[1:3]
            new_shape *= tf.constant(np.array([height_factor, width_factor]).astype('int32'))

        # x = tf.image.resize_bi_linear(x, new_shape)
        x = tf.compat.v1.image.resize_bilinear(x, new_shape)

        if target_height and target_width:
            x.set_shape((None, target_height, target_width, None))
        else:
            x.set_shape((None, original_shape[1] * height_factor, original_shape[2] * width_factor, None))
        return x

    else:
        raise Exception('Invalid data_format: ' + data_format)


# ----------------------------------------------------------------------------------------------------------------------


# Image normalization --------------------------------------------------------------------------------------------------
def normalize(arr):
    diff = np.amax(arr) - np.amin(arr)
    diff = 255 if diff == 0 else diff
    arr = arr / np.absolute(diff)

    return arr


# ----------------------------------------------------------------------------------------------------------------------


# Function to calculate Dice Coefficient -------------------------------------------------------------------------------
def dice_coefficient_fcn(y_true, y_predicted, smooth=1.):
    y_true_f = k.flatten(y_true)
    y_predicted_f = k.flatten(y_predicted)
    intersection = k.sum(y_true_f * y_predicted_f)

    return (2. * intersection + smooth) / (k.sum(y_true_f) + k.sum(y_predicted_f) + smooth)
