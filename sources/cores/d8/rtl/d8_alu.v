/*
Copyright (C) 2012 Carla Sauvanaud
Copyright (C) 2012, 2016  Benoît Morgan

This file is part of dumb8.

dumb8 is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

dumb8 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with dumb8.  If not, see <http://www.gnu.org/licenses/>.
*/

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
