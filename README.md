# 8-Bit Ripple Carry Counter 

### RTL Design | Sequential Logic | T Flip-Flop | Functional Verification

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![Counter](https://img.shields.io/badge/Architecture-8--Bit%20Ripple%20Counter-green)
![VCS](https://img.shields.io/badge/Simulation-Synopsys%20VCS-orange)
![Verdi](https://img.shields.io/badge/Debugging-Synopsys%20Verdi-purple)
![Verification](https://img.shields.io/badge/Verification-Functional%20Testing-success)

---

## 1. Project Overview

This project presents the RTL design and functional verification of an **8-Bit Ripple Carry Counter** using Verilog Hardware Description Language (HDL).

A ripple counter is a sequential digital circuit in which multiple flip-flops are connected in cascade. Each flip-flop toggles based on the output transition of the preceding flip-flop.

The design implements an 8-bit asynchronous ripple counter using T Flip-Flop functionality realized through D Flip-Flops with inverted feedback.

The first flip-flop is driven by the external clock, while the output of each subsequent flip-flop acts as the clock input for the next stage.

An asynchronous active-high reset is used to initialize the counter to zero.

The RTL design is simulated using **Synopsys VCS**, and waveform visualization and debugging are performed using **Synopsys Verdi**.

## 2. Design Specifications

| Parameter | Description |
|---|---|
| Project Name | 8-Bit Ripple Carry Counter |
| Design Type | Sequential Logic |
| Architecture | Asynchronous Ripple Counter |
| Counter Width | 8-bit |
| Number of Flip-Flops | 8 |
| Flip-Flop Implementation | T Flip-Flop using D Flip-Flop |
| Clock Trigger | Negative-edge triggered |
| Reset | Asynchronous active-high |
| Output | 8-bit binary count |
| Counting Range | 0 to 255 |
| HDL | Verilog |
| Simulator | Synopsys VCS |
| Waveform Viewer | Synopsys Verdi |
| Waveform Format | VCD / FSDB |

## 3. Counter Architecture

The design consists of eight cascaded T Flip-Flops.

Each T Flip-Flop toggles its output whenever a negative edge occurs at its clock input.

The first flip-flop receives the external clock signal. The output of each flip-flop is connected to the clock input of the next flip-flop.

### 3.1 Block-Level Architecture

```text
             External Clock
                   |
                   v
              +---------+
              |  TFF 0  |
              |   Q0    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 1  |
              |   Q1    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 2  |
              |   Q2    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 3  |
              |   Q3    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 4  |
              |   Q4    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 5  |
              |   Q5    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 6  |
              |   Q6    |
              +---------+
                   |
                   v
              +---------+
              |  TFF 7  |
              |   Q7    |
              +---------+

          8-Bit Counter Output
             Q[7:0]
```

Each flip-flop is connected in cascade, allowing the counter to increment through successive binary values.

## 4. T Flip-Flop Implementation

The T Flip-Flop functionality is implemented using a D Flip-Flop with inverted output feedback.

The D input is connected to the complement of the present output.

### 4.1 Boolean Equation

\[
D = \overline{Q}
\]

The next-state equation is:

\[
Q_{next} = \overline{Q}
\]

Therefore, the output toggles whenever the triggering clock edge occurs.

### 4.2 D Flip-Flop

The D Flip-Flop is implemented using an asynchronous active-high reset.

```verilog
always @(negedge clk or posedge rst)
    if (rst)
        q <= 1'b0;
    else
        q <= d;
```

### 4.3 T Flip-Flop

The T Flip-Flop is constructed by connecting the inverted output back to the D input.

```verilog
wire din;
dff dff0 (q, qb, din, clk, rst);
not n1(din, q);
```

This configuration makes the flip-flop toggle at every negative edge of its clock input.

## 5. Ripple Counter Operation

The counter consists of eight T Flip-Flops connected in cascade.

- The first flip-flop receives the external clock.
- The second flip-flop receives Q0 as its clock.
- The third flip-flop receives Q1 as its clock.
- This connection continues up to the eighth flip-flop.
- Each stage toggles on the negative edge of the preceding stage output.

### 5.1 Counting Sequence

The counter generates an 8-bit binary counting sequence.

| Decimal Count | Binary Output Q[7:0] |
|---:|---|
| 0 | 00000000 |
| 1 | 00000001 |
| 2 | 00000010 |
| 3 | 00000011 |
| 4 | 00000100 |
| 5 | 00000101 |
| 6 | 00000110 |
| 7 | 00000111 |
| 8 | 00001000 |
| 9 | 00001001 |
| ... | ... |
| 255 | 11111111 |

After reaching 255, the counter rolls over to 0 on the next count.

### 5.2 Counting Range

The total number of possible states is:

\[
N = 2^n
\]

For an 8-bit counter:

\[
N = 2^8 = 256
\]

Therefore, the counter operates from:

\[
0 \text{ to } 255
\]

## 6. Reset Operation

The design uses an asynchronous active-high reset.

The reset signal is connected to all eight flip-flops.

When reset is asserted HIGH, all flip-flop outputs are immediately cleared to zero, independent of the clock.

```verilog
always @(negedge clk or posedge rst)
    if (rst)
        q <= 1'b0;
    else
        q <= d;
```

After reset is deasserted, the counter starts counting from zero.

## 7. RTL Module Description

**Top Module Name:** `ripple_carry_counter_8bit`

### 7.1 Module Hierarchy

| Module | Function |
|---|---|
| `dff` | Implements negative-edge-triggered D Flip-Flop with asynchronous reset |
| `tff` | Implements T Flip-Flop using inverted feedback |
| `ripple_carry_counter_8bit` | Connects eight T Flip-Flops to implement the counter |
| `bit8rcc_tb` | Testbench for functional verification |

### 7.2 Input and Output Ports

| Port | Direction | Width | Description |
|---|---|---|---|
| q | Output | 8-bit | Binary counter output |
| clk | Input | 1-bit | External clock |
| rst | Input | 1-bit | Asynchronous active-high reset |

### 7.3 Internal Connections

| Signal | Description |
|---|---|
| din | Inverted feedback input to the D Flip-Flop |
| qb | Complementary output port declared in the DFF module |
| q[0] | First flip-flop output |
| q[7] | Final flip-flop output |

## 8. Repository Structure

```text
8-bit-ripple-counter/
│
├── ripple_carry_counter_8bit.v
│   └── DFF, TFF and 8-bit counter RTL
│
├── bit8rcc_tb.v
│   └── Verilog testbench
│
├── screenshots/
│   └── verdi_waveform.png
│
├── README.md
│
└── .gitignore
```

## 9. Functional Verification

A Verilog testbench is developed to verify the functionality of the 8-bit ripple counter.

The testbench generates a clock signal with a 10 ns period and applies an active-high reset.

The counter output is monitored during simulation using the `$monitor` system task.

### 9.1 Testbench Configuration

| Parameter | Value |
|---|---|
| Clock Period | 10 ns |
| Clock Frequency | 100 MHz |
| Clock Generation | `forever #5 clk = ~clk` |
| Clock Trigger | Negative edge |
| Reset Type | Asynchronous active-high |
| Initial Reset | HIGH |
| Reset Deassertion | After 5 ns |
| Simulation Duration | 100 ns |

### 9.2 Test Scenarios

| Test Case | Operation | Expected Behavior |
|---|---|---|
| TC1 | Reset asserted | Counter output becomes 00000000 |
| TC2 | Reset deasserted | Counter starts counting |
| TC3 | Clock transitions | Counter increments through binary values |
| TC4 | Multiple clock cycles | Cascaded flip-flops toggle correctly |
| TC5 | Continued counting | Counter maintains the correct binary sequence |

### 9.3 Expected Simulation Output

The counter starts from zero and increments on successive negative clock edges.

Example:

```text
Time=0  Q=00000000 CLK=0 reset=1
Time=5  Q=00000000 CLK=1 reset=0
Time=10 Q=00000001 CLK=0 reset=0
Time=20 Q=00000010 CLK=0 reset=0
Time=30 Q=00000011 CLK=0 reset=0
Time=40 Q=00000100 CLK=0 reset=0
```

The exact printed timestamps and intermediate values depend on simulation scheduling and waveform observation.

## 10. Simulation Using Synopsys VCS

Synopsys VCS is used to compile and simulate the Verilog RTL design and testbench.

### 10.1 Compilation

Compile the RTL and testbench files using:

```bash
vcs -full64 -debug_access+all \
ripple_carry_counter_8bit.v \
bit8rcc_tb.v \
-o simv
```

### 10.2 Execute Simulation

```bash
./simv
```

The simulation executes the testbench and displays counter values using `$monitor`.

### 10.3 VCD Waveform Generation

The current testbench uses VCD dump commands:

```verilog
initial begin
    $dumpfile("8bitrcc.vcd");
    $dumpvars(0, bit8rcc_tb);
end
```

This generates a VCD waveform database containing the counter signals.

### 10.4 FSDB Waveform Generation

For FSDB waveform generation, replace the VCD commands with:

```verilog
initial begin
    $fsdbDumpfile("8bitrcc.fsdb");
    $fsdbDumpvars(0, bit8rcc_tb);
end
```

Ensure the appropriate Verdi FSDB PLI integration is configured during VCS compilation.

### 10.5 Open Waveform in Synopsys Verdi

For FSDB:

```bash
verdi -ssf 8bitrcc.fsdb &
```

For VCD, the waveform can also be opened using:

```bash
verdi -vcd 8bitrcc.vcd &
```

## 11. Waveform Analysis Using Synopsys Verdi

Synopsys Verdi is used to visualize and analyze the simulation waveforms.

The following signals are observed:

| Signal | Description |
|---|---|
| clk | External clock signal |
| rst | Asynchronous active-high reset |
| q[7:0] | 8-bit counter output |
| q[0] | Least significant counter bit |
| q[7] | Most significant counter bit |

Waveform analysis helps verify:

- Clock signal generation.
- Asynchronous reset functionality.
- Negative-edge-triggered operation.
- Binary counting sequence.
- Cascaded flip-flop operation.
- Correct ripple counter behavior.
- Counter output transitions.

### Simulation Waveform

![8-Bit Ripple Counter Verdi Waveform](screenshots/verdi_waveform.png)

*Synopsys Verdi waveform showing the 8-bit counter output, clock, and reset signals.*

## 12. Tools and Technologies

| Tool / Technology | Application |
|---|---|
| Verilog HDL | RTL design implementation |
| Synopsys VCS | RTL compilation and simulation |
| Synopsys Verdi | Waveform visualization and debugging |
| VCD / FSDB | Simulation waveform database |
| Git | Version control |
| GitHub | Project hosting and documentation |

## 13. Key Learning Outcomes

Through this project, the following concepts are explored:

- Sequential digital circuit design.
- D Flip-Flop implementation.
- T Flip-Flop implementation.
- Inverted feedback logic.
- Negative-edge-triggered sequential circuits.
- Asynchronous reset implementation.
- Ripple counter architecture.
- Cascaded flip-flop connections.
- Binary counting operation.
- Verilog structural modeling.
- Testbench development.
- Functional verification.
- RTL simulation using Synopsys VCS.
- Waveform debugging using Synopsys Verdi.
- VCD and FSDB waveform generation.

## 14. Future Enhancements

Potential extensions to this project include:

- Implementing 4-bit and 16-bit ripple counters.
- Designing synchronous binary counters.
- Comparing synchronous and asynchronous counters.
- Implementing up/down counters.
- Developing modulo-N counters.
- Performing RTL synthesis and area analysis.
- Analyzing propagation delay across cascaded flip-flops.
- Comparing ripple counters with synchronous counters.

## 15. Author

**SANTHOSH KUMAR N A**

RTL Design | Digital Electronics | VLSI Engineering

- GitHub: [Your GitHub Profile](https://github.com/your-username)
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/your-profile)

## 16. License

This project is intended for educational and learning purposes.

Feel free to explore, modify, and extend the implementation with appropriate attribution.

---

<p align="center">
  <b>Designed with Verilog HDL | Simulated using Synopsys VCS | Debugged using Synopsys Verdi</b>
</p>

<p align="center">
  ⭐ If you find this project useful, consider giving the repository a star!
</p>

---

### GitHub Topics

`verilog` `ripple-counter` `8-bit-counter` `digital-electronics` `digital-design` `t-flip-flop` `d-flip-flop` `sequential-logic` `rtl-design` `vlsi` `synopsys-vcs` `synopsys-verdi` `waveform-analysis` `rtl-verification`
