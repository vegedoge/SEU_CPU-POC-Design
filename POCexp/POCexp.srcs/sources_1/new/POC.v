`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/08 20:17:45
// Design Name: 
// Module Name: POC
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


module POC(
    input clk,
    output IRQ,
    input RW,
    input [7:0]Din,
    output [7:0]Dout,
    input ADDR,
    input RDY,
    input reset,
   // input mod,//1中断0查询
    output TR,
    output [7:0]PD

    );
    
//reg mod_reg;
reg IRQ_reg;
reg TR_reg;  
reg[7:0] PD_reg;
reg[7:0] Dout_reg;
reg[2:0] state_reg;
reg[2:0] next_state=3'b000;
reg[7:0] BR;
reg[7:0] SR;
//reg select;//reset后是1否0选定模式

parameter state1= 3'b000;
parameter state2= 3'b001;
parameter state3= 3'b010;
parameter state4= 3'b011;
parameter state5= 3'b100;
parameter state6= 3'b101;//重开模式
    
    
    
always@(negedge reset or posedge clk)
begin
   // mod_reg<=mod;//首先载入模式
    if(!reset)
    begin
        next_state=state6;//先读取模式
    end
   // mod_reg<=0;//默认查询
    else 
    begin
        state_reg=next_state;
    end
end
always@(posedge clk)
begin
    //state_reg=next_state;
    case(state_reg)
        state1:
        begin
            TR_reg<=0;//复原TR脉冲
            if(SR==8'b10000001)
            begin
                IRQ_reg<=0;
                next_state<=state2;
            end
            else if(SR==8'b10000000)
            begin
                IRQ_reg<=1;
                next_state<=state3;
            end
            else if(SR==8'b00000000)
            begin
                IRQ_reg<=1;
                next_state<=state4;
            end
            else if(SR==8'b00000001)
            begin
                IRQ_reg<=0;
                next_state<=state5;
            end
            else//reset模式尝试
            begin
                next_state<=state6;
            end
        end
        state2://中断
        begin
            if(RW==1&&ADDR==1)
            begin
                BR<=Din;
                //SR<=8'b00000001;
               // next_state=state2;
                
            end
            else if(RW==1&&ADDR==0)
            begin
                SR<=Din;
                Dout_reg<=Din;
                next_state <=state5;
            end
        end
        state3://查询
        begin
            if(RW==0&&ADDR==0)//读sr
            begin
                Dout_reg<=SR;
                //next_state=state3;
                //next_state <=state3;
            end
            else if(RW==1&&ADDR==1)//写br
            begin
                BR<=Din;
                //next_state=state3;
                //next_state <=state3;
            end 
            else if(RW==1&&ADDR==0)//写sr
            begin
                SR<=Din;
                Dout_reg<=Din;
                next_state<=state4;
            end
        end
        state4://查询后握手
        begin
            if(RDY)
            begin
                TR_reg<=1;
                PD_reg<=BR;
                SR<=8'b10000000;
                next_state<=state1;
            end
        end
        state5://中断后握手
        begin
            if(RDY)
            begin
                TR_reg<=1;
                PD_reg<=BR;
                SR<=8'b10000001;
                next_state<=state1;
            end
        end
        state6:
        begin
            SR<=Din;  
            next_state<=state1;            
        end
        default:
            next_state<=state6;
    endcase     
end

assign IRQ = IRQ_reg;
assign TR = TR_reg;
assign PD = PD_reg;
assign Dout = Dout_reg;


endmodule








