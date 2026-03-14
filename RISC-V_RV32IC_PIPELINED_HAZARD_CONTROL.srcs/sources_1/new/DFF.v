`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 13:07:13
// Design Name: 
// Module Name: DFF
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


module DFF#(parameter WIDTH=32)(
input clk,rst,
input [WIDTH-1:0]d,
output reg[WIDTH-1:0]q
    );


always@(posedge clk or negedge rst)
begin
   if(!rst)
   q<=0;
   else
   q<=d;
end

  

endmodule

