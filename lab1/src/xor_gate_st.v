// XOR Gate - Structural Modeling Style
// Implements y = (~a & b) | (a & ~b) by instantiating NOT, AND, and OR submodules
module xor_gate_st (
    input  wire a,
    input  wire b,
    output wire y
);
    wire not_a, not_b;
    wire term1, term2;

    // Invert inputs
    not_gate_df u_not_a (.a(a), .y(not_a));
    not_gate_df u_not_b (.a(b), .y(not_b));

    // Form minterms
    and_gate_df u_and1 (.a(not_a), .b(b),     .y(term1));
    and_gate_df u_and2 (.a(a),     .b(not_b), .y(term2));

    // Combine minterms with OR gate
    or_gate_df u_or (.a(term1), .b(term2), .y(y));
endmodule
