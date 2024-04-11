module fifo #(
  parameter FIFO_WIDTH = 8,
  parameter FIFO_DEPTH = 32
  )
  (
  input                      clk,
  input                      rst,
  input                      wr_en,
  input                      rd_en,
  input   [FIFO_WIDTH-1:0] din,
  output reg [FIFO_WIDTH-1:0] dout,
  // output                     almost_full,
  // output                     almost_empty,
  output                     full,
  output                    empty,
  output  reg                   valid,
  // output                     wr_ack,
  // output                     overflow,
  // output                     underflow,
  output  [log2(FIFO_DEPTH)-1:0] data_count
  );
  
  // Function to calculate the logarithm base 2
  function automatic integer log2;
    input integer value;
    begin
      log2 = 0;
      while(value > 1) begin
        value = value >> 1;
        log2 = log2 + 1;
      end
    end
  endfunction

  reg [log2(FIFO_DEPTH):0] counter;
  reg [FIFO_WIDTH-1:0] memory [FIFO_DEPTH-1:0];
  reg [log2(FIFO_DEPTH)-1:0] read_ptr, write_ptr;
  
  always@(posedge clk)begin
    
    if(rst)begin 
      read_ptr    <= 0;
      write_ptr   <= 0;
      counter     <= 0;
      valid       <= 0;
    end

    else begin

      if(wr_en && !rd_en)
        counter <= counter + 1;
      else if(!wr_en && rd_en)
        counter <= counter - 1;
      else
        counter <= counter;

      if(wr_en && !full)
      begin
        write_ptr <= write_ptr + 1;
        memory[write_ptr] <= din;
      end


      if(rd_en && !empty)
      begin
        read_ptr <= read_ptr + 1;
        dout <= memory[read_ptr];
        valid <= 1;
      end
      else
        valid <= 0;

    end
  end

  
  assign data_count = counter;
  assign empty = (counter == 0);
  assign full  = (counter == FIFO_DEPTH);

  // Dump waves
  integer idx;
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, fifo);
    for (idx = 0; idx < FIFO_DEPTH; idx = idx + 1) $dumpvars(1, memory[idx]);
  end

endmodule