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
