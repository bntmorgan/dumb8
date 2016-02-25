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
