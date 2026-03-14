`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 20:14:22
// Design Name: 
// Module Name: Main_Decoder
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


module Main_Decoder(

input [6:0]op,
input [2:0]funct3,

output [2:0]ImmSrc,   //control signal for selecting the immediate value for various types I,J,B,S,
output [2:0]Rd_Src,    //control signal for selecting btw different data for load instructions
output Regwrite,      //Control Signal for the Register Write operation
output [1:0]ALUop,   //ALU op tells what to do
output AluSrc ,     // Control Signal for the mux to select btw ALU and Extend unit of load
output ImmS,        //Control signal to select btw ImmExt or Imm[24:20]
output IR_Src,  //Control Signal for MUX to select btw Rd2 and IMMMux
output Rd2Src , //Control Signal for MUX to select btw Rd2 or Rd2[4:0]
//output [1:0]SA_Src, // control Signal for MUX to select ADDress for data memory 
output[1:0] WD_Src,  //Control Signal for MUX to select The data which is to be written in the data memory
output Memwrite,  //Enable signal for data memory write
output [1:0]RFW_Src ,   //Control Signal to select btw ImmExt,WD_RF,and PC_ImmExt
output Branch,   //Control Signal for Branch Instructions
output Jump,   //control signal for jump type instruction
output WDRF_SEL,  //control signal for data written to the register file
output [1:0]PC_BJI  //control signal for selecting the target address
    );
    
    reg [22:0]Control;
    assign {ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI}=Control;


  always@(*) begin
  case(op)
 7'b0000011: begin
             case(funct3)
             3'b000: Control=23'b000_000_1_00_1_1_1_x_xx_0_01_0_0_1_xx; //lb
             3'b001: Control=23'b000_001_1_00_1_1_1_x_xx_0_01_0_0_1_xx; //lh
             3'b010: Control=23'b000_010_1_00_1_1_1_x_xx_0_01_0_0_1_xx; //lw
             3'b100: Control=23'b000_011_1_00_1_1_1_x_xx_0_01_0_0_1_xx; //lbu
             3'b101: Control=23'b000_100_1_00_1_1_1_x_xx_0_01_0_0_1_xx; //lhu
             
             default: Control=23'b0;
             endcase
             end
             
         // ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
 7'b0010011: begin      
             case(funct3)     // Control signal for ADDI,XORI,ORI,ANDI,
             3'b000: Control=23'b000_xxx_1_10_0_1_1_x_xx_x_01_0_0_1_xx;
             3'b100: Control=23'b000_xxx_1_10_0_1_1_x_xx_x_01_0_0_1_xx;
             3'b110: Control=23'b000_xxx_1_10_0_1_1_x_xx_x_01_0_0_1_xx;
             3'b111: Control=23'b000_xxx_1_10_0_1_1_x_xx_x_01_0_0_1_xx;
             3'b010: Control=23'b000_xxx_1_10_0_1_1_x_xx_x_01_0_0_1_xx; //slti
             3'b011: Control=23'b000_xxx_1_10_0_1_1_x_xx_x_01_0_0_1_xx; //sltiu
             3'b001: Control=23'b000_xxx_1_10_0_0_1_x_xx_x_01_0_0_1_xx; //slli
             3'b101: Control=23'b000_xxx_1_10_0_0_1_x_xx_x_01_0_0_1_xx; //srli,srai
             endcase
             end
             
           //  ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b0110011: begin
            case(funct3)
            3'b001:Control=23'bxxx_xxx_1_10_0_x_0_0_xx_x_01_0_0_1_xx;    ///Conntrol Signal for R type sll
            3'b101:Control=23'bxxx_xxx_1_10_0_x_0_0_xx_x_01_0_0_1_xx;    ///Conntrol Signal for R type srl,sra
            
            default:Control=23'bxxx_xxx_1_10_0_x_0_1_xx_x_01_0_0_1_xx;    ///Conntrol Signal for R type remaining
             endcase
             end
             
           //  ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b0100011: begin
            case(funct3)
            3'b000: Control=23'b001_xxx_0_00_x_1_1_x_00_1_xx_0_0_x_xx;    // Control Signal for sb  
            3'b001: Control=23'b001_xxx_0_00_x_1_1_x_01_1_xx_0_0_x_xx;    // Control signal for sh
            3'b010: Control=23'b001_xxx_0_00_x_1_1_x_10_1_xx_0_0_x_xx;     // Control Signal for sw
            
            default: Control=23'bx;
            endcase
            end
            
         // ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b0010111: begin
            Control=23'b011_xxx_1_xx_x_x_x_x_xx_x_10_0_0_1_xx;     //Control Signal for AUIPC
            end
            
           // ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b0110111: begin
            Control=23'b011_xxx_1_xx_x_x_x_x_xx_x_00_0_0_1_xx;  //COntrol signal for lui
            end     
             
           //ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b1100011: begin
            Control=23'b010_xxx_0_01_x_x_0_1_xx_x_xx_1_0_x_00;  //Control signal for Beq,bne,blt,bge,bltu,bgeu,
            end 
            
           // ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b1100111: begin
            Control=23'b000_xxx_1_00_x_1_1_x_xx_x_xx_0_1_0_10;  //Control signal for jalr
            end
 
  //ImmSrc,Rd_Src,Regwrite,ALUop,AluSrc,ImmS,IR_Src,Rd2Src,WD_Src,Memwrite,RFW_Src,Branch,Jump,WDRF_SEL,PC_BJI
7'b1101111: begin
            Control=23'b100_xxx_1_xx_x_1_x_x_xx_x_xx_0_1_0_01; //Control signal for jal
            end
            
            default: Control=23'bx;
             endcase
             end

endmodule
