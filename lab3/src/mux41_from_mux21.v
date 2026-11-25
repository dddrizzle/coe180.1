// 4:1 Multiplexer using 2:1 Multiplexers
// Hierarchical structural implementation (Task 2, Figure 3.4)
module mux41_from_mux21 (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire s1,
    input  wire s0,
    output wire y
);
    // Internal wires connecting stage 1 to stage 2
    wire w0;
    wire w1;

    // First stage 2:1 MUXes controlled by S0 (LSB)
    mux21_df mux_top (
        .i0(i0),
        .i1(i1),
        .s(s0),
        .y(w0)
    );

    mux21_df mux_bot (
        .i0(i2),
        .i1(i3),
        .s(s0),
        .y(w1)
    );

    // Second stage 2:1 MUX controlled by S1 (MSB)
    mux21_df mux_out (
        .i0(w0),
        .i1(w1),
        .s(s1),
        .y(y)
    );
endmodule
