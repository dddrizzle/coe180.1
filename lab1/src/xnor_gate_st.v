// XNOR Gate - Structural Modeling Style
// Implements Q = (A & B) + (~A & ~B) per Lab Manual Figure 1.2
module xnor_gate_st (
    input  wire a,
    input  wire b,
    output wire y
);
    wire not_a, not_b;
    wire term_ab, term_not_ab;

    // Invert inputs
    not_gate_df u_not_a (.a(a), .y(not_a));
    not_gate_df u_not_b (.a(b), .y(not_b));

    // Upper AND gate: A & B
    and_gate_df u_and_upper (.a(a), .b(b), .y(term_ab));

    // Lower AND gate: ~A & ~B
    and_gate_df u_and_lower (.a(not_a), .b(not_b), .y(term_not_ab));

    // Output OR gate: (A & B) | (~A & ~B)
    or_gate_df u_or (.a(term_ab), .b(term_not_ab), .y(y));
endmodule
