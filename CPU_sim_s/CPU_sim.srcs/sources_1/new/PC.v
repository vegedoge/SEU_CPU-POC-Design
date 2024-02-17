`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/10 23:47:03
// Design Name: 
// Module Name: PC
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

module PC(
input clk,reset,c6,c14,
input [7:0] MBR_in,
output [7:0] PC_out
    );
    
reg [7:0] PC_out1;
always @(posedge clk) begin
    if(reset==0) begin
    PC_out1<=8'b0;
    end
    else if(c6==1) begin
    PC_out1<=PC_out1+1;
    end
    else if(c14==1) begin
    PC_out1<=MBR_in;
    end
end
assign PC_out=PC_out1;
endmodule
