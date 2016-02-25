module d8_jmp_handler (
  input sys_rst,
  input [7:0] op,
  input [7:0] a,
  input z,
  output li_di_rst,
  output [7:0] mem_addr,
  output load
);

assign li_di_rst =
  (sys_rst == 1'b1) ? 1'b1 :
  ((op == 8'h0a && z == 1'b1) || op == 8'h09) ? 1'b1 :
  1'b0;
assign mem_addr =
  (sys_rst == 1'b1) ? 8'b0 :
  ((op == 8'h0a && z == 1'b1) || op == 8'h09) ? a :
  8'b0;
assign load =
  (sys_rst == 1'b1) ? 8'b0 :
  ((op == 8'h0a && z == 1'b1) || op == 8'h09) ? 1'b1 :
  1'b0;

endmodule
