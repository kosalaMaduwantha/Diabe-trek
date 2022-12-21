import cv2


# This function can calculate the wound area
def calculate_area(img):
    # convert the image read from the db to gray scale
    gray_image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    ret, thresh = cv2.threshold(gray_image, 127, 255, 0)
    contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    area = cv2.contourArea(contours[0])

    return area
