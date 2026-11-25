// OR Gate - Dataflow Modeling Style
module or_gate_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Continuous assignment using bitwise OR operator
    assign y = a | b;
endmodule
