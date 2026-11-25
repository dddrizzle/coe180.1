`timescale 1ns/1ps
`define CHECK(cond, msg) if (!(cond)) begin errors++; $display("FAIL @%0t: %s", $time, msg); end
// Directed, self-checking test of one D latch and four D flip-flops sharing the same D input.
module tb_latch_ff;
  logic clk = 0, d = 0, en = 0, rstn_s = 1, rstn_a = 1;
  logic q_lat, q_pos, q_neg, q_srst, q_arst;
  int errors = 0;
  d_latch   u_l (.en, .d, .q(q_lat));
  d_ff_pos  u_p (.clk, .d, .q(q_pos));
  d_ff_neg  u_n (.clk, .d, .q(q_neg));
  d_ff_srst u_s (.clk, .rst_n(rstn_s), .d, .q(q_srst));
  d_ff_arst u_a (.clk, .rst_n(rstn_a), .d, .q(q_arst));
  initial begin
    $dumpfile("sim/tb_latch_ff.vcd"); $dumpvars(0, tb_latch_ff);
    // ---- A: latch is transparent while en = 1 and holds while en = 0 ----
    en = 1; d = 1; #1 `CHECK(q_lat === 1'b1, "latch follows d=1 while en=1")
    d = 0;         #1 `CHECK(q_lat === 1'b0, "latch follows d=0 while en=1")
    en = 0; d = 1; #1 `CHECK(q_lat === 1'b0, "latch holds 0 while en=0 even though d=1")
    en = 1;        #1 `CHECK(q_lat === 1'b1, "latch becomes transparent again")
    en = 0; d = 0; #1 `CHECK(q_lat === 1'b1, "latch holds 1 while en=0")
    // ---- B: async reset acts at once; then one clock pulse defines every flip-flop ----
    rstn_a = 0; #1 `CHECK(q_arst === 1'b0, "async reset clears q without a clock edge")
    clk = 1; #5 clk = 0; #5;
    rstn_a = 1;
    // ---- C: rising-edge capture ----
    d = 1; #1 `CHECK(q_pos === 1'b0 && q_neg === 1'b0, "no flip-flop changes when only d changes")
    clk = 1; #1
    `CHECK(q_pos  === 1'b1, "posedge FF captures d at the rising edge")
    `CHECK(q_neg  === 1'b0, "negedge FF ignores the rising edge")
    `CHECK(q_srst === 1'b1, "sync-reset FF (reset inactive) captures d")
    `CHECK(q_arst === 1'b1, "async-reset FF (reset inactive) captures d")
    // ---- D: falling-edge capture, and d changes between edges are ignored ----
    #4 clk = 0; #1
    `CHECK(q_neg === 1'b1, "negedge FF captures d at the falling edge")
    `CHECK(q_pos === 1'b1, "posedge FF holds")
    d = 0; #1
    `CHECK(q_pos === 1'b1 && q_neg === 1'b1, "flip-flops ignore d changes between active edges")
    // ---- E: synchronous reset waits for the clock edge ----
    d = 1; rstn_s = 0; #1
    `CHECK(q_srst === 1'b1, "sync reset must NOT act before the clock edge")
    clk = 1; #1
    `CHECK(q_srst === 1'b0, "sync reset clears q at the clock edge")
    clk = 0; #1;
    // ---- F: asynchronous reset does not wait ----
    rstn_a = 0; #1 `CHECK(q_arst === 1'b0, "async reset clears q immediately")
    rstn_a = 1;
    if (errors == 0) $display("PASS: latch and flip-flops"); else $display("FAIL: %0d error(s)", errors);
    $finish;
  end
endmodule
