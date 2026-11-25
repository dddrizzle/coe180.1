`timescale 1ns / 1ps

module mux81_tb;
    reg  i0, i1, i2, i3, i4, i5, i6, i7;
    reg  s2, s1, s0;
    wire y_df, y_bh, y_st;

    mux81_df dut_df (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .i4(i4), .i5(i5), .i6(i6), .i7(i7),
        .s2(s2), .s1(s1), .s0(s0), .y(y_df)
    );
    mux81_bh dut_bh (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .i4(i4), .i5(i5), .i6(i6), .i7(i7),
        .s2(s2), .s1(s1), .s0(s0), .y(y_bh)
    );
    mux81_st dut_st (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .i4(i4), .i5(i5), .i6(i6), .i7(i7),
        .s2(s2), .s1(s1), .s0(s0), .y(y_st)
    );

    initial begin
        $dumpfile("sim/mux81_tb.vcd");
        $dumpvars(0, mux81_tb);

        $monitor("Time=%0t | s2=%b s1=%b s0=%b | y_df=%b y_bh=%b y_st=%b",
                 $time, s2, s1, s0, y_df, y_bh, y_st);

        // Inputs: i0=0, i1=1, i2=0, i3=1, i4=0, i5=1, i6=0, i7=1
        i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        i4 = 0; i5 = 1; i6 = 0; i7 = 1;

        s2 = 0; s1 = 0; s0 = 0; #10;
        s2 = 0; s1 = 0; s0 = 1; #10;
        s2 = 0; s1 = 1; s0 = 0; #10;
        s2 = 0; s1 = 1; s0 = 1; #10;
        s2 = 1; s1 = 0; s0 = 0; #10;
        s2 = 1; s1 = 0; s0 = 1; #10;
        s2 = 1; s1 = 1; s0 = 0; #10;
        s2 = 1; s1 = 1; s0 = 1; #10;

        $finish;
    end
endmodule
