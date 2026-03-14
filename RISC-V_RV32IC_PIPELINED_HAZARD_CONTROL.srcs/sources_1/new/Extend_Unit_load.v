`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 21:05:27
// Design Name: 
// Module Name: Extend_Unit_load
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


module Extend_Unit_load#(parameter WIDTH=32)(
input [WIDTH-1:0]ReadData,   //data read from the data memory
input [2:0]Rd_Src,  //control signal for the extend source
output reg [WIDTH-1:0]Rd_load  //output from the Extend source for load instructions
    );
    
    always@(*)begin
    case(Rd_Src)
    3'b000: Rd_load={{24{ReadData[7]}},ReadData[7:0]} ;// load byte
    3'b001: Rd_load={{16{ReadData[15]}},ReadData[15:0]}; // load half
    3'b010: Rd_load=ReadData; //load word
    3'b011: Rd_load={24'b0,ReadData[7:0]} ;// load byte unsigned
    3'b100: Rd_load={16'b0,ReadData[15:0]}; // load half unsigned
    
    default: Rd_load=32'bx;
    
    endcase
    end
    
    
endmodule
