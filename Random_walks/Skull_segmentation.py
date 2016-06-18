from medpy.io import load
from matplotlib.pyplot import imshow
from skimage.segmentation import random_walker
import numpy
# Load image data
image_data, image_header = load('Downloads\CT-MONO2-16-brain.dcm') # Insert full path to the file location
import matplotlib.pyplot as plt
# Display image data
print"load successful"
plt.show()
plt.figure(1), imshow(image_data, cmap='gray', interpolation='nearest')
print"show successful"
# Random walks segmentation
markers = numpy.zeros(image_data.shape, dtype=numpy.uint)
markers[(image_data > 30) & (image_data < 50)] = 1
markers[image_data > 300] = 2
labels = random_walker(image_data, markers, beta=2, mode='bf')
 
# Display results
plt.figure(2), imshow(markers, interpolation='nearest')
plt.figure(3), imshow(labels, interpolation='nearest') 