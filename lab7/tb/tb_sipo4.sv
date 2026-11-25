`timescale 1ns/1ps
`define CHECK(cond, msg) if (!(cond)) begin errors++; $display("FAIL @%0t: %s", $time, msg); end

module tb_sipo4;
  logic clk = 0, rst_n = 1, en = 0, sin = 0;
  logic [3:0] q;
  int errors = 0;

  sipo4 dut (.*);

  always #5 clk = ~clk;

  initial begin
    $dumpfile("sim/tb_sipo4.vcd");
    $dumpvars(0, tb_sipo4);

    rst_n = 0; #3 `CHECK(q === 4'h0, "async reset");
    rst_n = 1; en = 1; sin = 1;
    @(posedge clk); #1 `CHECK(q === 4'b0001, "shift 1");
    sin = 0;
    @(posedge clk); #1 `CHECK(q === 4'b0010, "shift 0");
    sin = 1;
    @(posedge clk); #1 `CHECK(q === 4'b0101, "shift 1");
    sin = 1;
    @(posedge clk); #1 `CHECK(q === 4'b1011, "shift 1");
    en = 0; sin = 0;
    @(posedge clk); #1 `CHECK(q === 4'b1011, "hold when disabled");

    if (errors == 0) $display("PASS: sipo4"); else $display("FAIL: %0d error(s)", errors);
    $finish;
  end
endmodule
