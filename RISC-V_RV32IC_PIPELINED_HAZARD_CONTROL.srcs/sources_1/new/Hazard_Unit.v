`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2026 17:05:08
// Design Name: 
// Module Name: Hazard_Unit
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


module Hazard_Unit(
input [4:0]Rs1E,
input [4:0]Rs1D,
input [4:0]Rs2D,
input [4:0]Rs2E,
input [4:0]RdM,
input [4:0]RdW,
input [4:0]RdE,
input RegwriteM,
input RegwriteW,
input WDRF_SEL,
input RFW_SRC,
input AluSrc,
input PCSrcE,
output lwStall,
output StallF,
output StallD,
output FlushD,
output FlushE,
output reg[1:0]ForwardAE,
output reg[1:0]ForwardBE
    );
 
 //Forwarding logic for the Read After Write Data Hazards
 always@(*) begin             
 
 if(((Rs1E==RdM)& RegwriteM)&(Rs1E!=0))  
 ForwardAE=2'b10;
 else if(((Rs1E==RdW)& RegwriteW)&(Rs1E!=0))
 ForwardAE=2'b01;
 else
 ForwardAE=2'b00;
 
 if(((Rs2E==RdM)& RegwriteM)&(Rs2E!=0))  
 ForwardBE=2'b10;
 else if(((Rs2E==RdW)& RegwriteW)&(Rs2E!=0))
 ForwardBE=2'b01;
 else
 ForwardBE=2'b00;
 
 end
  
 //Stall logic for the Load hazard
 assign lwStall=((WDRF_SEL & RFW_SRC &  AluSrc)===1)&((Rs1D==RdE)|(Rs2D==RdE));
 assign StallF=(lwStall===1?1:0);
 assign StallD=(lwStall===1?1:0);
 
 //Flush logic when Branch is taken or a load introduces a bubble
 assign FlushD=PCSrcE;
 assign FlushE=lwStall | PCSrcE;

endmodule
