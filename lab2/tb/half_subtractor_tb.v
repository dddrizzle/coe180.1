`timescale 1ns / 1ps

module half_subtractor_tb;
    logic a, b;
    logic diff, bout;

    // Wildcard connection
    half_subtractor_df dut(.*);

    initial begin
        $dumpfile("sim/half_subtractor_tb.vcd");
        $dumpvars(0, half_subtractor_tb);

        $display("Testing Half Subtractor");
        $monitor("Time=%0t, a=%b, b=%b, diff=%b, bout=%b",
                 $time, a, b, diff, bout);

        // Test using a loop
        for (int i = 0; i < 4; i++) begin
            {a, b} = i;
            #10;
        end

        $finish;
    end
endmodule
