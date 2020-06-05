`timescale 1ns / 1ps
module 8-bit_counter;
reg clk;
reg [7:0] count;

initial
begin
clk=0;
forever
#5 clk=~clk;
end

initial
begin
count=5;
begin:blk1
forever
begin
@(posedge clk) 
count=count+1;
if(count>66 || count<5)
disable blk1;
end
end
end
initial
$monitor($time, "count =%d\n",count);

endmodule
