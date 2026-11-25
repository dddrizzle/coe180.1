// Part 2: 4-bit Universal Shift Register
// Modes:
// 2'b00: Hold
// 2'b01: Shift Left (sin_left enters q[0], bits shift left)
// 2'b10: Shift Right (sin_right enters q[3], bits shift right)
// 2'b11: Parallel Load (d[3:0] loaded into q[3:0])
// Asynchronous active-low reset (rst_n) clears q immediately
module univ_shift4 (
  input  logic       clk,       // Rising-edge clock
  input  logic       rst_n,     // Asynchronous active-low reset (highest priority)
  input  logic [1:0] mode,      // 00: Hold, 01: Shift Left, 10: Shift Right, 11: Parallel Load
  input  logic       sin_left,  // Serial bit shifted into q[0] during Shift Left (mode 01)
  input  logic       sin_right, // Serial bit shifted into q[3] during Shift Right (mode 10)
  input  logic [3:0] d,         // Parallel data input for Parallel Load (mode 11)
  output logic [3:0] q          // 4-bit registered parallel output
);

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      q <= '0;
    end else begin
      case (mode)
        2'b00: q <= q;                        // Hold
        2'b01: q <= {q[2:0], sin_left};       // Shift Left: sin_left enters q[0]
        2'b10: q <= {sin_right, q[3:1]};      // Shift Right: sin_right enters q[3]
        2'b11: q <= d;                        // Parallel Load
        default: q <= q;                      // Safe fallback
      endcase
    end
  end

endmodule
