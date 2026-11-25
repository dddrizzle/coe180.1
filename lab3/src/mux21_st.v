// 2:1 Multiplexer - Structural Modeling Style
// Uses gates developed from Lab 1
module mux21_st (
    input  wire i0,
    input  wire i1,
    input  wire s,
    output wire y
);
    wire s_n;
    wire net0;
    wire net1;

    not_gate_bh g1 (.a(s),  .y(s_n));
    and_gate_bh g2 (.a(i0), .b(s_n), .y(net0));
    and_gate_bh g3 (.a(i1), .b(s),   .y(net1));
    or_gate_bh  g4 (.a(net0), .b(net1), .y(y));
endmodule
