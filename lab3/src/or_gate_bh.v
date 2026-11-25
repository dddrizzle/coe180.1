// OR Gate - Behavioral Modeling Style (from Lab 1)
module or_gate_bh (
    input  wire a,
    input  wire b,
    output reg  y
);
    always @(*) begin
        y = a | b;
    end
endmodule
