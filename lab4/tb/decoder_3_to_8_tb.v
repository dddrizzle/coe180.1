`timescale 1ns / 1ps

module decoder_3_to_8_tb;
    reg  a2, a1, a0, e;
    wire [2:0] a = {a2, a1, a0};

    // outputs for dataflow, behavioral, and structural
    wire y7_df, y6_df, y5_df, y4_df, y3_df, y2_df, y1_df, y0_df;
    wire [7:0] y_df = {y7_df, y6_df, y5_df, y4_df, y3_df, y2_df, y1_df, y0_df};
    wire [7:0] y_bh;
    wire y7_st, y6_st, y5_st, y4_st, y3_st, y2_st, y1_st, y0_st;
    wire [7:0] y_st = {y7_st, y6_st, y5_st, y4_st, y3_st, y2_st, y1_st, y0_st};

    // instantiate dataflow
    decoder_3_to_8_df dut_df (
        .a2(a2), .a1(a1), .a0(a0), .e(e),
        .y7(y7_df), .y6(y6_df), .y5(y5_df), .y4(y4_df),
        .y3(y3_df), .y2(y2_df), .y1(y1_df), .y0(y0_df)
    );

    // instantiate behavioral
    decoder_3_to_8_bh dut_bh (
        .a(a), .e(e),
        .y(y_bh)
    );

    // instantiate structural
    decoder_3_to_8_st dut_st (
        .a2(a2), .a1(a1), .a0(a0), .e(e),
        .y7(y7_st), .y6(y6_st), .y5(y5_st), .y4(y4_st),
        .y3(y3_st), .y2(y2_st), .y1(y1_st), .y0(y0_st)
    );

    integer i;

    initial begin
        $dumpfile("sim/decoder_3_to_8_tb.vcd");
        $dumpvars(0, decoder_3_to_8_tb);

        $monitor("Time=%0t | e=%b a=%b | y_df=%b y_bh=%b y_st=%b",
                 $time, e, a, y_df, y_bh, y_st);

        // disabled state
        e = 0;
        {a2, a1, a0} = 3'b000; #10;
        {a2, a1, a0} = 3'b101; #10;

        // enabled states
        e = 1;
        for (i = 0; i < 8; i = i + 1) begin
            {a2, a1, a0} = i[2:0];
            #10;
        end

        $finish;
    end
endmodule
