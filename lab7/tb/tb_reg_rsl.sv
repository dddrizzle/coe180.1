`timescale 1ns/1ps
`define CHECK(cond, msg) if (!(cond)) begin errors++; $display("FAIL @%0t: %s", $time, msg); end

module tb_reg_rsl;
  logic clk = 0, rst = 0, set = 0, load = 0;
  logic [3:0] d = 4'h0, q;
  int errors = 0;

  reg_rsl #(.W(4)) dut (.*);

  always #5 clk = ~clk;

  initial begin
    $dumpfile("sim/tb_reg_rsl.vcd");
    $dumpvars(0, tb_reg_rsl);

    rst = 1; @(posedge clk); #1 `CHECK(q === 4'h0, "reset clears")
    rst = 0; set = 1; load = 1; d = 4'h5; @(posedge clk); #1 `CHECK(q === 4'hF, "set beats load")
    set = 0; @(posedge clk); #1 `CHECK(q === 4'h5, "load captures d")
    load = 0; d = 4'hA; @(posedge clk); #1 `CHECK(q === 4'h5, "register holds when load = 0")
    rst = 1; set = 1; @(posedge clk); #1 `CHECK(q === 4'h0, "reset beats set")
    rst = 0; set = 0; d = 4'h3; #2 `CHECK(q === 4'h0, "no change between clock edges")

    if (errors == 0)
      $display("PASS: reg_rsl (all 6 checks pass)");
    else
      $display("FAIL: %0d error(s)", errors);

    $finish;
  end
endmodule
