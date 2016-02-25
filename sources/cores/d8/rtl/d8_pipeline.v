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

module d8_pipeline (
  input [7:0] op,
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  output reg[7:0] op_out,
  output reg [7: 0] a_out,
  output reg [7:0] b_out,
  output reg [7:0] c_out,
  input sys_clk,
  input en,
  input sys_rst
);

task init;
begin
  op_out <= 8'b0;
  a_out <= 8'b0;
  b_out <= 8'b0;
  c_out <= 8'b0;
end
endtask

initial begin
  init;
end

always @(posedge sys_clk) begin
  if (sys_rst == 1'b1) begin
    init;
  end else begin
    if (en == 1'b1) begin
      op_out <= op;
      a_out <= a;
      b_out <= b;
      c_out <= c;
    end
  end
end

endmodule
