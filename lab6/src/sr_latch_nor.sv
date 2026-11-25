`timescale 1ns/1ps
// Gate-level SR latch from two cross-coupled NOR gates (Part A, simulation only).
// The #1 gate delay is what lets the simulator settle the feedback loop; synthesis ignores it.
module sr_latch_nor (input logic s, r, output wire q, qb);
  nor #1 g1 (q,  r, qb);
  nor #1 g2 (qb, s, q);
endmodule
