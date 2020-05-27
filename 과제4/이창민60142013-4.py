import time

print('문제 1')
str = 'Beautiful is better than ugly.'
print(str)
print('위 철학을 메소드 replace()를 사용하여 다음 철학으로 다시 저장')
str = str.replace('Beautiful', 'Explicit')
str = str.replace('ugly', 'implicit')
print(str)


print('문제 2')
url = 'https://docs.python.org/3/tutorial'
print(url[:url.find(':')])
print(url[url.find('docs'):url.find('/3/')])
print(url[url.rfind('tutorial'):])

print('문제 3')
##print("시각 정보(",end='')
##print(time.strftime('%H:%M:%S', time.localtime(time.time())),end='')
##time= input(") 입력 >> ")
time= input("시각 정보(16:30:15) 입력 >> ")
hours, mins, secs = time.split(':')
print('입력 시각 정보:',time)
print(hours,'시 ',mins,'분 ',secs,'초',sep='')
