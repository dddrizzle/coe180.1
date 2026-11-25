`timescale 1ns / 1ps

module or_gate_tb;
    reg a, b;
    wire y_df, y_bh;

    // Instantiate Dataflow DUT
    or_gate_df dut_df (
        .a(a),
        .b(b),
        .y(y_df)
    );

    // Instantiate Behavioral DUT
    or_gate_bh dut_bh (
        .a(a),
        .b(b),
        .y(y_bh)
    );

    initial begin
        // Output waveform file for GTKWave
        $dumpfile("sim/or_gate_tb.vcd");
        $dumpvars(0, or_gate_tb);

        // Display output changes in console
        $monitor("Time = %0t ns | a = %b, b = %b | y_df = %b | y_bh = %b", $time, a, b, y_df, y_bh);

        // Test all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule
