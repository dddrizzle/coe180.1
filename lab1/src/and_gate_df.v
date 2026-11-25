// AND Gate - Dataflow Modeling Style
module and_gate_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Continuous assignment using bitwise AND operator
    assign y = a & b;
endmodule
