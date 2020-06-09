`timescale 1ns / 1ps

module myMem(HRDATA, HADDR, HWDATA);
output reg [0:15] HRDATA;
input [0:7] HADDR;
input [0:23] HWDATA;
reg [0:15] M[0:199];
integer count;
wire [0:15] data;
wire [0:7] addr;
assign {addr, data} = HWDATA;
initial
    for ( count = 0; count < 200; count = count + 1)
        M[count] = count;
always @ (*)
    begin
        HRDATA = M[HADDR];
        M[addr] = data;
    end
endmodule


//module stimulus;
//wire [0:15] HRDATA;
//reg [0:7] HADDR;
//reg [0:23] HWDATA;

//myMem test(HRDATA, HADDR, HWDATA);

//initial 
//    begin
//        HADDR = 0;
//        HWDATA =0;
//        #10 HADDR = 8'd1;
//        #10 HADDR = 8'd2;
//        #10 HWDATA = 24'b0000_0010_0000_0000_0000_1000;
//    end
//endmodule
