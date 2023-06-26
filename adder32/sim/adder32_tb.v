`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2023 01:27:59 PM
// Design Name: 
// Module Name: adder32_tb
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


module adder32_tb;

reg clk;
reg[31:0]a,b;
wire[31:0]sum;
reg cin;
wire cout;
    
adder32 a1(
.A_in(a),
.B_in(b),
.Carry_in(cin),
.sum(sum),
.Carry_out(cout)
);

initial begin
    a=0;
    b=0;
    cin=0;
    clk=0;
end

always # 10 clk=~clk;

always @ (posedge clk)
begin
    #10;
    #10 a=32'b11111111110000000000111111111100;
    #10 b=32'b11111111111111111111000000000011;
end

always @ (a or b)
#50 $display($time,"clk=%b,a=%b,b=%b,cin=%b",$time,clk,a,b,cin);
initial
#100 $finish;

endmodule