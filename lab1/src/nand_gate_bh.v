// NAND Gate - Behavioral Modeling Style
module nand_gate_bh (
    input  wire a,
    input  wire b,
    output reg  y
);
    // Procedural block triggered whenever any input changes
    always @(*) begin
        y = ~(a & b);
    end
endmodule
