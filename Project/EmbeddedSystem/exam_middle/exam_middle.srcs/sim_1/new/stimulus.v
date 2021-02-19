`timescale 1ns / 1ps

module stimulus;
    reg clk, reset;
    wire [3:0] Q;
    my_ripple_counter mrc(Q, clk, reset);
    initial 
        clk = 0; 
    always
        #10 clk = ~clk;
    initial 
    begin
        $monitor($time,"Q = %b\n",Q);
        reset = 1;
        #20 reset = 0;
    end
endmodule