// 8:1 Multiplexer - Structural Modeling Style
// Uses logic gates developed from Lab 1
module mux81_st (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire i4,
    input  wire i5,
    input  wire i6,
    input  wire i7,
    input  wire s2,
    input  wire s1,
    input  wire s0,
    output wire y
);
    // Inverted select signals
    wire s2_n;
    wire s1_n;
    wire s0_n;

    // 2-bit intermediate terms (s2, s1)
    wire c00;
    wire c01;
    wire c10;
    wire c11;

    // 3-bit decoded select lines
    wire sel0;
    wire sel1;
    wire sel2;
    wire sel3;
    wire sel4;
    wire sel5;
    wire sel6;
    wire sel7;

    // AND gate outputs for each data channel
    wire p0;
    wire p1;
    wire p2;
    wire p3;
    wire p4;
    wire p5;
    wire p6;
    wire p7;

    // Intermediate OR tree signals
    wire or_01;
    wire or_23;
    wire or_45;
    wire or_67;
    wire or_0123;
    wire or_4567;

    // Invert select lines
    not_gate_bh inv2 (.a(s2), .y(s2_n));
    not_gate_bh inv1 (.a(s1), .y(s1_n));
    not_gate_bh inv0 (.a(s0), .y(s0_n));

    // Decode upper two select lines (s2, s1)
    and_gate_bh dec_c00 (.a(s2_n), .b(s1_n), .y(c00));
    and_gate_bh dec_c01 (.a(s2_n), .b(s1),   .y(c01));
    and_gate_bh dec_c10 (.a(s2),   .b(s1_n), .y(c10));
    and_gate_bh dec_c11 (.a(s2),   .b(s1),   .y(c11));

    // Combine with s0 to complete 3-bit decoding
    and_gate_bh dec_m0 (.a(c00), .b(s0_n), .y(sel0));
    and_gate_bh dec_m1 (.a(c00), .b(s0),   .y(sel1));
    and_gate_bh dec_m2 (.a(c01), .b(s0_n), .y(sel2));
    and_gate_bh dec_m3 (.a(c01), .b(s0),   .y(sel3));
    and_gate_bh dec_m4 (.a(c10), .b(s0_n), .y(sel4));
    and_gate_bh dec_m5 (.a(c10), .b(s0),   .y(sel5));
    and_gate_bh dec_m6 (.a(c11), .b(s0_n), .y(sel6));
    and_gate_bh dec_m7 (.a(c11), .b(s0),   .y(sel7));

    // AND decoded select with respective input
    and_gate_bh and0 (.a(sel0), .b(i0), .y(p0));
    and_gate_bh and1 (.a(sel1), .b(i1), .y(p1));
    and_gate_bh and2 (.a(sel2), .b(i2), .y(p2));
    and_gate_bh and3 (.a(sel3), .b(i3), .y(p3));
    and_gate_bh and4 (.a(sel4), .b(i4), .y(p4));
    and_gate_bh and5 (.a(sel5), .b(i5), .y(p5));
    and_gate_bh and6 (.a(sel6), .b(i6), .y(p6));
    and_gate_bh and7 (.a(sel7), .b(i7), .y(p7));

    // OR tree to combine all product terms
    or_gate_bh or1 (.a(p0),      .b(p1),      .y(or_01));
    or_gate_bh or2 (.a(p2),      .b(p3),      .y(or_23));
    or_gate_bh or3 (.a(p4),      .b(p5),      .y(or_45));
    or_gate_bh or4 (.a(p6),      .b(p7),      .y(or_67));
    or_gate_bh or5 (.a(or_01),   .b(or_23),   .y(or_0123));
    or_gate_bh or6 (.a(or_45),   .b(or_67),   .y(or_4567));
    or_gate_bh or7 (.a(or_0123), .b(or_4567), .y(y));
endmodule
