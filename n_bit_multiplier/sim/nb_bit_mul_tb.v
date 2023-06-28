`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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


module nb_bit_mul_tb 
    #(
        _BIT_DEPTH = 4
    )
    (
    
    );
    
    reg clk;
    reg [_BIT_DEPTH - 1:0]a_in, b_in;
    wire[2*_BIT_DEPTH - 1:0]c_out;
   
    n_bit_mul # (
            .BIT_DEPTH (_BIT_DEPTH)
    )
    n_bit_mul (
        .a(a_in),
        .b(b_in), 
        .c(c_out)
    );

    initial begin
        clk = 0;
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
        a_in = 2097120;
        b_in = 16776960;
        #20;
        a_in = 2097120;
        b_in = 17660;
        #20;
        a_in = 32'hFFFFFFFF;
        b_in = 32'hFFFFFFFF;
        #20;
    end 
    
endmodule
