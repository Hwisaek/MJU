`timescale 1ns / 1ps

module my_ripple_counter(Q, clk, reset);
    output [3:0] Q;
    input clk, reset;
    wire my_reset, init, cbar;
    wire [3:0] X;
    or (my_reset, reset, init);
    not (cbar, clk);
    ripple_counter rc (X, cbar, my_reset);
    my_register mr (Q, clk, X);
    counter_init ci (init, Q);
endmodule

module my_register(Q, clk, X);
output [3:0] Q;
input clk;
input [3:0] X;
wire clear;
wire [3:0] xbar, Qbar;
and(clear, clk, X[0],X[1],X[2],X[3]);
edge_dff edff0(Q[0], Qbar[0], X[0], clk, clear);
edge_dff edff1(Q[1], Qbar[1], X[1], clk, clear);
edge_dff edff2(Q[2], Qbar[2], X[2], clk, clear);
edge_dff edff3(Q[3], Qbar[3], X[3], clk, clear);
endmodule

module ripple_counter(Q, clock, clear);
output [3:0] Q;
input clock, clear;
T_FF tff0 (Q[0], clock, clear);
T_FF tff1 (Q[1], Q[0], clear);
T_FF tff2 (Q[2], Q[1], clear);
T_FF tff3 (Q[3], Q[2], clear);
endmodule


module T_FF(q,clk,clear);
output q;
input clk;
input clear;
wire qbar;
not (qbar,q);
edge_dff ff1 (q, ,qbar, clk, clear);
endmodule

module edge_dff(q, qbar,d, clk, clear);
output q, qbar;
input d, clk, clear;
wire s, sbar, r, rbar, cbar;
assign cbar = ~clear;
assign sbar = ~(rbar & s),
s = ~(sbar & cbar & ~clk),
r = ~(rbar & ~clk & s),
rbar = ~(r & cbar & d);
assign q = ~(s & qbar),
qbar = ~(q & r & cbar);
endmodule


module counter_init(init, Q);
output init;
input [3:0] Q;
wire x;
and (init, Q[3], Q[1]);
endmodule