// NOR Gate - Dataflow Modeling Style
module nor_gate_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Continuous assignment using bitwise NOR operator
    assign y = ~(a | b);
endmodule
