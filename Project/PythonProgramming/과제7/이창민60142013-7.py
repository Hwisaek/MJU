print('문제 1')
import random
list=[]
for i in range(10):
    num_a=random.randint(1,99)
    list.append(num_a)
print('리스트',list)
list_sort=sorted(list)
print('정렬 리스트',list_sort)
list_reverse = sorted(list,reverse=True)
print('역순 리스트',list_reverse)

print('\n문제 2')
korean=('정렬', '초보자', '내포', '사전')
english=('sorting', 'novice', 'comprehension', 'dictionary')
while True:
    word=input('찾을 단어 입력 ? ')
    if word in korean:
        print(english[korean.index(word)])
    else:
        print(word,'은(는) 리스트에 없습니다.')
        break

print('\n문제 3')
data = [[1,2,3],
        [4,5,6],
        [7,8,9]]

rsum=[0,0,0]
csum=[0,0,0]

for i in range(3):
    for j in range(3):
        rsum[i]+=data[i][j]
        csum[i]+=data[j][i]
print('각 행의 합:',rsum)
print('각 열의 합:',csum)
