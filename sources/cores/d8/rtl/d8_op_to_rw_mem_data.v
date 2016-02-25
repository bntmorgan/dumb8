module d8_op_to_rw_mem_data (
  input [7:0] op,
  output w
);

assign w = (op == 8'h08) ? 1'b1 : 1'b0;

endmodule
