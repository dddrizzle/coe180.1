`timescale 1ns/1ps
module tb_sr_latch;
  logic s = 0, r = 0; wire q, qb; int errors = 0;
  sr_latch_nor dut (.*);
  initial begin
    $dumpfile("sim/tb_sr_latch.vcd"); $dumpvars(0, tb_sr_latch);
    r = 1; #5;                          // reset first: the power-up state is unknown (X)
    if (q !== 1'b0 || qb !== 1'b1) begin errors++; $display("FAIL reset: q=%b qb=%b", q, qb); end
    r = 0; #5;
    if (q !== 1'b0 || qb !== 1'b1) begin errors++; $display("FAIL hold 0: q=%b qb=%b", q, qb); end
    s = 1; #5;
    if (q !== 1'b1 || qb !== 1'b0) begin errors++; $display("FAIL set: q=%b qb=%b", q, qb); end
    s = 0; #5;
    if (q !== 1'b1 || qb !== 1'b0) begin errors++; $display("FAIL hold 1: q=%b qb=%b", q, qb); end
    s = 1; r = 1; #5;                   // FORBIDDEN input: both outputs are forced to 0
    if (q !== 1'b0 || qb !== 1'b0) begin errors++; $display("FAIL forbidden: q=%b qb=%b", q, qb); end
    r = 0; #5;                          // release R first, S still high: latch ends up SET
    if (q !== 1'b1 || qb !== 1'b0) begin errors++; $display("FAIL release: q=%b qb=%b", q, qb); end
    if (errors == 0) $display("PASS: sr_latch_nor"); else $display("FAIL: %0d error(s)", errors);
    $finish;
  end
endmodule
