`timescale 1ns / 1ps

module counter_4bit(clear, clock, count_enable, Q);
input clear, clock, count_enable;
output [3:0] Q;
wire ce1, ce2, ce3;
assign ce1 = Q[0] & count_enable,
        ce2 = Q[1] & ce1,
        ce3 = Q[2] & ce2;
jk_ff jk0(clear, clock, count_enable, count_enable, Q[0], );
jk_ff jk1(clear ,clock, ce1, ce1, Q[1], );
jk_ff jk2(clear ,clock, ce2, ce2, Q[2], );
jk_ff jk3(clear ,clock, ce3, ce3, Q[3], );      
endmodule


module jk_ff(clear, clock, J, K,q,qbar);
output q,qbar;
input clear, clock, J, K;

wire a, b, y, ybar, c, cbar, d;

assign cbar = ~clock,
        a = ~(qbar & J & clock & clear),
        y = ~(a & ybar),
        c = ~(y & cbar),
        q = ~(c & qbar),
        b = ~(clock & K & q),
        ybar = ~(y & clear & b),
        d = ~(cbar & ybar),
        qbar = ~(q & clear & d);
endmodule