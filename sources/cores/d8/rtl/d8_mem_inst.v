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

module d8_mem_inst (
  input sys_clk,
  input sys_rst,
  input en,
  input [7:0] adr,
  output reg [31:0] dout
);

`include "d8.vh"

reg [7:0] mem [255:0];

task init;
  integer i;
begin
  for (i = 0; i < 256; i = i + 1) begin
    mem[i] <= 8'b0;
  end
  // instructions here

  // 0x0
  mem[8'h03] <= OP_AFC;
  mem[8'h02] <= 8'h00;
  mem[8'h01] <= 8'h00;
  mem[8'h00] <= 8'h00;

  // 0x4
  mem[8'h07] <= OP_AFC;
  mem[8'h06] <= 8'h01;
  mem[8'h05] <= 8'h10;
  mem[8'h04] <= 8'h00;

  // 0x8
  mem[8'h0b] <= OP_AFC;
  mem[8'h0a] <= 8'h02;
  mem[8'h09] <= 8'h01;
  mem[8'h08] <= 8'h00;

  // 0xc
  mem[8'h0f] <= OP_ADD;
  mem[8'h0e] <= 8'h00;
  mem[8'h0d] <= 8'h00;
  mem[8'h0c] <= 8'h02;

  // 0x10
  mem[8'h13] <= OP_SOU;
  mem[8'h12] <= 8'h03;
  mem[8'h11] <= 8'h01;
  mem[8'h10] <= 8'h00;

  // 0x14
  mem[8'h17] <= OP_JMZ;
  mem[8'h16] <= 8'h1c;
  mem[8'h15] <= 8'h03;
  mem[8'h14] <= 8'h00;

  // 0x18
  mem[8'h1b] <= OP_JMP;
  mem[8'h1a] <= 8'h0C;
  mem[8'h19] <= 8'h00;
  mem[8'h18] <= 8'h00;

  // 0x1c
  mem[8'h1f] <= OP_VWR;
  mem[8'h1e] <= 8'hff;
  mem[8'h1d] <= 8'h01;
  mem[8'h1c] <= 8'h01;

  // 0x1c
  mem[8'h23] <= OP_JMP;
  mem[8'h22] <= 8'h1C;
  mem[8'h21] <= 8'h00;
  mem[8'h20] <= 8'h00;

  dout <= 32'b0;
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
      dout <= {
        mem[adr + 8'h03],
        mem[adr + 8'h02],
        mem[adr + 8'h01],
        mem[adr + 8'h00]};
    end
  end
end

endmodule
