`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module n_bit_mul 
    #(
    BIT_DEPTH = 32
    )
    (
    input [BIT_DEPTH-1:0] a,
    input [BIT_DEPTH-1:0] b,
    output [2*BIT_DEPTH-1:0] c
    );
    
    wire[BIT_DEPTH-1:0] m1_temp, m2_temp, m3_temp, m4_temp, m5_temp, temp1;
    wire[(BIT_DEPTH+BIT_DEPTH/2)-1:0] m6_temp, m7_temp, temp2, temp3, temp4;
    wire[3:0]temp;
     
    generate
        if (BIT_DEPTH > 2) begin

            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g0(a[(BIT_DEPTH/2)-1:0],b[(BIT_DEPTH/2)-1:0],m1_temp);
            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g1(a[BIT_DEPTH-1:BIT_DEPTH/2],b[(BIT_DEPTH/2)-1:0],m2_temp);
            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g2(a[(BIT_DEPTH/2)-1:0],b[BIT_DEPTH-1:BIT_DEPTH/2],m3_temp);
            n_bit_mul #(.BIT_DEPTH(BIT_DEPTH/2)) g3(a[BIT_DEPTH-1:BIT_DEPTH/2],b[BIT_DEPTH-1:BIT_DEPTH/2],m4_temp);

            assign temp1 ={{(BIT_DEPTH/2){1'b0}} , m1_temp[(BIT_DEPTH-1):(BIT_DEPTH/2)]};
            assign m5_temp = m2_temp[(BIT_DEPTH-1):0] + temp1;
            assign temp2 ={{(BIT_DEPTH/2){1'b0}} , m3_temp[(BIT_DEPTH-1):0]};
            assign temp3 ={m4_temp[(BIT_DEPTH-1):0], {(BIT_DEPTH/2){1'b0}}};
            assign m6_temp = temp2 + temp3;
            assign temp4={{(BIT_DEPTH/2){1'b0}}, m5_temp[(BIT_DEPTH-1):0]}; 
            assign m7_temp = temp4 + m6_temp;
            
            assign c[(BIT_DEPTH/2 - 1):0] = m1_temp[(BIT_DEPTH/2 - 1):0];
            assign c[(2*BIT_DEPTH - 1):(BIT_DEPTH/2)] = m7_temp[(BIT_DEPTH+BIT_DEPTH/2)-1:0];

        end
        
        else if (BIT_DEPTH == 2) begin
        
            assign c[0] = a[0]&b[0];
            assign temp[0] = a[1]&b[0];
            assign temp[1] = a[0]&b[1];
            assign temp[2] = a[1]&b[1];
            
            ha m1(temp[0],temp[1],c[1],temp[3]);
            ha m2(temp[2],temp[3],c[2],c[3]);
            
        end
  
    endgenerate
            
    
endmodule
