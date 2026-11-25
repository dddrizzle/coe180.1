// 2:1 Multiplexer - Dataflow Modeling Style
module mux21_df (
    input  wire i0,
    input  wire i1,
    input  wire s,
    output wire y
);
    assign y = (i0 & (~s)) | (i1 & s);
endmodule
