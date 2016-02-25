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

module d8_registers (
  input sys_clk,
  input sys_rst,
  input [3:0] addr_a,
  input [3:0] addr_b,
  input [3:0] addr_w,
  input w,
  input [7:0] data,
  output [7:0] qa,
  output [7:0] qb
);

reg [7:0] regs [15:0];

task init;
integer i;
begin
  for (i = 0; i < 16; i = i + 1) begin
    regs[i] <= 8'b0;
  end
end
endtask

initial begin
  init;
end

assign qa =
    (sys_rst == 1'b1) ? 8'b0 :
    (w == 1'b1 && addr_a == addr_w) ? data :
    regs[addr_a];

assign qb =
    (sys_rst == 1'b1) ? 8'b0 :
    (w == 1'b1 && addr_b == addr_w) ? data :
    regs[addr_b];

always @(posedge sys_clk) begin
  if (sys_rst == 1'b1) begin
    init;
  end else begin
    if (w == 1'b1) begin
      regs[addr_w] <= data;
    end
  end
end

endmodule
