# 7장 도전! 프로그래밍 1번
print('7장 도전! 프로그래밍 1번')
def factorial1(n):
    if(n==1):
        return n
    else :
        return n*factorial1(n-1)
    
def factorial2(n):
    num = 1
    for i in range(2,n+1):
        num *= i
    return num

print('\nfactorial1(n)')
print("5! = {}".format(factorial1(5)))
print("10! = {}".format(factorial1(10)))
print("20! = {}".format(factorial1(20)))
print('\nfactorial2(n)')
print("5! = {}".format(factorial2(5)))
print("10! = {}".format(factorial2(10)))
print("20! = {}".format(factorial2(20)))

# 7장 도전! 프로그래밍 2번
print('\n7장 도전! 프로그래밍 2번\n')
def getinterrest(money, rate, year):
    return money * (1+rate)**year
money = 300000
rate = 0.05
print('예금 원금: {}'.format(money))
for i in range(2,9,2):
    print('{}년 총액: {:.2f}'.format(i, getinterrest(money, rate,i)))
