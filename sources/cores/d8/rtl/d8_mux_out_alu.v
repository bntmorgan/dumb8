module d8_mux_out_alu (
  input [7:0] op,
  input [7:0] b_in,
  input [7:0] s,
  output [7:0] mux_out
);

assign mux_out =
    (op == 8'h01 || op == 8'h02 || op == 8'h03 || op == 8'h04) ? s : b_in;

endmodule
