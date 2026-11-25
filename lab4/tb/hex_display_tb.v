`timescale 1ns / 1ps

module hex_display_tb;
    reg  [3:0] in;
    reg  en;
    wire [15:0] dec_out;
    wire [6:0]  seg;
    wire a, b, c, d, e, f, g;

    // instantiate top hex display module
    hex_display_top dut (
        .in(in),
        .en(en),
        .dec_out(dec_out),
        .seg(seg),
        .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)
    );

    integer i;

    initial begin
        $dumpfile("sim/hex_display_tb.vcd");
        $dumpvars(0, hex_display_tb);

        $monitor("Time=%0t | en=%b in=%h (%b) | dec_out=%h | seg=%b (abcdefg=%b%b%b%b%b%b%b)",
                 $time, en, in, in, dec_out, seg, a, b, c, d, e, f, g);

        // disabled state
        en = 0;
        in = 4'h0; #10;
        in = 4'h7; #10;

        // enabled states: test digits 0 to F
        en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            in = i[3:0];
            #10;
        end

        $finish;
    end
endmodule
