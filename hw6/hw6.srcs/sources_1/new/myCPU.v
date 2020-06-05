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