`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 00:40:26
// Design Name: 
// Module Name: Control_Path
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


module Control_Path(
input [6:0]op,
input [2:0]funct3,
input funct7,
output Regwrite_D,//Control Signal for the Regwrite
output [2:0]ImmSrc_D,  //select signal for extend unit  
output [3:0]ALUControl_D,   //Select signal for ALU
output [2:0]Rd_Src_D,     //select signal for Extend_unit_load
output AluSrc_D,         //select signal for MUX1
output ImmS_D  ,         //select signal for MUX2
output IR_Src_D ,   //Select signal for MUX3
output Rd2Src_D ,   //select signal for MUX4
output [1:0]WD_Src_D,  //select signal for MUX which selects the data written to the data memory
output Memwrite_D,    //signal which enable the data memory write
output [1:0]RFW_Src_D,  //Select signal for MUX7
output WDRF_SEL_D,//select signal for RFWD
output [1:0]PC_BJI_D, //select signal for the PC target address
output Jump_D, //Jump signal for the Jalr and jal instruction
output Branch_D //Branch Signal if Branch is taken
    );
    
    wire [1:0]ALUop; 
 
    Main_Decoder MD(op,funct3,ImmSrc_D,Rd_Src_D,Regwrite_D,ALUop,AluSrc_D,ImmS_D,IR_Src_D,Rd2Src_D,WD_Src_D[1:0],Memwrite_D,RFW_Src_D[1:0],Branch_D,Jump_D,WDRF_SEL_D,PC_BJI_D);
    ALU_Decoder  AD(ALUop,op[5],funct3,funct7,ALUControl_D);
    
   
    
endmodule
