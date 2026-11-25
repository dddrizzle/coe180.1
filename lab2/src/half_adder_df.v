// Half Adder - Dataflow Modeling Style
// Uses continuous assignments with logic data type
module half_adder_df (
    input  logic a, b,
    output logic sum, carry
);
    // Boolean logic for half adder
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule
