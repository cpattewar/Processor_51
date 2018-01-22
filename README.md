# Processor_51


Summary:
- Processor_51 is a 32bit Processor designed completely using VHDL
- The processor has a specialized Instruction Set Algorithm and supports both sequential and concurrent processing
- We have implemented the RC5 Encryption, Decryption and Key Generation using the instructions of this ISA
- final working code and report are in folder FINAL DELIVERABLES

Hardware Used:
- Board: Digilent Nexys 4 DDR Board
- Family: Artix 7
- Device: XC7A100T
- Package: CSG324
- Speed Grade : -1 

Software Used:
- VHDL Modelling: Xilinx ISE Project Navigator Purpose 
- Programming the FPGA: Digilent Adept
- Assembler: Python 2.7

Processor Specs:
- Speed: 83.918 MHz
- Instruction per Cycle (IPC): 1 instruction
- Instruction per Second (IPS): 83.918 Million
- ALU Operations: Arithmetic: add, subtract | Logical: or, nor, and | Compare: bne, beq, blt | Shift: shl, shr
- ISA: 3 address
- Instruction Length: 32bits
- Instruction Memory: 2 KB
- Register File: 32 32bit Registers
- Data Memory: 2 KB
- Assembler(Convert Assembly to Machine Code): Yes
