`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 11:54:36
// Design Name: 
// Module Name: D_FF_CLR
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


module D_FF_CLR#(parameter WIDTH=32)(
input clk,clr,En,
input [WIDTH-1:0]d,
output reg[WIDTH-1:0]q
 );
 
 always@(posedge clk)begin
 if(clr)
 q<=0;
 
 else if(!En)
 q<=d;
 end
 
 
endmodule
