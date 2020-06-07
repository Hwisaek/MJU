# 7장 도전! 프로그래밍 4번
print('7장 도전! 프로그래밍 4번')

planets = [('수성', 2439, 0.4), ('금성', 6052, 0.7), ('태양', 695000, 0),
           ('지구', 6378, 1), ('화성', 3390, 1.5), ('목성', 71492, 5.2)]

print('태양계 행성의 크기(반지름)로 정렬')
planets.sort(key = lambda x : x[1], reverse = True)
print(planets)

print('\n태양계 행성의 태양과의 거리로 정렬')
planets.sort(key = lambda x : x[2])
print(planets)

# 7장 도전! 프로그래밍 5번
print('\n7장 도전! 프로그래밍 5번\n')

import random

def setsequence(start, end, count, array):
    for _ in range(count):
        array.append(random.randint(start, end))

cels = []
setsequence(1, 100, 9, cels)
cels.sort()
fahr = list(map(lambda temp : temp * 9/5 + 32, cels))

print('섭씨온도: ',cels)
print('화씨온도: ',fahr)
for c, f in zip(cels, fahr):
    print('섭씨온도 {} => 화씨 {}'.format(c, f))
