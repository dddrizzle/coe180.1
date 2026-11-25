// Full Subtractor - Behavioral Modeling Style
// Uses always_comb procedural block
module full_subtractor_bh (
    input  logic a, b, bin,
    output logic diff, bout
);
    // Procedural description of full subtractor
    always_comb begin
        diff = a ^ b ^ bin;
        bout = (~a & b) | (bin & ~(a ^ b));
    end
endmodule
