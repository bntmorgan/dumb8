module d8_decode (
  input [31:0] instr,
  output [7:0] op_out,
  output [7:0] a_out,
  output [7:0] b_out,
  output [7:0] c_out
);

assign op_out = instr[31:24];
assign a_out = instr[23:16];
assign b_out = instr[15:8];
assign c_out = instr[7:0];

endmodule
