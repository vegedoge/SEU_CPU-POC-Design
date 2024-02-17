`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/14 09:20:42
// Design Name: 
// Module Name: LED
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


module LED(
    input clk,
    input rst_n,                                                        
	input [15:0] data,
	output reg [7:0] SSEG_AN,//位选
	output reg [7:0] SSEG_CA//段选
);
//分频
	reg [20:0] div_cnt;
	always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
	    div_cnt<= 0;
		else if(div_cnt>=21'd99999)//50Mhz的input
		    div_cnt<= 0;
		else
		    div_cnt<= div_cnt+1'b1;
	end 
	 
	reg clk_1;
	always@(posedge clk or negedge rst_n)begin
	    if(!rst_n)
		    clk_1<= 0;
		else if(div_cnt==21'd99999)
		    clk_1<= ~clk_1;
	end
	
	reg [2:0] cnt;
	always@(posedge clk_1 or negedge rst_n)begin
	  if(!rst_n)
	    cnt<= 0;
	  else
	    cnt<= cnt+1'b1;
	end
	
	always@(*)begin
	  case(cnt)
	   0:SSEG_AN = 8'b11111110;
	   1:SSEG_AN = 8'b11111101;
	   2:SSEG_AN = 8'b11111011;
	   3:SSEG_AN = 8'b11110111;
	//    4:sel = 8'b0001_0000;
	//    5:sel = 8'b0010_0000;
	//    6:sel = 8'b0100_0000;
	//    7:sel = 8'b1000_0000;
	    endcase
	end
	
	reg [3:0] data_1;
	always@(*)begin
	  case(cnt)
	    // 0:data_1 = data[31:28];
		// 1:data_1 = data[27:24];
		// 2:data_1 = data[23:20];
		// 3:data_1 = data[19:16];
		3:data_1 = data[15:12];
		2:data_1 = data[11:8];
		1:data_1 = data[7:4];
		0:data_1 = data[3:0];
	  endcase
	end
	
	always@(*)begin
	  case(data_1)
	     0:SSEG_CA = 8'hc0;
		 1:SSEG_CA = 8'hf9;
		 2:SSEG_CA = 8'ha4;
		 3:SSEG_CA = 8'hb0;
		 4:SSEG_CA = 8'h99;
		 5:SSEG_CA = 8'h92;
		 6:SSEG_CA = 8'h82;
		 7:SSEG_CA = 8'hf8;
		 8:SSEG_CA = 8'h80;
		 9:SSEG_CA = 8'h90;
	 4'ha:SSEG_CA = 8'h88;
	 4'hb:SSEG_CA = 8'h83;
	 4'hc:SSEG_CA = 8'hc6;
	 4'hd:SSEG_CA = 8'ha1;
	 4'he:SSEG_CA = 8'h86;
	 4'hf:SSEG_CA = 8'h8e;
	 default: SSEG_CA = 8'b11111111;
	  endcase
	end
                   
endmodule

