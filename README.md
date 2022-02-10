# RISC-V soft processor core for Intel Cyclone V FPGAs

<!-- ![version_badge](https://img.shields.io/badge/version-ALPHA-green) -->

![status_badge](https://img.shields.io/badge/status-under%20development-orange?style=for-the-badge)
![last_commit_badge](https://img.shields.io/github/last-commit/Al3bad/rv32i-cpu-cyclonev-fpga/v2?style=for-the-badge)

## Project Description

This is a RISC-V soft processor designed that can be deployed to Cyclone-V FPGA that is found on the [DE10-Nano Development Board](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=1) from Terasic.

## Info

- Tested on DE10-Nano Board revision C.
- System configurations:
  - HPS - Eanbled
  - CLOCK - Enabled
  - HDMI TX - Enabled (not used)
  - x8 LED - Eanbled
  - x4 SWITCH - Eanbled (not used)
  - x2 BUTTON - Enabled
  - GPIO-0 Headers - Enabled
  - GPIO-1 Headers - Enabled
  - ADC Header - Disabled
  - Arduino Header - Disabled

## TODO:

- [ ] Use the built-in physcial RAM on the board as the main memory for data.
  - [ ] Configure the HPS to use 32-bit width for data & address.
  - [ ] Generate the proper bootloader to configure the RAM controller that is connected to the HPS.
- [ ] Support R type instructions.
- [ ] Support I type instructions.
- [ ] Support S type instructions.
- [ ] Support U type instructions.
