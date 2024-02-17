`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 23:06:10
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb();

reg	clk;
reg reset;
wire [7:0] SSEG_CA;
wire [7:0] SSEG_AN;

localparam PERIOD = 10;	//100MHz

initial	
begin
	clk = 0;
	forever	#(PERIOD/2)	
	clk = ~clk;
end
//always #5 clk<=!clk;

cpu_top u_cpu_top(
    .clk(clk),
    .reset(reset),
    .SSEG_CA(SSEG_CA),
    .SSEG_AN(SSEG_AN)
    );

initial
begin
    reset = 0;
    # (2*PERIOD)
    reset = 1;
    # 3000
    $stop;
end

endmodule
