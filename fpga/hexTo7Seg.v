module hexTo7Seg (
    input  [3:0] in,  // 4 bit input 
    input        E,   // switch
    output reg [6:0] Y // 7 output wires. 
);
    always @(*) begin
        if (E == 1'b1) begin 
            case (in) 
                4'b0000: Y = 7'b1000000; // 0
                4'b0001: Y = 7'b1111001; // 1
                4'b0010: Y = 7'b0100100; // 2
                4'b0011: Y = 7'b0110000; // 3
                4'b0100: Y = 7'b0011001; // 4
                4'b0101: Y = 7'b0010010; // 5
                4'b0110: Y = 7'b0000010; // 6
                4'b0111: Y = 7'b1111000; // 7
                4'b1000: Y = 7'b0000000; // 8
                4'b1001: Y = 7'b0010000; // 9
                4'b1010: Y = 7'b0001000; // A
                4'b1011: Y = 7'b0000011; // B
                4'b1100: Y = 7'b1000110; // C
                4'b1101: Y = 7'b0100001; // D
                4'b1110: Y = 7'b0000110; // E
                4'b1111: Y = 7'b0001110; // F
                default: Y = 7'b1000000; //default is 0 
            endcase
        end else begin
            Y = 7'b1000000; //output 0 when off 
        end
    end
endmodule