// TODO (Task 2): rising-edge D flip-flop with ASYNCHRONOUS active-low reset (rst_n = 0 clears q immediately).
module d_ff_arst (input logic clk, rst_n, d, output logic q); // note the added event
    always_ff @(posedge clk or negedge rst_n)
        if (!rst_n) q <= 1'b0;
        else        q <= d;
endmodule
