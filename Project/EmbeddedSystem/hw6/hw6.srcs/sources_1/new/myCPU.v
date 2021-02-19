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

module myCPU(haddr, hwdata, inst_in, clock);
output haddr;
output [0:15] hwdata;
input [0:15] inst_in;
input clock;
wire [0:3] op, r1, r2, r3;
reg [0:15] R[0:15];

initial
    begin
        R[0] <= 0; R[1] <= 1; R[2] <= 2;
        R[3] <= 3; R[4] <= 4; R[5] <= 5;
        R[6] <= 6; R[7] <= 7; R[8] <= 8;
        R[9] <= 9; R[10] <= 10; R[11] <= 11;
        R[12] <= 12; R[13] <= 13; R[14] <= 14; 
        R[15] <= 15;
    end

inst inst_CPU(op, r1, r2, r3, inst_in, clock);
PC PC_CPU(haddr, clock);
ALU ALU_CPU(hwdata, op, r1, r2, r3, R[0:15], clock);

always @ (posedge clock)
    #1 R[r3] <= hwdata;

endmodule

module inst(op, r1, r2, r3, inst_in, clock);
output [0:3] op, r1, r2, r3;
input [0:15] inst_in;
input clock;

assign {op, r1, r2, r3} = inst_in;

endmodule

module PC(haddr, clock);
output reg [0:7] haddr;
input clock;

initial
    haddr = 0;
    
always @ (posedge clock)
    haddr += 1;

endmodule


module ALU(hwdata, op, r1, r2, r3, R[0:15], clock);
output reg [0:15] hwdata;
input [0:3] op, r1, r2, r3;
input [0:15] R[0:15];
input clock;

always @(posedge clock)
    begin
        case (op)
            4'd0 : hwdata = R[r1] + R[r2];
            4'd1 : hwdata = R[r1] - R[r2];
            4'd2 : hwdata = R[r1] & R[r2];
            4'd3 : hwdata = R[r1] | R[r2];
        endcase
    end
    
endmodule


module stimulus;
wire [0:15] hwdata;
wire [0:3] haddr;
reg [0:15] inst_in;
reg clock;

myCPU test(haddr, hwdata, inst_in, clock);

initial
    begin
        clock = 0;
        forever #10 clock = ~clock;
    end

initial
    begin
        inst_in = 0;
        #10 inst_in = 16'h0124;
        #60 inst_in = 16'h1316;
        #60 inst_in = 16'h2F38;
        #60 inst_in = 16'h310A;
    end

endmodule