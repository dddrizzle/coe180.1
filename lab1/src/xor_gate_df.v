// XOR Gate - Dataflow Modeling Style
module xor_gate_df (
    input  wire a,
    input  wire b,
    output wire y
);
    // Continuous assignment using bitwise XOR operator
    assign y = a ^ b;
endmodule
