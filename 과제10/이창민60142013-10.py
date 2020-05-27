# 6장 도전! 프로그래밍 4번
print('6장 도전! 프로그래밍 4번')
from random import choice
from random import sample
total = 20.
dcs = {'가위':'보오', '바위':'가위', '보오':'바위'}
tit = ['비김',0.0, '철수',0.0, '영희',0.0, '승자']
rsp = ('가위', '바위', '보오')
print('*'*20)
print('{:4} {:4} {:4}'.format(tit[2], tit[4], tit[6]))
print('*'*20)
for _ in range(int(total)):
    #철수의 결정
    cs = choice(rsp)
    #영희 결정
    yh = choice(rsp)
    
    #철수와 영희의 결정 출력
    print('{:4} {:3}'.format(cs, yh), end = ' ')
    
    #비기는 조건
    if cs == yh:
        index = 0 #비김 출력
        tit[index+1] += 1
    #철수가 이기는 조건
    elif dcs[cs] == yh:
        index = 2  #철수 출력
        tit[index+1] += 1
    #영희가 이기는 조건
    else: 
        index = 4  #영희 출력
        tit[index+1] += 1
    #게임 결과 출력
    print('{0:3}{1:.0f}'.format(tit[index],tit[index+1])) 
print()
print('총 게임 회수: {:.0f}  비긴 회수: {:.0f}'.format(total, tit[1]))
print('철수 승률: {:.2f}'.format(tit[3]/(total-tit[1])))
print('영희 승룰: {:.2f}'.format(tit[5]/(total-tit[1])))
print('*'*20)

# 6장 도전! 프로그래밍 6번
print('\n6장 도전! 프로그래밍 6번')

A = set(sample(list(range(1, 21)), 5))
B = set(sample(list(range(1, 21)), 5))


print('A = {}'.format(A))
print('B = {}'.format(B))
print()
print('A | B = {}'.format(A|B))
print('A & B = {}'.format(A&B))
print('A - B = {}'.format(A-B))
print('A ^ B = {}'.format(A^B))
print()
print('A | B = {}'.format(A.union(B)))
print('A & B = {}'.format(A.intersection(B)))
print('A - B = {}'.format(A.difference(B)))
print('A ^ B = {}'.format(A.symmetric_difference(B)))

