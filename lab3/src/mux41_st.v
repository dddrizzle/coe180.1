// 4:1 Multiplexer - Structural Modeling Style
// Uses logic gates developed from Lab 1
module mux41_st (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire s1,
    input  wire s0,
    output wire y
);
    // Inverted select signals
    wire s1_n;
    wire s0_n;

    // Intermediate select decoding signals
    wire sel0;
    wire sel1;
    wire sel2;
    wire sel3;

    // AND gate outputs for each data channel
    wire m0;
    wire m1;
    wire m2;
    wire m3;

    // Intermediate OR gate signals
    wire or_lo;
    wire or_hi;

    // Invert select lines
    not_gate_bh inv1 (.a(s1), .y(s1_n));
    not_gate_bh inv0 (.a(s0), .y(s0_n));

    // Decode select line combinations
    and_gate_bh dec0 (.a(s1_n), .b(s0_n), .y(sel0));
    and_gate_bh dec1 (.a(s1_n), .b(s0),   .y(sel1));
    and_gate_bh dec2 (.a(s1),   .b(s0_n), .y(sel2));
    and_gate_bh dec3 (.a(s1),   .b(s0),   .y(sel3));

    // AND decoded select with respective input
    and_gate_bh and0 (.a(sel0), .b(i0), .y(m0));
    and_gate_bh and1 (.a(sel1), .b(i1), .y(m1));
    and_gate_bh and2 (.a(sel2), .b(i2), .y(m2));
    and_gate_bh and3 (.a(sel3), .b(i3), .y(m3));

    // OR together all product terms to form output Y
    or_gate_bh or1 (.a(m0),    .b(m1),    .y(or_lo));
    or_gate_bh or2 (.a(m2),    .b(m3),    .y(or_hi));
    or_gate_bh or3 (.a(or_lo), .b(or_hi), .y(y));
endmodule
