// Task 1: W-bit register with synchronous reset, set and load.
// Priority (highest first): rst -> q = 0;  set -> q = all ones;  load -> q = d;  otherwise hold.
module reg_rsl #(parameter int W = 4) (
  input  logic         clk,
  input  logic         rst,
  input  logic         set,
  input  logic         load,
  input  logic [W-1:0] d,
  output logic [W-1:0] q
);

  always_ff @(posedge clk) begin
    if (rst)
      q <= '0;
    else if (set)
      q <= '1;
    else if (load)
      q <= d;
    // Implicit else: hold current value of q
  end

endmodule
