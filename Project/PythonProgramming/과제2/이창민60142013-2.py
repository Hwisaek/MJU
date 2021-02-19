print("문제 1")
str1=input("문자열 1: ")
str2=input("문자열 2: ")
print(str1+" "+str2)

print("문제 2")
speed=input("차의 속도를 입력(km) >> ")
speed2=int(speed)/1.61
print(speed,"(km)은 ",speed2," 마일(miles) 입니다.")

print("문제 3")
a=40120
b=6378.1*3.141592*2
print("알려진 지구 둘레: ",a)
print("지구와 같은 원 둘레: ",b)
c=float(a)-float(b)
print("차이: ",c,"(km)")
