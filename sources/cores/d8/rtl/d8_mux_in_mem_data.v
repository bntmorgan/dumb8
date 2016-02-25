module d8_mux_in_mem_data (
  input [7:0] a,
  input [7:0] op,
  input [7:0] b,
  output [7:0] adr
);

assign adr = (op == 8'h08) ? a : b;

endmodule
