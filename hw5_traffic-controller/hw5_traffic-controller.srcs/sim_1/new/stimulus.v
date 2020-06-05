`timescale 1ns / 1ps


module stimulus;
wire [1:0] MAIN_SIG, CNTRY_SIG;
reg CAR_ON_CNTRY_RD;
// 만약 참이면 간선도로에 차가 있다는 것을 가리킨다.
reg CLOCK, CLEAR;
// 신호 제어기를 파생
sig_control SC(MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD, CLOCK, CLEAR);
// 모니터 구성
initial
$monitor($time, " Main Sig = %b Country Sig = %b Car_on_cntry = %d",
MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);
// 클럭의 구성
initial
begin
CLOCK = `FALSE;
forever #5 CLOCK = ~CLOCK;
end

// clear 신호의 제어
initial
begin
CLEAR = `TRUE;
repeat (5) @(negedge CLOCK);
CLEAR = `FALSE;
end
// 스티뮬러스를 적용
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