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
