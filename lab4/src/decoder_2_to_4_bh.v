// 2 to 4 decoder behavioral
module decoder_2_to_4_bh (
    input  wire [1:0] a,
    input  wire e,
    output reg  [3:0] y
);
    // behavioral case statement
    always @(*) begin
        if (e == 1'b1) begin
            case (a)
                2'b00: y = 4'b0001;
                2'b01: y = 4'b0010;
                2'b10: y = 4'b0100;
                2'b11: y = 4'b1000;
                default: y = 4'b0000;
            endcase
        end else begin
            y = 4'b0000;
        end
    end
endmodule
