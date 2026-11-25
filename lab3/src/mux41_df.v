// 4:1 Multiplexer - Dataflow Modeling Style
module mux41_df (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire s1,
    input  wire s0,
    output wire y
);
    // Boolean equation from truth table
    assign y = (~s1 & ~s0 & i0) |
               (~s1 &  s0 & i1) |
               ( s1 & ~s0 & i2) |
               ( s1 &  s0 & i3);
endmodule
