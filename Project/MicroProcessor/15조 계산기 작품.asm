;���� Ŀ�� ��ġ�� AL�� �Էµ� �ƽ�Ű�ڵ��� ���ڸ� ����ϴ� ��ũ�� 
PUTC    MACRO   char
        PUSH    AX      ;�Էµ� ���� ���ÿ� ���� 
        MOV     AL, char;AL�� char�� ���� ���� 
        MOV     AH, 0Eh ;�ڷ�Ÿ���� ��� 
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
;Ű���� �Է� ��ũ��
INPUT MACRO
    MOV AH,1
    INT 21H
ENDM
;Ű����� ���� �Է��� ��ũ���� ����ϴ� ��ũ��
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
     
;���� ����
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
    ;ù��° ���� �Է�
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

cmp     bx, 0          ;a�� �������� Ȯ��
jns     div_not_signed  ;����̸� ����
neg     dx              
div_not_signed:
cmp     ax, 0           ; x�� �����κ��� 0���� Ȯ��
jne     checked         ; ax!=0 �̸� ����
cmp     dx, 0
jns     checked         ; ax=0 and dx>=0   �̸� ����
push    dx
mov     dl, '-'
call    write_char      ; '-' ���
pop     dx
checked:

; print whole part:
call    print_num-d

; �������� 0�̸� ����� �ʿ䰡 �����Ƿ� Ȯ��
cmp     dx, 0
je      done

push    dx
;�Ҽ����� ���� ��� ���� '.' ���
mov     dl, '.'
call    write_char
pop     dx

;�Ҽ������� ���� ���
mov     cx, precision   ;�Ҽ��� �Ʒ� ��� �ڸ��� ����
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
        ;��� �Ҽ����� ��µǾ����� Ȯ�� 
        cmp     cx, 0
        jz      end_rem
        dec     cx      ; �Ҽ����ڸ��� ī���� 1���� 

        ;�������� 0���� Ȯ��, 0�̸� ������� 
        cmp     dx, 0
        je      end_rem

        mov     ax, dx    ;�������� AX�� ���� 
        xor     dx, dx    ;DX �ʱ�ȭ 
        cmp     ax, 0     ;AX�� 0���� ū�� Ȯ�� 
        jns     not_sig1  ;0���� ũ�� (SF=0)�̸� ���� 
        not     dx        ;AX�� 0���������� DX:AX�� �պκ��� DX�� 1�� ä������� ������ ���� 
not_sig1:

        imul    ten             ; dx:ax = ax * 10

        idiv    bx              ; ax = dx:ax / bx   (dx - remainder)

        push    dx              ; �������� ���ÿ� ����.
        mov     dx, ax
        cmp     dx, 0
        jns     not_sig2
        neg     dx
not_sig2:
        add     dl, 30h         ; �ƽ�Ű�ڵ�� ��ȯ 
        call    write_char      ; DL ��� 
        pop     dx
        ;�����Ҽ��� ��������� ���� 
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
;AX�� 0���� ���� 0�� �ƴϸ� ����
cmp     ax, 0
jnz     not_zero-d

mov     dl, '0'
call    write_char
jmp     printed-d

not_zero-d:
; AX�� �������� Ȯ���ϰ� �����̸� '-'�� ���� ����ϱ����� �ٽ� ������ ����
cmp     ax, 0
jns     positive-d ;����̸� ����
neg     ax   ;�����̸� ������ ����
;������ ��� ����θ���� �տ� '-'�� �����
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

; ���� �����Ͱ� ��µǱ����� 0�� ��µ��� �ʰ��Ϸ��� CX�� 1�� ����
mov     cx, 1

mov     bx, 10000       ; 2710h -�ִ���ڰ� 32767�̹Ƿ� ���Ǵ������� ����ϱ����� BX�� 10000����
;10�� ������ 10000,1000,100,10,1 �� �ڸ����� ǥ���ϴµ� ���

