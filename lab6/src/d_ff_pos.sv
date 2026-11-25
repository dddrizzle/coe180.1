module d_ff_pos (input logic clk, d, output logic q);
  always_ff @(posedge clk) q <= d;   // non-blocking assignment in clocked blocks
endmodule
