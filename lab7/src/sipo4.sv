// Task 2: 4-bit serial-in, parallel-out shift register.
// On each enabled clock edge q <= {q[2:0], sin}.
// Asynchronous active-low reset clears q.
module sipo4 (
  input  logic       clk,
  input  logic       rst_n,
  input  logic       en,
  input  logic       sin,
  output logic [3:0] q
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      q <= 4'b0000;
    else if (en)
      q <= {q[2:0], sin};
  end

endmodule
