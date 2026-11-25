`timescale 1ns / 1ps

module mux21_tb;
    reg  i0, i1;
    reg  s;
    wire y_df, y_bh, y_st;

    mux21_df dut_df (.i0(i0), .i1(i1), .s(s), .y(y_df));
    mux21_bh dut_bh (.i0(i0), .i1(i1), .s(s), .y(y_bh));
    mux21_st dut_st (.i0(i0), .i1(i1), .s(s), .y(y_st));

    initial begin
        $dumpfile("sim/mux21_tb.vcd");
        $dumpvars(0, mux21_tb);

        $monitor("Time=%0t | s=%b | i0=%b i1=%b | y_df=%b y_bh=%b y_st=%b",
                 $time, s, i0, i1, y_df, y_bh, y_st);

        s = 0; i0 = 0; i1 = 0; #10;
        s = 0; i0 = 1; i1 = 0; #10;
        s = 0; i0 = 0; i1 = 1; #10;
        s = 0; i0 = 1; i1 = 1; #10;

        s = 1; i0 = 0; i1 = 0; #10;
        s = 1; i0 = 1; i1 = 0; #10;
        s = 1; i0 = 0; i1 = 1; #10;
        s = 1; i0 = 1; i1 = 1; #10;

        $finish;
    end
endmodule
