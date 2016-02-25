module d8_op_to_rw_registres (
  input [7:0] op,
  output w
);

assign w =
    (8'h05 == op || 8'h06 == op || 8'h01 == op || 8'h02 == op ||
        8'h03 == op || 8'h04 == op || 8'h07 == op) ? 1'b1 : 1'b0;

endmodule
