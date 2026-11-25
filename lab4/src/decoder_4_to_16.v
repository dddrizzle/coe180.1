// 4 to 16 decoder
module decoder_4_to_16 (
    input  wire [3:0] in,
    input  wire en,
    output reg  [15:0] out
);
    // decode 4-bit input to 16 lines
    always @(*) begin
        if (en) begin
            out = 16'b1 << in;
        end else begin
            out = 16'b0;
        end
    end
endmodule
