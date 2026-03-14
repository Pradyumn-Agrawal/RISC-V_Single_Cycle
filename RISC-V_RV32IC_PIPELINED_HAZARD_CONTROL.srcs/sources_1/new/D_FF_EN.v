`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:24:20
// Design Name: 
// Module Name: D_FF_EN
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


module D_FF_EN(
input clk,rst,nEn,     //Enable is negative logic
input [WIDTH-1:0]d,
output reg [WIDTH-1:0]q
    );
    
 parameter WIDTH=32;
 
 always@(posedge clk or posedge rst) begin
 if(rst)
         q<=0;
 else if(!nEn)
         q<=d;
         
         end
endmodule
