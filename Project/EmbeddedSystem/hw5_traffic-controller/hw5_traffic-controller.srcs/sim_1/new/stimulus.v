`timescale 1ns / 1ps


module stimulus;
wire [1:0] MAIN_SIG, CNTRY_SIG;
reg CAR_ON_CNTRY_RD;
// ���� ���̸� �������ο� ���� �ִٴ� ���� ����Ų��.
reg CLOCK, CLEAR;
// ��ȣ ����⸦ �Ļ�
sig_control SC(MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);
// ����� ����
initial
$monitor($time, " Main Sig = %b Country Sig = %b Car_on_cntry = %d",
MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);
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
CAR_ON_CNTRY_RD = `FALSE;
repeat (20)@(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
repeat (20)@(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
repeat (20)@(negedge CLOCK); CAR_ON_CNTRY_RD = `TRUE;
repeat (10)@(negedge CLOCK); CAR_ON_CNTRY_RD = `FALSE;
repeat (10)@(negedge CLOCK); $stop;
end
endmodule