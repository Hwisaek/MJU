# mouth.py
import cv2
import dlib
from math import hypot
import time

# face detector 와 landmark predictor 정의
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor(
    "./shape_predictor_68_face_landmarks.dat")  # 얼굴의 특징을 68개의 점을 이용하여 인식
font = cv2.FONT_HERSHEY_SIMPLEX  # 폰트 지정
mouth_points = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
                58, 59, 60, 61, 62, 63, 64, 65, 66, 67]  # 입의 점 좌표


# 중간 지점을 계산하는 함수
def midpoint(p1, p2):
    return int((p1.x + p2.x) / 2), int((p1.y + p2.y) / 2)


# 입의 가로세로 비율 측정 함수
def get_mouth_pen_ratio(mouth_points, facial_landmarks):
    left_point = (facial_landmarks.part(mouth_points[12]).x, facial_landmarks.part(
        mouth_points[12]).y)  # 입의 최좌측 좌표
    right_point = (facial_landmarks.part(
        mouth_points[16]).x, facial_landmarks.part(mouth_points[16]).y)  # 입의 최우측 좌표
    # center_top = midpoint(facial_landmarks.part(
    #     mouth_points[13]), facial_landmarks.part(mouth_points[14]))  # 입의 최상단 좌표
    # center_bottom = midpoint(facial_landmarks.part(
    #     mouth_points[19]), facial_landmarks.part(mouth_points[18]))  # 입의 최하단 좌표
    center_top = (facial_landmarks.part(
        mouth_points[14]).x, facial_landmarks.part(mouth_points[14]).y)  # 입의 최상단 좌표
    center_bottom = (facial_landmarks.part(
        mouth_points[18]).x, facial_landmarks.part(mouth_points[18]).y)  # 입의 최하단 좌표

    # cv2.line(선분이 그려질 이미지, 선분의 시작점(x,y), 선분의 끝점(x,y), 선분의 색(B,G,R), 선 굵기(기본 1))
    hor_line = cv2.line(image, left_point, right_point,
                        (0, 255, 0), 2)  # 윈도우에 입의 가로 선 생성
    ver_line = cv2.line(image, center_top, center_bottom,
                        (0, 255, 0), 2)  # 윈도우에 입의 세로 선 생성

    # hypot(x, y) 는 x^2 + y^2 = z^2 를 계산하여 z 값을 반환함
    # 즉 피타고라스 방정식을 이용하여 그려질 선의 길이 계산
    hor_line_lenght = hypot(
        (left_point[0] - right_point[0]), (left_point[1] - right_point[1]))  # 입의 가로 선 길이
    ver_line_lenght = hypot(
        (center_top[0] - center_bottom[0]), (center_top[1] - center_bottom[1]))  # 입의 세로 선 길이

    # 입의 가로 세로 비율
    # 가로/세로 이므로 입을 닫을수록 값이 커짐
    # 인식 오류로 세로 길이가 0이 되는 경우 계산 에러 방지
    if ver_line_lenght != 0:
        ratio = hor_line_lenght / ver_line_lenght
    else:
        ratio = 60
    return ratio


count_mouth_open = 0  # 변수 초기화

# 내장 카메라로 비디오 캡쳐
capture = cv2.VideoCapture(0)

# 프레임의 너비와 높이의 속성 설정
# cv2.CAP_PROP_FRAME_WIDTH : 프레임의 너비 속성
capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
# cv2.CAP_PROP_FRAME_HEIGHT : 프레임의 높이 속성
capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

start = time.time()  # 시작 시간 저장
mouth_time = 0
mouth_time_open = 0
mouth_time_close = 0
while True:
    # 재생되는 비디오의 한 프레임 씩 읽어서 두 개의 값 반환
    # 첫 번째 값은 제대로 읽었으면 True, 아니면 False
    # 두 번째 값은 읽은 frame
    _, image = capture.read()

    # 읽은 frame 을 흑백으로 변환
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    faces = detector(gray)

    for face in faces:
        landmarks = predictor(gray, face)

        # 입의 비율 계산
        mouths = get_mouth_pen_ratio(mouth_points, landmarks)

        # 입의 가로 길이가 세로 길이의 5배보다 작거나 같으면 입을 벌린 것으로 인식
        if mouths <= 5.0:
            if mouth_time_open == 0:
                mouth_time_open = time.time()
            count_mouth_open += 1  # 입을 벌리면 1씩 증가
        else:
            if mouth_time_close == 0 and mouth_time_open != 0:
                mouth_time_close = time.time()
            if mouth_time_open != 0 and mouth_time_close != 0:
                mouth_time += mouth_time_close - mouth_time_open
                mouth_time_open = 0
                mouth_time_close = 0

    # 입을 벌린 시간 출력 , 정확한 시간(초)가 아니라 1초당 약 23
    cv2.putText(image, "Mouth open: " + str(count_mouth_open),
                (50, 50), font, 2, (255, 0, 0))
    cv2.putText(image, "Mouth time: " + str(mouth_time),
                (50, 100), font, 2, (255, 0, 0))
    cv2.putText(image, "Mouth open: " + str(mouth_time_open),
                (50, 150), font, 2, (255, 0, 0))
    cv2.putText(image, "Mouth close: " + str(mouth_time_close),
                (50, 200), font, 2, (255, 0, 0))

    # 받아온 frame을 화면에 표시
    cv2.imshow("Frame", image)

    # 지정된 시간동안 키보드 입력을 기다림. 1ms 단위
    # cv.waitKey(0)은 키보드 입력이 있을 때까지 계속 대기.
    # 64비트는 '& 0xFF' 연산을 해야함. 32비트의 운영체제는 생략가능
    key = cv2.waitKey(1) & 0xFF

    # 입을 벌린 시간을 txt로 저장
    f = open("count_mouth.txt", 'w')
    data = "mouth: {}".format(mouth_time)
    f.write(data)
    f.close()

    # q를 누르거나 10초 지나면 종료
    # ord() 함수는 문자를 아스키 코드 값으로 변환하는 함수
    # chr() 함수는 아스키 코드 값을 문자로 변환하는 함수
    # ord('c') 는 99를 리턴
    # chr(99) 는 'c' 를 리턴
    if (key == ord("q")) or (time.time() - start) >= 5:
##        print(str(count_mouth_open))
##        print(time.time() - start)
        if mouth_time_open != 0 and mouth_time_close == 0:
            mouth_time_close = time.time()
            mouth_time += mouth_time_close - mouth_time_open
        print(round(mouth_time,2))
        break

# 생성한 모든 윈도우 제거
cv2.destroyAllWindows()
