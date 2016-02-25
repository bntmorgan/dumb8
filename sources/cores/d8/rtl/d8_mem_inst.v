module d8_mem_inst (
  input sys_clk,
  input sys_rst,
  input en,
  input [7:0] adr,
  output reg [31:0] dout
);

reg [7:0] mem [255:0];

task init;
  integer i;
begin
  for (i = 0; i < 256; i = i + 1) begin
    mem[i] <= 8'b0;
  end
  // instructions here
  mem[8'h03] <= 8'h06;
  mem[8'h02] <= 8'h00;
  mem[8'h01] <= 8'h00;
  mem[8'h00] <= 8'h00;

  mem[8'h07] <= 8'h06;
  mem[8'h06] <= 8'h01;
  mem[8'h05] <= 8'h10;
  mem[8'h04] <= 8'h00;

  mem[8'h0b] <= 8'h06;
  mem[8'h0a] <= 8'h02;
  mem[8'h09] <= 8'h01;
  mem[8'h08] <= 8'h00;

  mem[8'h0f] <= 8'h01;
  mem[8'h0e] <= 8'h00;
  mem[8'h0d] <= 8'h00;
  mem[8'h0c] <= 8'h02;

  mem[8'h13] <= 8'h02;
  mem[8'h12] <= 8'h03;
  mem[8'h11] <= 8'h01;
  mem[8'h10] <= 8'h00;

  mem[8'h17] <= 8'h0A;
  mem[8'h16] <= 8'h1C;
  mem[8'h15] <= 8'h03;
  mem[8'h14] <= 8'h00;

  mem[8'h1b] <= 8'h09;
  mem[8'h1a] <= 8'h0C;
  mem[8'h19] <= 8'h00;
  mem[8'h18] <= 8'h00;

  mem[8'h1f] <= 8'h09;
  mem[8'h1e] <= 8'h1C;
  mem[8'h1d] <= 8'h00;
  mem[8'h1c] <= 8'h00;

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
