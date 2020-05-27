;현재 커서 위치에 AL에 입력된 아스키코드의 문자를 출력하는 매크로 
PUTC    MACRO   char
        PUSH    AX      ;입력된 값을 스택에 저장 
        MOV     AL, char;AL에 char의 값을 저장 
        MOV     AH, 0Eh ;텔레타이프 출력 
        INT     10h     
        POP     AX
ENDM 
printC macro a,b,c,d
LOCAL   e,e_end,f
    pusha
    mov dx, cs
    mov es, dx
    mov ah, 13h
    mov al, 1
    mov bh, 0
    mov bl, c
    mov cx, offset e_end - offset e
    mov dl, b
    mov dh, a
    mov bp, offset e
    int 10h
    popa
    jmp f
    e DB d
    e_end DB 0
    f:    
endm
setc macro a,b
    push bx
    mov ah,2
    mov bh,0
    mov dl,b
    mov dh,a
    int 10h
    pop bx
endm
;키보드 입력 매크로
INPUT MACRO
    MOV AH,1
    INT 21H
ENDM
;키보드로 받은 입력을 스크린에 출력하는 매크로
OUTPUT MACRO
    MOV AH,2
    INT 21H
ENDM
ORG 100H
JMP START
MSG5 DB "Thank you for using the calculator! press any key... ", 0Dh,0Ah, '$' 
msg7 db 0Dh,0Ah,'*            Enter the angle: $' 
SMTH DB "and something.... $"
sosu1 db ".0$" 
sosu db ".$"  
sin dw 0, 17, 34, 52, 69, 87, 104, 121, 139, 154, 173, 190, 207, 224, 241, 258, 275, 292, 309, 325, 342, 358, 374, 390, 406, 422, 438, 453, 469, 484, 5, 515, 529, 544, 559, 573, 587, 601, 615, 629, 642, 656, 669, 681, 694, 707, 719, 731, 743, 754, 766, 777, 788, 798, 809, 819, 829, 838, 848, 857, 866, 874, 882, 891, 898, 906, 913, 920, 927, 933, 939, 945, 951, 956, 961, 965, 970, 974, 978, 981, 984, 987, 990, 992, 994, 996, 997, 998, 999, 999, 1000  
cos dw 1, 999, 999, 998, 997, 996, 994, 992, 990, 987, 984, 981, 978, 974, 970, 965, 961, 956, 951, 945, 939, 933, 927, 920, 913, 906, 898, 891, 882, 874, 866, 857, 848, 838, 829, 819, 809, 798, 788, 777, 766, 754, 743, 731, 719, 707, 694, 681, 669, 656, 642, 629, 615, 601, 587, 573, 559, 544, 529, 515, 5, 484, 469, 453, 438, 422, 406, 390, 374, 358, 342, 325, 309, 292, 275, 258, 241, 224, 207, 190, 173, 154, 139, 121, 104, 87, 69, 52, 34, 17, 0         
tan dw 0,17,34,52,69,87,105,122,140,158,176,194,212,230,249,267,286,305,324,344,363,383,404,424,445,466,487,509,531,554,577,600,624,649,674,700,726,753,781,809,839,869,900,932,965,1000,1035,1072,1110,1150,1191,1234,1279,1327,1376,1428,1482,1539,1600,1664,1732,1804,1880,1962,2050,2144,2246,2355,2475,2605,2747,2904,3077,3270,3487,3732,4010,4331,4704,5144,5671,6313,7115,8144,9514,11430,14300,19081,28636,57289
OPR DB 0
NUM1 DW 0
NUM2 DW 0
result dw 0
result1 dw 0            
sqrt dw 0
two dw 2
ten DW 10
hun dw 100 
thousand dw 1000     
precision = 10
     
