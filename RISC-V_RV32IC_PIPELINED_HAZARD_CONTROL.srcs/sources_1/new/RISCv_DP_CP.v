`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 20:07:21
// Design Name: 
// Module Name: RISCv_DP_CP
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


module RISCv_DP_CP#(parameter WIDTH=32)(
input clk,rst,
output [WIDTH-1:0]PC_F,  //input for the instruction memory containing the address
input [WIDTH-1:0]InstrF,  //input to the DP and CP which gets to know which instruction needs to be performed
output Memwrite_M,   //Write enable Signal for the data memory
output [WIDTH-1:0]ADD_DM,  //address for the data memory
output [WIDTH-1:0]WD_M,   //Data which needs to be written in the data memory
input  [WIDTH-1:0]ReadData_M,  //Data reads out from the data memory
output [WIDTH-1:0]RF_WRITEDATA_W  //data Written to the register file
);

wire [WIDTH-1:0]InstrD;//instruction signal from the Decode Register
wire [2:0]ImmSrc_D; //select signal for extend unit 
wire [3:0]ALUControl_D;   //Select signal for ALU
wire [2:0]Rd_Src_D;    //select signal for Extend_unit_load
wire AluSrc_D;      //select signal for MUX1
wire ImmS_D ;       //select signal for MUX2
wire Memwrite_D; //Enable signal for the data memory
wire Regwrite_D;  //Enable for writing the register
wire IR_Src_D ;  //Select signal for MUX3
wire Rd2Src_D ;  //select signal for MUX4
wire [1:0]WD_Src_D; //select signal for MUX6
wire [1:0]RFW_Src_D; //select signal for MUX7
wire B_Flag_E;  //Flag signal from the ALU which is going to the input of controller
wire WDRF_SEL_D;//select signal for RFWD
wire [1:0]PC_BJI_D; //select signal for the Mux9
wire Jump_D; //Jump signal output from the Control Path
wire Branch_D;//Branch signal output from the Control Path

wire FlushE; //Clear signal for the Execute Stage Register


    wire PC_Src_E; //select signal for MUX which is selecting btw PC+4 and PC + BTA
    wire Branch_E;    //Branch signal if branch is active
    wire Jump_E; //jump signal for jalr and jal
    wire RegWrite_E;
    wire [3:0]ALUControl_E;
    wire [2:0]Rd_Src_E;
    wire  AluSrc_E;
    wire  ImmS_E;
    wire  IR_Src_E;
    wire  Rd2Src_E;
    wire  [1:0]WD_Src_E;
    wire  Memwrite_E;
    wire [1:0]RFW_Src_E;
    wire WDRF_SEL_E;
    wire [1:0]PC_BJI_E;
    
    wire RegWrite_M;
    wire [2:0]Rd_Src_M;
    wire  AluSrc_M;
    wire [1:0]RFW_Src_M;
    wire WDRF_SEL_M;
    
    wire RegWrite_W;
    wire [2:0]Rd_Src_W;
    wire  AluSrc_W;
    wire [1:0]RFW_Src_W;
    wire WDRF_SEL_W;

    DFF_Clr #(.WIDTH(1))  E_Regwrite(clk,FlushE,RegWrite_D,RegWrite_E);//Execute Stage register for the Regwrite
    DFF_Clr #(.WIDTH(4))  E_ALUControl(clk,FlushE,ALUControl_D,ALUControl_E);//Execute Stage register for the ALUControl
    DFF_Clr #(.WIDTH(3))  E_RdSrc(clk,FlushE,Rd_Src_D,Rd_Src_E);//Execute stage  register for the Rd_Src
    DFF_Clr #(.WIDTH(1))  E_AluSrc(clk,FlushE,AluSrc_D,AluSrc_E);//Execute stage  register for the AluSrc
    DFF_Clr #(.WIDTH(1))  E_ImmS(clk,FlushE,ImmS_D,ImmS_E);//Execute stage  register for the ImmS
    DFF_Clr #(.WIDTH(1))  E_IR_Src(clk,FlushE,IR_Src_D,IR_Src_E);//Execute stage  register for the IR_Src
    DFF_Clr #(.WIDTH(1))  E_Rd2Src(clk,FlushE,Rd2Src_D,Rd2Src_E);//Execute stage  register for the Rd2Src
    DFF_Clr #(.WIDTH(2))  E_WD_Src(clk,FlushE,WD_Src_D,WD_Src_E);//Execute stage  register for the WD_Src
    DFF_Clr #(.WIDTH(1))  E_Memwrite(clk,FlushE,Memwrite_D,Memwrite_E);//Execute stage  register for the MemWrite
    DFF_Clr #(.WIDTH(2))  E_RFW_Src(clk,FlushE,RFW_Src_D,RFW_Src_E);//Execute stage  register for the RFW_Src
    DFF_Clr #(.WIDTH(1))  E_Jump(clk,FlushE,Jump_D,Jump_E);//Execute stage  register for the Jump
    DFF_Clr #(.WIDTH(1))  E_Branch(clk,FlushE,Branch_D,Branch_E);//Execute stage  register for the Branch
    DFF_Clr #(.WIDTH(1))  E_WDRF_SEL(clk,FlushE,WDRF_SEL_D,WDRF_SEL_E);//Execute stage  register for the WDRF_SEL
    DFF_Clr #(.WIDTH(2))  E_PC_BJI(clk,FlushE,PC_BJI_D,PC_BJI_E);//Execute stage  register for the PC_BJI
    
    DFF #(.WIDTH(1)) M_Regwrite(clk,rst,RegWrite_E,RegWrite_M);//Memory Stage register for the Regwrite
    DFF #(.WIDTH(3)) M_RdSrc(clk,rst,Rd_Src_E,Rd_Src_M);//Memory Stage register for the Rd_Src
    DFF #(.WIDTH(1)) M_AluSrc(clk,rst,AluSrc_E,AluSrc_M);//Memory stage  register for the AluSrc
    DFF #(.WIDTH(1)) M_Memwrite(clk,rst,Memwrite_E,Memwrite_M);//Memory stage  register for the MemWrite
    DFF #(.WIDTH(2)) M_RFW_Src(clk,rst,RFW_Src_E,RFW_Src_M);//Memory stage  register for the RFW_Src
    DFF #(.WIDTH(1)) M_WDRF_SEL(clk,rst,WDRF_SEL_E,WDRF_SEL_M);//Memory stage  register for the WDRF_SEL
    
    DFF #(.WIDTH(1)) W_Regwrite(clk,rst,RegWrite_M,RegWrite_W);//WB Stage register for the Regwrite
    DFF #(.WIDTH(3)) W_RdSrc(clk,rst,Rd_Src_M,Rd_Src_W);//WB Stage register for the Rd_Src
    DFF #(.WIDTH(1)) W_AluSrc(clk,rst,AluSrc_M,AluSrc_W);//WB stage  register for the AluSrc
    DFF #(.WIDTH(2)) W_RFW_Src(clk,rst,RFW_Src_M,RFW_Src_W);//WB stage  register for the RFW_Src
    DFF #(.WIDTH(1)) W_WDRF_SEL(clk,rst,WDRF_SEL_M,WDRF_SEL_W);//WB stage  register for the WDRF_SEL

 assign PC_Src_E=((Branch_E & B_Flag_E | Jump_E) === 1)?1:0 ; //if branch is taken and B_Flag is active or jump is taken

Datapath DP(clk,rst,PC_F,InstrF,RegWrite_W,RegWrite_M,ImmSrc_D,AluSrc_W,ImmS_E,ALUControl_E,ADD_DM,WD_M,B_Flag_E,ReadData_M,Rd_Src_W,IR_Src_E,Rd2Src_E,WD_Src_E,RFW_Src_W,PC_Src_E,PC_BJI_E,WDRF_SEL_W,RF_WRITEDATA_W,FlushE,InstrD);
Control_Path CP(InstrD[6:0],InstrD[14:12],InstrD[30],RegWrite_D,ImmSrc_D,ALUControl_D,Rd_Src_D,AluSrc_D,ImmS_D,IR_Src_D,Rd2Src_D,WD_Src_D,Memwrite_D,RFW_Src_D,WDRF_SEL_D,PC_BJI_D,Jump_D,Branch_D);
  
   
    
endmodule
