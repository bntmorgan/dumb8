module d8_pipeline (
  input [7:0] op,
  input [7:0] a,
  input [7:0] b,
  input [7:0] c,
  output reg[7:0] op_out,
  output reg [7: 0] a_out,
  output reg [7:0] b_out,
  output reg [7:0] c_out,
  input sys_clk,
  input en,
  input sys_rst
);

task init;
begin
  op_out <= 8'b0;
  a_out <= 8'b0;
  b_out <= 8'b0;
  c_out <= 8'b0;
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
      op_out <= op;
      a_out <= a;
      b_out <= b;
      c_out <= c;
    end
  end
end

endmodule
