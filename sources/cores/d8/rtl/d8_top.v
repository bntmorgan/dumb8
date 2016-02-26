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

module d8_top (
  input sys_clk,
  input sys_rst,
  // leds
  output [7:0] leds,
  // Text memory
  output [7:0] mem_dw,
  output [11:0] mem_a,
  output mem_we,
  input [7:0] mem_dr
);

  // Connection wires

  // Pipeline I/O
  wire [7:0] li_di_op_in;
  wire [7:0] li_di_op_out;
  wire [7:0] li_di_a_in;
  wire [7:0] li_di_a_out;
  wire [7:0] li_di_b_in;
  wire [7:0] li_di_b_out;
  wire [7:0] li_di_c_in;
  wire [7:0] li_di_c_out;

  wire [7:0] di_ex_op_in;
  wire [7:0] di_ex_op_out;
  wire [7:0] di_ex_a_in;
  wire [7:0] di_ex_a_out;
  wire [7:0] di_ex_b_in;
  wire [7:0] di_ex_b_out;
  wire [7:0] di_ex_c_in;
  wire [7:0] di_ex_c_out;

  wire [7:0] ex_mem_op_in;
  wire [7:0] ex_mem_op_out;
  wire [7:0] ex_mem_a_in;
  wire [7:0] ex_mem_a_out;
  wire [7:0] ex_mem_b_in;
  wire [7:0] ex_mem_b_out;
  wire [7:0] ex_mem_c_in;
  wire [7:0] ex_mem_c_out;

  wire [7:0] mem_re_op_in;
  wire [7:0] mem_re_op_out;
  wire [7:0] mem_re_a_in;
  wire [7:0] mem_re_a_out;
  wire [7:0] mem_re_b_in;
  wire [7:0] mem_re_b_out;
  wire [7:0] mem_re_c_in;
  wire [7:0] mem_re_c_out;

  // ALU I/O
  wire [7:0] alu_s;
  wire alu_n;
  wire alu_o;
  wire alu_z;
  wire alu_c;
  wire [2:0] alu_ctrl_alu;
  wire [7:0] alu_a;
  wire [7:0] alu_b;

  // Data mem I/O
  wire [7:0] md_adr;
  wire [7:0] md_din;
  wire md_w;
  wire [7:0] md_dout;

  // Aleas handler I/O
  wire [7:0] ah_di_ex_op;
  wire [7:0] ah_di_ex_a;
  wire [7:0] ah_ex_mem_op;
  wire [7:0] ah_ex_mem_a;
  wire [7:0] ah_li_di_op;
  wire [7:0] ah_li_di_a;
  wire [7:0] ah_li_di_b;
  wire [7:0] ah_li_di_c;
  wire ah_en;
  wire [7:0] ah_li_di_op_out;

  // JMP handler I/O
  wire jh_sys_rst;
  wire [7:0] jh_adr;
  wire jh_load;

  // LC out after the last pipeline
  wire w;

  // Ip
  wire sens = 1'b1;
  wire load = 1'b0;
  wire [7:0] ip;

  // Register bench outputs
  wire [7:0] qa;
  wire [7:0] qb;

  // Register bench out mux
  wire [7:0] msbr_out;

  // Instruction
  wire [31:0] instruction;

  wire [7:0] op;
  wire [7:0] a;
  wire [7:0] b;
  wire [7:0] c;

  wire [7:0] op_out;
  wire [7:0] a_out;
  wire [7:0] b_out;
  wire [7:0] c_out;

  wire rst_li_di;

  assign rst_li_di = sys_rst | jh_sys_rst;

  // Modules instanciation

  d8_pipeline p_li_di (
    .op(li_di_op_in),
    .a(li_di_a_in),
    .b(li_di_b_in),
    .c(li_di_c_in),
    .op_out(li_di_op_out),
    .a_out(li_di_a_out),
    .b_out(li_di_b_out),
    .c_out(li_di_c_out),
    .sys_clk(sys_clk),
    .en(ah_en),
    .sys_rst(rst_li_di)
  );

  d8_pipeline p_di_ex (
    .op(di_ex_op_in),
    .a(di_ex_a_in),
    .b(di_ex_b_in),
    .c(di_ex_c_in),
    .op_out(di_ex_op_out),
    .a_out(di_ex_a_out),
    .b_out(di_ex_b_out),
    .c_out(di_ex_c_out),
    .sys_clk(sys_clk),
    .en(1'b1),
    .sys_rst(sys_rst)
  );

  d8_pipeline p_ex_mem (
    .op(ex_mem_op_in),
    .a(ex_mem_a_in),
    .b(ex_mem_b_in),
    .c(ex_mem_c_in),
    .op_out(ex_mem_op_out),
    .a_out(ex_mem_a_out),
    .b_out(ex_mem_b_out),
    .c_out(ex_mem_c_out),
    .sys_clk(sys_clk),
    .en(1'b1),
    .sys_rst(sys_rst)
  );

  d8_pipeline p_mem_re (
    .op(mem_re_op_in),
    .a(mem_re_a_in),
    .b(mem_re_b_in),
    .c(mem_re_c_in),
    .op_out(mem_re_op_out),
    .a_out(mem_re_a_out),
    .b_out(mem_re_b_out),
    .c_out(mem_re_c_out),
    .sys_clk(sys_clk),
    .en(1'b1),
    .sys_rst(sys_rst)
  );

  d8_op_to_rw_registres rw_r (
    .op(op_out),
    .w(w)
  );

  d8_op_to_ctrl_alu otca (
    .op(di_ex_op_out),
    .ctrl_alu(alu_ctrl_alu)
  );

  d8_alu alu (
    .s(alu_s),
    .n(alu_n),
    .o(alu_o),
    .z(alu_z),
    .c(alu_c),
    .ctrl_alu(alu_ctrl_alu),
    .a(alu_a),
    .b(alu_b)
  );

  d8_mux_out_alu moa (
    .op(di_ex_op_out),
    .b_in(di_ex_b_out),
    .s(alu_s),
    .mux_out(ex_mem_b_in)
  );

  d8_mem_data md (
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .addr(md_adr),
    .din(md_din),
    .w(md_w),
    .dout(md_dout)
  );

  d8_op_to_rw_mem_data otrmd (
    .op(ex_mem_op_out),
    .w(md_w)
  );

  d8_op_to_rw_mem_text otrmt (
    .op(ex_mem_op_out),
    .w(mem_we)
  );

  d8_mux_out_mem_data momd (
    .dout(md_dout),
    .b_in(ex_mem_b_out),
    .op(ex_mem_op_out),
    .b_out(mem_re_b_in)
  );

  d8_mux_in_mem_data mimd (
    .a(ex_mem_a_out),
    .op(ex_mem_op_out),
    .b(ex_mem_b_out),
    .adr(md_adr)
  );

  d8_aleas_handler ah (
    .sys_clk(sys_clk),
    .di_ex_op(ah_di_ex_op),
    .di_ex_a(ah_di_ex_a),
    .ex_mem_op(ah_ex_mem_op),
    .ex_mem_a(ah_ex_mem_a),
    .li_di_op(ah_li_di_op),
    .li_di_a(ah_li_di_a),
    .li_di_b(ah_li_di_b),
    .li_di_c(ah_li_di_c),
    .li_di_op_out(ah_li_di_op_out),
    .en(ah_en)
  );

  assign li_di_op_in = op;
  assign li_di_a_in = a;
  assign li_di_b_in = b;
  assign li_di_c_in = c;

  assign di_ex_op_in = ah_li_di_op_out;
  assign di_ex_a_in = li_di_a_out;
  assign di_ex_b_in = msbr_out;
  assign di_ex_c_in = qb;
  assign alu_a = di_ex_b_out;
  assign alu_b = di_ex_c_out;

  assign ex_mem_op_in = di_ex_op_out;
  assign ex_mem_a_in = di_ex_a_out;

  assign mem_re_op_in = ex_mem_op_out;
  assign mem_re_a_in = ex_mem_a_out;

  assign md_din = ex_mem_b_out;

  assign op_out = mem_re_op_out;
  assign a_out = mem_re_a_out;
  assign b_out = mem_re_b_out;
  assign c_out = mem_re_c_out;

  assign ah_di_ex_op = di_ex_op_out;
  assign ah_di_ex_a = di_ex_a_out;
  assign ah_ex_mem_op = ex_mem_op_out;
  assign ah_ex_mem_a = ex_mem_a_out;
  assign ah_li_di_op = li_di_op_out;
  assign ah_li_di_a = li_di_a_out;
  assign ah_li_di_b = li_di_b_out;
  assign ah_li_di_c = li_di_c_out;

  assign mem_dw = ex_mem_c_out;
  assign mem_a = {ex_mem_b_out[3:0], ex_mem_a_out[7:0]}; // 12 bits
  assign ex_mem_c_in = di_ex_c_out;

  d8_cpt8 cpt_ip (
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .dir(1'b1),
    .load(jh_load),
    .en(ah_en),
    .din(jh_adr),
    .dout(ip)
  );

  d8_mem_inst memi (
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .en(1'b1),
    .adr(ip),
    .dout(instruction)
  );

  d8_decode decode (
    .instr(instruction),
    .op_out(op),
    .a_out(a),
    .b_out(b),
    .c_out(c)
  );

  d8_registers regs (
    .sys_clk(sys_clk),
    .sys_rst(sys_rst),
    .addr_a(li_di_b_out[3:0]),
    .addr_b(li_di_c_out[3:0]),
    .addr_w(a_out[3:0]),
    .w(w),
    .data(b_out),
    .qa(qa),
    .qb(qb)
  );

  d8_mux_out_br msbr (
    .op(li_di_op_out),
    .b_in(li_di_b_out),
    .qa(qa),
    .mux_out(msbr_out)
  );

  d8_jmp_handler jh (
    .sys_rst(sys_rst),
    .op(di_ex_op_out),
    .a(di_ex_a_out),
    .z(alu_z),
    .li_di_rst(jh_sys_rst),
    .mem_addr(jh_adr),
    .load(jh_load)
  );

  assign leds = ip;

endmodule
