`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:11:02
// Design Name: 
// Module Name: Adder
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


module Adder #(parameter WIDTH=32)
(input [WIDTH-1:0]A,
       [WIDTH-1:0]B,
 output [WIDTH-1:0]Y
    );

    assign Y=A+B;
endmodule
