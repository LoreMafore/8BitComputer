# 8-Bit Computer — FPGA Implementation (Ben Eater Design)

![Verilog](https://img.shields.io/badge/HDL-Verilog-orange)
![FPGA](https://img.shields.io/badge/FPGA-Intel%20Cyclone%2010%20LP-0071C5?logo=intel&logoColor=white)
![Toolchain](https://img.shields.io/badge/Toolchain-Quartus%20Prime-0071C5?logo=intel&logoColor=white)
![Course](https://img.shields.io/badge/Course-CSC%20457%20Hardware%20Programming-blue)

A Verilog FPGA implementation of Ben Eater's classic 8-bit breadboard computer, built for **CSC 457: Hardware Programming**. Rather than relying purely on discrete 74-series TTL logic chips, the core computational units were re-implemented in Verilog and synthesized onto a physical FPGA board — which then interfaces directly with the breadboard hardware via header pin connections.

<img width="4284" height="5712" alt="8-Bit Computer Build" src="https://github.com/user-attachments/assets/1c5f3cd1-689f-4525-89a7-baa90a2553c5" />

---

## Overview

Ben Eater's 8-bit computer is a well-known educational project that builds a functional CPU from scratch using breadboards and logic chips. This project takes the architecture as a foundation and migrates the programmable components into Verilog HDL, demonstrating how the same low-level concepts — bus arbitration, synchronous resets, and register control signals — map from physical chips to an FPGA fabric.

The FPGA sits alongside the physical breadboard, with its output pins wired directly into the bus and control lines of the hardware build.

---

## Hardware

| Component | Details |
|-----------|---------|
| **FPGA** | Intel Cyclone 10 LP (`10CL025YU256I7G`) |
| **Toolchain** | Intel Quartus Prime |
| **Bus Width** | 8-bit shared bus |
| **Interface** | Pin-mapped header connections to physical breadboard |

---

## Implemented Modules

### `binary_counter.v` — Program Counter
A 4-bit synchronous counter that drives the lower nibble of the 8-bit bus. Supports:
- **Enable** (`counter_enable`) — toggles counting on/off
- **Out** (`counter_out`) — drives the current PC value onto the bus
- **In** (`counter_in`) — loads a value from the bus (for jumps)
- **Clear** (`counter_clear`) / **Reset** — zeroes the counter
- **LEDs** — 4 LEDs display the current PC value in binary

### `alu.v` — Arithmetic Logic Unit + Registers A & B
An 8-bit ALU with two general-purpose registers. Supports:
- **A In / A Out** — load or drive Register A on the bus
- **B In / B Out** — load or drive Register B on the bus
- **ALU Out** (`alu_flag`) — drives the computed result onto the bus
- **Subtract** (`b_sub`) — selects addition (`A + B`) or subtraction (`A - B`)
- Combinational result, latched into registers on the rising clock edge

### `computer.v` — Top-Level Module
Wires the Program Counter and ALU together through the shared 8-bit bus. Control signals are driven via active-low switch inputs mapped to FPGA pins.

---

## Project Structure

```
8BitComputer/
├── computer.v          # Top-level module — bus and control wiring
├── binary_counter.v    # Program Counter (4-bit, Bus-interfaced)
├── alu.v               # ALU with Registers A & B (8-bit add/subtract)
├── computer.qpf        # Quartus project file
├── computer.qsf        # Pin assignments and device settings
├── computer.csv        # Signal export
├── output_files/       # Synthesis and fitting reports
└── simulation/         # Questa simulation output
```

---

## What Was Completed

- [x] 8-bit shared bus architecture
- [x] Program Counter (binary counter with load, enable, and output)
- [x] Register A and Register B
- [x] ALU (8-bit addition and subtraction)
- [x] RAM module
- [x] Clock
- [x] Memory Address Register (MAR)

## What Remains

- [ ] Output Register
- [ ] Instruction Register
- [ ] Control logic / microcode decoder
- [ ] Full instruction set execution

---

## Deployment

1. Open `computer.qpf` in **Intel Quartus Prime**
2. Compile the project (Processing → Start Compilation)
3. Assign pins via `computer.qsf` to match your breadboard header connections
4. Flash `output_files/computer.sof` to the FPGA via the Programmer tool
5. Wire the FPGA header pins to the corresponding lines on the breadboard bus
