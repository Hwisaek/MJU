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