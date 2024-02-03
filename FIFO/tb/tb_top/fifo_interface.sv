interface fifo_if;
  
  logic clock, rd, wr;
  logic full, empty;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic rst;

endinterface


