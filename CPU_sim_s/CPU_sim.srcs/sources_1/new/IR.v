`timescale 1ns / 1ps

module IR(
input clk,reset,c4,
input [7:0] MBR_in,
output [7:0] IR_out
    );
reg [7:0] IR_out_reg;
always @(posedge clk)
begin
    if(reset==0) 
    begin
        IR_out_reg<=8'h00;
    end
    else if(c4==1) 
    begin
        IR_out_reg<=MBR_in;
    end
end
assign IR_out=IR_out_reg;
endmodule