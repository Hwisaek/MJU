# capture.py

import cv2
import os


class VideoCamera(object):
    def __init__(self):
        self.video = cv2.VideoCapture(0)
        # 내장 카메라 외장카메라에서 영상을 받아옴 0은 노트북 내장카메라
        # 여러대의 카메라가 연결되어 있을 경우 0 대신 1, 2 등 숫자를 높여가며 확인할 것
        # 카메라로 촬영이 아니라 영상을 이용하는 경우 아래의 코드 사용
        # self.video = cv2.VideoCapture('video.mp4')

    def __del__(self):
        self.video.release()
        # 카메라 장치에서 받아온 메모리 해제

    def get_frame(self):
        # 영상으로부터 프레임을 가져옴
        # 2개의 값을 리턴하는데 ret는 프레임을 성공적으로 읽었는지 반환
        # frame 은 프레임 자체를 반환
        ret, frame = self.video.read()
        return frame

if __name__ == '__main__':
    cam = VideoCamera()
    path = os.path.dirname(__file__)
    filename = "recognizeface.jpg" # 캡쳐한 화면을 recognizeface.jpg 로 저장
    fullpath = os.path.join(path, filename)

    i = 0
    while True:
        frame = cam.get_frame()
        cv2.imshow("Frame", frame)
        if i == 3: # DroidCam 등으로 연결된 카메라의 경우 로딩시간으로 인해 3으로 설정해야 촬영 가능
            cv2.imwrite(fullpath, frame)
            break
        i += 1
    # do a bit of cleanup
    cv2.destroyAllWindows()
    print('finish')
