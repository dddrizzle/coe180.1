// Half Subtractor - Dataflow Modeling Style
// Uses continuous assignments with logic data type
module half_subtractor_df (
    input  logic a, b,
    output logic diff, bout
);
    // Difference is a ^ b, Borrow-out is ~a & b
    assign diff = a ^ b;
    assign bout = ~a & b;
endmodule
