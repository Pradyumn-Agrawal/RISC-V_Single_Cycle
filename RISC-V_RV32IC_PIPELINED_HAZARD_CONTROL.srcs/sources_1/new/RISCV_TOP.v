`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 21:00:01
// Design Name: 
// Module Name: RISCV_TOP
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


module RISCV_TOP #(parameter WIDTH=32)(
input clk,rst,
output [31:0]WD_M,[31:0]ADD_DM,[31:0]ReadData_M,
output Memwrite_M,
output [31:0]PC_F,
output [31:0]InstrF,
output [31:0]RF_WRITEDATA_W
    );
    
 /*   wire [WIDTH-1:0]WD,ADD_DM;
    wire Memwrite;
    wire [WIDTH-1:0]ReadData;
    wire [WIDTH-1:0]PC;
    wire [WIDTH-1:0]Instr;*/
   
    
Instruction_Memory IMEM(PC_F,InstrF);
Data_Memory RAM(clk,Memwrite_M,ADD_DM,WD_M,ReadData_M);
RISCv_DP_CP DP_CP(clk,rst,PC_F,InstrF,Memwrite_M,ADD_DM,WD_M,ReadData_M,RF_WRITEDATA_W);
    
    
endmodule
