module d8_alu (
  output [7:0] s,
  output n,
  output o,
  output z,
  output c,
  input [2:0] ctrl_alu,
  input [7:0] a,
  input [7:0] b
);

wire [15:0] out =
    (ctrl_alu == 3'b001) ? a + b :
    (ctrl_alu == 3'b010) ? a - b :
    (ctrl_alu == 3'b011) ? a << b :
    (ctrl_alu == 3'b100) ? a >> b :
    16'b0;

assign s = out[7:0];
assign c = out[8];
assign n = out[7];
assign z = (out[7:0] == 8'b0) ? 1'b1 : 1'b0;
assign o =
    (ctrl_alu == 3'b001) ? a[7] & b[7] & ~out[7] | ~a[7] & ~b[7] & out[7] :
    (ctrl_alu == 3'b010) ? ~a[7] & b[7] & out[7] | a[7] & ~b[7] & ~out[7] :
    (ctrl_alu == 3'b011) ? out[15] | out[14] | out[13] | out[12] | out[11]
        | out[10] | out[9] | out[8] * b :
    (ctrl_alu == 3'b100) ? 1'b0 :
    1'b0;

endmodule
