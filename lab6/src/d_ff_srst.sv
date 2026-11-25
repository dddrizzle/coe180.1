// TODO (Task 2): rising-edge D flip-flop with SYNCHRONOUS active-low reset (rst_n = 0 clears q at the next clock edge).
module d_ff_srst (input logic clk, rst_n, d, output logic q); // sensitivity list: posedge only
  always_ff @(posedge clk)
    if (!rst_n) q <= 1'b0;                                      // reset clears to 0
    else        q <= d;                                         // otherwise capture d
endmodule
