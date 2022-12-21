import tensorflow as tf
import keras.backend as k

from keras.layers import *
from keras.utils import conv_utils


# Class definition for Bi-linear-Up-Sampling
class BiLinearUpSampling(Layer):
    def __init__(self, up_sampling=(2, 2), output_size=None, data_format=None, **kwargs):
        super(BiLinearUpSampling, self).__init__(**kwargs)

        self.data_format = k.image_data_format()
        self.input_spec = InputSpec(ndim=4)

        if output_size:
            self.output_size = conv_utils.normalize_tuple(output_size, 2, 'output_size')
            self.upsampling = None
        else:
            self.output_size = None
            self.upsampling = conv_utils.normalize_tuple(up_sampling, 2, 'upsampling')

    def compute_output_shape(self, input_shape):
        if self.upsampling:
            height = self.upsampling[0] * \
                input_shape[1] if input_shape[1] is not None else None
            width = self.upsampling[1] * \
                input_shape[2] if input_shape[2] is not None else None
        else:
            height = self.output_size[0]
            width = self.output_size[1]

        return (input_shape[0],
                height,
                width,
                input_shape[3])

    def call(self, inputs):
        if self.upsampling:
            return tf.compat.v1.image.resize_bilinear(inputs, (inputs.shape[1] * self.upsampling[0],
                                                               inputs.shape[2] * self.upsampling[1]),
                                                      align_corners=True)
        else:
            return tf.compat.v1.image.resize_bilinear(inputs, (self.output_size[0],
                                                               self.output_size[1]),
                                                      align_corners=True)

    def get_config(self):
        config = {'upsampling': self.upsampling,
                  'output_size': self.output_size,
                  'data_format': self.data_format}

        base_config = super(BiLinearUpSampling, self).get_config()

        return dict(list(base_config.items()) + list(config.items()))
