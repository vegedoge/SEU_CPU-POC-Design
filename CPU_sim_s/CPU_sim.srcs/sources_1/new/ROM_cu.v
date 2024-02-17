`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 18:39:12
// Design Name: 
// Module Name: ROM_cu
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


module ROM_cu(
    input [7:0]address,
    input clk,
    output [31:0]c_out
    );

rom_cm u_rom(
  .clka(clk),    // input wire clka
  .ena(1),      // input wire ena
  .addra(address),  // input wire [7 : 0] addra
  .douta(c_out)  // output wire [31 : 0] douta
);

endmodule
