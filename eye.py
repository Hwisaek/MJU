# 눈깜빡임 감지 코드
import cv2
import dlib
from math import hypot
import time
start = time.time()  # 시작 시간 저장

# Returns the default face detector
detector = dlib.get_frontal_face_detector()
predictor = dlib.shape_predictor("./shape_predictor_68_face_landmarks.dat")
font = cv2.FONT_HERSHEY_SIMPLEX
r_eye_points = [42, 43, 44, 45, 46, 47]
l_eye_poits = [36, 37, 38, 39, 40, 41]


def midpoint(p1, p2):
    return int((p1.x + p2.x) / 2), int((p1.y + p2.y) / 2)


def get_blinking_ratio(eye_points, facial_landmarks):
    left_point = (facial_landmarks.part(
        eye_points[0]).x, facial_landmarks.part(eye_points[0]).y)
    right_point = (facial_landmarks.part(
        eye_points[3]).x, facial_landmarks.part(eye_points[3]).y)
    center_top = midpoint(facial_landmarks.part(
        eye_points[1]), facial_landmarks.part(eye_points[2]))
    center_bottom = midpoint(facial_landmarks.part(
        eye_points[5]), facial_landmarks.part(eye_points[4]))

    hor_line = cv2.line(image, left_point, right_point, (0, 255, 0), 2)
    ver_line = cv2.line(image, center_top, center_bottom, (0, 255, 0), 2)

    hor_line_lenght = hypot(
        (left_point[0] - right_point[0]), (left_point[1] - right_point[1]))
    ver_line_lenght = hypot(
        (center_top[0] - center_bottom[0]), (center_top[1] - center_bottom[1]))

    ratio = hor_line_lenght / ver_line_lenght
    return ratio


capture = cv2.VideoCapture(0)
capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
capture.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
# 프레임의 너비와 높이의 속성 설정
j = 0  # 현재 눈 상태 설정 0이면 뜬 상태, 1이면 감은 상태
blink = 0 # 깜빡임 횟수
while True:
    _, image = capture.read()

    # convert frame to gray
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    faces = detector(gray)

    for face in faces:
        landmarks = predictor(gray, face)

        left_eye_ratio = get_blinking_ratio(
            l_eye_poits, landmarks)
        right_eye_ratio = get_blinking_ratio(
            r_eye_points, landmarks)

        if left_eye_ratio >= 7.5 or right_eye_ratio >= 7.5:
            if j == 0:
                cv2.putText(image, "blinking", (50, 50), font, 2, (255, 0, 0))
                print("blinking")
                blink += 1
                j += 1

        if j != 0:
            j += 1
        if j == 10:
            j = 0

    cv2.imshow("Frame", image)
    key = cv2.waitKey(1) & 0xFF

    # 깜빡임 횟수를 txt로 저장
    f = open("count_blink.txt", 'w')
    data = "blinking: {}".format(blink)
    f.write(data)
    f.close()

    # if the `q` key was pressed, break from the loop
    if (key == ord("q")) or (time.time()-start)>=5: # q를 누르거나 5초 지나면 종료
        print(str(blink))
        break

cv2.destroyAllWindows()