;계산기 시작
START:    
PRINTC 0,0,0000_1111b, "--------------------------------------------------------------------------------"
PRINTC 1,0,0000_1111b, "-                                 CALCULATOR                                   -"
PRINTC 2,0,0000_1111b, "--------------------------------------------------------------------------------"
PRINTC 3,0,0000_1111b, "-      Operator : +(Plus) -(Minus)  *(Multiply) /(Divide) !(Pactorial)         -"
PRINTC 4,0,0000_1111b, "-                 S(Sin) C(Cos) T(Tan) ^(Exponential) G(Sigma) R(Root)         -" 
PRINTC 5,0,0000_1111b, "-                 Q(Quit)                                                      -"
PRINTC 6,0,0000_1111b, "--------------------------------------------------------------------------------"
PRINTC 7,0,0000_1111b, "-                                                                              -"
PRINTC 8,0,0000_1111b, "-                                                                              -"
PRINTC 9,0,0000_1111b, "-                                                                              -"
PRINTC 10,0,0000_1111b,"-                                                                              -" 
PRINTC 11,0,0000_1111b,"-                                                                              -" 
PRINTC 12,0,0000_1111b,"-                                                                              -"
PRINTC 13,0,0000_1111b,"-                                                                              -"
PRINTC 14,0,0000_1111b,"-                                                                              -" 
PRINTC 15,0,0000_1111b,"-                                                                              -"
PRINTC 16,0,0000_1111b,"-                                                                              -"
PRINTC 17,0,0000_1111b,"-                                                                              -"
PRINTC 18,0,0000_1111b,"-                                                                              -"
PRINTC 19,0,0000_1111b,"-                                                                              -"
PRINTC 20,0,0000_1111b,"-                                                                              -"
PRINTC 21,0,0000_1111b,"-                                                                              -"
PRINTC 22,0,0000_1111b,"-                                                                              -"
PRINTC 23,0,0000_1111b,"-                                                                              -"
PRINTC 24,0,0000_1111b,"--------------------------------------------------------------------------------"
  

RESTART:
PRINTC 8,25,0000_1111b,"Enter The operator : "

INPUT_OPR:
INPUT
MOV OPR,AL

cmp opr, 'q'     
je quit       
cmp opr, 'r'
je do_root  
cmp opr, 's'     
je do_sin
cmp opr, 'c'     
je do_cos
cmp opr, 't'     
je do_tan
cmp opr, 'Q'     
je quit       
cmp opr, 'R'
je do_root  
cmp opr, 'S'     
je do_sin
cmp opr, 'C'     
je do_cos
cmp opr, 'T'     
je do_tan     
cmp opr, '!'
je jmp_to_calc
cmp opr, '^'
je jmp_to_calc
cmp opr, 'g'
je jmp_to_calc
cmp opr, 'G'
je jmp_to_calc
cmp opr, '*'
jb wrong_opr
cmp opr, '/'
ja wrong_opr   

    PRINTC 10,25,0000_1111B,"Enter first number : "
    ;첫번째 숫자 입력
    CALL SCAN_NUM        

MOV NUM1,CX    


PRINTC 12,25,0000_1111B, "Enter second number : "

call scan_num

mov num2,cx

printc 14,25,0000_1111b, "Result : "  

cmp opr, '+'
je do_plus      
cmp opr, '-'
je do_minus
cmp opr, '*'
je do_mult
cmp opr, '/'
je do_div    
jmp_to_calc:
cmp opr, '!'
je do_factorial
cmp opr, '^'
je do_exponential
cmp opr, 'g'
je do_sigma
cmp opr, 'G'
je do_sigma

wrong_opr: 
    printc 12,25,0000_1111b,"Wrong operator!" 
    INPUT    
    PRINTC 12,0,0000_1111b, "-                                                                              -"                  
    PRINTC 8,25,0000_1111b,"Enter the operator :      " 
    PRINTC 8,25,0000_1111b,"Enter the operator : "          
        JMP INPUT_OPR
exit:
    prinTC 16,15,0000_1111b,"Thank you for using! press any key to restart. "
    input                                                                                                  
PRINTC 8,0,0000_1111b, "-                                                                              -"
PRINTC 10,0,0000_1111b, "-                                                                              -" 
PRINTC 11,0,0000_1111b, "-                                                                              -"
PRINTC 12,0,0000_1111b,"-                                                                              -"
PRINTC 14,0,0000_1111b,"-                                                                              -"
PRINTC 15,0,0000_1111b,"-                                                                              -" 
PRINTC 16,0,0000_1111b,"-                                                                              -"
    jmp REstart 
    
