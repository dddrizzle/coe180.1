// 2 to 4 decoder structural
module decoder_2_to_4_st (
    input  wire a1,
    input  wire a0,
    input  wire e,
    output wire y3,
    output wire y2,
    output wire y1,
    output wire y0
);
    wire not_a1, not_a0;

    // inverters for inputs
    not (not_a1, a1);
    not (not_a0, a0);

    // 3-input and gates
    and (y0, not_a1, not_a0, e);
    and (y1, not_a1, a0, e);
    and (y2, a1, not_a0, e);
    and (y3, a1, a0, e);
endmodule
