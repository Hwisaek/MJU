`timescale 1ns / 1ps

module myCPU(reset_n, clk, inst, haddr, hrdata, hwdata, hreq, hgrant);

input clk, reset_n;
input [15:0] inst;
input [15:0] hrdata;
input hgrant;

output [7:0] haddr;
output [15:0] hwdata;
output hreq;

reg state, next_state;
parameter S0 = 0, S1 = 1; // FSM states
parameter LD = 0, ST = 1, ADD = 2, SUB = 3; // opcodes

reg [3:0] opcode, opr1, opr2, opr3;
reg [7:0] opr4;
reg [7:0] addr_r, addr;

reg [15:0] Dreg[0:15];
reg [15:0] Qreg[0:15];
parameter MAXREG = 16;

integer i;

// CPU registers
always@(posedge clk, negedge reset_n)
begin
    if (~reset_n) 
    begin
      for (i=0; i<MAXREG; i = i+1) 
         Qreg[i] <= 16'h0;
    end
    else
    begin
      for (i=0; i<MAXREG; i=i+1) 
         Qreg[i] <= Dreg[i];
    end
end

// state register implementation
always@(posedge clk)
if (!reset_n)
    state = S0;
else
    state <= next_state;
    
// next state logic
always@(state)
begin
    case (state)
        S0: next_state = S1;
        S1: next_state = S0;
    endcase
end

// CPU implementation for state
always@(state, inst)
begin
    opcode = inst[15:12];
    if (state == S0) // IF and ID state inst 값들을 opr 에 저장 
    begin
        case (opcode)
            ADD: begin
                    opr1 = inst[11:8];
                    opr2 = inst[7:4];
                    opr3 = inst[3:0];
                 end
             LD: begin
                    opr1 = inst[11:8];
                    opr4 = inst[7:0];
                 end
        endcase
    end
    else // state == S1, EX and WB state 저장된 값을 주소로 이용하여 연산 
    begin
        case (opcode)
            ADD: begin Dreg[opr3] = Qreg[opr1] + Qreg[opr2]; end
            LD:  begin Dreg[opr1] = hrdata; end
        endcase
    end
end

// Access memory when the hreq is granted.
always@(posedge clk, negedge reset_n)
begin
    if (!reset_n)
    begin
        addr_r <= 0;
    end
    else if (hgrant)
    begin
        addr_r <= addr_r + 1;
    end
end
    
// haddr implementation
always@(state)
begin
    if (state == S1 && (opcode == LD || opcode == ST))
        addr = opr2;
    else 
        addr = addr_r;
end

assign haddr = addr;
assign hwdata = 0;
assign hreq = 1;

endmodule


module stimulus;
reg clk, reset_n;
reg [15:0] inst;
reg [15:0] hrdata;
reg hgrant;

wire [7:0] haddr;
wire [15:0] hwdata;
wire hreq;

myCPU dut(reset_n, clk, inst, haddr, hrdata, hwdata, hreq, hgrant);

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
$monitor("reset_n=%b, inst=%b, haddr=%d, hrdata=%d, hwdata=%d, hreq=%b, hgrant=%b\n", 
    reset_n, inst, haddr, hrdata, hwdata, hreq, hgrant);

initial
begin
    reset_n = 0; hgrant=1;
    inst = 16'b0000_0001_0000_1000; // LD r1, mymem(8)
    hrdata = 'd100; // mymem(8) stores 100
    $stop;
    #20; reset_n=1;
    #40; inst = 16'b0000_0010_0000_1001; // LD r2, mymem(9)
    hrdata = 'd150; // mymem(9) stores 150
    #40; inst = 16'b0010_0001_0010_0011; // ADD r1, r2, r3 inst
    #100; $stop;
    #20; $finish;
end

endmodule
