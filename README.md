# ICC2_COMPILER_VSDBABYSoC






## Table of Contents

  * [Introduction](##introduction-to-the-vsdbabysoc)
       + [ VSDBABYSoC](#vsdbabysoc)

  * [ICC2 COMPILER](#openlane-flow)
 
* [Acknowledgements](#acknowledgements)
* [References](#references)



# VSDBabySoC

VSDBabySoC is a small SoC including PLL, DAC, and a RISCV-based processor named RVMYTH.

![image](https://user-images.githubusercontent.com/55539862/189318328-db0fbdfe-fd84-432b-9262-a8171f91658c.png)


# Introduction to the VSDBabySoC

VSDBabySoC is a small yet powerful RISCV-based SoC. The main purpose of designing such a small SoC is to test three open-source IP cores together for the first time and calibrate the analog part of it. VSDBabySoC contains one RVMYTH microprocessor, an 8x-PLL to generate a stable clock, and a 10-bit DAC to communicate with other analog devices.

  

## Problem statement

This work discusses the different aspects of designing a small SoC based on RVMYTH (a RISCV-based processor). This SoC will leverage a PLL as its clock generator and controller and a 10-bit DAC as a way to talk to the outside world. Other electrical devices with proper analog input like televisions, and mobile phones could manipulate DAC output and provide users with music sound or video frames. At the end of the day, it is possible to use this small fully open-source and well-documented SoC which has been fabricated under Sky130 technology, for educational purposes.

## What is SoC

An SoC is a single-die chip that has some different IP cores on it. These IPs could vary from microprocessors (completely digital) to 5G broadband modems (completely analog).

## What is RVMYTH

RVMYTH core is a simple RISCV-based CPU, introduced in a workshop by RedwoodEDA and VSD. During a 5-day workshop students (including middle-schoolers) managed to create a processor from scratch. The workshop used the TLV for faster development. All of the present and future contributions to the IP will be done by students and under open-source licenses.

## What is PLL

A phase-locked loop or PLL is a control system that generates an output signal whose phase is related to the phase of an input signal. PLLs are widely used for synchronization purposes, including clock generation and distribution.

## What is DAC

A digital-to-analog converter or DAC is a system that converts a digital signal into an analog signal. DACs are widely used in modern communication systems enabling the generation of digitally-defined transmission signals. As a result, high-speed DACs are used for mobile communications and ultra-high-speed DACs are employed in optical communications systems.




## RVMYTH modeling

As we mentioned in [What is RVMYTH](#what-is-rvmyth) section, RVMYTH is designed and created by the TL-Verilog language. So we need a way for compile and trasform it to the Verilog language and use the result in our SoC. Here the `sandpiper-saas` could help us do the job.

  [Here](https://github.com/ireneann713/vsdriscv) is the repo we used as a reference to model the RVMYTH

## PLL modeling

It is not possible to sythesis an analog design with Verilog, yet. But there is a chance to simulate it using `real` datatype. We will use the following repositories to model the PLL cores:

  [Here]([https://github.com/ireneann713/PLL]) is the repo we used as a reference to model the PLL
  
## ICC Compiler II
* IC Compiler is the industry leading place-and-route system for established and emerging
process technology node designs.
* Multicore support throughout the flow delivers improved productivity. New technologies,
like concurrent clock and data (CCD) with clock concurrent optimization, PrimeTime
physically-aware engineering change order (PT-ECO) guidance with minimum physical
impact implementation, and golden unified power format (IEEE 1801 UPF), enable
designers to handle gigascale design complexity and meet tight project schedules.
* IC Compiler hierarchical design technology enables powerful design planning and early
chip level exploration / analysis features to handle large, complex designs.
* IC Compiler delivers smaller die size with predictable design closure to reduce the cost of
design.
* IC Compiler with Zroute digital router technology utilizes advanced routing algorithms,
concurrent manufacturability optimizations and multi-threading, to improve
manufacturability and deliver faster turn-around-time.
* IC Compiler In-Design technology seamlessly integrates the IC Validator signoff DRC and
metal fill solution allowing designers to mitigate manufacturing compliance challenges in
the implementation stage for faster signoff closure.

![image](https://user-images.githubusercontent.com/55539862/189331113-3078e99c-6cc8-4817-ab80-e15b7e32719b.png)


### 1. Milkyway Reference Libraries
Information is stored in so-called “views”, for example:
* CEL: The full layout view
* FRAM: The abstract view used for P&R
* LM: Logic Model with Timing and Power info (optional*) 。(Optional) here means that the logical
libraries do not have to be stored within the Milkyway library structure, but can be located
anywhere else. IC Compiler only reads logical libraries (.db) specified through the link_library
variable.

### 2. Technology File (.tf file)
* Tech File is unique to each technology
* Contains metal layer technology parameters:
* Number and name designations for each layer/via
* Dielectric constant for technology
* Physical and electrical characteristics of each layer/via
* Design rules for each layer/Via (Minimum wire widths and wire-to-wire spacing, etc.)
* Units and precision for electrical units
* Colors and patterns of layers for display
Example of a Technology File:
Technology {
dielectric = 3.7
unitTimeName = "ns"
timePrecision = 1000
unitLengthName = "micron"
lengthPrecision = 1000
gridResolution = 5
unitVoltageName = "v"
}
...
Layer "m1" {
layerNumber = 16
maskName = "metal1"
pitch = 0.56
defaultWidth = 0.23
minWidth = 0.23
minSpacing = 0.23


![image](https://user-images.githubusercontent.com/55539862/189332908-fe14c779-4312-4738-9a86-4003f7102566.png)


![Screenshot 2022-09-09 111736](https://user-images.githubusercontent.com/55539862/189316956-c7f3bdc5-5e49-4adf-88e6-54944aacd371.png)