; AX�� 0���� Ȯ�� 0�̸� ����
cmp     ax, 0
jz      end_show

begin_print-d:

; �и� 0���� Ȯ���ϰ� 0�̵Ǹ� ����
cmp     bx,0
jz      end_show

; ���� ������ ������� 0�� ��Ÿ���� �ʰ� �ϱ����� ��� CX= 0�̸� ����
cmp     cx, 0
je      calc-d
;AX<BX�̸� ������ ���� 0�� �ɰ��̹Ƿ� AX<BX�̸� ����
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
; �Ʒ��ڸ��� ����� ���� BX�� 10���� ����
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
mov cx,bx ; ������ �� ���� 
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
add ax,offset sin   ;num1��° sin���� ã������ ax�� ����
mov bx, ax          ;bx�� �̵� 
mov ax, [bx]         ; num1��° sin���� ax�� ���� 
idiv thousand
cmp dx,10
jnc app     ;dx�� 0�� �ƴϸ� ���� 

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
;;;;;;;;;;;;�ڻ���''''''''''''
do_cos:        
printc 10,25,0000_1111b,"Enter the angle : "      
printc 11,25,0000_1111b,"                 (angle : 0 ~ 90) " 
setc 10,43

call scan_num
mov num1,cx 
mov dx,0
mov ax,num1
mul two        ; �ڻ��� ������ ������ ũ�Ⱑ WORD��
add ax,offset cos
mov bx, ax
mov ax, [bx] 
idiv thousand
cmp dx,10
jnc app1       ;DL�� 16���� ũ�� 

mov result,dx       ;16���� ������ �������� result�� ���� 
cmp dx,5
jz sosu2            ;dl�� 5�� ���� 
              
printc 14,25,0000_1111b, "Result : "

mov ax, result
call print_num
jmp exit

app1:   

mov result1,dx     ;������ 
mov dx, result1 
cmp dx,100
jnc sosu2             ;DL�� 94���� ũ�� ���� 


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
        MOV     CS:make_minus, 0  ;��ȣ �ʱ�ȭ 


next_digit:

        input

        ; -�� �ԷµǾ����� Ȯ��
        CMP     AL, '-'
        JE      set_minus ;-�� �ԷµǸ� ����

        ; ENTER Ű�� ���ȴ��� Ȯ��
        CMP     AL, 0Dh  ; AL�� ���Ͱ� �ԷµǾ����� ��
        JNE     not_cr   ; ���Ͱ� �ƴϸ� ���� 
        JMP     stop_input  ;���Ͱ� �ԷµǾ����� �Է��� ���� 
not_cr:


        CMP     AL, 8                   ; 'BACKSPACE' �� ���ȴ��� Ȯ��
        JNE     backspace_checked       ; 'BACKSPACE' �� �ƴϸ� ���� 
        MOV     DX, 0                   ; ������ �ڸ��� ���ڸ� ����� �ڸ����� �ϳ� ������ ���� 
        MOV     AX, CX                  ; �Էµ� ���ڸ� 10���� ���� 
        DIV     CS:ten                  ; AX = DX:AX / 10 (DX�� ���������� �Էµ� �����̹Ƿ� ���ǹ�).
        MOV     CX, AX
        PUTC    ' '                     ; ���������� �Էµ� ���ڸ� ���� 
        PUTC    8                       ; Ŀ���� ��ĭ ������ ������ 
        JMP     next_digit              ; ���� ���� �Է����� ���� 
backspace_checked:


        ; allow only digits: �Էµ� ���� �������� Ȯ��, ���� = 30~39 
        CMP     AL, '0'    ;0���� ū�� Ȯ��
        JAE     ok_AE_0    ;0���� ũ�� ���� 
        JMP     remove_not_digit   ;0���� ������ remove_not_digit���� ���� 
ok_AE_0:        
        CMP     AL, '9'    ;9���� ������ Ȯ��
        JBE     ok_digit   ;9���� ������ ���� 
