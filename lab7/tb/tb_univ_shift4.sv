`timescale 1ns/1ps
`define CHECK(cond, msg) if (!(cond)) begin errors++; $display("FAIL @%0t: %s (q=%b)", $time, msg, q); end

module tb_univ_shift4;
  logic clk = 0;
  logic rst_n = 1;
  logic [1:0] mode = 2'b00;
  logic sin_left = 0;
  logic sin_right = 0;
  logic [3:0] d = 4'b0000;
  logic [3:0] q;
  int errors = 0;

  univ_shift4 dut (
    .clk(clk),
    .rst_n(rst_n),
    .mode(mode),
    .sin_left(sin_left),
    .sin_right(sin_right),
    .d(d),
    .q(q)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("sim/tb_univ_shift4.vcd");
    $dumpvars(0, tb_univ_shift4);

    // 1. Initial State / Asynchronous Reset Test
    rst_n = 0;
    #3; // Reset asserted asynchronously
    `CHECK(q === 4'b0000, "async reset clears q immediately");
    @(posedge clk); #1;
    `CHECK(q === 4'b0000, "reset holds at clock edge");
    rst_n = 1;

    // 2. Parallel Load Test (PISO load: mode 11, d = 4'b1011)
    mode = 2'b11; d = 4'b1011;
    @(posedge clk); #1;
    `CHECK(q === 4'b1011, "parallel load d=1011");

    // 3. Shift Left Test (PISO serial output on q[3] with sin_left = 0)
    mode = 2'b01; sin_left = 0;
    // Edge 1
    @(posedge clk); #1;
    `CHECK(q === 4'b0110, "shift left 1st edge: q=0110, q[3] output was 1");
    // Edge 2
    @(posedge clk); #1;
    `CHECK(q === 4'b1100, "shift left 2nd edge: q=1100, q[3] output was 0");
    // Edge 3
    @(posedge clk); #1;
    `CHECK(q === 4'b1000, "shift left 3rd edge: q=1000, q[3] output was 1");

    // 4. Hold Test (mode 00: d changes to 1111, q retains 1000)
    mode = 2'b00; d = 4'b1111;
    @(posedge clk); #1;
    `CHECK(q === 4'b1000, "hold mode retains q=1000");
    @(posedge clk); #1;
    `CHECK(q === 4'b1000, "hold mode retains q across 2nd edge");

    // 5. Shift Left with sin_left = 1
    mode = 2'b01; sin_left = 1;
    @(posedge clk); #1;
    `CHECK(q === 4'b0001, "shift left with sin_left=1: q=0001");
    @(posedge clk); #1;
    `CHECK(q === 4'b0011, "shift left with sin_left=1: q=0011");

    // 6. Shift Direction Reversal (Switch from Left to Right: mode 10 with sin_right = 1)
    // Before: q = 0011. Shift right: bit 3 gets sin_right=1, bits 3:1 become bits 2:0 -> q = 1001
    mode = 2'b10; sin_right = 1;
    @(posedge clk); #1;
    `CHECK(q === 4'b1001, "shift right reversal: q becomes 1001");
    // Shift right with sin_right = 0
    sin_right = 0;
    @(posedge clk); #1;
    `CHECK(q === 4'b0100, "shift right with sin_right=0: q becomes 0100");

    // 7. Mid-operation Asynchronous Reset Test
    #3; // Mid-clock-cycle
    rst_n = 0;
    #1;
    `CHECK(q === 4'b0000, "mid-operation async reset immediately clears q");
    @(posedge clk); #1;
    `CHECK(q === 4'b0000, "q stays 0 after clock edge during reset");
    rst_n = 1;

    // Report final status
    if (errors == 0) begin
      $display("PASS: univ_shift4 universal shift register");
    end else begin
      $display("FAIL: %0d error(s) in univ_shift4", errors);
    end
    $finish;
  end
endmodule
