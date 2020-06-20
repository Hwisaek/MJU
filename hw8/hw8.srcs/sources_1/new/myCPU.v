`timescale 1ns / 1ps

module myCPU(haddr, hwdata, hreq, hgrant, hrdata, clk, reset_n);
output [0:7] haddr;
output [0:15] hwdata;
output hreq;
input [0:15] hrdata;
input clk, reset_n, hgrant; // reset_n == 0 인 경우 리셋 

parameter S0 = 0, S1 = 1, S2 = 2,// S0 = HRDATA 값을 분석 , S1 = opcode 수행, ST인 경우 255 전송, S2 = 메모리에 주소와 값 전송하여 메모리에 값 쓰기
          ADD = 0, SUB = 1, AND = 2, OR = 3, LD = 4, ST = 5;
         
reg [0:1] state, next_state;
reg [0:7] haddr_r, haddr_r_next; // 모듈 연결시 오류 발생 가능성이 있으므로 레지스터를 따로 지정
reg [0:3] opcode, oper1, oper2, oper3;
reg [0:7] mem_addr;
reg [0:15] R_in[0:15], R_out[0:15];
reg [0:15] hwdata_r;
reg hreq_r;


assign hwdata = hwdata_r,
        haddr = haddr_r,
        hreq = hreq_r;
// hreq 초기화        
initial
    hreq_r = 0;
    
// 상태기
 always @ (state)
    case (state)
        S0: next_state <= S1;
        S1: if(opcode == ST)
                next_state <= S2;
            else
                next_state <= S0;
        S2: next_state <= S0;
    endcase
always @ (posedge clk)
    if(~reset_n)
        next_state <= S0;
    else
        state <= next_state;

// hrdata 분석
always @ (state, hrdata)
    begin
        opcode = hrdata[0:3]; // opcode 는 hrdata의 앞 4비트
        if (state == S0)
            case (opcode) 
                // ADD, SUB, AND, OR 일 때는 피연산자를 3개로 나눔 
                ADD: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                SUB: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                AND: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                OR: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                // LD, ST 는 oper1에 레지스터 주소를 저장, 뒷부분에는 메모리 주소를 저장
                LD: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15];  hreq_r = 1;end
                ST: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15];  hreq_r = 1;end
            endcase
        else if(state == S1) // 상태가 S1 인 경우 
        begin
            case (opcode)
                ADD: R_in[oper3] = R_out[oper1] + R_out[oper2];
                SUB: R_in[oper3] = R_out[oper1] - R_out[oper2];
                AND: R_in[oper3] = R_out[oper1] & R_out[oper2];
                OR: R_in[oper3] = R_out[oper1] | R_out[oper2];
                LD: #1 R_in[oper1] = haddr; // haddr를 
                ST: haddr_r = 8'b11111111;
            endcase
        end
        else if(state == S2)
            hwdata_r = R_out[oper1];
    end

// PC
initial
    haddr_r_next = 0;
always @ ( posedge clk, negedge reset_n) // 클럭의 상승엣지랑 reset_n == 0 될 때마다 실행
begin
    if(~reset_n) // 리셋시 0으로 설정
        haddr_r_next = 0;
    else // 리셋신호가 0인 경우 1씩 증가 
        if((state == S1 && opcode != ST )|| state == S2 ) // if 를 적용 안하면 S0, S1 한번 순환할때 2씩 증가함 
            haddr_r_next = haddr_r_next+1;
end
always @ (state)
begin
    if (state == S1 && (opcode == LD)) // LD를 하는 경우에는 s0일때 들어온 값의 뒷부분을 haddr로 다시 메모리에 보내서 해당 주소의 값을 받아옴
        haddr_r = mem_addr;
    else if (state == S1 && ( opcode == ST))
        haddr_r = 8'b11111111;
    else if (state == S2)
    begin
        haddr_r = mem_addr;
    end
    else // LD를 하지 않는 경우에는 그대로 1씩 증가 
        haddr_r = haddr_r_next;
end


// 레지스터
integer i, j;
always @ (posedge clk, negedge reset_n)
begin
    #1 if(~reset_n) // 다음 클럭에서 값이 바뀌게 되어 실행에 1의 딜레이 적용 
    begin
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                R_out[i][j] <= 0; // 출력부분만 0으로 설정 , 레지스터 내부 값은 초기화 되지 않음 
    end
    else
    begin
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                R_out[i][j] <= R_in[i][j];
    end
end
// 레지스터 값 초기화
initial
begin
    for (i = 0; i < 16; i = i + 1)
        R_in[i] <= i;
end

endmodule


// 메모리 모듈 ---------------------------------------------------------------------------------------------
module myMem(hrdata, haddr, hwdata, clk, reset_n);
output [0:15] hrdata;
input [0:7] haddr;
input [0:15] hwdata;
input clk, reset_n;
reg [0:15] M[0:199], hrdata_r;
integer count;
wire [0:15] data;
wire [0:7] addr;
assign addr = haddr;
assign data = hwdata;
assign hrdata = hrdata_r;

reg state, next_state;
parameter S0 = 0, S1 = 1;// S0 = 주소가 255가 아닌 모든 경우  , S1 = ST 인 경우/주소로 255가 들어올 때  

// 상태기
 always @ (*)
    case (state)
        S0: if(haddr == 8'b11111111)
                next_state <= S1;
            else
                next_state <= S0;
        S1: next_state <= S0;
    endcase
always @ (posedge clk)
    if(~reset_n)
        next_state <= S0;
    else
        state <= next_state;

// 메모리 초기화
initial
begin
    for ( count = 0; count < 100; count = count + 1)
            M[count] = 0;
    M[0] = 16'h001A;
    M[2] = 16'h131B;
    M[4] = 16'h213C;
    M[6] = 16'h312D;
    M[8] = 16'h4E64;
    M[10] = 16'h5F66;
    for ( count = 100; count < 200; count = count + 1)
        M[count] = count;
    if (~reset_n) // 메모리 초기화
        begin
            for ( count = 0; count < 100; count = count + 1)
            M[count] = 0;
            M[0] = 16'h001A;
            M[2] = 16'h131B;
            M[4] = 16'h213C;
            M[6] = 16'h312D;
            M[8] = 16'h4E64;
            M[10] = 16'h5F66;
            for ( count = 100; count < 200; count = count + 1)
            M[count] = count;
        end
end
    
// 상태에 따른 case
always @ (*)
    if (state == S0)
        hrdata_r = M[haddr];
    else if (state == S1)    
        M[addr] = data;
        
endmodule


// 아비터 모듈 -----------------------------------------------------------------------------------------------------------------
module arbiter(hgrant, hreq1, hreq2, clk, reset_n);
output hgrant;
input hreq1, hreq2, reset_n, clk;

reg hgrant_r;

always @ (clk)
    if(~reset_n)
        hgrant_r <= 1;
    else
        if(hreq1)
            hgrant_r <= 1;
        else
            hgrant_r <= 0;
    
assign hgrant = hgrant_r;
endmodule

// 시뮬레이션 모듈 ------------------------------------------------------------------------------------------------------------------
module stimulus;
wire [0:7] haddr1, haddr2;
wire [0:15] hwdata1, hwdata2, hrdata;
reg [0:15] hrdata1, hrdata2;
wire hreq1, hreq2, hgrant;

reg [0:7] haddr;
reg [0:15] hwdata;
reg clk, reset_n, hgrant_n, hgrant_r;

assign hgrant = hgrant_r;

myCPU CPU1(haddr1, hwdata1, hreq1, hgrant, hrdata1, clk, reset_n);
myCPU CPU2(haddr2, hwdata2, hreq2, hgrant_n, hrdata2, clk, reset_n);
myMem Mem(hrdata, haddr, hwdata, clk, reset_n);
// arbiter Arb(hgrant, hreq1, hreq2, clk, reset_n);

always @ (*) // hgrant = 1 -> CPU1 작동 , hgrant = 0 -> CPU2 작동 
begin
    hgrant_n <= ~hgrant;
    haddr <= hgrant? haddr1 : haddr2;
    hwdata <= hgrant? hwdata1 : hwdata2;
    case(hgrant)
        1:  begin
                hrdata1 <= hrdata;
                hrdata2 <= 16'bx;
            end
        0:  begin
                hrdata2 <= hrdata;
                hrdata1 <= 16'bx;
            end
    endcase
end

initial
begin
    hgrant_r <= 1;
    reset_n <= 0;
    reset_n = #40 1;
    #1000 hgrant_r <= 0;
    #1000 hgrant_r <= 1;
end

initial
begin
    clk <= 1;
    forever #10 clk <= ~clk;
end

initial
begin
end
endmodule