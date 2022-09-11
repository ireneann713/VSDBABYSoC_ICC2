# VSDBABYSoC






## Table of Contents

  * [Introduction](##introduction-to-the-vsdbabysoc)
       + [ VSDBABYSoC](#vsdbabysoc)

  * [ICC2 COMPILER](##icc-compiler-ii) 
      +  [Milkyway Reference Libraries]()
      +  [Technology File (.tf file)]()
      +  [ICC Design Planning Flow]()
      +  [Create the Starting Floorplan]()
      +  [Connecting Power and Ground Ports]()
      + [ Floorplan After Initialization]()
      +  [Planning I/Os and Flip-Chip Bumps]()
      +  [Creating a 3DIC Design]()
      + [ Managing Design Blocks]()
      + [Performing Block Shaping and Macro Placement]()
      + [Performing Power Planning]()
      + [Performing Global Planning]()
      + [Performing Clock Trunk Planning]()
      + [Performing Pin Assignment]()
      + [Performing Timing Budgeting]()
* [RVMYTH CORE IN VSDBABYSOC ]()

    + Timing Reports
* [Final Output]()

* [Important Points about the design]()
* [Errors encountered in the Design Flow]()

     
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

![image](https://user-images.githubusercontent.com/55539862/189332908-fe14c779-4312-4738-9a86-4003f7102566.png)

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

## ICC Design Planning Flow

![image](https://user-images.githubusercontent.com/55539862/189333614-8b2fbdcd-95ab-4c15-a918-1c2576a39824.png)

If the design contains black boxes or the netlist is dirty, use the read_mw_verilog command in place of
import_designs.
Also include adding of power pads (VSS,VDD) and insertion of pad fillers;

# Create the Starting Floorplan

![image](https://user-images.githubusercontent.com/55539862/189334457-294543eb-bfad-473d-b262-c2864512125a.png)

## Connecting Power and Ground Ports
The macro cells and modules in your design contain power and ground pins that must be
connected before initializing the floorplan. The derive_pg_connection command (or Preroute >
Derive PG Connection in the GUI) connects power, ground, and tie-off pins to power and ground
nets.
You can perform automatic power and ground connections for the power and ground pins of cells in
the design, as well as direct rail-tie connections to power and ground nets by using the
derive_pg_connection command. This is the only recommended method for creating a power
and ground (PG) network for nonmultivoltage designs. Use this command before using any of the
optimization commands.

## Floorplan After Initialization


![image](https://user-images.githubusercontent.com/55539862/189334741-4ce7c848-59a7-4b41-a973-145891b66de4.png)
hierarchies can be black boxes in the tool.

## Planning I/Os and Flip-Chip Bumps

After creating the floorplan, you can instantiate the I/O drivers and bump cells for your design. The IC Compiler II tool supports advanced features for unconstrained and constraint-based placement of I/O drivers and flip-chip bump cells. You can create I/O placement constraints and specify the ordering, xy coordinate, and placement side for each I/O. The tool supports both package-driven and die-driven I/O placement flows, and you can adapt the tool for different chip packaging scenarios. Different I/O driver styles, such as pads with integrated drivers, are supported by the tool.

![image](https://user-images.githubusercontent.com/55539862/189337136-727ae704-0ded-41be-8b87-ff94f5ef9a8d.png)

## Creating a 3DIC Design

In a 3DIC design, two or more die are directly stacked vertically to create a complete design or system that contains multiple dies. In a 2.5D IC design, one or more die are mounted on an interposer; the interposer also connects the die to each other and to the package. The interposer can be manufactured from various materials including silicon or glass.


![image](https://user-images.githubusercontent.com/55539862/189337295-cf935b53-10f4-4116-9478-070c5174ed3b.png)

## Managing Design Blocks

To manage design blocks, the IC Compiler II tool supports operations to easily partition your design and commit a logical hierarchy cell to a physical hierarchy block early in the design flow. After committing to blocks, you can create multiple optimized, abstract views for design blocks that contain only the information needed to perform placement, timing, and other tasks. This approach enables you to minimize the system requirements needed to efficiently distribute and process very large designs.

![image](https://user-images.githubusercontent.com/55539862/189337398-17110f3e-ab6f-40a6-ba54-9e6d09b53d01.png)

## Performing Block Shaping and Macro Placement

The block shaping flow refines the boundary for the block based on the rough rectangular or rectilinear shape defined during hierarchy exploration. When creating the block shape, the tool considers design constraints such as target utilization for the block, channel width and keepout settings, while minimizing feedthroughs and interface wire lengths. You can create an optional block grid for your design; the tool aligns block shapes to the grid.


![image](https://user-images.githubusercontent.com/55539862/189337688-34a41c90-07d1-4ada-a021-836f075a89c5.png)




## Performing Power Planning

Power planning, which includes power network routing and power network analysis, is required to create a design with good power integrity. A design with a robust power and ground (PG) grid reduces IR drop and electromigration by providing an adequate number of power and ground pads and rails. The power plan can be used to assess the routing resources consumed by the power nets and to determine the impact on routability due to the power plan. You can experiment with different power plans or fine-tune the existing power plan by modifying the command option settings and regenerating the power plan.

![image](https://user-images.githubusercontent.com/55539862/189337827-ba9569af-32cf-4420-ac3e-085044bf69c9.png)


## Performing Global Planning

To improve global routing between design blocks during the design planning phase, the IC Compiler II tool supports operations to group similar nets, create global routing corridors, and push global route objects into blocks. Global planning enables you to better manage routing resources between blocks. You typically use global bus planning after running block shaping and macro placement.

## Performing Clock Trunk Planning

To manage clock trunks during design planning, the tool supports clock trunk planning. A clock trunk is a coarse-grain physical distribution of the clock, which starts at the clock source and ends at the clock trunk endpoint. 

![image](https://user-images.githubusercontent.com/55539862/189338062-856e74b2-9475-484c-b749-61fb98d29c40.png)

## Performing Pin Assignment

The IC Compiler II tool provides extensive control over pin placement and feedthrough creation during floorplanning. Pin placement is based on global routing and can be guided by user-defined constraints. You can make minimal changes to an existing pin placement by changing constraints and running pin assignment in incremental mode.


![image](https://user-images.githubusercontent.com/55539862/189338205-1719fd7f-11b1-4370-9734-d57f8cc3ea0b.png)

## Performing Timing Budgeting

To support a hierarchical design flow, the IC Compiler II tool provides timing budgeting to allocate timing among the blocks in the design. The budgeting process begins by partitioning the chip-level timing constraints into top-level and block-level constraints. To speed the budget creation process, the tool creates lightweight timing abstract representations for the blocks in the design. Each block is virtually optimized to negate the effects of high-fanout nets and provide more accurate timing estimations. The timing budgeter uses the optimized timing for each block to derive new budgets. In the final step, top-level and block-level timing budgets are written out in preparation for further block-level optimization. The timing budgeter is fully multimode and multicorner aware, and handles designs with multiply instantiated blocks.


![image](https://user-images.githubusercontent.com/55539862/189338325-e40637d5-9bb6-4589-bb8f-d8b3c9e576d9.png)
## RVMYTH CORE IN VSDBABYSOC 


 * Synthesise the RVMYTH design using the Design Compiler and generate the Gate Level Netlist.The library used for the Synthesis 45nm Nangate Typical libs.
 
 
 ![image](https://user-images.githubusercontent.com/55539862/189540845-e1eed1e8-cc0a-40a5-94fe-6b54efa11479.png)

 
 For more explanation of STA and Synthesis refer:
 [Adavnced Synthesis and STA Using Design Compiler]( https://github.com/ireneann713/AdvancedSynthesisandSTAwithDC)
 

#### create_power

![image](https://user-images.githubusercontent.com/55539862/189543264-f6cb84bc-1202-48f6-97d8-07765d3050a7.png)

#### Pin Placement

![image](https://user-images.githubusercontent.com/55539862/189543327-857698b9-8b10-4fbf-938b-b6a5954be517.png)

#### Timing Estimation


![image](https://user-images.githubusercontent.com/55539862/189543461-9e692038-917c-47d0-8157-8dcf256a8928.png)
 #### Place, CTS, Route
 
 

![image](https://user-images.githubusercontent.com/55539862/189543551-d0ebc0ed-e782-489a-9384-99dde6966125.png)




## Final Output

![Screenshot 2022-09-09 111736](https://user-images.githubusercontent.com/55539862/189316956-c7f3bdc5-5e49-4adf-88e6-54944aacd371.png)


### Important Points about the design
* The design that was first done included analog blocks of PLL and DAC in 28nm.Since we have encountered some errors in the the design flow we used did not include analog blocks.


* The error encountered were:
    + Related to the Standard Cells LEF file in 28nm 
    + The analog blocks LEF File were not able to be executed with standard LEF.
    + The estimate_timing was not able to execute due to the problem with 28nm LEF files.
    
* Therefore we did our design with digital block i.e. RVMYTH,the 32 bit RISC-V Core in 45nm Technology.

* Dummy interconnect technology file (ITF) was used to generate TLU+ files using ICC2 grdgenxo utility of STAR-RC

* Memory views were generated using open-source memory compiler OpenRAM for open-source nangate 45nm freePDK

* This repo is only for educational purposes.

All scripts in "standAlone" directory are ICC2 reference scripts. It cannot be used with any other PNR tool



## Errors encountered in the Design Flow

* The errors related to the macro height and width mismatch with the standard LEF File.


![image](https://user-images.githubusercontent.com/55539862/189542930-d1f73953-9cb7-4566-8027-340e70a332ac.png)

![image](https://user-images.githubusercontent.com/55539862/189542998-29a73fa1-31d0-4ed7-b6e5-9c62a0a84d0e.png)




## ACKNOWLEDGEMENTS
* Kunal Ghosh, Co-founder (VSD Corp. Pvt. Ltd)

## REFERENCES

* https://github.com/ireneann713/AdvancedPhysicalDesign-with-OpenLane-using-Sky-130
* https://github.com/ireneann713/FunctionalNetlistingof-VSDBABYSoC
* https://github.com/ireneann713/vsdriscv
* https://github.com/ireneann713/AdvancedSynthesisandSTAwithDC
* https://github.com/ireneann713/PLL

