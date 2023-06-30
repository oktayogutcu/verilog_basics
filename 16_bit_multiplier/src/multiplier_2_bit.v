module multiplier_2_bit(
    input [1:0] a,
    input [1:0] b,
    output [3:0] c
    );
    
    wire[3:0]temp;
    
    assign c[0] = a[0]&b[0];
    assign temp[0] = a[1]&b[0];
    assign temp[1] = a[0]&b[1];
    assign temp[2] = a[1]&b[1];
    
    ha m1(temp[0],temp[1],c[1],temp[3]);
    ha m2(temp[2],temp[3],c[2],c[3]);
    
    
endmodule
