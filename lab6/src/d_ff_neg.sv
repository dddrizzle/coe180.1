// TODO (Task 1): falling-edge-triggered D flip-flop.
module d_ff_neg (input logic clk, d, output logic q);
  always_ff @(negedge clk) q <= d; // posedge -> negedge 
endmodule
