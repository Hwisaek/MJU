`timescale 1ns / 1ps
module stimulus;
reg clock, clear, count_enable;
wire [3:0] Q;
counter_4bit c4(clear, clock, count_enable, Q);
initial
clock = 0;
always
#10 clock = ~clock;
initial
begin
$monitor ($time," clear = %b, count_enable = %b, --- Q = %b\n", clear, count_enable, Q);
end
initial
begin
clear = 0; count_enable = 1;
#40 clear = 1;
#360 count_enable = 0;
end
endmodule