quit: 
prinTC 16,15,0000_1111b,"Thank you for using! press any key to quit. "
input
mov ah,4ch
int 21h     
                      
;;;;;;;;;;;;;;;;;;;;;;
do_sigma:    
PRINTC 10,25,0000_1111B,"Enter the number : "  
CAll scan_num
MOV AX,0      
cal_sigma:    
ADD AX,CX
LOOP CAL_SIGma   
printc 14,25,0000_1111b, "Result : "
call print_num
jmp exit      
;;;;;;;;;;;;;;;;;;;;;;      
do_exponential:        
PRINTC 10,25,0000_1111B,"Enter the base : "
CALL SCAN_NUM        
MOV NUM1,CX  
PRINTC 12,25,0000_1111B,"Enter the exponent : "
CALL SCAN_NUM
mov ax,1   
MOV BX,NUM1
cal_exponential:
mul Bx
loop cal_exponential  
printc 14,25,0000_1111b, "Result : "
call print_num
jmp exit
;;;;;;;;;;;;;;;;;;;;;;
do_factorial:     
PRINTC 10,25,0000_1111B,"Enter the number : "
CALL SCAN_NUM 
mov ax,1    
cal_factorial:
mul cx
loop cal_factorial  
printc 14,25,0000_1111b, "Result : "
call print_num
jmp exit
;;;;;;;;;;;;;;;;;;;;;;
do_plus:
mov ax, num1  
add ax, num2 
call print_num 
jmp exit
;;;;;;;;;;;;;;;;;;;;;;;
do_minus:
mov ax, num1
sub ax, num2
call print_num    
jmp exit
;;;;;;;;;;;;;;;;;;;;;;;
do_mult:
mov ax, num1
imul num2 
call print_num    
jmp exit
;;;;;;;;;;;;;;;;;;;
do_div:
mov dx, 0        
mov ax, num1
mov bx, num2    
idiv bx
call print_float

print_float     proc    near
push    cx
push    dx

cmp     bx, 0          ;a가 음수인지 확인
jns     div_not_signed  ;양수이면 점프
neg     dx              
div_not_signed:
cmp     ax, 0           ; x의 정수부분이 0인지 확인
jne     checked         ; ax!=0 이면 점프
cmp     dx, 0
jns     checked         ; ax=0 and dx>=0   이면 점프
push    dx
mov     dl, '-'
call    write_char      ; '-' 출력
pop     dx
checked:

; print whole part:
call    print_num-d

; 나머지가 0이면 출력할 필요가 없으므로 확인
cmp     dx, 0
je      done

push    dx
;소수이후 숫자 출력 이전 '.' 출력
mov     dl, '.'
call    write_char
pop     dx

;소수점이후 숫자 출력
mov     cx, precision   ;소수점 아래 출력 자리수 설정
call    print_fraction
done:
pop     dx
pop     cx
ret
print_float     endp   

print_fraction  proc    near
        push    ax
        push    dx
next_fraction:
        ;모든 소수점이 출력되었는지 확인 
        cmp     cx, 0
        jz      end_rem
        dec     cx      ; 소수점자리수 카운터 1감소 

        ;나머지가 0인지 확인, 0이면 출력종료 
        cmp     dx, 0
        je      end_rem

        mov     ax, dx    ;나머지를 AX에 저장 
        xor     dx, dx    ;DX 초기화 
        cmp     ax, 0     ;AX가 0보다 큰지 확인 
        jns     not_sig1  ;0보다 크면 (SF=0)이면 점프 
        not     dx        ;AX가 0보다작으면 DX:AX의 앞부분인 DX를 1로 채우기위해 보수를 취함 
not_sig1:

        imul    ten             ; dx:ax = ax * 10

        idiv    bx              ; ax = dx:ax / bx   (dx - remainder)

        push    dx              ; 나머지를 스택에 저장.
        mov     dx, ax
        cmp     dx, 0
        jns     not_sig2
        neg     dx
