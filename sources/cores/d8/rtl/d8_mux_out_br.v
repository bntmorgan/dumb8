module d8_mux_out_br (
  input [7:0] op,
  input [7:0] b_in,
  input [7:0] qa,
  output [7:0] mux_out
);

assign mux_out = (op == 8'h06 || op == 8'h07) ? b_in : qa;

endmodule
