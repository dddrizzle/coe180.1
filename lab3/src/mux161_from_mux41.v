// 16:1 Multiplexer using 4:1 Multiplexers
// Hierarchical structural implementation (Challenge Problem, Figure 3.5)
module mux161_from_mux41 (
    input  wire [15:0] in,
    input  wire [3:0]  s,
    output wire        y
);
    // Intermediate outputs from the four first-stage 4:1 MUXes
    wire m0;
    wire m1;
    wire m2;
    wire m3;

    // Stage 1: Four 4:1 MUXes controlled by S1 and S0 (s[1] and s[0])
    mux41_df mux0 (
        .i0(in[0]),
        .i1(in[1]),
        .i2(in[2]),
        .i3(in[3]),
        .s1(s[1]),
        .s0(s[0]),
        .y(m0)
    );

    mux41_df mux1 (
        .i0(in[4]),
        .i1(in[5]),
        .i2(in[6]),
        .i3(in[7]),
        .s1(s[1]),
        .s0(s[0]),
        .y(m1)
    );

    mux41_df mux2 (
        .i0(in[8]),
        .i1(in[9]),
        .i2(in[10]),
        .i3(in[11]),
        .s1(s[1]),
        .s0(s[0]),
        .y(m2)
    );

    mux41_df mux3 (
        .i0(in[12]),
        .i1(in[13]),
        .i2(in[14]),
        .i3(in[15]),
        .s1(s[1]),
        .s0(s[0]),
        .y(m3)
    );

    // Stage 2: Final 4:1 MUX controlled by S3 and S2 (s[3] and s[2])
    mux41_df mux_out (
        .i0(m0),
        .i1(m1),
        .i2(m2),
        .i3(m3),
        .s1(s[3]),
        .s0(s[2]),
        .y(y)
    );
endmodule
