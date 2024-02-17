`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/08 20:17:23
// Design Name: 
// Module Name: Printer
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


module Printer(
    input clk,
    input TR,
    input [7:0]PD,
    input reset,
    output RDY,
    output [7:0]PRINT

    );
    
reg [7:0]data;//data是转存
reg [7:0]print;//print是等待后打印输出
reg [2:0]counter=3'b000;  
//计时器 
reg waiting=0; 
//写入过程的waiting，写入时为1
reg ready;
//RDY的赋值版本


always @(posedge clk or negedge reset)
begin
    if(!reset)
    begin
        print<=0;
        ready<=1;
    end
    else
    begin
        if(TR)
        begin
            ready<=0;
            data<=PD;
            waiting<=1;
            //如果TR已经触发，不再接收，开始等待延时
        end
        else//TR没触发
        begin
            if(waiting)//如果是等待中
            begin
                counter<=counter+1;
                print<=data;
                if(counter==3'b010)
                begin
                    print<=0;
                    ready=1;
                    waiting<=0;
                    counter<=0;
                end
            end
        end
    end
end

assign RDY = ready;
assign PRINT = print;
endmodule






