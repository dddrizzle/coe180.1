// 8:1 Multiplexer - Behavioral Modeling Style
module mux81_bh (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire i4,
    input  wire i5,
    input  wire i6,
    input  wire i7,
    input  wire s2,
    input  wire s1,
    input  wire s0,
    output reg  y
);
    // Procedural description using case statement
    always @(*) begin
        case ({s2, s1, s0})
            3'b000: y = i0;
            3'b001: y = i1;
            3'b010: y = i2;
            3'b011: y = i3;
            3'b100: y = i4;
            3'b101: y = i5;
            3'b110: y = i6;
            3'b111: y = i7;
        endcase
    end
endmodule
