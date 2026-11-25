// NOT Gate - Dataflow Modeling Style
module not_gate_df (
    input  wire a,
    output wire y
);
    // Continuous assignment using bitwise NOT operator
    assign y = ~a;
endmodule
