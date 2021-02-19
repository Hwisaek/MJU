`timescale 1ns / 1ps
`define TRUE 1'b1
`define FALSE 1'b0

// 지연

`define Y2RDELAY 3 // 노란색에서 빨간색으로 변하는 지연
`define R2GDELAY 2 // 빨간색에서 녹색으로 변하는 지연
module sig_control (hwy, cntry1, cntry2, P, X1, X2, X3, clock, clear);
// I/O 포트
output [1:0] hwy, cntry1, cntry2, P;
// 녹색, 노란색, 빨간색 3가지 상태의 신호를 위한 2 비트 출력
reg [1:0] hwy, cntry1, cntry2, P;
// 출력 신호를 레지스터로 선언
input X1, X2, X3;
// 만약 참이면, 간선도로 혹은 횡단보도에 차가 있음을 가리킨다. 아니면 거짓
input clock, clear;
parameter RED = 2'd0,
YELLOW = 2'd1,
GREEN = 2'd2;
// 상태 정의 주요도로 간선도로1 간선도로2 횡단보도
parameter S0 = 3'd0, // 녹색 빨간색 빨간색 빨간색
S1 = 3'd1, // 노란색 빨간색 빨간색 빨간색
S2 = 3'd2, // 빨간색 빨간색 빨간색 빨간색
S3 = 3'd3, // 빨간색 녹색 녹색 녹색
S4 = 3'd4; // 빨간색 노란색 노란색 빨간색

// 내부 상태 변수
reg [2:0] state;
reg [2:0] next_state;
// 클럭의 상승 모서리에서만 상태가 바뀐다.
always @(posedge clock)
if (clear)
state <= S0; // S0 상태에서 제어기 시작
else
state <= next_state; // 상태가 바뀐다.
// 주요도로와 간선도로의 신호의 값을 계산한다.
always @(state)
begin
hwy = GREEN; // 기본 주요도로 값 할당
cntry1 = RED; // 기본 간선도로 값 할당
cntry2 = RED; // 기본 간선도로 값 할당
P = RED;
case(state)
S0: ; // 바뀌지 않는다. 기본값을 사용
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

// case 문장을 사용한 상태기
always @(state or X1 or X2 or X3)
begin
    case (state)
        S0: if(X1 || X3 || X2)
                next_state = S1;
            else
            next_state = S0;
        S1: begin // 클럭의 상승 모서리 지연
                repeat(`Y2RDELAY) @(posedge clock);
                next_state = S2;
            end
        S2: begin // 클럭의 상승 모서리 지연
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
        S4: begin // 클럭의 상승 모서리 지연
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
// 만약 참이면 간선도로에 차가 있다는 것을 가리킨다.
reg CLOCK, CLEAR;
// 신호 제어기를 파생
sig_control SC(MAIN_SIG, CNTRY_SIG1, CNTRY_SIG2, P, CAR_ON_CNTRY_RD1, CAR_ON_CNTRY_RD2, P_SENSOR, CLOCK, CLEAR);
// 모니터 구성
initial
$monitor($time, " Main Sig = %b Country Sig1 = %b Country Sig2 = %b Car_on_cntry1 = %b Car_on_cntry2 = %b P = %d P_SENSOR = %b",MAIN_SIG, CNTRY_SIG1, CNTRY_SIG2, CAR_ON_CNTRY_RD1, CAR_ON_CNTRY_RD2, P, P_SENSOR);
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