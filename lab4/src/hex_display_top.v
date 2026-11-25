// top module: 4 to 16 decoder to 7-segment display
module hex_display_top (
    input  wire [3:0] in,
    input  wire en,
    output wire [15:0] dec_out,
    output reg  [6:0] seg, // {a, b, c, d, e, f, g}
    output wire a, b, c, d, e, f, g
);
    // instantiate 4:16 decoder
    decoder_4_to_16 dec (
        .in(in),
        .en(en),
        .out(dec_out)
    );

    // active-high 7-segment display mapping (figure 4.7)
    // 1 = segment on, 0 = segment off
    always @(*) begin
        if (!en) begin
            seg = 7'b0000000;
        end else begin
            case (dec_out)
                16'h0001: seg = 7'b1111110; // 0
                16'h0002: seg = 7'b0110000; // 1
                16'h0004: seg = 7'b1101101; // 2
                16'h0008: seg = 7'b1111001; // 3
                16'h0010: seg = 7'b0110011; // 4
                16'h0020: seg = 7'b1011011; // 5
                16'h0040: seg = 7'b1011111; // 6
                16'h0080: seg = 7'b1110000; // 7
                16'h0100: seg = 7'b1111111; // 8
                16'h0200: seg = 7'b1111011; // 9
                16'h0400: seg = 7'b1110111; // A
                16'h0800: seg = 7'b0011111; // b
                16'h1000: seg = 7'b1001110; // C
                16'h2000: seg = 7'b0111101; // d
                16'h4000: seg = 7'b1001111; // E
                16'h8000: seg = 7'b1000111; // F
                default:  seg = 7'b0000000;
            endcase
        end
    end

    // individual segment pins
    assign {a, b, c, d, e, f, g} = seg;

endmodule
