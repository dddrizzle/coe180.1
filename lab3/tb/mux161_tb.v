`timescale 1ns / 1ps

module mux161_tb;
    reg  [15:0] in;
    reg  [3:0]  s;
    wire        y_from_41;
    wire        y_bh;
    integer     k;

    mux161_from_mux41 dut_41 (
        .in(in),
        .s(s),
        .y(y_from_41)
    );

    mux161_bh dut_bh (
        .in(in),
        .s(s),
        .y(y_bh)
    );

    initial begin
        $dumpfile("sim/mux161_tb.vcd");
        $dumpvars(0, mux161_tb);

        $monitor("Time=%0t | s=%b (%0d) | y_from_41=%b y_bh=%b",
                 $time, s, s, y_from_41, y_bh);

        // Alternating test pattern across 16 data lines
        in = 16'b1010_1010_1010_1010;

        for (k = 0; k < 16; k = k + 1) begin
            s = k[3:0];
            #10;
        end

        $finish;
    end
endmodule
