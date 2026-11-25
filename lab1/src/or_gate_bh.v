// OR Gate - Behavioral Modeling Style
module or_gate_bh (
    input  wire a,
    input  wire b,
    output reg  y
);
    // Procedural block triggered whenever any input changes
    always @(*) begin
        y = a | b;
    end
endmodule
