// XNOR Gate - Dataflow Modeling Style
module xnor_gate_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Continuous assignment using bitwise XNOR operator
    assign y = ~(a ^ b);
endmodule
