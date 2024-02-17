`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/26 14:53:21
// Design Name: 
// Module Name: cpu_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_top(
    input clk,
    input reset,
    output [7:0] SSEG_CA,
    output [7:0] SSEG_AN
    );

//wire clk_50M;
//wire clk_100M;
//wire locked;

//clk_divide u_clk
//   (
//    // Clock out ports
//    .clk_100M(clk_100M),     // output clk_100M
//    .clk_50M(clk_50M),     // output clk_50M
//    // Status and control signals
//    .locked(locked),       // output locked
//   // Clock in ports
//    .clk_in1(clk)
//    );      // input clk_in1
reg clk_div=0;
reg [1:0] count1=0;
//分频
always @(posedge clk) begin
    count1=count1+1;
    if(count1>1)begin
        count1=0;
        clk_div=~clk_div;
    end
end
    
// reg [31:0] c_bit=0;//操作信号
// reg [2:0] flag_reg=3'b0;//flag信号
wire [2:0]flag;
//assign flag=flag_reg;

//这里所有out并不区分端口位置
//每个module抽象化为多输入，单输出端口连接彼此

wire [7:0]MAR_out;
wire [15:0]ACC_out;
wire [15:0]memory_out;
wire [15:0]MBR_out;
wire [7:0]PC_out;
wire [7:0]IR_out;
wire [15:0]BR_out;
wire [15:0]ALU_out;
wire [15:0]MR;
wire [31:0]CU_out;
//sseg

//ram
ila_0 ila(
	.clk(clk_div), // input wire clk
	.probe0(PC_out), // input wire [7:0]  addr
	.probe1(ACC_out), // input wire [15:0]  acc
	.probe2(CU_out) // input wire [31:0]  Cbit
);

ram u_ram(
    .clk(clk),
    .reset(reset),
    .mbr_in(MBR_out),
    .mar_in(MAR_out),
    .c12(CU_out[12]),
    .ram_out(memory_out)
    );


MAR u_MAR(
    .clk(clk_div),
    .c5(CU_out[5]),//控制信号
    .c10(CU_out[10]),
    .reset(reset),
    .PC_2_MAR(PC_out),//PC导入MAR
    .MBR_2_MAR(MBR_out[7:0]),//MBR输出地址
    .MAR_out(MAR_out)
);

MBR u_MBR(
.acc_in(ACC_out),
.memory_in(memory_out),
.reset(reset),
.c3(CU_out[3]),
.c11(CU_out[11]),
.clk(clk_div),
.mbr_out(MBR_out)
);

PC u_PC(
.clk(clk_div),
.reset(reset),
.c6(CU_out[6]),
.c14(CU_out[14]),
.MBR_in(MBR_out[7:0]),
.PC_out(PC_out)
    );

IR u_IR(
.clk(clk_div),
.reset(reset),
.c4(CU_out[4]),
.MBR_in(MBR_out[15:8]),
.IR_out(IR_out)
    );

//ACC
ACC u_ACC(
.clk(clk_div),
.c8(CU_out[8]),
.c23(CU_out[23]),
.c25(CU_out[25]),
.reset(reset),
.ALU_in(ALU_out),
.MBR_in(MBR_out),
.ACC_out(ACC_out),
.flag0(flag[0]),
.flag2(flag[2])
);

ControlUnit u_CU(
    .clk(clk_div),
    .clk_rom(clk),
    .reset(reset),
    .IR_in(IR_out),
    .c(CU_out),
    .flag(flag),//flag0:正负1乘法完成2操作完成
    .c_out(CU_out)
);

BR u_BR(
    .clk(clk_div),
    .reset(reset),
    .c7(CU_out[7]),
    .MBR_in(MBR_out),
    .BR_out(BR_out)
);

ALU u_ALU(
    .clk(clk_div),
    .reset(reset),
    .c_in(CU_out),
    .ACC_in(ACC_out),
    .BR_in(BR_out),
    .flag1(flag[1]),
    .MR(MR),
    .ALU_out(ALU_out)
);

LED u_LED(
    .clk(clk),
    .rst_n(reset),                                                        
	.data(ACC_out),
	.SSEG_AN(SSEG_AN),//位选
	.SSEG_CA(SSEG_CA)//段选
);


endmodule
