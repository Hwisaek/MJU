print('문제 1')
num = int(input('소수(prime number)인지를 판별한 2 이상의 정수 입력 >> '))
prime=True
if(num<2):
    print('2 이상의 정수를 입력해주세요')
else:    
    for i in range(2,num):
        if(num%i==0):
            prime=False
            break

if prime:
    print('정수 {}는 소수입니다.'.format(num))
else:
    
    print('정수 {}는 소수가 아닙니다.'.format(num))
    

print('문제 2')
import random
num_a=random.randint(1,100)
print('첫 값은',num_a,'입니다.')
while True:
    opr = input('산술 연산의 종류를 입력하세요. >> ')
    if opr=='+':
        num_b=int(input('두 번째 피연산자를 입력하세요. >> '))
        print(num_a,'+',num_b,'=',num_a+num_b,'\n')
    elif opr=='-':
        num_b=int(input('두 번째 피연산자를 입력하세요. >> '))
        print(num_a,'-',num_b,'=',num_a-num_b,'\n')
    elif opr=='*':
        num_b=int(input('두 번째 피연산자를 입력하세요. >> '))
        print(num_a,'*',num_b,'=',num_a*num_b,'\n')
    elif opr=='/':
        num_b=int(input('두 번째 피연산자를 입력하세요. >> '))
        print(num_a,'/',num_b,'=',num_a/num_b,'\n')
    elif opr=='%':
        num_b=int(input('두 번째 피연산자를 입력하세요. >> '))
        print(num_a,'%',num_b,'=',num_a%num_b,'\n')
    else:
        print('종료'.center(32,'*'))
        break;
