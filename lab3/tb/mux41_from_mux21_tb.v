`timescale 1ns / 1ps

module mux41_from_mux21_tb;
    reg  i0, i1, i2, i3;
    reg  s1, s0;
    wire y;

    mux41_from_mux21 dut (
        .i0(i0), .i1(i1), .i2(i2), .i3(i3),
        .s1(s1), .s0(s0), .y(y)
    );

    initial begin
        $dumpfile("sim/mux41_from_mux21_tb.vcd");
        $dumpvars(0, mux41_from_mux21_tb);

        $monitor("Time=%0t | s1=%b s0=%b | i0=%b i1=%b i2=%b i3=%b | y=%b",
                 $time, s1, s0, i0, i1, i2, i3, y);

        // Pattern 1
        i0 = 1; i1 = 0; i2 = 1; i3 = 0;
        s1 = 0; s0 = 0; #10;
        s1 = 0; s0 = 1; #10;
        s1 = 1; s0 = 0; #10;
        s1 = 1; s0 = 1; #10;

        // Pattern 2
        i0 = 0; i1 = 1; i2 = 0; i3 = 1;
        s1 = 0; s0 = 0; #10;
        s1 = 0; s0 = 1; #10;
        s1 = 1; s0 = 0; #10;
        s1 = 1; s0 = 1; #10;

        $finish;
    end
endmodule
