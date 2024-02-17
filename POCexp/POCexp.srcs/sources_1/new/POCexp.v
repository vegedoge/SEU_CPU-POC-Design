`timescale 1ns / 1ps

module POCexp(
    input clk,
    input reset,
    input modset,
    input [7:0]data,
    output [7:0]print
   
    );
 
  
wire ADDR;
wire TR;
wire RW;
wire IRQ;
wire RDY;

wire [7:0]Din;
wire [7:0]Dout;
wire [7:0]PD;
 
    
Processor u_Processor(
    .ADDR(ADDR),//控制SR还是BR，1是BR
    .Dout(Dout[7:0]),
    .Din(Din[7:0]),
    .RW(RW),//控制读写，1是cpu向外写
    .clk(clk),
    .IRQ(IRQ),//IRQ为0代表中断请求
    .reset(reset),
    .modset(modset),
    .data(data[7:0])

    );
    
POC u_POC(
    .clk(clk),
    .IRQ(IRQ),
    .RW(RW),
    .Din(Din[7:0]),
    .Dout(Dout[7:0]),
    .ADDR(ADDR),
    .RDY(RDY),
    .TR(TR),
    .PD(PD[7:0]),
    .reset(reset)

    );   
    
Printer u_Printer(
    .clk(clk),
    .TR(TR),
    .PD(PD[7:0]),
    .RDY(RDY),
    .PRINT(print[7:0]),
    .reset(reset)

    ); 
    
    
    
endmodule
