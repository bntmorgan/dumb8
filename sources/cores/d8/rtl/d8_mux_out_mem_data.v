module d8_mux_out_mem_data (
  input [7:0] dout,
  input [7:0] b_in,
  input [7:0] op,
  output [7:0] b_out
);

assign b_out = (op == 8'h07) ? dout : b_in;

endmodule
