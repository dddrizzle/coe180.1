// Half Adder - Behavioral Modeling Style
// Uses always_comb procedural block
module half_adder_bh (
    input  logic a, b,
    output logic sum, carry
);
    // Procedural description of half adder
    always_comb begin
        sum   = a ^ b;
        carry = a & b;
    end
endmodule
