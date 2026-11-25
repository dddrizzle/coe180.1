// NAND Gate - Structural Modeling Style
// Instantiates AND gate and NOT gate submodules
module nand_gate_st (
    input  wire a,
    input  wire b,
    output wire y
);
    wire and_out;

    // Submodule Instantiations
    and_gate_df and1 (
        .a(a),
        .b(b),
        .y(and_out)
    );

    not_gate_df not1 (
        .a(and_out),
        .y(y)
    );
endmodule
