# camera.py

import cv2


class VideoCamera(object):
    def __init__(self):
        # Using OpenCV to capture from device 0. If you have trouble capturing
        # from a webcam, comment the line below out and use a video file
        # instead.
        self.video = cv2.VideoCapture(0)
        # 내장 카메라 외장카메라에서 영상을 받아옴 0은 노트북 내장카메라
        # If you decide to use video.mp4, you must have this file in the folder
        # as the main.py.
        # self.video = cv2.VideoCapture('video.mp4')

    def __del__(self):
        self.video.release()
        # 카메라 장치에서 받아온 메모리 해제

    def get_frame(self):
        # Grab a single frame of video
        ret, frame = self.video.read()
        return frame


if __name__ == '__main__':
    cam = VideoCamera()
    while True:
        frame = cam.get_frame()

        # show the frame
        cv2.imshow("Frame", frame)
        key = cv2.waitKey(1) & 0xFF

        # if the `q` key was pressed, break from the loop
        if key == ord("q"):
            break

    # do a bit of cleanup
    cv2.destroyAllWindows()
    print('finish')
