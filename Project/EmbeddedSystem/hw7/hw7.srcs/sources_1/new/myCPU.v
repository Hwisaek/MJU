`timescale 1ns / 1ps

module myCPU(HADDR, HWDATA, HRDATA, clk, reset);
output [0:7] HADDR;
output reg [0:15] HWDATA;
input [0:15] HRDATA;
input clk, reset;
wire [0:3] op, r1, r2, r3;
wire [0:15] R_out[0:15], R_in[0:15];


endmodule

module PC(HADDR, clk, reset);
output reg [0:7] HADDR;
input clk, reset;
initial 
    HADDR = 0;
always @ (posedge clk)
    if (reset)
        HADDR = 0;
    else
        begin
            HADDR = HADDR + 1;
        end
endmodule

module inst(op, r1, r2, r3, HRDATA, clk, reset);
output [0:3] op, r1, r2, r3;
input [0:15] HRDATA;
input clk, reset;
assign {op, r1, r2, r3} = HRDATA;
endmodule

module ALU(HWDATA, R_in, op, r1, r2, r3, R_out, clk, reset);
output reg [0:15] HWDATA, R_in;
input [0:3] op, r1, r2, r3;
input [0:15] R_out;
input clk, reset;
initial
    HWDATA = 0;
always @ (posedge clk)
    if (reset)
        HWDATA = 0;
    else
        begin
                case (op)
                    4'd0 : HWDATA = R_out[r1] + R_out[r2];
                    4'd1 : HWDATA = R_out[r1] - R_out[r2];
                    4'd2 : HWDATA = R_out[r1] & R_out[r2];
                    4'd3 : HWDATA = R_out[r1] | R_out[r2];
                endcase
        end
endmodule

module dff(q, d, clk, reset);
output reg q;
input d, clk, reset;
always @ (posedge clk)
    begin
        q = d;
    end
endmodule

module R(R_out, R_in, clk, reset);
output [0:15] R_out;
input [0:15] R_in;
input clk, reset;
dff dff0(R_out[0], R_in[0], clk, reset);
dff dff1(R_out[1], R_in[1], clk, reset);
dff dff2(R_out[2], R_in[2], clk, reset);
dff dff3(R_out[3], R_in[3], clk, reset);
dff dff4(R_out[4], R_in[4], clk, reset);
dff dff5(R_out[5], R_in[5], clk, reset);
dff dff6(R_out[6], R_in[6], clk, reset);
dff dff7(R_out[7], R_in[7], clk, reset);
dff dff8(R_out[8], R_in[8], clk, reset);
dff dff9(R_out[9], R_in[9], clk, reset);
dff dff10(R_out[10], R_in[10], clk, reset);
dff dff11(R_out[11], R_in[11], clk, reset);
dff dff12(R_out[12], R_in[12], clk, reset);
dff dff13(R_out[13], R_in[13], clk, reset);
dff dff14(R_out[14], R_in[14], clk, reset);
dff dff15(R_out[15], R_in[15], clk, reset);
endmodule

module Register(R_out[0:15], R_in[0:15], clk, reset);
output [0:15] R_out[0:15];
input [0:15] R_in[0:15];
input clk, reset;
integer count;

R R0(R_out[0], R_in[0], clk, reset);
R R1(R_out[1], R_in[1], clk, reset);
R R2(R_out[2], R_in[2], clk, reset);
R R3(R_out[3], R_in[3], clk, reset);
R R4(R_out[4], R_in[4], clk, reset);
R R5(R_out[5], R_in[5], clk, reset);
R R6(R_out[6], R_in[6], clk, reset);
R R7(R_out[7], R_in[7], clk, reset);
R R8(R_out[8], R_in[8], clk, reset);
R R9(R_out[9], R_in[9], clk, reset);
R R10(R_out[10], R_in[10], clk, reset);
R R11(R_out[11], R_in[11], clk, reset);
R R12(R_out[12], R_in[12], clk, reset);
R R13(R_out[13], R_in[13], clk, reset);
R R14(R_out[14], R_in[14], clk, reset);
R R15(R_out[15], R_in[15], clk, reset);
endmodule

module stimulus;
reg [0:15] R_in[0:15];
reg clk, reset;
wire [0:15] R_out[0:15];


Register test(R_out[0:15], R_in[0:15], clk, reset);

initial
    begin
        reset = 0;
        clk = 0;
        forever #10 clk = ~clk;
    end

initial
    begin
        R_in[0] = 0;
        R_in[1] = 1;
    end
endmodule