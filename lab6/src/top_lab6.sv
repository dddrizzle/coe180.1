// DE1-SoC top level for Lab 6.  Compare a latch with flip-flops on the board.
// SW0 = D, SW1 = latch enable.  KEY1 is the clock (pressing it makes ~KEY1 rise).  KEY0 = async reset (active-low).
// LEDR0 = latch, LEDR1 = rising-edge FF (changes when you PRESS), LEDR2 = falling-edge FF (changes when you RELEASE),
// LEDR3 = FF with async reset, LEDR9 = clock.
module top_lab6 (input logic [9:0] SW, input logic [3:0] KEY, output logic [9:0] LEDR);
  logic clk;  assign clk = ~KEY[1];
  logic q_lat, q_pos, q_neg, q_arst;
  d_latch  u1 (.en(SW[1]), .d(SW[0]), .q(q_lat));
  d_ff_pos u2 (.clk, .d(SW[0]), .q(q_pos));
  d_ff_neg u3 (.clk, .d(SW[0]), .q(q_neg));
  d_ff_arst u4 (.clk, .rst_n(KEY[0]), .d(SW[0]), .q(q_arst));
  assign LEDR = {clk, 5'b00000, q_arst, q_neg, q_pos, q_lat};
endmodule
