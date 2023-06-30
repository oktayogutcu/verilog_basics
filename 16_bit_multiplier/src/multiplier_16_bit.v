`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: oktayogutcu
// 
// Create Date: 06/12/2023 04:19:50 PM
// Design Name: 
// Module Name: array16
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
////////////////////////////////s//////////////////////////////////////////////////


module multiplier_16_bit(
    input [15:0] a,
    input [15:0] b,
    output [31:0] c
    );

    wire [15:0] mul_00, mul_10, mul_01, mul_11, sum_temp1, concat1;
    wire [23:0] sum_temp2, sum_temp3, concat2, concat3, concat4;
     
    multiplier_8_bit m1(a[7:0], b[7:0], mul_00);
    multiplier_8_bit m2(a[15:8], b[7:0], mul_10);
    multiplier_8_bit m3(a[7:0], b[15:8], mul_01);
    multiplier_8_bit m4(a[15:8], b[15:8], mul_11);

    assign concat1      = {8'b0, mul_00[15:8]};
    assign sum_temp1    = mul_10[15:0] + concat1;
    assign concat2      = {8'b0, mul_01[15:0]};
    assign concat3      = {mul_11[15:0], 8'b0};
    assign sum_temp2    = concat2 + concat3;
    assign concat4      = {8'b0, sum_temp1[15:0]}; 
    assign sum_temp3    = concat4 + sum_temp2;
     
    assign c[7:0] = mul_00[7:0];
    assign c[31:8] = sum_temp3[23:0]; 
    
endmodule










