// 4-bit Configurable Adder-Subtractor - Behavioral Modeling Style
// Uses always_comb with if-else branching for comparison
module adder_subtractor_4bit_bh (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       ctrl,
    output logic [3:0] result,
    output logic       cout
);
    // Procedural description
    always_comb begin
        if (ctrl == 1'b0) begin
            // Addition: A + B
            {cout, result} = a + b;
        end else begin
            // Subtraction: A - B
            {cout, result} = a - b;
        end
    end
endmodule
