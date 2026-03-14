`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 00:17:41
// Design Name: 
// Module Name: Datapath
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


module Datapath#(parameter WIDTH=32)(

input clk,rst,  //Clock and Reset signal for the datapath
output [WIDTH-1:0]PC_F, //input to the instruction memory
input [WIDTH-1:0]InstrF,//input to the data path 
input Regwrite_W,  //Enable signal for the register write from the WriteBack Stage
input Regwrite_M,  //Enable signal for the register write from the Memory Access Stage
input [2:0]ImmSrc, //Control Signal for the Immediate extent block
input AluSrc,  //Which data will go to the destination either Load or R type??
input ImmS , // select signal for Mux2
input [3:0]ALUControl,  //control signal to the ALU
output[WIDTH-1:0]ALUResult_M,  //Input address to the data memory
output [WIDTH-1:0]WD_M, //data written in the data memory
output B_Flag_E,//Flag output from ALU
input [WIDTH-1:0]ReadData_M,  //output from data memory
input [2:0]Rd_Src,  //select signal for Extend_unit_load
input IR_Src ,   //Select signal for MUX3
input Rd2Src , //select signal for MUX4
input [1:0]WD_Src, //select signal for MUX6
input [1:0]RFW_Src, // select signal for MUX7
input PC_Src_E , //Select Signal for MUX8
input [1:0]PC_BJI, //select signal for MUX9
input WDRF_SEL,  //select signal for MUX10
output [WIDTH-1:0]RF_WRITEDATA_W,//data written to the register file
output FlushE, //Clear signal from the hazard unit to clear the Execute register
output [31:0]InstrD //Instruction signal from the Decode Register
    );
    
   wire [WIDTH-1:0]PCNext; //PC + 4 
   wire [WIDTH-1:0]PC_ADD4_F; //output from Adder PC_4
   wire StallF; //Stalling signal for the FlipFlop for the PC
   wire StallD; //Stalling signal form the Hazard Unit to stall the Decode Register
   wire FlushD; //Clear signal from the hazard unit to clear the decode register
   wire lwStall; //Stall Signal for the load Instruction
   wire [1:0]ForwardAE; //Select Signal for the MUX 11
   wire [1:0]ForwardBE; //Select Signal for the MUX 12
   
   wire [WIDTH-1:0]PC_D; //PC signal from the Decode Register
   wire [WIDTH-1:0]PC_ADD4_D; //PC+4 signal from the Decode Register 
   wire  [WIDTH-1:0]ImmExt_D;  //output from extent
   wire  [WIDTH-1:0] Rd1_D,Rd2_D; //reading source register rs1 and Rs2
   
   
   wire [WIDTH-1:0]Rd1_E; //Rd1 from the execute register
   wire [WIDTH-1:0]SrcA_E;// Source A going into the ALU
   wire [WIDTH-1:0]Rd2_E; //Rd2 from the Execute Register
   wire [WIDTH-1:0]SourceB_E; //Source B going into the MUX4
   wire [WIDTH-1:0]InstrE; //Instr Signal from the execute Register
   wire [WIDTH-1:0]PC_E; //PC Signal from the Execute Register
   wire [WIDTH-1:0]PC_ADD4_E; //PC+4 Signal from the Execute Register
   wire  [WIDTH-1:0]ImmExt_E; //Extent from the Execute Register
   wire  [WIDTH-1:0]PC_BTA_E;  //output from the Adder PC_ImmB  
   wire  [WIDTH-1:0]ImmMux_E; // output from MUX M2
   wire  [WIDTH-1:0]SrcB_E;   //output from MUX3
   wire  [WIDTH-1:0]Rd2_RdImm_E; //output from MUX4
   wire  [WIDTH-1:0]PC_ImmExt_E;  //output from Adder PC_Imm
   wire  [WIDTH-1:0]PC_JTA_E; //target address for jal
   wire  [WIDTH-1:0]PC_TARGET_E; //target address for Jalr,jal and B type instruction
   wire  [WIDTH-1:0]WD_E ; //Output from the store unit before the memory stage
   
   wire [WIDTH-1:0]ALUResult_E;//ALUResult from the Execute Register
   wire [WIDTH-1:0]InstrM;//Instruction from the Memory Register
   wire [WIDTH-1:0]PC_ADD4_M;//PC+4 from the Memory Register
   wire [WIDTH-1:0]ImmExt_M;//ImmExt from the Memory Register
   wire [WIDTH-1:0]PC_ImmExt_M;//PC+ ImmExt from the Memory Register
   
   wire [WIDTH-1:0]ReadData_W; //ReadData Signal from the WB register
   wire [WIDTH-1:0]ALUResult_W;//ALUResult Signal from the WB register
   wire [WIDTH-1:0]InstrW;//Instruction Signal from the WB register
   wire [WIDTH-1:0]ImmExt_W;//Immext Signal from the WB register
   wire [WIDTH-1:0]PC_ImmExt_W;//PC+ImmExt Signal from the WB register
   wire [WIDTH-1:0]PC_ADD4_W;//PC+4 Signal from the WB register
   wire  [WIDTH-1:0]Rd_load_W;    //Output from Extend unit for load
   wire  [WIDTH-1:0]WD_RF_W ;     // Output from MUX M1
   wire  [WIDTH-1:0]RFWD_W;     //output from MUX7
   
    Hazard_Unit HU(InstrE[19:15],InstrD[19:15],InstrD[24:20],InstrE[24:20],InstrM[11:7],InstrW[11:7],InstrE[11:7],Regwrite_M,Regwrite_W,WDRF_SEL,RFW_Src[0],AluSrc,PC_Src_E,lwStall,StallF,StallD,FlushD,FlushE,ForwardAE,ForwardBE);//Hazard Unit

    D_FF_CLR D_I(clk,FlushD,StallD,InstrF,InstrD); //Decode Stage Register for the Instruction
    D_FF_CLR D_PC(clk,FlushD,StallD,PC_F,PC_D); //Decode Stage Register for the PC
    D_FF_CLR D_PC_4(clk,FlushD,StallD,PC_ADD4_F,PC_ADD4_D); //Decode Stage Register for the PC+4
    
    DFF_Clr  E_Rd1(clk,FlushE,Rd1_D,Rd1_E);//Execute Stage register for the Rd1
    DFF_Clr  E_Rd2(clk,FlushE,Rd2_D,Rd2_E);//Execute Stage register for the Rd2
    DFF_Clr  E_Instr(clk,FlushE,InstrD,InstrE);//Execute Stage register for the Instr
    DFF_Clr  E_PC(clk,FlushE,PC_D,PC_E);//Execute Stage register for the PC
    DFF_Clr  E_PC_4(clk,FlushE,PC_ADD4_D,PC_ADD4_E);//Execute Stage register for the PC+4
    DFF_Clr  E_ImmExt(clk,FlushE,ImmExt_D,ImmExt_E);//Execute Stage register for the ImmExt
    
    DFF M_Aluresult(clk,rst,ALUResult_E,ALUResult_M);//Memory Stage Register for the ALUResult
    DFF M_WD(clk,rst,WD_E,WD_M);//Memory Stage Register for the Write Data
    DFF M_Instr(clk,rst,InstrE,InstrM);//Memory Stage Register for the instruction
    DFF M_PC_4(clk,rst,PC_ADD4_E,PC_ADD4_M);//Memory Stage Register for the PC+4
    DFF M_PC_ImmExt(clk,rst,PC_ImmExt_E,PC_ImmExt_M);//Memory Stage Register for the PC+ImmExt
    DFF M_ImmExt(clk,rst,ImmExt_E,ImmExt_M);//Memory Stage Register for the ImmExt
    
    DFF W_ReadData(clk,rst,ReadData_M,ReadData_W);//Write Back Stage Register for the ReadData
    DFF W_ALUResult(clk,rst,ALUResult_M,ALUResult_W);//Write Back Stage Register for the ALUResult
    DFF W_Instr(clk,rst,InstrM,InstrW);//Write Back Stage Register for the Instruction
    DFF W_ImmExt(clk,rst,ImmExt_M,ImmExt_W);//Write Back Stage Register for the ImmExt
    DFF W_PC_ImmExt(clk,rst,PC_ImmExt_M,PC_ImmExt_W);//Write Back Stage Register for the PC+ImmExt
    DFF W_PC_4(clk,rst,PC_ADD4_M,PC_ADD4_W);//Write Back Stage Register for the PC+4
    
    
    D_FF F_PC(clk,rst,StallF,PCNext,PC_F);   //D flip flop for PC
    Adder PC_4(PC_F,32'h4,PC_ADD4_F);    // PC=Pc+4
    Regfile Rf(clk,Regwrite_W,InstrD[19:15],InstrD[24:20],InstrW[11:7],RF_WRITEDATA_W,Rd1_D,Rd2_D);  // Register file
    Extend_Unit IMM(InstrD[WIDTH-1:7],ImmSrc,ImmExt_D);   //Extend unit 
    ALU alu(SrcA_E,SrcB_E,ALUControl,ALUResult_E,B_Flag_E);    //ALU
    Extend_Unit_load I_Load(ReadData_W,Rd_Src,Rd_load_W);  // Extend unit for load
    Mux_2x1 M1(ALUResult_W,Rd_load_W,AluSrc,WD_RF_W);   //Mux selects btw ALuresult and Rd_load
    Mux_2x1 M2({27'b0,InstrE[24:20]},ImmExt_E,ImmS,ImmMux_E); //Mux selects btw ImmExt and Instr[24:0]
    Mux_2x1 M3(Rd2_RdImm_E,ImmMux_E,IR_Src,SrcB_E);  //Mux selects btw Rd2 and ImmMux
    Mux_2x1 M4({27'b0,SourceB_E[4:0]},SourceB_E,Rd2Src,Rd2_RdImm_E); //Mux selects btw Rd2 or Rd2[4:0]
    Store_unit SD(SourceB_E,WD_Src,WD_E); //data written to the Data Memory
    Mux_3x1 M7(ImmExt_W,WD_RF_W,PC_ImmExt_W,RFW_Src,RFWD_W);  //data output to MUX7
    Adder PC_ImmU(ImmExt_E,PC_E,PC_ImmExt_E);  // Addition of PC and ImmExt for AUIPC 
    Adder PC_ImmB(ImmExt_E,PC_E,PC_BTA_E); //Addition of PC and ImmExtB for Calculating the branch target address
    Mux_2x1 M8(PC_ADD4_F,PC_TARGET_E,PC_Src_E,PCNext); //Mux for selecting PC + 4 or PC + BTA
    Adder PC_ImmJ(ImmExt_E,PC_E,PC_JTA_E); //Addition of PC and ImmExtJ for calculating the jump target address
    Mux_3x1 M9(PC_BTA_E,PC_JTA_E,ALUResult_E,PC_BJI,PC_TARGET_E);  //Mux selecting btw Branch target address,Jump target Address and Jalr target address
    Mux_2x1 M10(PC_ADD4_W,RFWD_W,WDRF_SEL,RF_WRITEDATA_W);  //Mux selecting btw PC+4 and WD_RF
    
    Mux_3x1 M11(Rd1_E,RF_WRITEDATA_W,ALUResult_M,ForwardAE,SrcA_E);  //Forwarding Mux for RD1
    Mux_3x1 M12(Rd2_E,RF_WRITEDATA_W,ALUResult_M,ForwardBE,SourceB_E); //Forwarding Mux for Rd2
    
    
    
  
    
endmodule
