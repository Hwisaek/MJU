# face_recog.py
import face_recognition
import cv2
import camera
import os
import numpy as np
import dlib
from math import hypot
import time

class FaceRecog():
    def __init__(self):
        # 객체 생성
        self.camera = camera.VideoCamera()

        self.known_face_encodings = []
        self.known_face_names = []

        # knowns 에서 사진파일을 읽고 인식하여 특징 추출
        dirname = 'knowns'
        files = os.listdir(dirname)
        for filename in files:
            name, ext = os.path.splitext(filename)
            if ext == '.jpg':
                self.known_face_names.append(name)
                # knowns 디렉토리에서 사진 파일을 읽어와서 사람 이름을 추출
                pathname = os.path.join(dirname, filename)
                img = face_recognition.load_image_file(pathname)
                
                # 특징 추출
                # 얼굴 특징을 검출할 수 없을 경우 에러 발생
##                face_encoding = face_recognition.face_encodings(img)[0]  

                # 에러 발생시 해결하는 코드 
                encodings = face_recognition.face_encodings(img)
                if len(encodings) > 0:
                    face_encoding = encodings[0]
                else: # 얼굴 특징을 찾을 수 없는 사진이 있을 경우 해당 사진을 출력해줌
                   print("{} : No faces found in the image!".format(name))
##                   quit()
                
                # 사진에서 얼굴 특징의 데이터를 분석한 데이터를 self.known_face_encodings 에 저장
                self.known_face_encodings.append(face_encoding)

        # 변수 초기화
        self.face_locations = []
        self.face_encodings = []
        self.face_names = []
        self.process_this_frame = True

    # 소멸자
    def __del__(self):
        del self.camera

    def get_frame(self):
        # 영상으로부터 프레임을 가져옴
        frame = self.camera.get_frame()

        # 계산 양을 줄이기 위해 frame의 크기를 1/4로 줄임
        small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)

        # OpenCV 에서 사용하는 BGR 색에서 face_recognition 에서 사용하는 RGB로 이미지를 변환
        rgb_small_frame = small_frame[:, :, ::-1]

        # 계산 양을 줄이기 위해 두 프레임당 1번씩 계산
        if self.process_this_frame:
            # Find all the faces and face encodings in the current frame of video
            self.face_locations = face_recognition.face_locations(
                rgb_small_frame)
            self.face_encodings = face_recognition.face_encodings(
                rgb_small_frame, self.face_locations)

            self.face_names = []
            for face_encoding in self.face_encodings:
                # Frame에서 추출한 얼굴 특징과 knowns에 있는 얼굴 사진과 비교하여
                # 얼마나 비슷한지 거리 척도로 환산(작을수록 비슷한 얼굴)
                distances = face_recognition.face_distance(
                    self.known_face_encodings, face_encoding)
                min_value = min(distances)

                # 0.6 이상은 다른 사람의 얼굴
                # 인식이 잘 안되면 min_value의 범위 조절 (0.6이 최적)
                name = "Unknown"
                if min_value < 0.4:
                    index = np.argmin(distances)
                    name = self.known_face_names[index]
                    print(name)  # 인식된 이름 출력
##                    break

                self.face_names.append(name)

        # 두 프레임당 1번씩 계산하기 위해 변수 값 전환
        self.process_this_frame = not self.process_this_frame

        # 결과 출력
        for (top, right, bottom, left), name in zip(self.face_locations, self.face_names):
            # 1/4배로 만들었던 frame을 다시 원래 크기로 키움
            top *= 4
            right *= 4
            bottom *= 4
            left *= 4

            # 인식된 얼굴 주위에 네모박스 생성
            cv2.rectangle(frame, (left, top), (right, bottom), (0, 0, 255), 2)

            # 인식된 얼굴 아래에 이름 생성
            cv2.rectangle(frame, (left, bottom - 35),
                          (right, bottom), (0, 0, 255), cv2.FILLED)
            font = cv2.FONT_HERSHEY_DUPLEX
            cv2.putText(frame, name, (left + 6, bottom - 6),
                        font, 1.0, (255, 255, 255), 1)

        return frame

    def get_jpg_bytes(self):
        # 비디오 프레임 가져오기
        frame = self.get_frame()

        # OpenCV 에서는 기본적으로 raw 이미지를 사용하므로, 영상 송출을 위해
        # Motion JPEG로 인코딩 하는 함수
        ret, jpg = cv2.imencode('.jpg', frame)
        return jpg.tobytes()


if __name__ == '__main__':
    face_recog = FaceRecog()
    start = time.time()  # 시작 시간 저장

    while True:
        # 객체 생성
        frame = face_recog.get_frame()

        # 윈도우에 frame 출력
        cv2.imshow("Frame", frame)
        key = cv2.waitKey(1) & 0xFF

##        if (key == ord("q")) or (time.time() - start) >= 5:  # q를 누르거나 5초 지나면 종료
##            break

    # 생성한 윈도우 창 제거
    cv2.destroyAllWindows()
