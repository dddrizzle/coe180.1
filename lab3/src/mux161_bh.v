// 16:1 Multiplexer - Behavioral Modeling Style
// Uses procedural case statement (Section 3.2.1)
module mux161_bh (
    input  wire [15:0] in,
    input  wire [3:0]  s,
    output reg         y
);
    always @(*) begin
        case (s)
            4'd0:  y = in[0];
            4'd1:  y = in[1];
            4'd2:  y = in[2];
            4'd3:  y = in[3];
            4'd4:  y = in[4];
            4'd5:  y = in[5];
            4'd6:  y = in[6];
            4'd7:  y = in[7];
            4'd8:  y = in[8];
            4'd9:  y = in[9];
            4'd10: y = in[10];
            4'd11: y = in[11];
            4'd12: y = in[12];
            4'd13: y = in[13];
            4'd14: y = in[14];
            4'd15: y = in[15];
            default: y = 1'b0;
        endcase
    end
endmodule