not_sig2:
        add     dl, 30h         ; 아스키코드로 변환 
        call    write_char      ; DL 출력 
        pop     dx
        ;다음소수점 출력을위해 점프 
        jmp     next_fraction
end_rem:
        pop     dx
        pop     ax
        jmp     exit
print_fraction  endp

write_char      proc    near
push    ax
mov     ah, 02h
int     21h
pop     ax
ret
write_char      endp

print_num-d       proc    near
push    dx
push    ax
;AX가 0인지 비교후 0이 아니면 점프
cmp     ax, 0
jnz     not_zero-d

mov     dl, '0'
call    write_char
jmp     printed-d

not_zero-d:
; AX가 음수인지 확인하고 음수이면 '-'를 따로 출력하기위해 다시 보수를 취함
cmp     ax, 0
jns     positive-d ;양수이면 점프
neg     ax   ;음수이면 보수를 취함
;음수인 경우 양수로만들고 앞에 '-'를 출력함
mov     dl, '-'
call    write_char
positive-d:
call    print_numx
printed-d:
pop     ax
pop     dx
ret
print_num-d       endp

print_numx      proc    near
push    bx
push    cx
push    dx

; 실제 데이터가 출력되기전에 0이 출력되지 않게하려고 CX를 1로 설정
mov     cx, 1

mov     bx, 10000       ; 2710h -최대숫자가 32767이므로 만의단위부터 출력하기위해 BX를 10000부터
;10씩 나눠서 10000,1000,100,10,1 씩 자리수를 표현하는데 사용

; AX가 0인지 확인 0이면 점프
cmp     ax, 0
jz      end_show

begin_print-d:

; 분모가 0인지 확인하고 0이되면 점프
cmp     bx,0
jz      end_show

; 실질 데이터 출력전에 0이 나타나지 않게 하기위해 사용 CX= 0이면 점프
cmp     cx, 0
je      calc-d
;AX<BX이면 나누는 몫은 0이 될것이므로 AX<BX이면 점프
cmp     ax, bx
jb      skip-d
calc-d:
xor     cx, cx  ; set flag.

xor     dx, dx
div     bx      ; ax = dx:ax / bx   (dx=remainder).

; print last digit
; ah is always zero, so it's ignored
push    dx
mov     dl, al
add     dl, 30h    ; convert to ascii code.
call    write_char
pop     dx

mov     ax, dx  ; get remainder from last div.

skip-d:
; 아래자리수 출력을 위해 BX를 10으로 나눔
push    ax
xor     dx, dx
mov     ax, bx
div     ten     ; ax = dx:ax / 10   (dx=remainder).
mov     bx, ax
pop     ax

jmp     begin_print-d

end_show:

pop     dx
pop     cx
pop     bx
ret
print_numx      endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


do_root: 
printc 10,25,0000_1111b,"Enter the Number : "
call scan_num
mov num1,cx 
mov bx,0
root:
mov dx,0
mov cx,bx ; 이전의 값 저장 
inc bx
mov ax,bx
mul bx
cmp ax,num1
jg  skip_root
mov AX,NUM1 
div bx
cmp ax,bx
jnz root
mov sqrt,bx
push ax
push dx
printc 14,25,0000_1111b, "Result : "
pop dx
pop ax
call print_num 
cmp dx,0
jne root_smth
jmp exit

root_smth   proc near
        printc 15,25,0000_1111b,"and something...."
        jmp exit
root_smth   endp

skip_root:
printc 14,25,0000_1111b, "Result : "
mov ax,cx
call print_num
printc 15,8,0000_1111b,"and something...."
jmp exit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
do_sin:
printc 10,25,0000_1111b,"Enter the angle : "
printc 11,25,0000_1111b,"                 (angle : 0 ~ 90) "
setc 10,43
call scan_num
mov num1,cx 
mov dx,0
mov ax,num1
mul TWO 
add ax,offset sin   ;num1번째 sin값을 찾기위해 ax에 더함
mov bx, ax          ;bx로 이동 
mov ax, [bx]         ; num1번째 sin값을 ax에 저장 
idiv thousand
cmp dx,10
jnc app     ;dx가 0이 아니면 점프 

