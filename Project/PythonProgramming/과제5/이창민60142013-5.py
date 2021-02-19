print('문제 1')
mask=0xff
for i in range(-7,1):
    print('10진수: {0:3d} '.format(i),end='')
    print('2진수: {0:8b} 8진수: {0:4o} 16진수: {0:2x}'.format(i&mask, i&mask, i&mask))

print('\n문제 2')
num_a = int(input('정수 입력 >> '))
num_b = int(input('2의 지수승 입력 >> '))

print('정수 ',num_a,' << ',num_b,', 결과: ',num_a<<num_b,sep='')
print('정수 ',num_a,' * 2**',num_b,', 결과: ',num_a*(2**num_b),sep='')
print('이진수(32비트): {:32b} 정수: {}'.format(num_a,num_a))
print('이진수(32비트): {:32b} 정수: {} << {}'.format(num_a<<num_b,num_a,num_b))
print('이진수(32비트): {:32b} 정수: {} * 2**{}'.format(num_a*2**num_b,num_a,num_b))
