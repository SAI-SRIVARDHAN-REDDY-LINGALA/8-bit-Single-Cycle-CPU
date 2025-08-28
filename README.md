# 🚀 8-bit Single-Cycle CPU (Verilog HDL)

## 📌 Overview

This project implements a **simple 8-bit Single-Cycle CPU** using **Verilog HDL**.
The CPU is based on a **Harvard Architecture** (separate instruction and data memory) and supports a **custom instruction set** with arithmetic, logical, memory, and control operations.

The design is modular, meaning each block (ALU, Register File, Control Unit, Memories, etc.) is built as a separate module and then integrated at the top-level CPU.
This makes the CPU easy to understand, debug, and extend.

---

## 🎯 Key Features

* **8-bit architecture** (data path width = 8 bits).
* **Single-cycle execution** (one instruction executes per clock cycle).
* **Harvard architecture**: separate instruction and data memories.
* **Custom Instruction Set**:

  * Arithmetic: `ADD`, `SUB`, `ADDI`
  * Logical: `AND`
  * Memory: `LOAD`, `STORE`
  * Control: `JMP`, `HALT`
* **Register File**: 4 general-purpose registers (R0–R3).
* **Instruction width**: 16 bits (opcode + operands + immediate).
* **Supports immediate values & memory addressing**.
* **HALT instruction**: gracefully stops CPU execution.

---

## 🧩 Architecture & Modules

### 1. **ALU (Arithmetic Logic Unit)**

* Performs arithmetic (`ADD`, `SUB`) and logical (`AND`) operations.
* Supports **pass-through** for memory address calculation (LOAD/STORE).
* Generates a **zero flag** (useful for branching in future extensions).

### 2. **Register File**

* Contains **4 general-purpose registers (R0–R3)**.
* Supports **asynchronous read** (fast reads) and **synchronous write** (safe updates on clock edge).
* Used for storing temporary values, results, and operands.

### 3. **Control Unit**

* Decodes the **4-bit opcode**.
* Generates control signals:

  * `reg_write_en` → enables register writes
  * `mem_write_en` → enables memory writes
  * `jump_en` → controls jumps
  * `alu_src_b_is_imm` → selects between register/immediate operand
  * `alu_op` → tells ALU which operation to perform
  * `halt` → stops execution when `HALT` instruction is encountered

### 4. **Instruction Memory (ROM)**

* Stores program instructions (preloaded).
* Addressed by the **Program Counter (PC)**.
* Outputs a 16-bit instruction each cycle.

### 5. **Data Memory (RAM)**

* 256 bytes of storage.
* Used for `LOAD` and `STORE` instructions.
* Example: loading from memory to a register, or saving register data to memory.

### 6. **Program Counter (PC)**

* Holds the address of the current instruction.
* Normally increments sequentially.
* Can **jump** to a new address when `JMP` instruction is executed.

### 7. **Top-Level CPU**

* Connects all modules together.
* Manages instruction fetch → decode → execute → memory → write-back in a single cycle.
* Supports halting execution via the `HALT` signal.

### 8. **Testbench**

* Simulates the CPU with a clock and reset.
* Monitors register values, PC, and instructions.
* Dumps signals into a VCD file for viewing in GTKWave.
* Stops automatically when HALT instruction is reached.

---

## 📜 Instruction Format (16-bit)

Each instruction is **16 bits wide**:

```
[15:12]   Opcode
[11:10]   Destination Register (Rd)
[9:8]     Source Register (Rs)
[7:0]     Immediate Value / Memory Address
```

Example:

* `0101_00_00_00000101` → `ADDI R0, 5`
* `0011_01_10_00000000` → `ADD R1, R2`

---

## ⚙️ Execution Cycle (Single-Cycle CPU)

Every instruction executes in **one clock cycle**:

1. **Fetch** → PC fetches instruction from Instruction Memory.
2. **Decode** → Control Unit decodes opcode & generates signals.
3. **Read Operands** → Register File provides operand data.
4. **Execute** → ALU performs computation (or calculates memory address).
5. **Memory Access** → For LOAD/STORE instructions.
6. **Write Back** → Result written back to Register File.
7. **PC Update** → Increment PC or jump to new address.

---

## 📊 Advantages of This Design

* **Simplicity** → Easy to understand fundamental CPU concepts.
* **Extensible** → New instructions (like OR, XOR, BEQ, etc.) can be added.
* **Educational Value** → Demonstrates how real CPUs work at the hardware level.
* **Harvard Architecture** → Parallel instruction fetch & data memory access.

---

## 🔮 Possible Extensions

* Add **branch instructions** (`BEQ`, `BNE`).
* Implement **pipelines** for multi-stage execution.
* Increase register count (R0–R7, R0–R15).
* Add **I/O ports** for external communication.
* Support **interrupts** and exception handling.

---

## 🖥️ Simulation & Testing

* Written in **Verilog HDL**.
* Simulated using **Icarus Verilog + GTKWave**.
* Testbench provides:

  * Register dump after each cycle.
  * PC, opcode, and instruction tracking.
  * Automatic termination on `HALT`.

---

## 📷 Example Output

During simulation, you’ll see execution traces like:

```
Time    PC  Instr   Opcode  R0  R1  R2  R3
10      00  5105    5       05  00  00  00
20      01  520A    5       05  0A  00  00
30      02  3300    3       05  0F  00  00
...
CPU halted at time 100, PC=05
```

---

## 🧠 What You’ll Learn

* How **instructions are encoded and decoded**.
* How a CPU executes **arithmetic, logical, memory, and control** operations.
* Importance of **registers, ALU, and program counter**.
* How hardware is simulated using Verilog & waveform viewers.

---

## 🌟 Conclusion

This project is a **foundation-level CPU** that brings together key computer architecture concepts — instruction set design, ALU operations, register management, control signals, and memory access — into a compact yet powerful 8-bit single-cycle implementation.

It acts as a **miniature version of real processors**, making it perfect for learning, teaching, and future research extensions.

---

Sai, do you want me to also add a **diagram/flowchart of the CPU architecture** (data path + control signals) into the README so it looks even more “god level”?
