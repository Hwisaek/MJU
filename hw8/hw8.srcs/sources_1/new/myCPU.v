`timescale 1ns / 1ps

module myCPU(haddr, hwdata, hrdata, clk, reset_n);
output [0:7] haddr;
output [0:15] hwdata;
input [0:15] hrdata;
input clk, reset_n; // reset_n == 0 �� ��� ���� 

parameter S0 = 0, S1 = 1, S2 = 2,// S0 = HRDATA ���� �м� , S1 = opcode ����, ST�� ��� 255 ����, S2 = �޸𸮿� �ּҿ� �� �����Ͽ� �޸𸮿� �� ����
          ADD = 0, SUB = 1, AND = 2, OR = 3, LD = 4, ST = 5;
         
reg [0:1] state, next_state;
reg [0:7] haddr_r, haddr_r_next; // ��� ����� ���� �߻� ���ɼ��� �����Ƿ� �������͸� ���� ����
reg [0:3] opcode, oper1, oper2, oper3;
reg [0:7] mem_addr;
reg [0:15] R_in[0:15], R_out[0:15];
reg [0:15] hwdata_r;
// ���±�
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

// hrdata �м�
always @ (state, hrdata)
    begin
        opcode = hrdata[0:3]; // opcode �� hrdata�� �� 4��Ʈ
        if (state == S0)
            case (opcode) 
                // ADD, SUB, AND, OR �� ���� �ǿ����ڸ� 3���� ���� 
                ADD: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                SUB: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                AND: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                OR: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; end
                // LD, ST �� oper1�� �������� �ּҸ� ����, �޺κп��� �޸� �ּҸ� ����
                LD: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15]; end
                ST: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15];  end
            endcase
        else if(state == S1) // ���°� S1 �� ��� 
        begin
            case (opcode)
                ADD: R_in[oper3] = R_out[oper1] + R_out[oper2];
                SUB: R_in[oper3] = R_out[oper1] - R_out[oper2];
                AND: R_in[oper3] = R_out[oper1] & R_out[oper2];
                OR: R_in[oper3] = R_out[oper1] | R_out[oper2];
                LD: #1 R_in[oper1] = haddr; // haddr�� 
                ST: haddr_r = 8'b11111111;
            endcase
        end
        else if(state == S2)
            hwdata_r = R_out[oper1];
    end
assign hwdata = hwdata_r;

// PC
initial
    haddr_r_next = 0;
always @ ( posedge clk, negedge reset_n) // Ŭ���� ��¿����� reset_n == 0 �� ������ ����
begin
    if(~reset_n) // ���½� 0���� ����
        haddr_r_next = 0;
    else // ���½�ȣ�� 0�� ��� 1�� ���� 
        if((state == S1 && opcode != ST )|| state == S2 ) // if �� ���� ���ϸ� S0, S1 �ѹ� ��ȯ�Ҷ� 2�� ������ 
            haddr_r_next = haddr_r_next+1;
end
always @ (state)
begin
    if (state == S1 && (opcode == LD)) // LD�� �ϴ� ��쿡�� s0�϶� ���� ���� �޺κ��� haddr�� �ٽ� �޸𸮿� ������ �ش� �ּ��� ���� �޾ƿ�
        haddr_r = mem_addr;
    else if (state == S1 && ( opcode == ST))
        haddr_r = 8'b11111111;
    else if (state == S2)
    begin
        haddr_r = mem_addr;
    end
    else // LD�� ���� �ʴ� ��쿡�� �״�� 1�� ���� 
        haddr_r = haddr_r_next;
end
assign haddr = haddr_r;


// ��������
integer i, j;
always @ (posedge clk, negedge reset_n)
begin
    #1 if(~reset_n) // ���� Ŭ������ ���� �ٲ�� �Ǿ� ���࿡ 1�� ������ ���� 
    begin
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                R_out[i][j] <= 0; // ��ºκи� 0���� ���� , �������� ���� ���� �ʱ�ȭ ���� ���� 
    end
    else
    begin
        for (i = 0; i < 16; i = i + 1)
            for (j = 0; j < 16; j = j + 1)
                R_out[i][j] <= R_in[i][j];
    end
end
// �������� �� �ʱ�ȭ
initial
begin
for (i = 0; i < 16; i = i + 1)
        R_in[i] <= i;
end

endmodule


// �޸� ��� ---------------------------------------------------------------------------------------------
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

reg state, next_state;
parameter S0 = 0, S1 = 1;// S0 = �ּҰ� 255�� �ƴ� ��� ���  , S1 = ST �� ���/�ּҷ� 255�� ���� ��  

// ���±�
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
    if (~reset_n) // �޸� �ʱ�ȭ
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

//// �޸��� ������ ���� 
//always @ (posedge clk, negedge reset_n)
//    begin
//        hrdata_r = M[haddr];
//    end

//// hwdata ����
//always @ (hwdata)
//    if(addr > 7'd99)
//        M[addr] = data;
    

always @ (posedge clk, negedge reset_n, hwdata)
    if (state == S0)
        hrdata_r = M[haddr];
    else if (state == S1)    
        M[addr] = data;
        
assign hrdata = hrdata_r;
endmodule


// �ùķ��̼� ��� ------------------------------------------------------------------------------------------------------------------
module stimulus;
wire [0:7] haddr;
wire [0:15] hwdata;
wire [0:15] hrdata;
reg clk, reset_n;

myCPU CPU(haddr, hwdata, hrdata, clk, reset_n);
myMem Mem(hrdata, haddr, hwdata, clk, reset_n);

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