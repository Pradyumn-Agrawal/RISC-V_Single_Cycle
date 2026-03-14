`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 20:47:32
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory#(parameter WIDTH=32,MEMORY_WIDTH=512)(
input [WIDTH-1:0]PC_F,  //Input address for the Instruction memory
output [WIDTH-1:0]InstrF  //Output from Instruction memory
 );
 reg [WIDTH-1:0] Mem[0:MEMORY_WIDTH-1]; //Memory 
 
 initial begin
 $display("Reading the file");
 $readmemh("rv32i_book.hex",Mem);  //Reading Instruction memory
 end
 
 assign InstrF= Mem[PC_F[WIDTH-1:2]];  //Assigning Instruction to the Instr
 
endmodule
