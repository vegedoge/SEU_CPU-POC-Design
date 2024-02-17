`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/08 20:17:05
// Design Name: 
// Module Name: Processor
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


module Processor(
    output ADDR,//控制SR还是BR，1是BR
    input [7:0]Dout,
    output [7:0]Din,
    output RW,//控制读写，1是cpu向外写
    input clk,
    input IRQ,//IRQ为0代表中断请求
    input reset,
    input modset,
    input [7:0]data

    );


reg ADDR_reg;
reg RW_reg;
reg [7:0]Din_reg;
reg handle=0;//用于判别cpu是否写入br
//reg check=0;//判别查询模式是否查过
//reg [7:0]data=8'b10100101;
reg [1:0]change_flag=2'b00;//模式切换时空过1slot


always @(negedge reset or posedge clk)
begin
    if(!reset)
    begin
        change_flag<=2'b01;
        if(modset)//如果中断开局
        begin
            ADDR_reg<=0;//写sr
            RW_reg<=1;
            Din_reg<=8'b10000001;
            handle<=0;
        end
        else
        begin//查询模式开局
            ADDR_reg<=0;//写sr
            RW_reg<=1;
            Din_reg<=8'b10000000;
            handle<=0;
        end
    end
    else
//    begin
    
//    end
//end
//        //reset根据mod重置为默认
//always @(posedge clk)
    begin
        if(change_flag==2'b01)
        begin
        //空置时隙
            change_flag<=2'b00;
        end
        else if(change_flag==2'b00)
        begin
            if(!IRQ)//中断请求
            begin
                if(handle==0)
                begin
                    ADDR_reg<=1;
                    RW_reg<=1;
                    Din_reg<=data;//写入data
                    handle<=1;
                end
                else
                begin
                    ADDR_reg<=0;
                    RW_reg<=1;
                    Din_reg<=8'b00000001;//SR0=1,SR7=0;
                    handle<=0;//sr处理完毕
                end
            end
            /*
            else if(RW&&Dout==8'b00000001)//没准备好
            begin
                RW_reg=0;
            end
            */   
            else if(IRQ)//查询
            begin
                if(Dout==8'b10000000)
                //查询sr7
                begin
                    if(handle==0)
                    begin
                        RW_reg <= 1;
                        ADDR_reg <= 1;
                        Din_reg<=data;
                        handle<=1;
                    end
                    else
                    begin//置sr7=0
                        RW_reg <=1;
                        ADDR_reg <=0;
                        Din_reg<=8'b00000000;
                        handle<=0;
                    end
                end
                else
                begin//保持读取态查询
                    RW_reg<=0;
                    ADDR_reg<=0;
                end
            end
            else
            begin
                //空过
            end
        end
    end
end
    
assign ADDR = ADDR_reg;
assign RW = RW_reg;
assign Din = Din_reg;


endmodule
