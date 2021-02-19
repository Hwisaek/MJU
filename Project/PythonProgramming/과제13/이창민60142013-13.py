import math
import random
import turtle

# 9장 도전! 프로그래밍 1번
print('9장 도전! 프로그래밍 1번')

r = random.random()*10
r = round(r,2)
pi = math.pi

def getarea(r):
    return r**2 * pi

print('원의 반지름: {}'.format(r))
print('원주율 pi : {:.4f}'.format(pi))
print('반지름 {}인 원의 면적은 {:.2f}'.format(r, getarea(r)))

# 9장 도전! 프로그래밍 3번
print('\n9장 도전! 프로그래밍 3번\n')

cols = ['yellow', 'red', 'blue']

turtle.setup(500, 500)
turtle.hideturtle()
turtle.bgcolor('black')
turtle.speed(0)

turtle.pu()
turtle.goto(0,0)
turtle.pd()

for i in range(200):
    turtle.pencolor(cols[i % len(cols)])
    turtle.width(i/200 + 1)
    turtle.forward(i*2)
    turtle.left(119)
