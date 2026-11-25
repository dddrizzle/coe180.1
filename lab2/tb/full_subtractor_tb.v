`timescale 1ns / 1ps

module full_subtractor_tb;
    logic a, b, bin;
    logic diff, bout;

    // Wildcard connection
    full_subtractor_df dut(.*);

    initial begin
        $dumpfile("sim/full_subtractor_tb.vcd");
        $dumpvars(0, full_subtractor_tb);

        $display("Testing Full Subtractor");
        $monitor("Time=%0t, a=%b, b=%b, bin=%b, diff=%b, bout=%b",
                 $time, a, b, bin, diff, bout);

        // Test using a loop
        for (int i = 0; i < 8; i++) begin
            {a, b, bin} = i;
            #10;
        end

        $finish;
    end
endmodule
