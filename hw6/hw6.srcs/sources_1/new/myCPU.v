`timescale 1ns / 1ps
/*
ALU : 내부에 연산을 할 수 있는 계산 유닛  case 문을 이용
PM : 외부에 있는 프로그램 메모리, CPU가 실행할 수 있는 명령들이 2진수로 저장되어 있음 
CPU가 읽어와서 실행할 수 있도록 주소를 발생시켜줄 필요가 있음
주소 값을 보내는 것이 haddr라는 신호. CPU -> PM으로 감
haddr은 CPU 내부에서 보면 PC에서 감
PC(프로그램 카운터): 0부터 시작해서 계속 증가시켜주면서 코드를 한줄씩 가져오면 되는 것.
가져온 코드를 CPU에서 코드를 이해를 해서 ALU를 통해 실행을 시킴

CPU의 명령 INST 정의
16비트짜리 명령체계를 가진 CPU
 16비트짜리 레지스터 사용 
4비트 - op코드  총 16개의 명령
4비트 - 레지스터 1
4비트 - 레지스터 2
4비트 - 레지스터 3

PC값이 나오면 그 값을 확인해서 스티뮬러스 코드에서 CPU에 명령값을 할당함

연산을 ALU에서 실행함.

그 결과 값을 레지스터에 저장을 함.
*/

module myCPU(haddr, hwdata, inst_in);
output haddr, hwdata;
input [0:15] inst_in;
wire [0:3] op, r1, r2, r3;
reg [0:15] R;

endmodule

module inst(op, r1, r2, r3, inst_in);
output [0:3] op, r1, r2, r3;
input [0:15] inst_in;

assign {op, r1, r2, r3} = inst_in;

endmodule

module PC(haddr);
output haddr;
endmodule

module ALU(hwdata);
output hwdata;
endmodule

module stimulus;
wire [0:3] op, r1, r2, r3;
reg [0:15] inst_in;
inst tets(op, r1, r2, r3, inst_in);

initial
    begin
        inst_in = 16'b0001001001001000;
    end

initial
    $monitor($time, "op = %b, r1 = %b, r2 = %b, r3 = %b",op, r1, r2, r3); 
    
endmodule