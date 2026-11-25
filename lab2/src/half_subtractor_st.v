// Half Subtractor - Structural Modeling Style
// Uses gate primitives (xor, not, and)
module half_subtractor_st (
    input  logic a, b,
    output wire  diff, bout
);
    wire not_a;

    // Invert input a
    not inv_a       (not_a, a);

    // Difference output: a ^ b
    xor diff_gate   (diff, a, b);

    // Borrow-out output: ~a & b
    and borrow_gate (bout, not_a, b);
endmodule
