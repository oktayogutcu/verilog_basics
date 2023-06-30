`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: oktayogutcu
// 
// Create Date: 06/26/2023 04:16:43 PM
// Design Name: 
// Module Name: n_bit_mul
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.02
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module n_bit_mul 
    #(
    parameter BIT_DEPTH = 32
    )
    (
    input [BIT_DEPTH-1:0] a,
    input [BIT_DEPTH-1:0] b,
    output [2*BIT_DEPTH-1:0] c
    );
    
    wire[BIT_DEPTH-1:0] mul_00, mul_10, mul_01, mul_11, sum_temp1, concat1;
    wire[(BIT_DEPTH+BIT_DEPTH/2)-1:0] sum_temp2, sum_temp3, concat2, concat3, concat4;
    wire[3:0]temp;
     
    generate
        if (BIT_DEPTH > 2) begin

            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g0(a[(BIT_DEPTH/2)-1:0],b[(BIT_DEPTH/2)-1:0],mul_00);              // multiplication of right hand sides (BIT_DEPTH/2 bits)
            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g1(a[BIT_DEPTH-1:BIT_DEPTH/2],b[(BIT_DEPTH/2)-1:0],mul_10);        // multiplication of a's left hand and b's right hand sides
            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g2(a[(BIT_DEPTH/2)-1:0],b[BIT_DEPTH-1:BIT_DEPTH/2],mul_01);        // multiplication of b's left hand and a's right hand sides
            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g3(a[BIT_DEPTH-1:BIT_DEPTH/2],b[BIT_DEPTH-1:BIT_DEPTH/2],mul_11);  // multiplication of left hand sides 

            assign concat1    = {{(BIT_DEPTH/2){1'b0}} , mul_00[(BIT_DEPTH-1):(BIT_DEPTH/2)]};                      // concatenate BIT_DEPTH/2'b0 and left hand side of mul_00 
            assign sum_temp1  = mul_10[(BIT_DEPTH-1):0] + concat1;                                                  // first sum of multiplication, mul_10 + concat1
            assign concat2    = {{(BIT_DEPTH/2){1'b0}} , mul_01[(BIT_DEPTH-1):0]};                                  // concatenate BIT_DEPTH/2'b0 and mul_01 
            assign concat3    = {mul_11[(BIT_DEPTH-1):0], {(BIT_DEPTH/2){1'b0}}};                                   // concatenate mul_11 and BIT_DEPTH/2'b0 
            assign sum_temp2  = concat2 + concat3;                                                                  // second sum of multiplication, concat2 and concat3
            assign concat4    = {{(BIT_DEPTH/2){1'b0}}, sum_temp1[(BIT_DEPTH-1):0]};                                // concatenate BIT_DEPTH/2'b0 and sum_temp1 
            assign sum_temp3  = concat4 + sum_temp2;                                                                // final sum: concat4 + sum_temp2
            
            assign c[(BIT_DEPTH/2 - 1):0]               = mul_00[(BIT_DEPTH/2 - 1):0];                              // lowest BIT_DEPTH/2 bits stands in mul_00
            assign c[(2*BIT_DEPTH - 1):(BIT_DEPTH/2)]   = sum_temp3[(BIT_DEPTH+BIT_DEPTH/2)-1:0];                   // rest of the result concateneted with sum_temp3 

        end
        
        else if (BIT_DEPTH == 2) begin
        
            //two bit multiplication here!

            assign c[0]     = a[0] & b[0];
            assign temp[0]  = a[1] & b[0];
            assign temp[1]  = a[0] & b[1];
            assign temp[2]  = a[1] & b[1];
            
            ha s1(temp[0], temp[1], c[1], temp[3]);
            ha s2(temp[2], temp[3], c[2], c[3]);
            
        end
  
    endgenerate
            
    
endmodule
