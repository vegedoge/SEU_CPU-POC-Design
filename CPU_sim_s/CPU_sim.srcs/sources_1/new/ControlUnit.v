`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 18:39:12
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit (
    input clk,
    input clk_rom,
    input reset,
    input [7:0]IR_in,
    input [31:0]c,
    input [2:0]flag,//flag0:正负1乘法完成2操作完成
    output [31:0]c_out
);
wire [7:0]address;

CAR u_CAR(
    .clk(clk),
    .reset(reset),
    .IR_in(IR_in),
    .c(c),
    .flag(flag),//flag0:正负1乘法完成2操作完成
    .address(address)
);

ROM_cu u_ROM_cu(
    .address(address),
    .clk(clk_rom),
    .c_out(c_out)
    );





endmodule
