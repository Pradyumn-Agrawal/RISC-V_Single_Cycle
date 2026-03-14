`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 19:52:56
// Design Name: 
// Module Name: ALU
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


module ALU#(parameter WIDTH=32)(
input [WIDTH-1:0]SrcA,
input [WIDTH-1:0]SrcB,
input [3:0]Alu_ctrl,  //control signal for ALU operations
output reg [WIDTH-1:0]Aluresult,  //Result from ALU
output reg B_Flag     //Branch flag for the Branch Instructions
    );
    
    always@(*) begin
    
    Aluresult = 32'd0;
    B_Flag    = 1'b0;
    
    case(Alu_ctrl)
    4'b0000: Aluresult=SrcA + SrcB;   // ADD
    4'b0001: Aluresult=SrcA ^ SrcB;  //XOR
    4'b0010: Aluresult=SrcA | SrcB;   // OR
    4'b0011: Aluresult=SrcA & SrcB;   //AND
    4'b0100: Aluresult=($signed(SrcA) < $signed(SrcB))?32'd1:32'd0 ; // slti or slt signed comparison
    4'b0101: Aluresult=(SrcA < SrcB)?32'd1:32'd0;  // sltiu or sltu unsigned comparison
    4'b0110: Aluresult=(SrcA << SrcB); //slli or sll
    4'b0111: Aluresult=(SrcA >> SrcB); //srli or srl
    4'b1000: Aluresult=($signed(SrcA) >>> SrcB); //srai or sra
    4'b1001: Aluresult=SrcA - SrcB;  //Sub
    4'b1010: B_Flag=(SrcA==SrcB)?1:0;//beq
    4'b1011: B_Flag=(SrcA!=SrcB)?1:0;//bne
    4'b1100: B_Flag=($signed(SrcA) < $signed(SrcB))?1:0;//blt
    4'b1101: B_Flag=($signed(SrcA) >= $signed(SrcB))?1:0;//bge
    4'b1110: B_Flag=(SrcA < SrcB)?1:0;//bltu
    4'b1111: B_Flag=(SrcA >= SrcB)?1:0;//bgeu
    
  
    endcase
    end
    
endmodule
