`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2026 22:02:03
// Design Name: 
// Module Name: Store_unit
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


module Store_unit #(parameter WIDTH=32)(
input [WIDTH-1:0]Rd2_E,  //data which is to be written in the data memory coming from the Rs2 of register file
input [1:0]WD_Src,   //Control signal for the store unit 00: SB,01: SH,10: SW
//input [1:0]ALUResult, //2 bit address from the ALUresult
//input [WIDTH-1:0]ReadData, //Data from the data memory
output reg [WIDTH-1:0]WD_E  //Data which is to be written to the data memory
    );
    
   //wire [1:0]byte_offset=ALUResult;
    
    always@(*)begin
  //  WD=ReadData;
    case(WD_Src)
    2'b00: begin
         // case(byte_offset)
           // 2'b00: 
//           WD[7:0]=Rd2[7:0];
           WD_E[WIDTH-1:0]={{24{Rd2_E[7]}},Rd2_E[7:0]};
               //Byte store in WD[7:0]
           // 2'b01:  WD[15:8]=Rd2[7:0];  //Byte store in WD[15:8]
           // 2'b10:  WD[23:16]=Rd2[7:0]; //byte Store in WD[23:16]
          // 2'b11:  WD[31:24]=Rd2[7:0];  //byte store in WD[31:24]
          // endcase
            end
   
   2'b01: begin
           //if(byte_offset[1]==1'b1)
          // WD[31:16]=Rd2[15:0];  //if byte offset[1]=1 then Half store in WD[31:16]
          // else
           WD_E[WIDTH-1:0]={{16{Rd2_E[15]}},Rd2_E[15:0]}; //else half store in WD[15:0]
           end
           
  2'b10: WD_E=Rd2_E;
  
  default: WD_E=32'bx;
  
  endcase
  end
  

endmodule
