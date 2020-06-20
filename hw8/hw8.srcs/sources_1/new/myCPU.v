`timescale 1ns / 1ps

module myCPU(haddr, hwdata, hreq, hgrant, hrdata, clk, reset_n);
output [0:7] haddr;
output [0:15] hwdata;
output hreq;
input [0:15] hrdata;
input clk, reset_n, hgrant; // reset_n == 0 �� ��� ���� 

parameter S0 = 0, S1 = 1, S2 = 2,// S0 = HRDATA ���� �м� , S1 = opcode ����, ST�� ��� 255 ����, S2 = �޸𸮿� �ּҿ� �� �����Ͽ� �޸𸮿� �� ����
          ADD = 0, SUB = 1, AND = 2, OR = 3, LD = 4, ST = 5;
         
reg [0:1] state, next_state;
reg [0:7] haddr_r, haddr_r_next; // ��� ����� ���� �߻� ���ɼ��� �����Ƿ� �������͸� ���� ����
reg [0:3] opcode, oper1, oper2, oper3;
reg [0:7] mem_addr;
reg [0:15] R_in[0:15], R_out[0:15];
reg [0:15] hwdata_r;
reg hreq_r;


assign hwdata = hwdata_r,
        haddr = haddr_r,
        hreq = hreq_r;
// hreq �ʱ�ȭ        
initial
    hreq_r = 0;
    
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
                ADD: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                SUB: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                AND: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                OR: begin oper1 = hrdata[4:7]; oper2 = hrdata[8:11]; oper3 = hrdata[12:15]; hreq_r = 0; end
                // LD, ST �� oper1�� �������� �ּҸ� ����, �޺κп��� �޸� �ּҸ� ����
                LD: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15];  hreq_r = 1;end
                ST: begin oper1 = hrdata[4:7]; mem_addr = hrdata[8:15];  hreq_r = 1;end
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
assign hrdata = hrdata_r;

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

// �޸� �ʱ�ȭ
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
    
// ���¿� ���� case
always @ (*)
    if (state == S0)
        hrdata_r = M[haddr];
    else if (state == S1)    
        M[addr] = data;
        
endmodule


// �ƺ��� ��� -----------------------------------------------------------------------------------------------------------------
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

// �ùķ��̼� ��� ------------------------------------------------------------------------------------------------------------------
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

always @ (*) // hgrant = 1 -> CPU1 �۵� , hgrant = 0 -> CPU2 �۵� 
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