`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:29:36
// Design Name: 
// Module Name: Extend_Unit
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


module Extend_Unit#(parameter WIDTH=32)(
input [WIDTH-1:7]InstrD,
input [2:0]ImmSrc,
output reg [WIDTH-1:0]ImmExt
    );
    
    always@(*)begin
    case(ImmSrc)
        3'b000: ImmExt={{20{InstrD[31]}},InstrD[31:20]} ;// I Type 12 bit signed immediate
        3'b001: ImmExt={{20{InstrD[31]}},InstrD[31:25],InstrD[11:7]}; // S Type 12 bit signed immediate
        3'b010: ImmExt={{20{InstrD[31]}},InstrD[7],InstrD[30:25],InstrD[11:8],1'b0}; // B Type 13 bit signed immediate
        3'b011: ImmExt={InstrD[31:12],12'b0};  // U type
        3'b100: ImmExt={{12{InstrD[31]}},InstrD[19:12],InstrD[20],InstrD[30:21],1'b0}; // J Type 21 bit signed immediate
        
        default: ImmExt=32'bx;
        endcase
        
        end
        
endmodule
