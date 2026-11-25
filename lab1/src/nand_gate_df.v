// NAND Gate - Dataflow Modeling Style
module nand_gate_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Continuous assignment using bitwise NAND operator
    assign y = ~(a & b);
endmodule
