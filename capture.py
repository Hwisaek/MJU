# camera.py

import cv2
import os


class VideoCamera(object):
    def __init__(self):
        # Using OpenCV to capture from device 0. If you have trouble capturing
        # from a webcam, comment the line below out and use a video file
        # instead.
        self.video = cv2.VideoCapture(0)
        # If you decide to use video.mp4, you must have this file in the folder
        # as the main.py.
        # self.video = cv2.VideoCapture('video.mp4')

    def __del__(self):
        self.video.release()

    def get_frame(self):
        # Grab a single frame of video
        ret, frame = self.video.read()
        return frame

if __name__ == '__main__':
    cam = VideoCamera()
    path = os.path.dirname(__file__)
    filename = "recognizeface.jpg"
    fullpath = os.path.join(path, filename)
    i = 0
    while True:
        frame = cam.get_frame()
        cv2.imshow("Frame", frame)
        if i == 3:
            cv2.imwrite(fullpath, frame)
            break
        i += 1
    # do a bit of cleanup
    cv2.destroyAllWindows()
    print('finish')
