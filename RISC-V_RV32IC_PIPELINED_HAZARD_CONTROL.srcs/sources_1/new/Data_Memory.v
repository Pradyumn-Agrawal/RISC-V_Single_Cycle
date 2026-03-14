`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.02.2026 20:53:27
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory#(parameter WIDTH=32,DMEM_WIDTH=64)(
input clk,Memwrite_M,//Clock signal and Memwrite Signal
input [WIDTH-1:0]ADD_DM, //Address for the Data Memory
input [WIDTH-1:0] WD_M,  //Data written to the Data Memory
output [WIDTH-1:0]ReadData_M  //Data read from the Data memory
    );
    
    reg [WIDTH-1:0] DMEM[0:DMEM_WIDTH-1]; //Data Memory Size and Width
    
    assign ReadData_M=DMEM[ADD_DM];  //Reading Data from the Data Memory
    
    always@(posedge clk) begin

    if(Memwrite_M) begin
 
    DMEM[ADD_DM]<=WD_M; //Data Written to the data Memory
    end
    end
    
endmodule
