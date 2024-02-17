`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 19:53:20
// Design Name: 
// Module Name: ram
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


module ram(
    input clk,
    input reset,
    input [15:0] mbr_in,
    input [7:0] mar_in,
    input c12,
    output [15:0]ram_out
    );
reg wea_reg=0;
//reg [7:0]address;
//reg [15:0]content;

ram_mem u_ram (
  .clka(clk),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(mar_in),  // input wire [7 : 0] addra
  .dina(mbr_in),    // input wire [15 : 0] dina
  .douta(ram_out)  // output wire [15 : 0] douta
);
always@(posedge clk)
begin
    if(c12==1)//控制mbr写入mem不是无限制就可以
        wea_reg<=1;//读取功能在mbr管理
    else 
        wea_reg<=0;
end

assign wea=wea_reg;
    
endmodule
