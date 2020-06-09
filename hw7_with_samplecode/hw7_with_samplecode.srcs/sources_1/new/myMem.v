`timescale 1ns / 1ps

module myMem(HRDATA, HADDR, HWDATA);
output [0:15] HRDATA;
input [0:7] HADDR;
input [0:23] HWDATA;
reg [0:15] M[0:199], HRDATA_r;
integer count;
wire [0:15] data;
wire [0:7] addr;
assign {addr, data} = HWDATA;
initial
    begin
        M[0] <= 16'b0000_0000_0001_0010;
        M[1] <= 16'b0001_0011_0001_0100;
        M[2] <= 16'h2305;
        M[3] <= 16'h3306;
        M[4] <= 16'h4710;
        M[5] <= 16'h5020;
        for ( count = 100; count < 200; count = count + 1)
            M[count] = count;
    end
always @ (HWDATA)
    if (HWDATA[0:7] == 0)
        begin
            HRDATA_r = M[HADDR];
            M[addr] = data;
        end
assign HRDATA = HRDATA_r;
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
