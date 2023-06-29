module multiplier_8_bit(
    input [7:0]a,
    input [7:0]b,
    output [15:0]c
    );
     
    wire [7:0]q0,q1,q2,q3,q4,temp1;
    wire [11:0]q5,q6,temp2,temp3,temp4;
     
    multiplier_4_bit z1(a[3:0],b[3:0],q0[7:0]);
    multiplier_4_bit z2(a[7:4],b[3:0],q1[7:0]);
    multiplier_4_bit z3(a[3:0],b[7:4],q2[7:0]);
    multiplier_4_bit z4(a[7:4],b[7:4],q3[7:0]);
     
    assign temp1 ={4'b0,q0[7:4]};
    assign q4 = q1[7:0]+temp1;
    assign temp2 ={4'b0,q2[7:0]};
    assign temp3 ={q3[7:0],4'b0};
    assign q5 = temp2+temp3;
    assign temp4={4'b0,q4[7:0]};     
    assign q6 = temp4+q5;
     
    assign c[3:0]=q0[3:0];
    assign c[15:4]=q6[11:0];
    
endmodule