mov result,ax
cmp dx,5
jz sosu0

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num
jmp exit

app:   

mov result1,dx 
mov dx, result1 
cmp dx,100                 ;
jnc sosu0     


mov result,ax
mov result1,dx  

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num

lea dx, sosu1
mov ah, 09h
int 21h

mov ax, result1
call print_num

jmp exit  

sosu0:

mov result1,dx
sub ax,ax 
mov ax, result1
sub dx, dx
div thousand   
mov result,ax
mov result1,dx  

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num

lea dx, sosu
mov ah, 09h
int 21h

mov ax, result1
call print_num

jmp exit
;;;;;;;;;;;;코사인''''''''''''
do_cos:        
printc 10,25,0000_1111b,"Enter the angle : "      
printc 11,25,0000_1111b,"                 (angle : 0 ~ 90) " 
setc 10,43

call scan_num
mov num1,cx 
mov dx,0
mov ax,num1
mul two        ; 코사인 값들의 데이터 크기가 WORD이
add ax,offset cos
mov bx, ax
mov ax, [bx] 
idiv thousand
cmp dx,10
jnc app1       ;DL이 16보다 크면 

mov result,dx       ;16보다 작으면 나머지를 result에 저장 
cmp dx,5
jz sosu2            ;dl이 5면 점프 
              
printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num
jmp exit

app1:   

mov result1,dx     ;값저장 
mov dx, result1 
cmp dx,100
jnc sosu2             ;DL이 94보다 크면 점프 


mov result,ax
mov result1,dx  

printc 14,25,0000_1111b, "Result : "


mov ax, result
call print_num

lea dx, sosu1
mov ah, 09h
int 21h

mov ax, result1
call print_num

jmp exit  

sosu2:

mov result1,dx
sub ax,ax 
mov ax, result1
sub dx, dx
div thousand   
mov result,ax
mov result1,dx  

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num

lea dx, sosu
mov ah, 09h
int 21h

mov ax, result1
call print_num

jmp exit  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
do_tan:    
printc 10,25,0000_1111b,"Enter the angle : "    
printc 11,25,0000_1111b,"                 (angle : 0 ~ 90) " 
setc 10,43

call scan_num
mov num1,cx 
mov dx,0
mov ax,num1

cmp ax,90
je tan_infinite

mul two 
add ax,offset tan
mov bx, ax
mov ax, [bx] 
idiv thousand
mov result,ax
cmp dx,0        ;
jnz app3

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num
jmp exit

app3:   

mov result1,dx 
mov dx, result1 
cmp dx,100        ;
jnc sosu4     



mov result1,dx  

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num

lea dx, sosu1
mov ah, 09h
int 21h

mov ax, result1
call print_num

jmp exit  

sosu4:

mov result1,dx
mov ax, result1
sub dx, dx
div thousand   
mov result1,dx  

printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num

lea dx, sosu
mov ah, 09h
int 21h

mov ax, result1
call print_num

jmp exit

tan_infinite:
printc 14,25,0000_1111b, "Result : Infinity"  
jmp exit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SCAN_NUM        PROC    NEAR
        PUSH    DX
        PUSH    AX
        PUSH    SI
        MOV     CX, 0 
        MOV     CS:make_minus, 0  ;부호 초기화 


next_digit:

        input

        ; -가 입력되었는지 확인
        CMP     AL, '-'
        JE      set_minus ;-가 입력되면 점프

        ; ENTER 키가 눌렸는지 확인
        CMP     AL, 0Dh  ; AL에 엔터가 입력되었는지 비교
        JNE     not_cr   ; 엔터가 아니면 점프 
        JMP     stop_input  ;엔터가 입력되었으면 입력을 멈춤 
