module multiplier_4_bit(
    input [3:0] a,
    input [3:0] b,
    output [7:0] c
    );
    
    wire[3:0] mul_00, mul_10, mul_01, mul_11, sum_temp1, concat1;
    wire [5:0] sum_temp2, sum_temp3, concat2, concat3, concat4;
     
    multiplier_2_bit m1(a[1:0], b[1:0], mul_00);
    multiplier_2_bit m2(a[3:2], b[1:0], mul_10);
    multiplier_2_bit m3(a[1:0], b[3:2], mul_01);
    multiplier_2_bit m4(a[3:2], b[3:2], mul_11);
   
    assign concat1      = {2'b0, mul_00[3:2]};
    assign sum_temp1    = mul_10[3:0] + concat1;
    assign concat2      = {2'b0, mul_01[3:0]};
    assign concat3      = {mul_11[3:0], 2'b0};
    assign sum_temp2    = concat2 + concat3;
    assign concat4      = {2'b0, sum_temp1[3:0]}; 
    assign sum_temp3    = concat4 + sum_temp2;
     
    assign c[1:0] = mul_00[1:0];
    assign c[7:2] = sum_temp3[5:0];  
    
endmodule









