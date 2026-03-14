`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 20:46:41
// Design Name: 
// Module Name: ALU_Decoder
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


module ALU_Decoder(
input [1:0]ALUop,
input op,
input [2:0]funct3,
input funct7,
output reg [3:0]ALUctrl  //Control Signal for the ALU
    );
    
always@(*) begin
case(ALUop)
2'b00: ALUctrl=4'b0000; // Addition for l and S

2'b01: begin
       case(funct3)
       3'b000: ALUctrl=4'b1010; //Comparing rs1==rs2??
       3'b001: ALUctrl=4'b1011; //rs1!=rs2 ??
       3'b100: ALUctrl=4'b1100; // rs1<rs2 ?? signed
       3'b101: ALUctrl=4'b1101; //rs1>= rs2?? signed
       3'b110: ALUctrl=4'b1110; // rs1<rs2?? unsigned
       3'b111: ALUctrl=4'b1111; // rs1>=rs2?? unsigned
       
       default: ALUctrl=4'bxxxx; 
       endcase
       end
       
       
2'b10: begin
       case(funct3)
       3'b000:begin
            if(op) begin
              if(funct7)
              ALUctrl=4'b1001;  //Sub
              else
              ALUctrl=4'b0000;  //ADD
              end
            else  
             ALUctrl=4'b0000; //ADDI              
              end
              
       
       3'b100: ALUctrl=4'b0001;  //Xori,xor
       3'b110: ALUctrl=4'b0010;  //ori,or
       3'b111: ALUctrl=4'b0011;  //ANDI,AND
       3'b010: ALUctrl=4'b0100; // slti,slt
       3'b011: ALUctrl=4'b0101; // sltiu,sltu
       3'b001: ALUctrl=4'b0110; //slli,sll
       3'b101: begin
               if(funct7)
                 ALUctrl=4'b1000; //srai,sra
               else
                 ALUctrl=4'b0111; //srli,srl
                 end
       endcase
       end
       
  default: ALUctrl=4'bx;
    
    endcase
    end
    
    
endmodule
