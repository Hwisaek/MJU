//`timescale 1ns / 1ps

//module myMem(hrdata, haddr, hwdata);
//output [0:15] hrdata;
//input [0:7] haddr;
//input [0:23] hwdata;
//reg [0:15] M[0:199], hrdata_r;
//integer count;
//wire [0:15] data;
//wire [0:7] addr;
//assign {addr, data} = hwdata;
//initial
//begin
//    M[0] = 16'h001A;
//    M[2] = 16'h131B;
//    M[4] = 16'h213C;
//    M[6] = 16'h312D;
//    M[8] = 16'h4E64;
//    M[10] = 16'h5F66;
//    for ( count = 100; count < 200; count = count + 1)
//        M[count] = count;
//end

//always @ (*)
//    begin
//        hrdata_r = M[haddr];
//    end

//// hwdata ผ๖วเ
//always @ (hwdata)
//    if(addr > 7'd99)
//        M[addr] = data;
    
//assign hrdata = hrdata_r;
//endmodule


//module stimulus;
//wire [0:15] hrdata;
//reg [0:7] haddr;
//reg [0:23] hwdata;

//myMem test(hrdata, haddr, hwdata);

//initial 
//    begin
//        haddr = 0;
//        hwdata =0;
//        #10 haddr = 8'd1;
//        #10 haddr = 8'd2;
//        #10 hwdata = 24'b0000_0010_0000_0000_0000_1000;
//        #10 hwdata = 24'h400000;
//    end
//endmodule
