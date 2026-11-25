// Top-level wrapper for DE1-SoC FPGA board
// Maps 4-bit universal shift register (univ_shift4) to physical switches, buttons, and LEDs
module top_lab7 (
  input  logic [9:0] SW,   // SW[1:0]=mode, SW[2]=sin, SW[6:3]=d[3:0]
  input  logic [3:0] KEY,  // KEY[0]=rst_n, KEY[1]=manual clock
  output logic [9:0] LEDR  // LEDR[3:0]=q, LEDR[7:4]=~q, LEDR[8]=0, LEDR[9]=clk
);

  logic clk;
  logic [3:0] q_reg;

  // KEY buttons are active-low and debounced on DE1-SoC
  // Inverting KEY[1] creates a rising edge when pressed
  assign clk = ~KEY[1];

  // TODO 1: Instantiate univ_shift4 (u_usr) and connect all ports
  univ_shift4 u_usr (
    .clk       (clk),
    .rst_n     (KEY[0]),
    .mode      (SW[1:0]),
    .sin_left  (SW[2]),
    .sin_right (SW[2]),
    .d         (SW[6:3]),
    .q         (q_reg)
  );

  // TODO 2: Assign LEDR[3:0], LEDR[7:4], LEDR[8], and LEDR[9]
  // LEDR[3:0] = q_reg[3:0] (True register output)
  // LEDR[7:4] = ~q_reg[3:0] (Bitwise complement)
  // LEDR[8]   = 1'b0 (Unused spacer LED)
  // LEDR[9]   = clk (Manual clock monitor: lights while KEY[1] is pressed)
  assign LEDR = {clk, 1'b0, ~q_reg[3:0], q_reg[3:0]};

endmodule
