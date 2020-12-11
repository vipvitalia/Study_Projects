import cv2
import os
import numpy as np

input_path = (r'images_input')
output_path_prewit = (r'images_out_prewit')
output_path_nms = (r'images_out_nms')


def Grayscale(image):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    return image

def prewit(image):
    image = Grayscale(image)
    convolved = np.zeros(image.shape)
    G_x = np.zeros(image.shape)
    G_y = np.zeros(image.shape)
    size = image.shape
    kernel_x = np.array([[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]])
    kernel_y = np.array([[-1, -1, -1], [0, 0, 0], [1, 1, 1]])
    for i in range(1, size[0] - 1):
        for j in range(1, size[1] - 1):
            G_x[i, j] = np.sum(np.multiply(image[i - 1: i + 2, j - 1: j + 2], kernel_x))
            G_y[i, j] = np.sum(np.multiply(image[i - 1: i + 2, j - 1: j + 2], kernel_y))

    convolved = np.sqrt(np.square(G_x) + np.square(G_y))
    convolved = np.multiply(convolved, 255.0 / convolved.max())

    angles = np.rad2deg(np.arctan2(G_y, G_x))
    angles[angles < 0] += 180
    convolved = convolved.astype('uint8')
    return convolved, angles


def non_maximum_suppression(image, angles):
    size = image.shape
    suppressed = np.zeros(size)
    for i in range(1, size[0] - 1):
        for j in range(1, size[1] - 1):
            if (0 <= angles[i, j] < 22.5) or (157.5 <= angles[i, j] <= 180):
                value_to_compare = max(image[i, j - 1], image[i, j + 1])
            elif 22.5 <= angles[i, j] < 67.5:
                value_to_compare = max(image[i - 1, j - 1], image[i + 1, j + 1])
            elif 67.5 <= angles[i, j] < 112.5:
                value_to_compare = max(image[i - 1, j], image[i + 1, j])
            else:
                value_to_compare = max(image[i + 1, j - 1], image[i - 1, j + 1])

            if image[i, j] >= value_to_compare:
                suppressed[i, j] = image[i, j]
    suppressed = np.multiply(suppressed, 255.0 / suppressed.max())
    return suppressed

if __name__ == "__main__":
    for root, dirs, files in os.walk(input_path):
        for filename in files:
            image = cv2.imread(os.path.join(root, filename))

            prewit_image, angles = prewit(image)
            nms_image = non_maximum_suppression(prewit_image, angles)

            cv2.imwrite(os.path.join(output_path_prewit, "prewit_" + filename), prewit_image)
            cv2.imwrite(os.path.join(output_path_nms, "nms_"+filename), nms_image)