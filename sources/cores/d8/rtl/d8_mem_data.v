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

module d8_mem_data (
  input sys_rst,
  input sys_clk,
  input [7:0] addr,
  input [7:0] din,
  input w,
  output [7:0] dout
);

reg [7:0] mem [255:0];

task init;
  integer i;
begin
  for (i = 0; i < 256; i = i + 1) begin
    mem[i] <= 8'b0;
  end
end
endtask

initial begin
  init;
end

assign dout =
    (sys_rst == 1'b1) ? 8'b0 :
    (w == 1'b1) ? din :
    mem[addr];

always @(posedge sys_clk) begin
  if (sys_rst == 1'b1) begin
    init;
  end else begin
    if (w == 1'b1) begin
      mem[addr] <= din;
    end
  end
end

endmodule
