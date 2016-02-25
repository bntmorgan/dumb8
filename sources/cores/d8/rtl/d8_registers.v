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
