// 3 to 8 decoder structural
module decoder_3_to_8_st (
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
    wire not_a2, not_a1, not_a0;

    // inverters
    not (not_a2, a2);
    not (not_a1, a1);
    not (not_a0, a0);

    // 4-input and gates
    and (y0, not_a2, not_a1, not_a0, e);
    and (y1, not_a2, not_a1, a0, e);
    and (y2, not_a2, a1, not_a0, e);
    and (y3, not_a2, a1, a0, e);
    and (y4, a2, not_a1, not_a0, e);
    and (y5, a2, not_a1, a0, e);
    and (y6, a2, a1, not_a0, e);
    and (y7, a2, a1, a0, e);
endmodule
