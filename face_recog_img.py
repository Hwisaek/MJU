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
        dirname = './'
        files = os.listdir(dirname)
        for filename in files:
            name, ext = os.path.splitext(filename)
            if ext == '.jpg' and name == 'recognizeface':
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
                    print("Face recogniezd.".format(name))
                else: # 얼굴 특징을 찾을 수 없는 사진이 있을 경우 해당 사진을 출력해줌
                    print("Face recognize error.".format(name))
##                    quit()
                



if __name__ == '__main__':
    face_recog = FaceRecog()
    start = time.time()  # 시작 시간 저장


