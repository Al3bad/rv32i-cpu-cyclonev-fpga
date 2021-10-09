# RISC-V soft processor core for Intel Cyclone V FPGAs

https://img.shields.io/badge/version-ALPHA-green

## Project Description

This is RISCV soft processor designed that can be deployed to Cyclone-V FPGA. The hardware tool that is was used for testing is [DE10-Nano development kit](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=1) from Terasic.

## Current State

This is a fourth year capstone project and this project is not 100% complete. One of the aims is to perform read & write operation to the physical SDRAM that is on DE10-NANO board. While this is implemented in the design, the behaviour of the memory access operations (on hardware) is not correct. I spent hours trying to fix this problem but I stopped due to the time constrains to work on this project the limited hardware testing tools.

Other that the memory access operations, the processor should be able to execute the base 32-bit RISCV instructions. This project is considered in version ALPHA so you may encounter bugs

## Prepare the Project & Deploy the Design

1. The Quartus project can be found in `quartus-project` folder, open the `RISCV_CPU_FPGA.qpf` file
2. To initialise the ROM with RISCV instructions, follow these steps:
    1. Make sure you have `.mif` file in the `quartus-project` directory. (to compline the instructions, follow the steps in the next section)
    2. Open `CPU_pipelined.bdf` file
    3. Right-click on `rom` modules, then properties
    4. Add the full path of the `.mif` in the `INSTRUCTIONS_INIT_FILE` parameter.
3. Click on the "Start Compilation" button from the tool bar, or use the shortcut `Ctrl+L`.
4. Before deploying the design to the board, make sure you the BootLoader image from Terasic is written in the SD Card to initialise the SDRAM controller properly.
5. Open the "Programmer" window by navigating to Tools -> Programmer.
6. Make sure you have your DE10-Nano board connected to your computer
7. Select the FPGA chip, then click on "Add File" or "Change File".
8. Select the `.sof` file from the project directory. Most likely named `RISCV_CPU_FPGA.sof`
9. Click on Start button.

## Compile the RISC-V Instructions

NOTE: Windows users should have a program that can run bash scripts e.g. [git](https://git-scm.com/downloads) in order to run `assemble-inst.sh` file

1. Download [RARS](https://github.com/TheThirdOne/rars/releases/tag/continuous) tool from github and place the `.jar` file in the root directory of this project
1. Write your RISCV instructions in `code.s` file.
2. Run `assemble-inst.sh`

## Write the Bootloader Image to the SD Card

...