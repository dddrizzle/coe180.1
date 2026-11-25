`timescale 1ns / 1ps

module adder_subtractor_4bit_tb;
    logic [3:0] a;
    logic [3:0] b;
    logic       ctrl;
    logic [3:0] result;
    logic       cout;

    // Instantiate structural 4-bit adder-subtractor
    adder_subtractor_4bit dut (
        .a(a),
        .b(b),
        .ctrl(ctrl),
        .result(result),
        .cout(cout)
    );

    initial begin
        $dumpfile("sim/adder_subtractor_4bit_tb.vcd");
        $dumpvars(0, adder_subtractor_4bit_tb);

        $display("Testing 4-bit Adder-Subtractor");
        $monitor("Time=%0t, ctrl=%b, a=%b, b=%b, result=%b, cout=%b",
                 $time, ctrl, a, b, result, cout);

        // Addition tests (ctrl = 0)
        ctrl = 0;
        a = 4'd5;  b = 4'd3;  #10;
        a = 4'd7;  b = 4'd2;  #10;
        a = 4'd10; b = 4'd4;  #10;
        a = 4'd12; b = 4'd3;  #10;
        a = 4'd9;  b = 4'd7;  #10;

        // Subtraction tests (ctrl = 1)
        ctrl = 1;
        a = 4'd9;  b = 4'd4;  #10;
        a = 4'd15; b = 4'd7;  #10;
        a = 4'd8;  b = 4'd8;  #10;
        a = 4'd10; b = 4'd3;  #10;
        a = 4'd3;  b = 4'd5;  #10;

        $finish;
    end
endmodule
