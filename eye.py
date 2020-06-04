# 눈깜빡임 감지 코드
import cv2
import dlib
from math import hypot
import time

# face detector 와 landmark predictor 정의
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("./shape_predictor_68_face_landmarks.dat")
font = cv2.FONT_HERSHEY_SIMPLEX  # 폰트 지정
r_eye_points = [42, 43, 44, 45, 46, 47]
l_eye_points = [36, 37, 38, 39, 40, 41]


# 중간 지점을 계산하는 함수
def midpoint(p1, p2):
    return int((p1.x + p2.x) / 2), int((p1.y + p2.y) / 2)


# 눈의 가로세로 비율 측정 함수
def get_blinking_ratio(eye_points, facial_landmarks):
    left_point = (facial_landmarks.part(eye_points[0]).x, facial_landmarks.part(eye_points[0]).y) # 눈의 최좌측 좌표
    right_point = (facial_landmarks.part(eye_points[3]).x, facial_landmarks.part(eye_points[3]).y) # 눈의 최우측 좌표
    center_top = midpoint(facial_landmarks.part(eye_points[1]), facial_landmarks.part(eye_points[2])) # 눈의 최상단 좌표
    center_bottom = midpoint(facial_landmarks.part(eye_points[5]), facial_landmarks.part(eye_points[4])) #눈의 최하단 좌표

    # cv2.line(선분이 그려질 이미지, 선분의 시작점(x,y), 선분의 끝점(x,y), 선분의 색(B,G,R), 선 굵기(기본 1))
    hor_line = cv2.line(image, left_point, right_point, (0, 255, 0), 2) # 윈도우에 눈의 가로 선 생성
    ver_line = cv2.line(image, center_top, center_bottom, (0, 255, 0), 2) # 윈도우에 눈의 세로 선 생성

    # hypot(x, y) 는 x^2 + y^2 = z^2 를 계산하여 z 값을 반환함
    # 즉 피타고라스 방정식을 이용하여 그려질 선의 길이 계산
    hor_line_lenght = hypot((left_point[0] - right_point[0]), (left_point[1] - right_point[1])) # 눈의 가로 선 길이
    ver_line_lenght = hypot((center_top[0] - center_bottom[0]), (center_top[1] - center_bottom[1])) # 눈의 세로 선 길이

    # 눈의 가로 세로 비율
    # 가로/세로 이므로 눈을 감을수록 값이 커짐
    ratio = hor_line_lenght / ver_line_lenght
    return ratio


# 내장 카메라로 비디오 캡쳐
capture = cv2.VideoCapture(0)

start = time.time()  # 시작 시간 저장

# 프레임의 너비와 높이의 속성 설정
# cv2.CAP_PROP_FRAME_WIDTH : 프레임의 너비 속성
capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
# cv2.CAP_PROP_FRAME_HEIGHT : 프레임의 높이 속성
capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)

j = 0  # 현재 눈 상태 설정 0이면 뜬 상태, 1이면 감은 상태
blink = 0  # 깜빡임 횟수

while True:
    # 재생되는 비디오의 한 프레임 씩 읽어서 두 개의 값 반환
    # 첫 번째 값은 제대로 읽었으면 True, 아니면 False
    # 두 번째 값은 읽은 frame
    _, image = capture.read()

    # 읽은 frame 을 흑백으로 변환
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # 몇 번 깜빡였는지 출력
    cv2.putText(image, "blinking :" + str(blink), (50, 50), font, 2, (255, 0, 0))

    faces = detector(gray)

    for face in faces:
        landmarks = predictor(gray, face)

        left_eye_ratio = get_blinking_ratio(l_eye_points, landmarks) # 좌측 눈 비율 계산
        right_eye_ratio = get_blinking_ratio(r_eye_points, landmarks) # 우측 눈 비율 계산

        # 어느 한 쪽의 눈이라도 가로 길이가 세로 길이의 7.5배가 넘어가게 되면 눈을 감은 것으로 인식하여 코드 실행
        if left_eye_ratio >= 7.5 or right_eye_ratio >= 7.5:
            if j == 0:

                print("blinking")
                blink += 1
                j += 1

        if j != 0:
            j += 1
        if j == 10:
            j = 0

    # 받아온 frame을 화면에 표시
    cv2.imshow("Frame", image)

    # 지정된 시간동안 키보드 입력을 기다림. 1ms 단위
    # cv.waitKey(0)은 키보드 입력이 있을 때까지 계속 대기.
    # 64비트는 '& 0xFF' 연산을 해야함. 32비트의 운영체제는 생략가능
    key = cv2.waitKey(1) & 0xFF

    # 깜빡임 횟수를 txt로 저장
    f = open("count_blink.txt", 'w')
    data = "blinking: {}".format(blink)
    f.write(data)
    f.close()

    # q가 입력 되면 while 문 종료
    # ord() 함수는 문자를 아스키 코드 값으로 변환하는 함수
    # chr() 함수는 아스키 코드 값을 문자로 변환하는 함수
    # ord('c') 는 99를 리턴
    # chr(99) 는 'c' 를 리턴
    if (key == ord("q")) or (time.time() - start) >= 5:  # q를 누르거나 5초 지나면 종료
        print(str(blink))
        break

# 생성한 모든 윈도우 제거
cv2.destroyAllWindows()
