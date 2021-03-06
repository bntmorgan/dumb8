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

module d8_mux_out_br (
  input [7:0] op,
  input [7:0] b_in,
  input [7:0] qa,
  output [7:0] mux_out
);

assign mux_out = (op == 8'h06 || op == 8'h07) ? b_in : qa;

endmodule
