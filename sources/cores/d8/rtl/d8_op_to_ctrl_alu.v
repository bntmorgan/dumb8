module d8_op_to_ctrl_alu (
  input [7:0] op,
  output [2:0] ctrl_alu
);

assign ctrl_alu =
    (op == 8'h01) ? 3'b001 :
    (op == 8'h02) ? 3'b010 :
    (op == 8'h03) ? 3'b011 :
    (op == 8'h04) ? 3'b100 :
    3'b000;

endmodule
