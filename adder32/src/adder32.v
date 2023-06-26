`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2023 01:21:48 PM
// Design Name: 
// Module Name: adder32
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


module adder32(
    input [31:0] A_in,
    input [31:0] B_in,
    input Carry_in,
    output [31:0] sum,
    output Carry_out
    );
    
    wire[32:0] sum_temp;
    
    assign sum_temp = A_in + B_in + Carry_in;
    assign sum = sum_temp[31:0];
    assign Carry_out = sum_temp[32];
    
endmodule
