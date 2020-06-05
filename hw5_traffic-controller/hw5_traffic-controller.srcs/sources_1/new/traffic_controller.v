`timescale 1ns / 1ps
`define TRUE 1'b1
`define FALSE 1'b0

// ����

`define Y2RDELAY 3 // ��������� ���������� ���ϴ� ����
`define R2GDELAY 2 // ���������� ������� ���ϴ� ����
module sig_control (hwy, cntry1, cntry2, P, X1, X2, X3, clock, clear);
// I/O ��Ʈ
output [1:0] hwy, cntry1, cntry2, P;
// ���, �����, ������ 3���� ������ ��ȣ�� ���� 2 ��Ʈ ���
reg [1:0] hwy, cntry1, cntry2, P;
// ��� ��ȣ�� �������ͷ� ����
input X1, X2, X3;
// ���� ���̸�, �������� Ȥ�� Ⱦ�ܺ����� ���� ������ ����Ų��. �ƴϸ� ����
input clock, clear;
parameter RED = 2'd0,
YELLOW = 2'd1,
GREEN = 2'd2;
// ���� ���� �ֿ䵵�� ��������1 ��������2 Ⱦ�ܺ���
parameter S0 = 3'd0, // ��� ������ ������ ������
S1 = 3'd1, // ����� ������ ������ ������
S2 = 3'd2, // ������ ������ ������ ������
S3 = 3'd3, // ������ ��� ��� ���
S4 = 3'd4; // ������ ����� ����� ������

// ���� ���� ����
reg [2:0] state;
reg [2:0] next_state;
// Ŭ���� ��� �𼭸������� ���°� �ٲ��.
always @(posedge clock)
if (clear)
state <= S0; // S0 ���¿��� ����� ����
else
state <= next_state; // ���°� �ٲ��.
// �ֿ䵵�ο� ���������� ��ȣ�� ���� ����Ѵ�.
always @(state)
begin
hwy = GREEN; // �⺻ �ֿ䵵�� �� �Ҵ�
cntry1 = RED; // �⺻ �������� �� �Ҵ�
cntry2 = RED; // �⺻ �������� �� �Ҵ�
P = RED;
case(state)
S0: ; // �ٲ��� �ʴ´�. �⺻���� ���
S1: hwy = YELLOW;
S2: hwy = RED;
S3: begin
hwy = RED;
cntry1 = GREEN;
cntry2 = GREEN;
P = GREEN;
end
S4: begin
hwy = RED;
cntry1 = YELLOW;
cntry2 = YELLOW;
P = RED;
end
endcase
end

// case ������ ����� ���±�
always @(state or X1 or X2 or X3)
begin
    case (state)
        S0: if(X1 || X3 || X2)
                next_state = S1;
            else
            next_state = S0;
        S1: begin // Ŭ���� ��� �𼭸� ����
                repeat(`Y2RDELAY) @(posedge clock);
                next_state = S2;
            end
        S2: begin // Ŭ���� ��� �𼭸� ����
                repeat(`R2GDELAY) @(posedge clock);
                next_state = S3;
            end
        S3: if(X1 || X3 || X2)
                next_state = S3;
            else
                begin
                repeat(30) @(posedge clock);
                next_state = S4;
                end
        S4: begin // Ŭ���� ��� �𼭸� ����
                repeat(`Y2RDELAY) @(posedge clock) ;
                next_state = S0;
            end
        default: next_state = S0;
    endcase
end
endmodule


module stimulus;
wire [1:0] MAIN_SIG, CNTRY_SIG1, CNTRY_SIG2, P;
reg CAR_ON_CNTRY_RD1, CAR_ON_CNTRY_RD2, P_SENSOR;
// ���� ���̸� �������ο� ���� �ִٴ� ���� ����Ų��.
reg CLOCK, CLEAR;
// ��ȣ ����⸦ �Ļ�
sig_control SC(MAIN_SIG, CNTRY_SIG1, CNTRY_SIG2, P, CAR_ON_CNTRY_RD1, CAR_ON_CNTRY_RD2, P_SENSOR, CLOCK, CLEAR);
// ����� ����
initial
$monitor($time, " Main Sig = %b Country Sig1 = %b Country Sig2 = %b Car_on_cntry1 = %b Car_on_cntry2 = %b P = %d P_SENSOR = %b",MAIN_SIG, CNTRY_SIG1, CNTRY_SIG2, CAR_ON_CNTRY_RD1, CAR_ON_CNTRY_RD2, P, P_SENSOR);
// Ŭ���� ����
initial
begin
CLOCK = `FALSE;
forever #5 CLOCK = ~CLOCK;
end

// clear ��ȣ�� ����
initial
begin
CLEAR = `TRUE;
repeat (5) @(negedge CLOCK);
CLEAR = `FALSE;
end
// ��Ƽ�ķ����� ����
initial
begin
CAR_ON_CNTRY_RD1 = `FALSE;
CAR_ON_CNTRY_RD2 = `FALSE;
P_SENSOR = `FALSE;
repeat (20)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `TRUE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `FALSE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `FALSE;
repeat (60)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `TRUE; P_SENSOR = `FALSE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `FALSE;
repeat (60)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `TRUE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `FALSE;
repeat (60)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `FALSE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD1 = `FALSE; CAR_ON_CNTRY_RD2 = `FALSE; P_SENSOR = `FALSE;
repeat (10)@(negedge CLOCK); $stop;
end
endmodule