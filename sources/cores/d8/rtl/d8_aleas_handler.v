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

`include "d8.vh"

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
              li_di_op == OP_ADD |
              li_di_op == OP_SOU |
              li_di_op == OP_SHL |
              li_di_op == OP_SHR |
              li_di_op == OP_VWR
            )
          ) |
          (
            ex_mem_a == li_di_b &
            (
              li_di_op == OP_COP |
              li_di_op == OP_STR |
              li_di_op == OP_JMZ |
              li_di_op == OP_JMP
            )
          )
        ) &
        (
          ex_mem_op == OP_ADD |
          ex_mem_op == OP_SOU |
          ex_mem_op == OP_SHL |
          ex_mem_op == OP_SHR |
          ex_mem_op == OP_COP |
          ex_mem_op == OP_AFC |
          ex_mem_op == OP_LOD
        )
      ) |
      (
        (
          (
            (
              (di_ex_a == li_di_b) |
              (di_ex_a == li_di_c)
            ) &
            (
              li_di_op == OP_ADD |
              li_di_op == OP_SOU |
              li_di_op == OP_SHL |
              li_di_op == OP_SHR |
              li_di_op == OP_VWR
            )
          ) |
          (
            di_ex_a == li_di_b &
            (
              li_di_op == OP_COP |
              li_di_op == OP_STR |
              li_di_op == OP_JMZ |
              li_di_op == OP_JMP
            )
          )
        ) &
        (
          di_ex_op == OP_ADD |
          di_ex_op == OP_SOU |
          di_ex_op == OP_SHL |
          di_ex_op == OP_SHR |
          di_ex_op == OP_COP |
          di_ex_op == OP_AFC |
          di_ex_op == OP_LOD
        )
      )
    ) ? 1'b0 : 1'b1;

assign en = len;
assign li_di_op_out = (len == 1'b0) ? 8'b0 : li_di_op;

endmodule
