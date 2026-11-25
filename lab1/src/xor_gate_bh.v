// XOR Gate - Behavioral Modeling Style
module xor_gate_bh (
    input  wire a,
    input  wire b,
    output reg  y
);
    // Procedural block using conditional statement to model XOR logic behavior
    always @(*) begin
        if (a != b)
            y = 1'b1;
        else
            y = 1'b0;
    end
endmodule
