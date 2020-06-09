`timescale 1ns / 1ps

module myCPU(haddr, hwdata, hrdata, clk, reset_n);
output [7:0] haddr;
output reg [23:0] hwdata;
input [15:0] hrdata;
input clk, reset_n; // reset_n 이 0이 되면 리셋 

reg state, next_state;
parameter S0 = 0, S1 = 1, S2 = 2;
parameter ADD = 0, SUB = 1, AND = 2, OR = 3, LD = 4, ST = 5;

reg [3:0] opcode, opr1, opr2, opr3;
reg [7:0] opr4, addr_r, addr; // LD, ST를 위한 opr4

reg [15:0] Dreg[0:15];
reg [15:0] Qreg[0:15];
parameter MAXREG = 16;

integer i;

// CPU 레지스터
always @ (posedge clk, negedge reset_n) // clk가 상승 엣지이거나 reset_n이 하강 엣지일 때마다 실행
    begin
        if (~reset_n) // reset_n == 0 이면 
            begin
                for ( i = 0; i < MAXREG; i = i + 1)
                    Qreg[i] <= 16'h0; // 모든 레지스터의 출력부분을 0으로 설정
            end
        else
            begin
                for ( i = 0; i < MAXREG; i = i + 1)
                    Qreg[i] <= Dreg[i]; // 레지스터의 입력부분의 값을 레지스터에 저장
            end
    end
    
// 상태 레지스터 구현
always @ (posedge clk)
    if (~reset_n) // reset_n == 0 이면
        state = S0; // 상태를 0으로 고정
    else
        state <= next_state; // 상태를 다음 상태로 변경
        
// next_state 회로
always @ (state)
    begin
        case (state) // 상태가 S1, S0을 번갈아가면서 바뀜 
            S0: next_state = S1;
            S1: next_state = S0;
            S2:
                begin
                    addr = opr4;
                    next_state = S1;
                end
        endcase
    end
    
// 상태에 따른 CPU 구현
always @ (state, hrdata)
    begin
        opcode = hrdata[15:12]; // opcode는 hrdata의 앞 4비트로 할당
        if (state == S0) // 상태가 S0인 경우
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
        else if (state == S1) // 상태가 S1인 경우
            begin
                case (opcode)
                    ADD:
                        begin
                            Dreg[opr3] = Qreg[opr1] + Qreg[opr2]; // 레지스터의 입력부분에 레지스터 두개를 더한 값을 저장
                        end
                    SUB:
                        begin
                            Dreg[opr3] = Qreg[opr1] - Qreg[opr2]; // 레지스터의 입력부분에 레지스터 두개를 더한 값을 저장
                        end
                    AND:
                        begin
                            Dreg[opr3] = Qreg[opr1] & Qreg[opr2]; // 레지스터의 입력부분에 레지스터 두개를 더한 값을 저장
                        end
                    OR:
                        begin
                            Dreg[opr3] = Qreg[opr1] | Qreg[opr2]; // 레지스터의 입력부분에 레지스터 두개를 더한 값을 저장
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
    
// PC 구현
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
            addr = opr2; // LD, ST 를 수행할 때는 메모리에 보내는 addr 값을 opr2 로 설정하여 데이터를 받아 올 수 있게 함
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