`timescale 1ns / 1ps

module mux41_tb;
    reg  i0, i1, i2, i3;
    reg  s1, s0;
    wire y_df, y_bh, y_st;

    mux41_df dut_df (.i0(i0), .i1(i1), .i2(i2), .i3(i3), .s1(s1), .s0(s0), .y(y_df));
    mux41_bh dut_bh (.i0(i0), .i1(i1), .i2(i2), .i3(i3), .s1(s1), .s0(s0), .y(y_bh));
    mux41_st dut_st (.i0(i0), .i1(i1), .i2(i2), .i3(i3), .s1(s1), .s0(s0), .y(y_st));

    initial begin
        $dumpfile("sim/mux41_tb.vcd");
        $dumpvars(0, mux41_tb);

        $monitor("Time=%0t | s1=%b s0=%b | i0=%b i1=%b i2=%b i3=%b | y_df=%b y_bh=%b y_st=%b",
                 $time, s1, s0, i0, i1, i2, i3, y_df, y_bh, y_st);

        // Pattern 1: i0=1, i1=0, i2=1, i3=0
        i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        s1 = 0; s0 = 0; #10;
        s1 = 0; s0 = 1; #10;
        s1 = 1; s0 = 0; #10;
        s1 = 1; s0 = 1; #10;

        // Pattern 2: i0=0, i1=1, i2=0, i3=1
        i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        s1 = 0; s0 = 0; #10;
        s1 = 0; s0 = 1; #10;
        s1 = 1; s0 = 0; #10;
        s1 = 1; s0 = 1; #10;

        $finish;
    end
endmodule
