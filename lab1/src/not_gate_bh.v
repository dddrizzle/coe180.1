// NOT Gate - Behavioral Modeling Style
module not_gate_bh (
    input  wire a,
    output reg  y
);
    // Procedural block triggered whenever input 'a' changes
    always @(*) begin
        y = ~a;
    end
endmodule
