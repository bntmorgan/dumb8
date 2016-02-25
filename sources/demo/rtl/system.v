module system (
  // System
  input sys_clk,
  input sys_rst,
  // VGA
  output [2:0] vga_red,
  output [2:0] vga_grn,
  output [1:0] vga_blu,
  output vga_hsync,
  output vga_vsync,
  // LEDS
  output [7:0] leds
);

d8_top (
  sys_clk,
  sys_rst,
  leds
);

endmodule
