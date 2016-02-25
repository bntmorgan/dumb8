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

module d8_aleas_handler (
  input sys_clk,
  input [7:0] di_ex_op,
  input [7:0] di_ex_a,
  input [7:0] ex_mem_op,
  input [7:0] ex_mem_a,
  input [7:0] li_di_op,
  input [7:0] li_di_a,
  input [7:0] li_di_b,
  input [7:0] li_di_c,
  output [7:0] li_di_op_out,
  output en
);

wire len;

assign len =
    (
      (
        (
          (
            (
              (ex_mem_a == li_di_b) |
              (ex_mem_a == li_di_c)
            ) &
            (
              li_di_op == 8'h01 |
              li_di_op == 8'h02 |
              li_di_op == 8'h03 |
              li_di_op == 8'h04
            )
          ) |
          (
            ex_mem_a == li_di_b &
            (
              li_di_op == 8'h05 |
              li_di_op == 8'h08 |
              li_di_op == 8'h0A |
              li_di_op == 8'h09
            )
          )
        ) &
        (
          ex_mem_op == 8'h01 |
          ex_mem_op == 8'h02 |
          ex_mem_op == 8'h03 |
          ex_mem_op == 8'h04 |
          ex_mem_op == 8'h05 |
          ex_mem_op == 8'h06 |
          ex_mem_op == 8'h07
        )
      ) |
      (
        (
          (
            (
              (di_ex_a == li_di_b) | (di_ex_a == li_di_c)
            ) &
            (
              li_di_op == 8'h01 |
              li_di_op == 8'h02 |
              li_di_op == 8'h03 |
              li_di_op == 8'h04
            )
          ) |
          (
            di_ex_a == li_di_b &
            (
              li_di_op == 8'h05 |
              li_di_op == 8'h08 |
              li_di_op == 8'h0A |
              li_di_op == 8'h09
            )
          )
        ) &
        (
          di_ex_op == 8'h01 |
          di_ex_op == 8'h02 |
          di_ex_op == 8'h03 |
          di_ex_op == 8'h04 |
          di_ex_op == 8'h05 |
          di_ex_op == 8'h06 |
          di_ex_op == 8'h07
        )
      )
    ) ? 1'b0 : 1'b1;

assign en = len;
assign li_di_op_out = (len == 1'b0) ? 8'b0 : li_di_op;

endmodule