not_cr:


        CMP     AL, 8                   ; 'BACKSPACE' 가 눌렸는지 확인
        JNE     backspace_checked       ; 'BACKSPACE' 가 아니면 점프 
        MOV     DX, 0                   ; 마지막 자리의 숫자를 지우고 자리수를 하나 내리기 위해 
        MOV     AX, CX                  ; 입력된 숫자를 10으로 나눔 
        DIV     CS:ten                  ; AX = DX:AX / 10 (DX는 마지막으로 입력된 숫자이므로 무의미).
        MOV     CX, AX
        PUTC    ' '                     ; 마지막으로 입력된 숫자를 지움 
        PUTC    8                       ; 커서를 한칸 앞으로 움직임 
        JMP     next_digit              ; 다음 숫자 입력으로 점프 
backspace_checked:


        ; allow only digits: 입력된 값이 숫자인지 확인, 숫자 = 30~39 
        CMP     AL, '0'    ;0보다 큰지 확인
        JAE     ok_AE_0    ;0보다 크면 점프 
        JMP     remove_not_digit   ;0보다 작으면 remove_not_digit으로 점프 
ok_AE_0:        
        CMP     AL, '9'    ;9보다 작은지 확인
        JBE     ok_digit   ;9보다 작으면 점프 
remove_not_digit:                          
        PUTC    8       ; 백스페이스를 출력, 커서를 한 칸 앞으로 옮김 
        PUTC    ' '     ; 커서에 공백을 출력하여 입력된 기존의 마지막 문자를 지움 
        PUTC    8       ; 백스페이스를 출력하여 커서를 다시 한칸 앞으로 옮겨서 원래      
        JMP     next_digit ; 다음 숫자 입력을 위해 점프        
ok_digit:


; CX에 저장된 기존의 숫자를 새로 입력된 수를 위해 자리수를 올림 
        PUSH    AX        ;스택에 AX 저장 
        MOV     AX, CX
        MUL     CS:ten  ; DX:AX = AX*10 , 새로 입력된 수를 위해 기존에 입력된 수를 10배해서 자릿수를 높임 
        MOV     CX, AX  ;기본의 값에 자릿수를 올리고 다시 CX에 저장
        POP     AX      ;AX를 다시 불러옴 

        ; 숫자가 16비트 내에서 표현되는지 확인 
        ; AX를 10배했을 때 16비트를 초과하는 수는 DX에 저장 
        CMP     DX, 0  ; 16비트에서 Carry가 발생하는지 확인  
        JNE     too_big  ; 숫자가 너무 커 Carry가 발생하면 점프 

        ; ; ASCII 코드를 숫자로 변환 
        SUB     AL, 30h  

        ; add AL to CX:  입력된 값을 기존의 값에 더함 
        MOV     AH, 0
        MOV     DX, CX      ; 결과가 16bit를 초과할 경우를 대비해 CX를 DX에 저장함 
        ADD     CX, AX
        JC      too_big2    ; 숫자가 16bit 초과시 점프 

        JMP     next_digit  ; 다음 숫자 입력을 위해 점프 

;음수 설정
set_minus:
        MOV     CS:make_minus, 1 ; 해당 주소에 1을 저장 
        JMP     next_digit  ;음수 설정 후 다음 숫자입력으로 점프

too_big2:
        MOV     CX, DX      ; 덧셈을 실행하기전의 수로 CX를 되돌림 
        MOV     DX, 0       ; 덧셈하기전 DX또한 0이었으므로 0으로 되돌림 
too_big:
        MOV     AX, CX
        DIV     CS:ten  ;DX:AX를 10으로 나누고 AX에 저장  reverse last DX:AX = AX*10, make AX = DX:AX / 10
        MOV     CX, AX  
        PUTC    8       ; 백스페이스를 출력, 커서를 한 칸 앞으로 옮김 
        PUTC    ' '     ; 커서에 공백을 출력하여 입력된 기존의 마지막 숫자를 지움 
        PUTC    8       ; 백스페이스를 출력하여 커서를 다시 한칸 앞으로 옮겨서 원래의 자리로 되돌림         
        JMP     next_digit ; 다음 입력(엔터/백스페이스)를 위해 점프 
        
        
stop_input:
        ; 부호를 확인 
        CMP     CS:make_minus, 0  ;음수가 아닌지 확인
        JE      not_minus    ;음수가 아니면 점프 
        NEG     CX           ;음수이면 입력된 첫번째 수(CX)를 보수를 취함 
