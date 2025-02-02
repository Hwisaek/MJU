`timescale 1ns / 1ps

module myCPU(haddr, hwdata, hrdata, clk, reset_n);
output [0:7] haddr;
output [0:23] hwdata;
input [0:15] hrdata;
input clk, reset_n; // reset_n == 0 인 경우 리셋 

parameter S0 = 0, S1 = 1, // S0 = HRDATA 값을 분석 , S1 = opcode에 따라 수행
          ADD = 0, SUB = 1, AND = 2, OR = 3, LD = 4, ST = 5;
          
reg [0:1] state, next_state;
reg [0:7] haddr_r, haddr_r_next; // 모듈 연결시 오류 발생 가능성이 있으므로 레지스터를 따로 지정
reg [0:3] opcode, oper1, oper2, oper3;
reg [0:7] mem_addr;
reg [0:15] R_in[0:15], R_out[0:15];
reg [0:23] hwdata_r;
// 상태기
 always @ (state)
    case (state)
        S0: next_state <= S1;
        S1: next_state <= S0;
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
                ADD: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                SUB: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                AND: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                OR: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                // LD, ST 는 oper1에 레지스터 주소를 저장, 뒷부분에는 메모리 주소를 저장
                LD: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15]; end
                ST: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15];  end
            endcase
        else // 상태가 S1 인 경우 
        begin
            case (opcode)
                ADD: R_in[oper3] = R_out[oper1] + R_out[oper2];
                SUB: R_in[oper3] = R_out[oper1] - R_out[oper2];
                AND: R_in[oper3] = R_out[oper1] & R_out[oper2];
                OR: R_in[oper3] = R_out[oper1] | R_out[oper2];
                LD: #1 R_in[oper1] = haddr; // haddr를 
                ST: hwdata_r = {mem_addr, R_out[oper1]};
            endcase
        end
    end
assign hwdata = hwdata_r;

// PC
initial
    haddr_r_next = 0;
always @ ( posedge clk, negedge reset_n) // 클럭의 상승엣지랑 reset_n == 0 될 때마다 실행
begin
    if(~reset_n) // 리셋시 0으로 설정
        haddr_r_next = 0;
    else // 리셋신호가 0인 경우 1씩 증가 
        if(state == S1) // if 를 적용 안하면 S0, S1 한번 순환할때 2씩 증가함 
            haddr_r_next = haddr_r_next+1;
end
always @ (state)
begin
    if (state == S1 && (opcode == LD)) // LD를 하는 경우에는 s0일때 들어온 값의 뒷부분을 haddr로 다시 메모리에 보내서 해당 주소의 값을 받아옴
        haddr_r = mem_addr;
    else // LD를 하지 않는 경우에는 그대로 1씩 증가 
        haddr_r = haddr_r_next;
end
assign haddr = haddr_r;


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

module myMem(hrdata, haddr, hwdata);
output [0:15] hrdata;
input [0:7] haddr;
input [0:23] hwdata;
reg [0:15] M[0:199], hrdata_r;
integer count;
wire [0:15] data;
wire [0:7] addr;
assign {addr, data} = hwdata;
initial
begin
    M[0] = 16'h001A;
    M[2] = 16'h131B;
    M[4] = 16'h213C;
    M[6] = 16'h312D;
    M[8] = 16'h4E64;
    M[10] = 16'h5F66;
    for ( count = 100; count < 200; count = count + 1)
        M[count] = count;
end

always @ (*)
    begin
        hrdata_r = M[haddr];
    end

// hwdata 수행
always @ (hwdata)
    if(addr > 7'd99)
        M[addr] = data;
    
assign hrdata = hrdata_r;
endmodule

module stimulus;
wire [0:7] haddr;
wire [0:23] hwdata;
wire [0:15] hrdata;
reg clk, reset_n;

myCPU CPU(haddr, hwdata, hrdata, clk, reset_n);
myMem Mem(hrdata, haddr, hwdata);

initial
begin
    reset_n = 0;
    #40 reset_n = 1;
end

initial
begin
    clk = 1;
    forever #10 clk = ~clk;
end

initial
begin
end
endmodule