`timescale 1ns / 1ps

module nand_gate_tb;
    reg a, b;
    wire y_df, y_bh, y_st;

    // Instantiate Dataflow DUT
    nand_gate_df dut_df (
        .a(a),
        .b(b),
        .y(y_df)
    );

    // Instantiate Behavioral DUT
    nand_gate_bh dut_bh (
        .a(a),
        .b(b),
        .y(y_bh)
    );

    // Instantiate Structural DUT
    nand_gate_st dut_st (
        .a(a),
        .b(b),
        .y(y_st)
    );

    initial begin
        // Output waveform file for GTKWave
        $dumpfile("sim/nand_gate_tb.vcd");
        $dumpvars(0, nand_gate_tb);

        // Display output changes in console
        $monitor("Time = %0t ns | a = %b, b = %b | y_df = %b | y_bh = %b | y_st = %b", $time, a, b, y_df, y_bh, y_st);

        // Test all input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule
