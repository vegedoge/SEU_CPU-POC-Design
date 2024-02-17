`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 23:47:03
// Design Name: 
// Module Name: ACC
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


//测试
module ACC(
input clk,c8,c23,c25,reset,
input [15:0] ALU_in,MBR_in,
output [15:0] ACC_out,
output flag0,flag2
    );
    reg [15:0] ACC_out1;
    reg flag2_reg;
    reg flag0_reg;
always @(posedge clk) begin
    if (!reset) begin
      ACC_out1<=16'h0;
      flag2_reg<=0;
      flag0_reg<=0;
    end
    else if(c8==1)begin
      ACC_out1<=16'h0;
    end
    if (c23==1) begin
    ACC_out1<=ALU_in;
    flag2_reg<=1;
    end
    else begin
    flag2_reg<=0;
    end
    if (c25==1)begin
    ACC_out1<=MBR_in;
    end
    if (ACC_out1[15]==0) begin
    flag0_reg<=0;
    end
    else begin
    flag0_reg<=1;
    end
end
assign flag2=flag2_reg;
assign flag0=flag0_reg;
assign ACC_out=ACC_out1;
endmodule
