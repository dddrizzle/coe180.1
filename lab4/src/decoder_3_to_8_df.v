// 3 to 8 decoder dataflow
module decoder_3_to_8_df (
    input  wire a2,
    input  wire a1,
    input  wire a0,
    input  wire e,
    output wire y7,
    output wire y6,
    output wire y5,
    output wire y4,
    output wire y3,
    output wire y2,
    output wire y1,
    output wire y0
);
    // dataflow equations
    assign y0 = (~a2 & ~a1 & ~a0 & e);
    assign y1 = (~a2 & ~a1 &  a0 & e);
    assign y2 = (~a2 &  a1 & ~a0 & e);
    assign y3 = (~a2 &  a1 &  a0 & e);
    assign y4 = ( a2 & ~a1 & ~a0 & e);
    assign y5 = ( a2 & ~a1 &  a0 & e);
    assign y6 = ( a2 &  a1 & ~a0 & e);
    assign y7 = ( a2 &  a1 &  a0 & e);
endmodule
