module multiplier_8_bit(
    input [7:0]a,
    input [7:0]b,
    output [15:0]c
    );
     
    wire [7:0] mul_00, mul_10, mul_01, mul_11, sum_temp1, concat1;
    wire [11:0] sum_temp2, sum_temp3, concat2, concat3, concat4;
     
    multiplier_4_bit m1(a[3:0], b[3:0], mul_00);
    multiplier_4_bit m2(a[7:4], b[3:0], mul_10);
    multiplier_4_bit m3(a[3:0], b[7:4], mul_01);
    multiplier_4_bit m4(a[7:4], b[7:4], mul_11);

    assign concat1      = {4'b0, mul_00[7:4]};
    assign sum_temp1    = mul_10[7:0] + concat1;
    assign concat2      = {4'b0, mul_01[7:0]};
    assign concat3      = {mul_11[7:0], 4'b0};
    assign sum_temp2    = concat2 + concat3;
    assign concat4      = {4'b0, sum_temp1[7:0]}; 
    assign sum_temp3    = concat4 + sum_temp2;
     
    assign c[3:0] = mul_00[3:0];
    assign c[15:4] = sum_temp3[11:0]; 
    
endmodule