remove_not_digit:                          
        PUTC    8       ; �齺���̽��� ���, Ŀ���� �� ĭ ������ �ű� 
        PUTC    ' '     ; Ŀ���� ������ ����Ͽ� �Էµ� ������ ������ ���ڸ� ���� 
        PUTC    8       ; �齺���̽��� ����Ͽ� Ŀ���� �ٽ� ��ĭ ������ �Űܼ� ����      
        JMP     next_digit ; ���� ���� �Է��� ���� ����        
ok_digit:


; CX�� ����� ������ ���ڸ� ���� �Էµ� ���� ���� �ڸ����� �ø� 
        PUSH    AX        ;���ÿ� AX ���� 
        MOV     AX, CX
        MUL     CS:ten  ; DX:AX = AX*10 , ���� �Էµ� ���� ���� ������ �Էµ� ���� 10���ؼ� �ڸ����� ���� 
        MOV     CX, AX  ;�⺻�� ���� �ڸ����� �ø��� �ٽ� CX�� ����
        POP     AX      ;AX�� �ٽ� �ҷ��� 

        ; ���ڰ� 16��Ʈ ������ ǥ���Ǵ��� Ȯ�� 
        ; AX�� 10������ �� 16��Ʈ�� �ʰ��ϴ� ���� DX�� ���� 
        CMP     DX, 0  ; 16��Ʈ���� Carry�� �߻��ϴ��� Ȯ��  
        JNE     too_big  ; ���ڰ� �ʹ� Ŀ Carry�� �߻��ϸ� ���� 

        ; ; ASCII �ڵ带 ���ڷ� ��ȯ 
        SUB     AL, 30h  

        ; add AL to CX:  �Էµ� ���� ������ ���� ���� 
        MOV     AH, 0
        MOV     DX, CX      ; ����� 16bit�� �ʰ��� ��츦 ����� CX�� DX�� ������ 
        ADD     CX, AX
        JC      too_big2    ; ���ڰ� 16bit �ʰ��� ���� 

        JMP     next_digit  ; ���� ���� �Է��� ���� ���� 

;���� ����
set_minus:
        MOV     CS:make_minus, 1 ; �ش� �ּҿ� 1�� ���� 
        JMP     next_digit  ;���� ���� �� ���� �����Է����� ����

too_big2:
        MOV     CX, DX      ; ������ �����ϱ����� ���� CX�� �ǵ��� 
        MOV     DX, 0       ; �����ϱ��� DX���� 0�̾����Ƿ� 0���� �ǵ��� 
too_big:
        MOV     AX, CX
        DIV     CS:ten  ;DX:AX�� 10���� ������ AX�� ����  reverse last DX:AX = AX*10, make AX = DX:AX / 10
        MOV     CX, AX  
        PUTC    8       ; �齺���̽��� ���, Ŀ���� �� ĭ ������ �ű� 
        PUTC    ' '     ; Ŀ���� ������ ����Ͽ� �Էµ� ������ ������ ���ڸ� ���� 
        PUTC    8       ; �齺���̽��� ����Ͽ� Ŀ���� �ٽ� ��ĭ ������ �Űܼ� ������ �ڸ��� �ǵ���         
        JMP     next_digit ; ���� �Է�(����/�齺���̽�)�� ���� ���� 
        
        
stop_input:
        ; ��ȣ�� Ȯ�� 
        CMP     CS:make_minus, 0  ;������ �ƴ��� Ȯ��
        JE      not_minus    ;������ �ƴϸ� ���� 
        NEG     CX           ;�����̸� �Էµ� ù��° ��(CX)�� ������ ���� 
not_minus:
  ;���ÿ� �����س��� ������ �ҷ��� 
        POP     SI
        POP     AX
        POP     DX
        RET
