// Full Adder - Structural Modeling Style
// Built hierarchically using two Half Adders and an OR gate
// (as recommended in Section 2.5 of the Lab Manual)
module full_adder_st (
    input  logic a, b, cin,
    output logic sum, cout
);
    // Internal interconnection signals
    logic s1;
    logic c1;
    logic c2;

    // First Half Adder: computes sum and carry of a and b
    half_adder_df ha1 (
        .a(a),
        .b(b),
        .sum(s1),
        .carry(c1)
    );

    // Second Half Adder: adds intermediate sum (s1) with cin
    half_adder_df ha2 (
        .a(s1),
        .b(cin),
        .sum(sum),
        .carry(c2)
    );

    // Final Carry-out is the OR of carries from both half adders
    assign cout = c1 | c2;
endmodule
