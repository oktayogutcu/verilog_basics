module multiplier_4_bit(
    input [3:0] a,
    input [3:0] b,
    output [7:0] c
    );
    
    wire[3:0] m1_temp, m2_temp, m3_temp, m4_temp, m5, temp1;
    wire [5:0] m6, m7, temp2, temp3, temp4;
     
    multiplier_2_bit m1(a[1:0],b[1:0],m1_temp);
    multiplier_2_bit m2(a[3:2],b[1:0],m2_temp);
    multiplier_2_bit m3(a[1:0],b[3:2],m3_temp);
    multiplier_2_bit m4(a[3:2],b[3:2],m4_temp);
   
    assign temp1 = {2'b0,m1_temp[3:2]};
    assign m5 = m2_temp[3:0]+temp1;
    assign temp2 = {2'b0,m3_temp[3:0]};
    assign temp3 = {m4_temp[3:0],2'b0};
    assign m6 = temp2 + temp3;
    assign temp4 = {2'b0,m5[3:0]}; 
    assign m7 = temp4+m6;
     
    assign c[1:0]=m1_temp[1:0];
    assign c[7:2]=m7[5:0];  
    
endmodule









