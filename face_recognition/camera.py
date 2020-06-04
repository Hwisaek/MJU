# camera.py

import cv2

class VideoCamera(object):
    def __init__(self): # 초기화, 객체 생성시에 한번 실행
        self.video = cv2.VideoCapture(0)
        # 비디오 캡쳐 객체 생성, 인수 : 카메라 장치 번호(0 ~ N)

    def __del__(self): # 소멸자, 객체 소멸시에 한번 실행
        self.video.release()
        # 객체 해제

    def get_frame(self):
        ret, frame = self.video.read()
        # 비디오의 한 프레임씩 읽음.  ret은 제대로 읽으면 true, 실패시 false 반환
        # frame에 읽은 프레임이 나옴
        return frame


if __name__ == '__main__':
    cam = VideoCamera()
    # 객체 생성
    while True:
        frame = cam.get_frame()
        # 비디오 프레임 가져오기

        cv2.imshow("Frame", frame)
        # 윈도우 창의 타이틀 설정, frame 을 보여주는 창의 타이틀을 "Frame"로 설정
        key = cv2.waitKey(1) & 0xFF
        # 1ms 동안 키보드 입력 대기후 반환


        if key == ord("q"):
            break
        # 키보드로 q를 누르면 while 탈출

    cv2.destroyAllWindows()
    # 생성한 윈도우 창 제거
    print('finish')
