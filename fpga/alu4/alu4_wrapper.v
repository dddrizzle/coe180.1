// DE1-SoC FPGA Wrapper for 4-bit ALU
module alu4_wrapper (
    input  wire [8:0] SW,   // SW[8:5] = A, SW[4:1] = B, SW[0] = Cin
    input  wire [3:0] KEY,  // Push buttons: KEY[1:0] = Op, KEY[2] = Mode
    output wire [6:0] HEX0, // 7-segment display for ALU result F
    output wire       LED0  // LED for carry-out Cout
);

    wire [3:0] A;
    wire [3:0] B;
    wire       Cin;
    wire [3:0] F;
    wire       Cout;

    // input mappings from switches
    assign A   = SW[8:5];
    assign B   = SW[4:1];
    assign Cin = SW[0];

    // instantiate 4-bit ALU
    alu4 uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Operation(~KEY[1:0]),
        .Mode(~KEY[2]),
        .F(F),
        .Cout(Cout)
    );

    // instantiate 7-segment decoder
    hexTo7Seg de1soc (
        .hex_input(F),
        .seven_seg_out(HEX0)
    );

    // map carry out to LED0
    assign LED0 = Cout;

endmodule

