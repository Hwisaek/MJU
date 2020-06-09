`timescale 1ns / 1ps

module myCPU(haddr, hwdata, hrdata, clk, reset_n);
output [7:0] haddr;
output reg [23:0] hwdata;
input [15:0] hrdata;
input clk, reset_n; // reset_n �� 0�� �Ǹ� ���� 

reg state, next_state;
parameter S0 = 0, S1 = 1, S2 = 2;
parameter ADD = 0, SUB = 1, AND = 2, OR = 3, LD = 4, ST = 5;

reg [3:0] opcode, opr1, opr2, opr3;
reg [7:0] opr4, addr_r, addr; // LD, ST�� ���� opr4

reg [15:0] Dreg[0:15];
reg [15:0] Qreg[0:15];
parameter MAXREG = 16;

integer i;

// CPU ��������
always @ (posedge clk, negedge reset_n) // clk�� ��� �����̰ų� reset_n�� �ϰ� ������ ������ ����
    begin
        if (~reset_n) // reset_n == 0 �̸� 
            begin
                for ( i = 0; i < MAXREG; i = i + 1)
                    Qreg[i] <= 16'h0; // ��� ���������� ��ºκ��� 0���� ����
            end
        else
            begin
                for ( i = 0; i < MAXREG; i = i + 1)
                    Qreg[i] <= Dreg[i]; // ���������� �Էºκ��� ���� �������Ϳ� ����
            end
    end
    
// ���� �������� ����
always @ (posedge clk)
    if (~reset_n) // reset_n == 0 �̸�
        state = S0; // ���¸� 0���� ����
    else
        state <= next_state; // ���¸� ���� ���·� ����
        
// next_state ȸ��
always @ (state)
    begin
        case (state) // ���°� S1, S0�� �����ư��鼭 �ٲ� 
            S0: next_state = S1;
            S1: next_state = S0;
            S2:
                begin
                    addr = opr4;
                    next_state = S1;
                end
        endcase
    end
    
// ���¿� ���� CPU ����
always @ (state, hrdata)
    begin
        opcode = hrdata[15:12]; // opcode�� hrdata�� �� 4��Ʈ�� �Ҵ�
        if (state == S0) // ���°� S0�� ���
            begin
                case (opcode)
                    ADD: 
                        begin
                            opr1 = hrdata[11:8];
                            opr2 = hrdata[7:4];
                            opr3 = hrdata[3:0];
                        end
                    SUB:
                        begin
                            opr1 = hrdata[11:8];
                            opr2 = hrdata[7:4];
                            opr3 = hrdata[3:0];
                        end
                    AND:
                        begin
                            opr1 = hrdata[11:8];
                            opr2 = hrdata[7:4];
                            opr3 = hrdata[3:0];
                        end
                    OR:
                        begin
                            opr1 = hrdata[11:8];
                            opr2 = hrdata[7:4];
                            opr3 = hrdata[3:0];
                        end
                    LD:
                        begin
                            opr1 = hrdata[11:8];
                            opr4 = hrdata[7:0];
                        end
                    ST:
                        begin
                            opr1 = hrdata[11:8];
                            opr4 = hrdata[7:0];
                        end
                endcase
            end
        else if (state == S1) // ���°� S1�� ���
            begin
                case (opcode)
                    ADD:
                        begin
                            Dreg[opr3] = Qreg[opr1] + Qreg[opr2]; // ���������� �Էºκп� �������� �ΰ��� ���� ���� ����
                        end
                    SUB:
                        begin
                            Dreg[opr3] = Qreg[opr1] - Qreg[opr2]; // ���������� �Էºκп� �������� �ΰ��� ���� ���� ����
                        end
                    AND:
                        begin
                            Dreg[opr3] = Qreg[opr1] & Qreg[opr2]; // ���������� �Էºκп� �������� �ΰ��� ���� ���� ����
                        end
                    OR:
                        begin
                            Dreg[opr3] = Qreg[opr1] | Qreg[opr2]; // ���������� �Էºκп� �������� �ΰ��� ���� ���� ����
                        end
                    LD:
                        begin
                            state = S2;
                        end
                    ST:
                        begin
                            hwdata = {opr4,Qreg[opr1]};
                        end
                endcase
            end
        else if (state == S2)
            Dreg[opr1] = hrdata;
        
    end
    
// PC ����
always @ (posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            addr_r = 0;
        else
            addr_r = addr_r + 1;
    end
always @ (state)
    begin
        if (state == S1 && (opcode == LD || opcode == ST))
            addr = opr2; // LD, ST �� ������ ���� �޸𸮿� ������ addr ���� opr2 �� �����Ͽ� �����͸� �޾� �� �� �ְ� ��
        else if(state == S0)
            addr = addr_r;
    end
    
assign haddr = addr;
endmodule

module stimulus;
reg clk, reset_n;
reg [15:0] inst;
wire [7:0] haddr;
wire [15:0] hwdata, hrdata;

myCPU CPU(haddr, hwdata, hrdata, clk, reset_n);
myMem Mem(hrdata, haddr, hwdata);

initial
    begin
        clk = 0;
        forever
            #5 clk = ~clk;
    end

initial
    $monitor("reset_n=%b, haddr=%d, hrdata=%d, hwdata=%d\n", reset_n, haddr, hrdata, hwdata);

initial
    begin
        reset_n = 0;
    end
endmodule