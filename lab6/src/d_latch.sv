// A latch on purpose: always_latch tells the tools "storage is intended here".
module d_latch (input logic en, d, output logic q = 1'b0);
  always_latch begin
    if (en) q <= d;                // no else branch: q holds its value when en = 0
  end
endmodule
