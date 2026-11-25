`timescale 1ns / 1ps

module not_gate_tb;
    reg a;
    wire y_df, y_bh;

    // Instantiate Dataflow DUT
    not_gate_df dut_df (
        .a(a),
        .y(y_df)
    );

    // Instantiate Behavioral DUT
    not_gate_bh dut_bh (
        .a(a),
        .y(y_bh)
    );

    initial begin
        // Output waveform file for GTKWave
        $dumpfile("sim/not_gate_tb.vcd");
        $dumpvars(0, not_gate_tb);

        // Display output changes in console
        $monitor("Time = %0t ns | a = %b | y_df = %b | y_bh = %b", $time, a, y_df, y_bh);

        // Test all input combinations
        a = 0; #10;
        a = 1; #10;

        $finish;
    end
endmodule
