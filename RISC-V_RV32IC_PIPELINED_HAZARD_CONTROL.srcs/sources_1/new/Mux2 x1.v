`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:43:51
// Design Name: 
// Module Name: Mux_2x1
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


module Mux_2x1#(parameter WIDTH=32)(
input [WIDTH-1:0]A,   //Output when s=0
input [WIDTH-1:0]B,   //output when s=1
input s,
output [WIDTH-1:0]Y
    );
    
    assign Y=s?B:A;
    
endmodule
