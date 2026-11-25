// Full Adder - Dataflow Modeling Style
// Uses continuous assignments with logic data type
module full_adder_df (
    input  logic a, b, cin,
    output logic sum, cout
);
    // Boolean equations for full adder
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule
