`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 23:47:03
// Design Name: 
// Module Name: CAR
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

module CAR (
    input clk,
    input reset,
    input [7:0]IR_in,
    input [31:0]c,
    input [2:0]flag,//flag0:正负1乘法完成2操作完成
    output [7:0]address
);
//reg [7:0]opcode;
reg [7:0]add_pointer;

always @(posedge clk ) 
begin
    //opcode<=IR_in;
    if(c[0]==1)//步增
        add_pointer<=add_pointer+1;
    if(c[2]==1)//指针清零
        add_pointer<=0;
    if(flag[2])//当前操作结束
        add_pointer<=0;
    if(c[27]==1)//flag=1乘法结束继续
        add_pointer<=add_pointer+flag[1];
    if(c[20]==1)//flag0=1对应结果<0循环结束
        add_pointer<=add_pointer+1+flag[0];
    if (c[1]==1&&IR_in!=0)
    begin
        case (IR_in)
            8'b00000001: add_pointer<=8'h10;//store
            8'b00000010: add_pointer<=8'h08;//load
            8'b00000011: add_pointer<=8'h18;//add
            8'b00000100: add_pointer<=8'h20;//sub
            8'b00000101: add_pointer<=8'h60;//jmpgez
            8'b00000110: add_pointer<=8'h58;//jmp
            8'b00000111: add_pointer<=8'h68;//halt
            8'b00001000: add_pointer<=8'h50;//mpy
            8'b00001010: add_pointer<=8'h28;//and
            8'b00001011: add_pointer<=8'h30;//or
            8'b00001100: add_pointer<=8'h38;//not
            8'b00001101: add_pointer<=8'h48;//shl
            8'b00001110: add_pointer<=8'h40;//shr

            default: add_pointer<=8'h00;//default
        endcase
    end
    if(!reset)
        add_pointer<=0;
end
assign address=add_pointer;
    
endmodule
