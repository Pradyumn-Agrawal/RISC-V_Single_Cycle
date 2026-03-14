`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 00:04:09
// Design Name: 
// Module Name: Regfile
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


module Regfile#(parameter WIDTH=32,REG_SIZE=32)(
input clk,Regwrite,
input [4:0]A1,
input [4:0]A2,
input [4:0]A3,
input [WIDTH-1:0]WD3,
output  [WIDTH-1:0]RD1,
output  [WIDTH-1:0]RD2
  );
  
  
  reg [WIDTH-1:0] REG[0:REG_SIZE-1];

 
  
  assign RD1=(A3==A1 && A3!=0)?((WD3 !== 32'bx)?WD3:REG[A1]):REG[A1];
  //assign RD1=(A1!=0)?REG[A1]:32'b0;
  //assign RD2=(A2!=0)?REG[A2]:32'b0;
  assign RD2=(A3==A2 && A3!=0)?((WD3 !== 32'bx)?WD3:REG[A2]):REG[A2];
  
  always@(posedge clk) begin
  
  REG[0]<=0;
  
  if (Regwrite && (A3!=0))
  REG[A3]<=WD3;
  
end

endmodule
