# camera.py

import cv2


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
    # cam 객체 생성
    cam = VideoCamera()
    while True:

        # cam 으로부터 frame을 가져옴
        frame = cam.get_frame()

        # 받아온 frame을 화면에 표시
        cv2.imshow("Frame", frame)

        # 지정된 시간동안 키보드 입력을 기다림. 1ms 단위
        # cv.waitKey(0)은 키보드 입력이 있을 때까지 계속 대기.
        # 64비트는 '& 0xFF' 연산을 해야함. 32비트의 운영체제는 생략가능
        key = cv2.waitKey(1) & 0xFF

        # q가 입력 되면 while 문 종료
        # ord() 함수는 문자를 아스키 코드 값으로 변환하는 함수
        # chr() 함수는 아스키 코드 값을 문자로 변환하는 함수
        # ord('c') 는 99를 리턴
        # chr(99) 는 'c' 를 리턴
        if key == ord("q"):
            break

    # 생성한 모든 윈도우 제거
    cv2.destroyAllWindows()


    print('finish')
