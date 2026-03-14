`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:45:53
// Design Name: 
// Module Name: Mux_3x1
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


module Mux_3x1#(parameter WIDTH=32)(
input [WIDTH-1:0]A,  //s=00
input [WIDTH-1:0]B,  //s=01
input [WIDTH-1:0]C,  //s=10
input [1:0]s,
output [WIDTH-1:0]Y
    );
    
    assign Y=(s[1]&&!s[0])?C:(s[0]?B:A);
    
endmodule
