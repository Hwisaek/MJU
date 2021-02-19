print('문제 1-1')
kim = {'이름':'김영희',
     '전화번호':'010-3017-4468',
     '성별':'여자',
     '나이':22,
     '대학교':'한국대학교'}
for key in kim:
    print('{}: {}'.format(key,kim[key]))
print('\n문제 1-2')
kim = dict()
kim['이름']='김영희'
kim['전화번호']='010-3017-4468'
kim['성별']='여자'
kim['나이']=22
kim['대학교']='한국대학교'
for key in kim:
    print('{}: {}'.format(key,kim[key]))

print('\n문제 2')
stock={'삼성에스디에스':242000,
       '삼성전자':47000,
       '엔씨소프트':52600,
       '핸디소프트':5120}
stock['골프존']=215000
stock['기아']=56300

while True:
    name = input('주식 이름 ? ')
    if name not in stock:
        print('주식 이름이 없습니다.')
        break;
    print('{}: {}\n'.format(name,stock[name]))
