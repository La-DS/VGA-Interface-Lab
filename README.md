# VGA-Interface-Lab

## Overview
This was one of the labs from my Embedded Systems class. The goal of the lab was to create a working VGA interface to display a static image on an LCD monitor. The image is a Rutgers logo cropped to 480x480 pixels using a provided Matlab program. Note that when testing this with a VGA monitor, it may be necessary to manually adjust the Pixel Clock and Phase settings to get a clean image.

## Software
All of the programming was done in VHDL using Vivado. There are four top-level components in this design: `clock_div`, `picture`, `vga_ctrl`, and `pixel_pusher`.

### `clock_div`
The `clock_div` module divides the 125 MHz clock signal `clk` to a 25 MHz clock signal `div`. The `div` signal serves as the clock signal for `picture`, but also controls the enable of the `vga_ctrl` and `pix_pusher` modules. The clock divider is necessary for proper VGA signal timing to ensure a clean image can be displayed.

### `picture`
This module is a ROM storing the image data and was generated with the Xilinx Memory Block IP. I first converted the logo image file into a COE file using a provided Matlab program, then used said COE file to generate the IP. Because this file was generated, the file in the repository is a `.xci` file instead of a typical `.vhd` file. 

### `vga_ctrl`
This module generates the horizontal sync and vertical sync signals necessary for proper VGA timing. It also outputs an `hcount` signal for the `pix_pusher` module to help control the changes in the `vga_r`, `vga_g`, and `vga_b` signals.

### `pix_pusher`
The `pix_pusher` takes in the raw data from the `picture` module and outputs the appropriate `vga_r`, `vga_g`, and `vga_b` signals, as well as generates the next address for the `picture` module to access the next byte of data. Depending on the `vid`, `vs`, and `hcount` signals, the `pix_pusher` either outputs a pixel from the `picture` module or outputs a black pixel.

### Other Files
In addition to the files used for the modules, the repository also contains the following:
- `BITSTREAM.bit`: A ready bitstream file that can be written to a legacy Zybo using AMD Vivado to test the VGA interface
- `Lab4_constraints_zybo_old_board.xdc`: A constraints file that defines which pins of the FPGA are used

## Top-level Schematic

## Demo
Demo materials are in the `Demo` directory in this repository. 

## Hardware & Software Used
- Digilent Zybo (Legacy)
- AMD Vivado 2025.01
