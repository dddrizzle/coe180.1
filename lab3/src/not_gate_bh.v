// NOT Gate - Behavioral Modeling Style (from Lab 1)
module not_gate_bh (
    input  wire a,
    output reg  y
);
    always @(*) begin
        y = ~a;
    end
endmodule
