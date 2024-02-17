`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 23:47:03
// Design Name: 
// Module Name: BR
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

module BR (
    input clk,
    input reset,
    input c7,
    input [15:0] MBR_in,
    output [15:0] BR_out
);
reg [15:0] BR_out1;
always@(posedge clk)
begin
    if (!reset)
        BR_out1 <= 16'h0000;
    else if(c7==1)
        BR_out1 <= MBR_in;
end
assign BR_out = BR_out1;    
endmodule
