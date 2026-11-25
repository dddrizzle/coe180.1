// XNOR Gate - Behavioral Modeling Style
module xnor_gate_bh (
    input  wire a,
    input  wire b,
    output reg  y
);
    // Procedural block modeling XNOR behavior using case statement
    always @(*) begin
        case ({a, b})
            2'b00: y = 1'b1;
            2'b01: y = 1'b0;
            2'b10: y = 1'b0;
            2'b11: y = 1'b1;
            default: y = 1'b0;
        endcase
    end
endmodule
