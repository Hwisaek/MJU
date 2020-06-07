`timescale 1ns / 1ps
/*
ALU : ���ο� ������ �� �� �ִ� ��� ����  case ���� �̿�
PM : �ܺο� �ִ� ���α׷� �޸�, CPU�� ������ �� �ִ� ��ɵ��� 2������ ����Ǿ� ���� 
CPU�� �о�ͼ� ������ �� �ֵ��� �ּҸ� �߻������� �ʿ䰡 ����
�ּ� ���� ������ ���� haddr��� ��ȣ. CPU -> PM���� ��
haddr�� CPU ���ο��� ���� PC���� ��
PC(���α׷� ī����): 0���� �����ؼ� ��� ���������ָ鼭 �ڵ带 ���پ� �������� �Ǵ� ��.
������ �ڵ带 CPU���� �ڵ带 ���ظ� �ؼ� ALU�� ���� ������ ��Ŵ

CPU�� ��� INST ����
16��Ʈ¥�� ���ü�踦 ���� CPU
 16��Ʈ¥�� �������� ��� 
4��Ʈ - op�ڵ�  �� 16���� ���
4��Ʈ - �������� 1
4��Ʈ - �������� 2
4��Ʈ - �������� 3

PC���� ������ �� ���� Ȯ���ؼ� ��Ƽ�ķ��� �ڵ忡�� CPU�� ��ɰ��� �Ҵ���

������ ALU���� ������.

�� ��� ���� �������Ϳ� ������ ��.
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