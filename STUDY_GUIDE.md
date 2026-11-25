# COE180.1: Introduction to Hardware Description Language
## Comprehensive Beginner's Study Guide (Labs 1 & 2)

**Author:** Jan Mhar De Chavez  
**Course:** COE180.1 — Introduction to Hardware Description Language  

---

## Table of Contents
1. [The Big Picture: Thinking in Hardware vs. Software](#1-the-big-picture-thinking-in-hardware-vs-software)
2. [What is an HDL Module?](#2-what-is-an-hdl-module)
3. [Signals and Data Types: Traditional Verilog vs. SystemVerilog](#3-signals-and-data-types-traditional-verilog-vs-systemverilog)
4. [The Three Modeling Styles (With Examples)](#4-the-three-modeling-styles-with-examples)
5. [Lab 1 Concepts: Basic Logic Gates](#5-lab-1-concepts-basic-logic-gates)
6. [Lab 2 Concepts: Binary Adders and Subtractors](#6-lab-2-concepts-binary-adders-and-subtractors)
7. [The 4-Bit Adder-Subtractor & Two's Complement Magic](#7-the-4-bit-adder-subtractor--twos-complement-magic)
8. [Testbenches & Simulation (Icarus Verilog + GTKWave)](#8-testbenches--simulation-icarus-verilog--gtkwave)
9. [Common Student Pitfalls & Debugging Rules](#9-common-student-pitfalls--debugging-rules)

---

## 1. The Big Picture: Thinking in Hardware vs. Software

The single most common mistake when learning Verilog or SystemVerilog is treating it like C, Java, or Python.

### Software vs. Hardware Mindset
- **In Software (C / Python):** Statements execute **sequentially, line by line**, on a single processor. If you write:
  ```c
  x = a + b;
  y = c + d;
  ```
  The CPU executes line 1 first, then line 2.
- **In Hardware Description Languages (HDL):** You are **describing physical silicon chips**. Statements describe physical logic gates, wires, and transistors that exist simultaneously on a circuit board:
  ```verilog
  assign x = a & b;
  assign y = c | d;
  ```
  Both the AND gate and the OR gate **exist concurrently in the silicon** and operate at the exact same time. If input `c` flips, output `y` changes immediately, regardless of what `x` is doing.

### The Word "Concurrent"
In HDL, almost everything outside of a `begin ... end` block happens **in parallel** (concurrently). If you swap the order of two `assign` statements or module instantiations in your file, the compiled circuit is 100% identical.

---

## 2. What is an HDL Module?

A **module** is the fundamental building block of digital design in Verilog/SystemVerilog. Think of it as a physical integrated circuit (IC) or microchip:
- It has **inputs** (pins where electricity/signals come in).
- It has **outputs** (pins where results come out).
- Inside is the **logic** (how inputs transform into outputs).

```verilog
module my_circuit (
    input  logic a, b,    // Input pins
    output logic y        // Output pin
);
    // Internal circuitry goes here
    assign y = a & b;
endmodule
```

### Port Modes
1. `input`: Read-only. Signals driven from the outside world into this module.
2. `output`: Write-only. Driven by this module to send signals out.
3. `inout`: Bidirectional (used for shared data buses, rarely needed in introductory labs).

---

## 3. Signals and Data Types: Traditional Verilog vs. SystemVerilog

### The Verilog-2001 Confusion: `wire` vs. `reg`
In traditional Verilog (Lab 1), you had to choose between two main data types:
1. `wire`: Represents a physical wire. Used for continuous assignments (`assign`) and module inputs/outputs. It cannot store any value.
2. `reg`: Required whenever a signal was assigned inside an `always` procedural block.
   - **The Trap:** The name `reg` stands for "register", but **it does NOT necessarily create a physical hardware register (flip-flop)**! In combinational logic, a `reg` synthesizes into plain copper wires and logic gates. This confused every beginner in digital design.

### The SystemVerilog-2012 Fix: `logic`
In SystemVerilog (Lab 2), the language introduces **`logic`**:
- `logic` replaces both `wire` and `reg` for 99% of single-driver scenarios.
- You can drive a `logic` signal using continuous `assign` statements **or** inside `always_comb` procedural blocks.
- **Compile-time safety:** In Verilog, if you accidentally connect two drivers to the same `wire`, it often fails silently. In SystemVerilog, connecting multiple drivers to a `logic` signal throws an immediate compile-time error.

### 4-State Logic: What Can a Signal Be?
Both Verilog and SystemVerilog use 4-state logic:
- `0`: Logic Low (0 Volts / Ground)
- `1`: Logic High (Supply Voltage, e.g. 3.3V or 5V)
- `X`: **Unknown / Conflict**. Appears when a signal hasn't been initialized, or when two conflicting sources drive the same line with `0` and `1` simultaneously.
- `Z`: **High Impedance (Floating)**. The wire is completely disconnected from power and ground (like a three-state buffer turned off).

---

## 4. The Three Modeling Styles (With Examples)

Every digital circuit can be described using three different abstraction levels.

### A. Dataflow Modeling
- **Key keyword:** `assign`
- **Idea:** Expresses signal flow using Boolean logic equations.
- **When to use:** Great for small combinational circuits where you already know the Boolean algebra equation.
- **Example (Half Adder):**
  ```verilog
  module half_adder_df (
      input  logic a, b,
      output logic sum, carry
  );
      assign sum   = a ^ b;  // XOR
      assign carry = a & b;  // AND
  endmodule
  ```

### B. Behavioral Modeling
- **Key keyword:** `always_comb begin ... end` (in SystemVerilog) or `always @(*) begin ... end` (in Verilog)
- **Idea:** Describes *what the circuit does* (functionality, algorithm, truth table decisions) using procedural statements like `if-else`, `case`, or arithmetic operators (`+`, `-`).
- **Why `always_comb` is better than `always @(*)`:**
  1. It automatically includes all inputs in its sensitivity list.
  2. It warns you if you accidentally forget a branch and infer an unwanted latch.
  3. It evaluates automatically once at simulation time $t = 0$.
- **Example (Half Adder):**
  ```verilog
  module half_adder_bh (
      input  logic a, b,
      output logic sum, carry
  );
      always_comb begin
          sum   = a ^ b;
          carry = a & b;
      end
  endmodule
  ```
- **Example with `case` (Truth Table style):**
  ```verilog
  always_comb begin
      case ({a, b})
          2'b00: {carry, sum} = 2'b00;
          2'b01: {carry, sum} = 2'b01;
          2'b10: {carry, sum} = 2'b01;
          2'b11: {carry, sum} = 2'b10;
      endcase
  end
  ```

### C. Structural Modeling
- **Key idea:** Hierarchical wiring. You do NOT write equations; you instantiate smaller components (built-in gate primitives or submodules you already made) and wire their pins together like soldering chips on a breadboard.
- **When to use:** Assembling bigger systems out of smaller verified modules (e.g. building a Full Adder from 2 Half Adders).
- **Named Port Connections (`.port(signal)`):**
  - Always connect ports by name, not by position!
  - `half_adder_df ha1 (.a(a), .b(b), .sum(s1), .carry(c1));`
  - If someone reorders ports in `half_adder_df`, your circuit will NOT break.
- **Example (Full Adder built from 2 Half Adders + OR gate):**
  ```verilog
  module full_adder_st (
      input  logic a, b, cin,
      output logic sum, cout
  );
      logic s1, c1, c2; // Internal wires connecting the blocks

      // Half Adder 1 adds a and b
      half_adder_df ha1 (
          .a(a), .b(b),
          .sum(s1), .carry(c1)
      );

      // Half Adder 2 adds intermediate sum s1 and cin
      half_adder_df ha2 (
          .a(s1), .b(cin),
          .sum(sum), .carry(c2)
      );

      // Final carry is true if either stage produced a carry
      assign cout = c1 | c2;
  endmodule
  ```

---

## 5. Lab 1 Concepts: Basic Logic Gates

| Gate | Verilog Operator | Truth Condition | Expression |
|:---:|:---:|:---|:---:|
| **AND** | `&` | Output is `1` only if **all** inputs are `1` | `y = a & b` |
| **OR** | `\|` | Output is `1` if **at least one** input is `1` | `y = a \| b` |
| **NOT** | `~` | Inverts the input (`0` becomes `1`, `1` becomes `0`) | `y = ~a` |
| **NAND** | `~&` | Inverse of AND (output is `0` only if both are `1`) | `y = ~(a & b)` |
| **NOR** | `~\|` | Inverse of OR (output is `1` only if both are `0`) | `y = ~(a \| b)` |
| **XOR** | `^` | Output is `1` if inputs are **different** (odd parity) | `y = a ^ b` |
| **XNOR** | `~^` or `^~` | Output is `1` if inputs are **identical** (equality check)| `y = ~(a ^ b)` |

### Universal Gates
**NAND** and **NOR** are called *universal gates* because any Boolean function (AND, OR, NOT, XOR, XNOR) can be constructed using only NAND gates or only NOR gates.

---

## 6. Lab 2 Concepts: Binary Adders and Subtractors

### A. Half Adder
Adds two 1-bit binary digits:
- $0 + 0 = 0$ (Sum = 0, Carry = 0)
- $0 + 1 = 1$ (Sum = 1, Carry = 0)
- $1 + 0 = 1$ (Sum = 1, Carry = 0)
- $1 + 1 = 2_{10} = 10_2$ (Sum = 0, Carry = 1)

**Key Equations:**
- `Sum   = A ^ B` (Exclusive-OR gives 1 when inputs differ)
- `Carry = A & B` (AND gives 1 only when both are 1)

### B. Full Adder
A Half Adder cannot handle an incoming carry from a previous column. A **Full Adder** adds three single bits: $A$, $B$, and $C_{in}$.

**Key Equations:**
- `Sum  = A ^ B ^ Cin` (Sum is 1 when an odd number of inputs are 1)
- `Cout = (A & B) | (Cin & (A ^ B))` (or `AB + BCin + ACin`)

**Hierarchical Insight:**
A Full Adder is literally **two Half Adders and an OR gate**:
1. First HA adds $A$ and $B$, giving intermediate sum $S_1$ and carry $C_1$.
2. Second HA adds $S_1$ and $C_{in}$, giving final $Sum$ and carry $C_2$.
3. Final $C_{out} = C_1 \text{ OR } C_2$.

### C. Half Subtractor
Computes $A - B$, producing Difference ($D$) and Borrow-out ($B_{out}$):
- $0 - 0 = 0$ ($D = 0, B_{out} = 0$)
- $0 - 1 = 1$ with borrow $1$ ($D = 1, B_{out} = 1$)
- $1 - 0 = 1$ ($D = 1, B_{out} = 0$)
- $1 - 1 = 0$ ($D = 0, B_{out} = 0$)

**Key Equations:**
- `Diff = A ^ B` (Notice Difference is identical to Sum!)
- `Bout = ~A & B` (A borrow is needed only when subtracting 1 from 0)

### D. Full Subtractor
Computes $A - B - B_{in}$.

**Key Equations:**
- `Diff = A ^ B ^ Bin`
- `Bout = (~A & B) | (Bin & ~(A ^ B))` (or `~A*B + ~A*Bin + B*Bin`)

---

## 7. The 4-Bit Adder-Subtractor & Two's Complement Magic

Instead of building separate hardware for adders and subtractors, digital computers reuse adder hardware using **Two's Complement arithmetic**.

### The Mathematical Identity
$$A - B = A + (-B) = A + (\sim B) + 1$$
In two's complement, to negate a binary number, you:
1. Invert all bits ($\sim B$, One's Complement).
2. Add 1.

### How the Hardware Implements It (Figure 2.6)
We use a single control line called `ctrl`:
- **When `ctrl = 0` (Addition mode):**
  - We pass $B$ through XOR gates with `ctrl`: $B \oplus 0 = B$ (bits stay untouched).
  - The initial carry-in $C_{in}$ of the first Full Adder connects to `ctrl` ($C_{in} = 0$).
  - Result: $A + B + 0 = A + B$.
- **When `ctrl = 1` (Subtraction mode):**
  - We pass $B$ through XOR gates with `ctrl`: $B \oplus 1 = \sim B$ (all bits are flipped!).
  - The initial carry-in $C_{in}$ connects to `ctrl` ($C_{in} = 1$).
  - Result: $A + (\sim B) + 1 = A - B$.

This is one of the most elegant designs in computer engineering: **one extra wire and 4 XOR gates turn an adder into an adder-subtractor unit**.

---

## 8. Testbenches & Simulation (Icarus Verilog + GTKWave)

A **testbench** is a Verilog file that has **no inputs and no outputs**. It is a simulation sandbox designed to:
1. Instantiate your design under test (DUT).
2. Generate input test stimuli over time.
3. Observe and print outputs to verify correctness.

### Anatomy of a Clean SystemVerilog Testbench
```verilog
`timescale 1ns / 1ps   // Time unit = 1ns, Time precision = 1ps

module half_adder_tb;
    logic a, b;
    logic sum, carry;

    // 1. Instantiate the DUT using wildcard connection
    // (Automatically matches signals by identical name)
    half_adder_df dut(.*);

    initial begin
        // 2. Setup waveform dumping for GTKWave
        $dumpfile("sim/half_adder_tb.vcd");
        $dumpvars(0, half_adder_tb); // 0 = dump all signals recursively

        // 3. Setup console monitoring
        $display("Testing Half Adder");
        $monitor("Time=%0t, a=%b, b=%b, sum=%b, carry=%b",
                 $time, a, b, sum, carry);

        // 4. Apply test vectors using a loop
        for (int i = 0; i < 4; i++) begin
            {a, b} = i;  // Concatenation: assigns lower 2 bits of i to a and b
            #10;         // Wait 10 ns of simulation time
        end

        // 5. End simulation
        $finish;
    end
endmodule
```

### The Terminal Commands Explained
1. **Compile with Icarus Verilog:**
   ```bash
   iverilog -g2012 -o sim/half_adder_tb.vvp tb/half_adder_tb.v src/half_adder_df.v
   ```
   - `-g2012`: Enables SystemVerilog-2012 features (`logic`, `always_comb`, `.*`).
   - `-o <file>`: Specifies the output executable file name. If you omit `-o`, it defaults to `a.out`!
   - `tb/....v src/....v`: All source files needed for the design.

2. **Run Simulation Engine (`vvp`):**
   ```bash
   vvp sim/half_adder_tb.vvp
   ```
   - Executes the compiled bytecode.
   - Prints `$monitor` and `$display` lines in the terminal.
   - Writes signal transitions into the `.vcd` (Value Change Dump) file.

3. **Inspect Waveforms (`gtkwave`):**
   ```bash
   gtkwave sim/half_adder_tb.vcd
   ```
   - Opens the visual GUI.
   - Under the SST panel (top-left), click your testbench.
   - Select signals and click **Append** to see the digital traces transition over time.

---

## 9. Common Student Pitfalls & Debugging Rules

1. **Forgetting `-g2012`:**
   - Error: `syntax error` on lines containing `logic` or `always_comb`.
   - Fix: Always pass `-g2012` to `iverilog` when working with SystemVerilog.

2. **Unwanted Latch Creation:**
   - In combinational logic, if you write an `if` without an `else`, the synthesizer assumes: *"if condition is false, keep the old value"*. That creates a physical latch (memory element), which is sequential, not combinational!
   - Fix: Always assign values to all outputs in all branches, or use `always_comb` which alerts you of inferred latches.

3. **Primitives Net Requirement:**
   - Verilog gate primitives (`xor`, `and`, `or`, `not`) cannot drive a `logic` variable directly if declared as `output logic`.
   - Fix: Use `output wire` for modules that use built-in gate primitives, or build higher-level modules by instantiating submodules using `.port(name)`.

4. **Missing Submodule Files during Compilation:**
   - Error: `Unknown module type: half_adder_df`.
   - Cause: When compiling a structural file (like `full_adder_st.v`), you must also give `iverilog` the file that defines the child module (`half_adder_df.v`).

5. **Concatenation `{a, b}` Trick:**
   - In testbenches, `{a, b} = i;` groups bits together.
   - If `i = 0` $\rightarrow$ `a=0, b=0`
   - If `i = 1` $\rightarrow$ `a=0, b=1`
   - If `i = 2` $\rightarrow$ `a=1, b=0`
   - If `i = 3` $\rightarrow$ `a=1, b=1`
   - This lets you test all $2^N$ combinations in a simple `for` loop without typing repetitive lines.

---

*Keep this guide handy! Everything in future labs (multiplexers, decoders, ALUs, registers, counters, finite state machines) builds directly upon these exact same fundamentals.*
