`timescale 1ns / 1ps

module stimulus;
    reg clk, reset, clear;
    wire [3:0] Q;
    my_ripple_counter mrc(Q, clk, reset, clear);
    initial 
        clk = 0; 
    always
        #10 clk = ~clk;
    initial 
    begin
        clear = 0;
        reset = 0;
        #20 reset = 1;
        #20 reset = 0;
    end
endmodule