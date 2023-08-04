`timescale 1ns/1ns

module updown_counter
(
input clk,
input reset,
input [1:0]direction,
output [3:0] count
);

reg [3:0] counter = 0; 

always @(posedge clk)
begin
    if(reset) 
        counter <= 0;
    else if (direction == 2'b01)
        counter <= counter + 1;
    else if (direction == 2'b11)
        counter <= counter - 1; 
    else
        counter <= counter; 
end
    
assign count = counter;

// Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, updown_counter);
    $printtimescale(updown_counter);
  end
endmodule