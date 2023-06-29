`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: oktayogutcu
// 
// Create Date: 06/27/2023 05:16:18 PM
// Design Name: 
// Module Name: nb_bit_mul_tb
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


module multiplier_16_bit_tb
    (
    
    );
    
    reg [15:0]a_in, b_in;
    wire[31:0]c_out;
   
    multiplier_16_bit m1(
        .a(a_in),
        .b(b_in), 
        .c(c_out)
    );

    initial begin
        a_in = 0;
        b_in = 0;
        #20;
        a_in = 3;
        b_in = 3;
        #20;
        a_in = 3;
        b_in = 1;
        #20;
        a_in = 12;
        b_in = 10;
        #20;
        a_in = 5;
        b_in = 15;
        #20;
        a_in = 250;
        b_in = 11;
        #20; 
        a_in = 126;
        b_in = 211;
        #20;       
        a_in = 5526;
        b_in = 1660;
        #20;
        a_in = 65535;
        b_in = 65535;
        #20;
    end 
    
endmodule
