`timescale 1ns / 1ps

module full_adder_tb;
    logic a, b, cin;
    logic sum, cout;

    // Wildcard connection
    full_adder_df dut(.*);

    initial begin
        $dumpfile("sim/full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);

        $display("Testing Full Adder");
        $monitor("Time=%0t, a=%b, b=%b, cin=%b, sum=%b, cout=%b",
                 $time, a, b, cin, sum, cout);

        // Test using a loop
        for (int i = 0; i < 8; i++) begin
            {a, b, cin} = i;
            #10;
        end

        $finish;
    end
endmodule
