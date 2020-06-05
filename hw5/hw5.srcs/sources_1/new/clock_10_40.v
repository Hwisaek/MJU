`timescale 1ns / 1ps
module clock_10_40;
reg clk;

initial
begin
clk=1'b0;
forever
begin 
#6 clk=~clk;
#4 clk=~clk;
end
end

endmodule