not_minus:
  ;스택에 저장해놓은 값들을 불러옴 
        POP     SI
        POP     AX
        POP     DX
        RET
make_minus      DB      0       ; 숫자에 -가 입력되면 이 변수를 부호처럼 사용 
SCAN_NUM        ENDP





; AX가 음수인 경우 -출력을 위한 프로시저 
; -를 출력한 이후 PRINT_NUM_UNS로 점프함 
PRINT_NUM       PROC    NEAR
        PUSH    DX
        PUSH    AX

        CMP     AX, 0   ; 결과가 0 인지 비교 
        JNZ     not_zero ;0이 아니면 점프 

        PUTC    '0'
        JMP     printed

not_zero:
        ; AX의 부호를 확인
        CMP     AX, 0    ;AX이 0보다큰지 비교 
        JNS     positive ;SF가 0이면 점프, 0보다 크면 점프  
        NEG     AX       ; 결과에 -가 따로 출력 되므로 결과값을 양수로 되돌림 

        PUTC    '-'      ; - 출력 

positive:
        CALL    PRINT_NUM_UNS   ;양수이면 PRINT_NUM_UNS으로 점프하고 다음 수행될 명령어를 스택에 저장
printed:
        POP     AX
        POP     DX
        RET
PRINT_NUM       ENDP



; 무부호에서 실행되는 프로시저 
; number in AX (not just a single digit)
;  0부터 65535 (FFFF)까지의 값만 허용됨 
PRINT_NUM_UNS   PROC    NEAR
        PUSH    AX  ;레지스터들을 스택에 저장 
        PUSH    BX
        PUSH    CX
        PUSH    DX
                                                        
        ; 결과가 123인 경우 00123을 출력하지않고 숫자앞의 0을 제외한 123만 출력하기위해 사용 
        MOV     CX, 1

        ; 10000으로 나눈후의 몫은 항상 9보다 작거나 같음
        MOV     BX, 10000       ; 2710h, 더한결과의 최대값이 65535이기 때문에 최대 자리수가 만의 단위이므로
        ;해당 자리수 표현을위해 BX를 10000부터 시작해서 AX를 나누고 BX를 10으로 나눠 1000의 자리수를 표현하고 반복
        

        ; AX가 0이면 Print_zero로 점프
        CMP     AX, 0
        JZ      print_zero

begin_print:

        ; 분모(BX)가 0인지 확인 분모(BX)가 0이면 점프              
        ;1의 자리수까지 출력한 경우 출력을 종료 
        CMP     BX,0
        JZ      end_print

        ; 결과가 123인 경우 00123을 출력하지않고 숫자앞의 0을 제외한 123만 출력하기위해 사용 
        CMP     CX, 0
        JE      calc
        ; AX<BX 이면 나눗셈 결과는 0이 되므로 AX<BX이면 점프 
        CMP     AX, BX
        JB      skip
calc:
        MOV     CX, 0   ; set flag.

        MOV     DX, 0
        DIV     BX      ; AX = DX:AX / BX   (DX=아래 자릿수).

        ; 숫자를 출력 
        ADD     AL, 30h    ; ASCII코드로 변환 
        PUTC    AL ;AL의 값을 출력 


        MOV     AX, DX  ; 마지막으로 나눈값의 나머지를 다음자리수 출력을 위해 AX에 저장 

skip:
        ; BX에 BX/10을 넣음 
        PUSH    AX      ;BX를 나누기 전에 기존의 값을 저장 
        MOV     DX, 0   ;DX 값 초기화 
        MOV     AX, BX  ;10으로 나누기 위해 BX의 값을 AX에 저장 
        DIV     CS:ten  ; AX = DX:AX / 10   (DX=remainder).
        MOV     BX, AX  ;10으로 나눈 값을 BX에 저장 
        POP     AX      ;AX의 값을 다시 꺼내옴 

        JMP     begin_print
        
print_zero:
        PUTC    '0'
        
end_print:

        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
PRINT_NUM_UNS   ENDP