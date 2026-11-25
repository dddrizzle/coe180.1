// 4:1 Multiplexer - Behavioral Modeling Style
module mux41_bh (
    input  wire i0,
    input  wire i1,
    input  wire i2,
    input  wire i3,
    input  wire s1,
    input  wire s0,
    output reg  y
);
    // Procedural description using case statement
    always @(*) begin
        case ({s1, s0})
            2'b00: y = i0;
            2'b01: y = i1;
            2'b10: y = i2;
            2'b11: y = i3;
        endcase
    end
endmodule
