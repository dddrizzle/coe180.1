// 8:1 Multiplexer - Dataflow Modeling Style
module mux81_df (
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
    // Boolean equation from truth table
    assign y = (~s2 & ~s1 & ~s0 & i0) |
               (~s2 & ~s1 &  s0 & i1) |
               (~s2 &  s1 & ~s0 & i2) |
               (~s2 &  s1 &  s0 & i3) |
               ( s2 & ~s1 & ~s0 & i4) |
               ( s2 & ~s1 &  s0 & i5) |
               ( s2 &  s1 & ~s0 & i6) |
               ( s2 &  s1 &  s0 & i7);
endmodule