make_minus      DB      0       ; ���ڿ� -�� �ԷµǸ� �� ������ ��ȣó�� ��� 
SCAN_NUM        ENDP





; AX�� ������ ��� -����� ���� ���ν��� 
; -�� ����� ���� PRINT_NUM_UNS�� ������ 
PRINT_NUM       PROC    NEAR
        PUSH    DX
        PUSH    AX

        CMP     AX, 0   ; ����� 0 ���� �� 
        JNZ     not_zero ;0�� �ƴϸ� ���� 

        PUTC    '0'
        JMP     printed

not_zero:
        ; AX�� ��ȣ�� Ȯ��
        CMP     AX, 0    ;AX�� 0����ū�� �� 
        JNS     positive ;SF�� 0�̸� ����, 0���� ũ�� ����  
        NEG     AX       ; ����� -�� ���� ��� �ǹǷ� ������� ����� �ǵ��� 

        PUTC    '-'      ; - ��� 

positive:
        CALL    PRINT_NUM_UNS   ;����̸� PRINT_NUM_UNS���� �����ϰ� ���� ����� ��ɾ ���ÿ� ����
printed:
        POP     AX
        POP     DX
        RET
PRINT_NUM       ENDP



; ����ȣ���� ����Ǵ� ���ν��� 
; number in AX (not just a single digit)
;  0���� 65535 (FFFF)������ ���� ���� 
PRINT_NUM_UNS   PROC    NEAR
        PUSH    AX  ;�������͵��� ���ÿ� ���� 
        PUSH    BX
        PUSH    CX
        PUSH    DX
                                                        
        ; ����� 123�� ��� 00123�� ��������ʰ� ���ھ��� 0�� ������ 123�� ����ϱ����� ��� 
        MOV     CX, 1

        ; 10000���� �������� ���� �׻� 9���� �۰ų� ����
        MOV     BX, 10000       ; 2710h, ���Ѱ���� �ִ밪�� 65535�̱� ������ �ִ� �ڸ����� ���� �����̹Ƿ�
        ;�ش� �ڸ��� ǥ�������� BX�� 10000���� �����ؼ� AX�� ������ BX�� 10���� ���� 1000�� �ڸ����� ǥ���ϰ� �ݺ�
        

        ; AX�� 0�̸� Print_zero�� ����
        CMP     AX, 0
        JZ      print_zero

begin_print:

        ; �и�(BX)�� 0���� Ȯ�� �и�(BX)�� 0�̸� ����              
        ;1�� �ڸ������� ����� ��� ����� ���� 
        CMP     BX,0
        JZ      end_print

        ; ����� 123�� ��� 00123�� ��������ʰ� ���ھ��� 0�� ������ 123�� ����ϱ����� ��� 
        CMP     CX, 0
        JE      calc
        ; AX<BX �̸� ������ ����� 0�� �ǹǷ� AX<BX�̸� ���� 
        CMP     AX, BX
        JB      skip
calc:
        MOV     CX, 0   ; set flag.

        MOV     DX, 0
        DIV     BX      ; AX = DX:AX / BX   (DX=�Ʒ� �ڸ���).

        ; ���ڸ� ��� 
        ADD     AL, 30h    ; ASCII�ڵ�� ��ȯ 
        PUTC    AL ;AL�� ���� ��� 


        MOV     AX, DX  ; ���������� �������� �������� �����ڸ��� ����� ���� AX�� ���� 

skip:
        ; BX�� BX/10�� ���� 
        PUSH    AX      ;BX�� ������ ���� ������ ���� ���� 
        MOV     DX, 0   ;DX �� �ʱ�ȭ 
        MOV     AX, BX  ;10���� ������ ���� BX�� ���� AX�� ���� 
        DIV     CS:ten  ; AX = DX:AX / 10   (DX=remainder).
        MOV     BX, AX  ;10���� ���� ���� BX�� ���� 
        POP     AX      ;AX�� ���� �ٽ� ������ 

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