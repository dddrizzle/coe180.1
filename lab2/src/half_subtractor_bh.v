// Half Subtractor - Behavioral Modeling Style
// Uses always_comb procedural block
module half_subtractor_bh (
    input  logic a, b,
    output logic diff, bout
);
    // Procedural description of half subtractor
    always_comb begin
        diff = a ^ b;
        bout = ~a & b;
    end
endmodule
