/*
Copyright (C) 2016  Benoît Morgan

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

`timescale 1ns/10ps

module main();

`include "sim.v"

wire [7:0] leds;

/**
 * Tested component
 */
d8_top d8 (
  .sys_clk(sys_clk),
  .sys_rst(sys_rst),
  .leds(leds)
);

integer i;
initial begin
  for (i = 0; i < 'hff; i = i + 1)
  begin
    $dumpvars(0,d8.memi.mem[i]);
  end
  for (i = 0; i < 'hf; i = i + 1)
  begin
    $dumpvars(0,d8.regs.regs[i]);
  end

  // Reset
  sys_rst <= 1'b1;
  waitnclock(8);
  sys_rst <= 1'b0;
  waitnclock(1);

  #1000;

  $finish();
end

endmodule
