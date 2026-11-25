// NOR Gate - Structural Modeling Style
// Instantiates OR gate and NOT gate submodules
module nor_gate_st (
    input  wire a,
    input  wire b,
    output wire y
);
    wire or_out;

    // Submodule Instantiations
    or_gate_df or1 (
        .a(a),
        .b(b),
        .y(or_out)
    );

    not_gate_df not1 (
        .a(or_out),
        .y(y)
    );
endmodule
