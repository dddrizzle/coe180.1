// 2 to 4 decoder dataflow
module decoder_2_to_4_df (
    input  wire a1,
    input  wire a0,
    input  wire e,
    output wire y3,
    output wire y2,
    output wire y1,
    output wire y0
);
    // boolean expressions with active-high enable
    assign y0 = (~a1 & ~a0 & e);
    assign y1 = (~a1 &  a0 & e);
    assign y2 = ( a1 & ~a0 & e);
    assign y3 = ( a1 &  a0 & e);
endmodule
