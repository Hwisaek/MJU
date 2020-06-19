# 11장 도전! 프로그래밍 2번
print('11장 도전! 프로그래밍 2번')
def divide(x, y):
    try:
        n = x/y
    except ZeroDivisionError as e:
        print("0으로는 나눌 수 없습니다.")
    else:
        print("결과: {}".format(n))

divide(3.2,2)
divide(5.4,0)


# 11장 도전! 프로그래밍 3번
print('11장 도전! 프로그래밍 3번')
uyear = {1:'freshman', 2:'sophomore', 3:'junior', 4:'senior'}

try:
    grade = int(input('대학 몇 학년이지요?'))
    if(grade < 1 or grade > 4):
        raise Exception('1에서 4사이의 정수를 입력하세요')
except Exception as e:
    print('예외 발생 이름: {}'.format(type(e)))
    print('예외 발생 이유: {}'.format(e))
else:
    print("{}학년: {}".format(grade, uyear[grade]))
finally:
    print("예외처리가 잘 되는군요!")
