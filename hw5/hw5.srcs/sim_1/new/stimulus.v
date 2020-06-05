`timescale 1ns / 1ps
module stimulus;
//wire [4:0] out;
//reg [3:0] a, b;
//reg [2:0] select;
//alu ALU(out, a, b, select);
//initial
//begin
//a=4'b1100; b=4'b0011; select=3'b000;
//#10 select = 3'b001;
//#10 select = 3'b010;
//#10 select = 3'b011;
//#10 select = 3'b100;
//#10 select = 3'b101;
//#10 select = 3'b110;
//#10 select = 3'b111;
//#10 select = 3'b000;
//end

reg clk;
reg [7:0] count;
initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial
begin
    count = 5;
    begin: block1
        forever
            begin
                @(posedge clk) count = count + 1;
                if(count > 66 || count < 5)
                disable block1;
            end
    end
    $monitor($time, "count = %d\n",count);
end
endmodule