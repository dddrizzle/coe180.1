// Full Adder - Behavioral Modeling Style
// Uses always_comb procedural block
module full_adder_bh (
    input  logic a, b, cin,
    output logic sum, cout
);
    // Procedural description of full adder
    always_comb begin
        sum  = a ^ b ^ cin;
        cout = (a & b) | (cin & (a ^ b));
    end
endmodule
