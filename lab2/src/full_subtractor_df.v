// Full Subtractor - Dataflow Modeling Style
// Uses continuous assignments with logic data type
module full_subtractor_df (
    input  logic a, b, bin,
    output logic diff, bout
);
    // Boolean equations for full subtractor
    assign diff = a ^ b ^ bin;
    assign bout = (~a & b) | (bin & ~(a ^ b));
endmodule
