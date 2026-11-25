// 4-bit Configurable Adder-Subtractor - Structural Modeling Style
// Implements Figure 2.6 from Section 2.6 of the Lab Manual
// - ctrl = 0: Addition (A + B + 0)
// - ctrl = 1: Subtraction via 2's complement (A + ~B + 1 = A - B)
module adder_subtractor_4bit (
    input  logic [3:0] a,
    input  logic [3:0] b,
    input  logic       ctrl,
    output logic [3:0] result,
    output logic       cout
);
    // Intermediate signals
    logic [3:0] b_xor;
    logic c1, c2, c3;

    // Invert B when ctrl = 1 using XOR gates (b ^ 1 = ~b, b ^ 0 = b)
    assign b_xor[0] = b[0] ^ ctrl;
    assign b_xor[1] = b[1] ^ ctrl;
    assign b_xor[2] = b[2] ^ ctrl;
    assign b_xor[3] = b[3] ^ ctrl;

    // Stage 0: Least Significant Bit (Cin is connected to ctrl)
    full_adder_df fa0 (
        .a(a[0]),
        .b(b_xor[0]),
        .cin(ctrl),
        .sum(result[0]),
        .cout(c1)
    );

    // Stage 1
    full_adder_df fa1 (
        .a(a[1]),
        .b(b_xor[1]),
        .cin(c1),
        .sum(result[1]),
        .cout(c2)
    );

    // Stage 2
    full_adder_df fa2 (
        .a(a[2]),
        .b(b_xor[2]),
        .cin(c2),
        .sum(result[2]),
        .cout(c3)
    );

    // Stage 3: Most Significant Bit
    full_adder_df fa3 (
        .a(a[3]),
        .b(b_xor[3]),
        .cin(c3),
        .sum(result[3]),
        .cout(cout)
    );
endmodule
