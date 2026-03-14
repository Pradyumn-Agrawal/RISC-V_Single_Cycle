`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:14:31
// Design Name: 
// Module Name: D_FF
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


module D_FF#(parameter WIDTH=32)(
input clk,rst,En,
input [WIDTH-1:0]d,
output reg[WIDTH-1:0]q
    );


always@(posedge clk or negedge rst)
begin
   if(!rst)
   q<=0;
   else if(!En)
   q<=d;
end

  

endmodule
