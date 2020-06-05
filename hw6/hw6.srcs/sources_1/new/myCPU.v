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
reg [0:3] R[0:15];
endmodule

module inst(op, r1, r2, r3, inst_in);
output [0:3] op, r1, r2, r3;
input [0:15] inst_in;

assign {op, r1, r2, r3} = inst_in;

endmodule

module PC(haddr);
output haddr;
endmodule

module ALU(hwdata, op, r1, r2, R);
output reg [0:3] hwdata;
input [0:3] op, r1, r2;
input [0:3] R[0:15];


always @(op)
begin
    case (op)
        4'd0 : hwdata = R[r1] + R[r2];
        4'd1 : hwdata = R[r1] + R[r2];
        4'd2 : hwdata = R[r1] + R[r2];
        4'd3 : hwdata = R[r1] + R[r2];

    endcase
end
endmodule

module stimulus;
wire [0:3] hwdata;
reg [0:3]  r1, r2, op, R[0:15];


ALU test(hwdata, op, r1, r2, R);

initial
    begin
        op = 4'b0000;
        R[0] = 4'd0;
        R[1] = 4'd1;
        R[2] = 4'd2;
        R[3] = 4'd3;
        R[4] = 4'd4;
    end
    
initial
    $monitor($time, "R[0] = %b, R[1] = %b, R[2] = %b, R[3] = %b",R[0], R[1], R[2], R[3]); 
    
endmodule