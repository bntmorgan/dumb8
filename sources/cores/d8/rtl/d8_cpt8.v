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

module d8_cpt8 (
  input sys_clk,
  input sys_rst,
  input dir,
  input load,
  input en,
  input [7:0] din,
  output [7:0] dout
);

reg [7:0] cpt;

task init;
begin
  cpt <= 8'b0;
end
endtask

initial begin
  init;
end

assign dout = cpt;

always @(posedge sys_clk) begin
  if (sys_rst == 1'b1) begin
    init;
  end else begin
    if (load == 1'b1) begin
      cpt <= din;
    end else begin
      if (dir == 1'b1) begin
        cpt <= cpt + 8'h04;
      end else begin
        cpt <= cpt - 8'h04;
      end
    end
  end
end

endmodule
