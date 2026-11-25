// Full Subtractor - Structural Modeling Style
// Built hierarchically using two Half Subtractors and an OR gate
// (Matching Figure 2.4 and hierarchical composition principles)
module full_subtractor_st (
    input  logic a, b, bin,
    output logic diff, bout
);
    // Internal interconnection signals
    logic d1;
    logic b1;
    logic b2;

    // First Half Subtractor: computes difference and borrow for a and b
    half_subtractor_df hs1 (
        .a(a),
        .b(b),
        .diff(d1),
        .bout(b1)
    );

    // Second Half Subtractor: subtracts bin from intermediate difference (d1)
    half_subtractor_df hs2 (
        .a(d1),
        .b(bin),
        .diff(diff),
        .bout(b2)
    );

    // Final Borrow-out is the OR of borrows from both stages
    assign bout = b1 | b2;
endmodule
