// 2:1 Multiplexer - Behavioral Modeling Style
module mux21_bh (
    input  wire i0,
    input  wire i1,
    input  wire s,
    output reg  y
);
    always @(*) begin
        if (s == 1'b0)
            y = i0;
        else
            y = i1;
    end
endmodule
