// Half Adder - Structural Modeling Style
// Uses gate primitives (xor, and) to implement logic
module half_adder_st (
    input  logic a, b,
    output wire  sum, carry
);
    // Gate primitives: primitive_name instance_name (output, input1, input2)
    xor sum_gate   (sum, a, b);
    and carry_gate (carry, a, b);
endmodule
