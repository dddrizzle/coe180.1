`timescale 1ns / 1ps

module decoder_2_to_4_tb;
    reg  a1, a0, e;
    wire [1:0] a = {a1, a0};

    // outputs for dataflow, behavioral, and structural
    wire y3_df, y2_df, y1_df, y0_df;
    wire [3:0] y_df = {y3_df, y2_df, y1_df, y0_df};
    wire [3:0] y_bh;
    wire y3_st, y2_st, y1_st, y0_st;
    wire [3:0] y_st = {y3_st, y2_st, y1_st, y0_st};

    // instantiate dataflow
    decoder_2_to_4_df dut_df (
        .a1(a1), .a0(a0), .e(e),
        .y3(y3_df), .y2(y2_df), .y1(y1_df), .y0(y0_df)
    );

    // instantiate behavioral
    decoder_2_to_4_bh dut_bh (
        .a(a), .e(e),
        .y(y_bh)
    );

    // instantiate structural
    decoder_2_to_4_st dut_st (
        .a1(a1), .a0(a0), .e(e),
        .y3(y3_st), .y2(y2_st), .y1(y1_st), .y0(y0_st)
    );

    initial begin
        $dumpfile("sim/decoder_2_to_4_tb.vcd");
        $dumpvars(0, decoder_2_to_4_tb);

        $monitor("Time=%0t | e=%b a=%b (%b%b) | y_df=%b y_bh=%b y_st=%b",
                 $time, e, a, a1, a0, y_df, y_bh, y_st);

        // disabled state
        e = 0; a1 = 0; a0 = 0; #10;
        e = 0; a1 = 1; a0 = 1; #10;

        // enabled states
        e = 1; a1 = 0; a0 = 0; #10;
        e = 1; a1 = 0; a0 = 1; #10;
        e = 1; a1 = 1; a0 = 0; #10;
        e = 1; a1 = 1; a0 = 1; #10;

        $finish;
    end
endmodule
