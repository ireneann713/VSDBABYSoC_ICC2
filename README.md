# VSDBABYSoC






## Table of Contents

  * [Introduction](##introduction-to-the-vsdbabysoc)
       + [ VSDBABYSoC](#vsdbabysoc)

  * [ICC2 COMPILER](##icc-compiler-ii) 
      +  [Milkyway Reference Libraries](#1-milkyway-reference-libraries)
      +  [Technology File (.tf file)](#2-technology-file-tf-file)
      +  [ICC Design Planning Flow](#icc-design-planning-flow)
      +  [Create the Starting Floorplan](#create-the-starting-floorplan)
      +  [Connecting Power and Ground Ports](#connecting-power-and-ground-ports)
      + [ Floorplan After Initialization](#floorplan-after-initialization)
      +  [Planning I/Os and Flip-Chip Bumps](#planning-ios-and-flip-chip-bumps)
      +  [Creating a 3DIC Design](#creating-a-3dic-design)
      + [ Managing Design Blocks](#managing-design-blocks)
      + [Performing Block Shaping and Macro Placement](#performing-block-shaping-and-macro-placement)
      + [Performing Power Planning](#performing-power-planning)
      + [Performing Global Planning](#performing-global-planning)
      + [Performing Clock Trunk Planning](#performing-clock-trunk-planning)
      + [Performing Pin Assignment](#performing-pin-assignment)
      + [Performing Timing Budgeting](#performing-timing-budgeting)
* [RVMYTH CORE IN VSDBABYSOC ](#rvmyth-core-in-vsdbabysoc)
   + [Stages of Physical Design Flow](#stages-of-physical-design-flow)
   + [Timing Estimation Post Route](#timing-estimation-post-routing)
* [Important Points about the design](#important-points-about-the-design)
* [Errors encountered in the Design Flow](#errors-encountered-in-the-design-flow)
* [Final Output](#final-output)
* [Future Works](#future-works) 
* [Acknowledgements](#acknowledgements)
* [Contributors](#contributors)
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

### Stages of Physical Design Flow

#### Read Synthesized Verilog
 * Synthesise the RVMYTH design using the Design Compiler and generate the Gate Level Netlist and read the synthesised netlist.The library used for the Synthesis 45nm Nangate Typical libs.
 
 
 ![image](https://user-images.githubusercontent.com/55539862/189540845-e1eed1e8-cc0a-40a5-94fe-6b54efa11479.png)

 
 For more explanation of STA and Synthesis refer:
 [Adavnced Synthesis and STA Using Design Compiler]( https://github.com/ireneann713/AdvancedSynthesisandSTAwithDC)
 
 ### Floorplan
 
 
 Floorplan is one the critical & important step in Physical design. Quality of your Chip / Design implementation 
depends on how good is the Floorplan. A good floorplan can be make implementation process (place, cts,
route & timing closure) cake walk. On similar lines a bad floorplan can create all kind issues in the design
(congestion, timing, noise, IR, routing issues). A bad floorplan will blow up the area, power & affects reliability,
life of the IC and also it can increase overall IC cost (more effort to closure, more LVTs/ULVTs).

 ![image](https://user-images.githubusercontent.com/55539862/189545643-0900071d-6b69-432e-9516-d2edbf2fb994.png)

 

#### create_power

This	command	creates	additional	power	network	robustness	but	at	the	expense	of	routability	later.	



![image](https://user-images.githubusercontent.com/55539862/189543264-f6cb84bc-1202-48f6-97d8-07765d3050a7.png)

#### Pin Placement


In block-level PnR, input-output pins location are generally decided by the full-chip owner and the pin def is given to block owners. But some times pin location are not fixed at the top level and meanwhile block owner need to place them as per their convenience.

![image](https://user-images.githubusercontent.com/55539862/189543327-857698b9-8b10-4fbf-938b-b6a5954be517.png)

#### Timing Estimation


* Reg-to-reg paths

In a reg-to-reg path, both startpoint and endpoint are sequential elements; i.e. either an edge-triggered element or a level sensitive element. Edge-triggered elements are mostly flip-flops, memories or edge-triggered arcs of sub-partitions of the design. Level sensitive elements are mostly latches or any such element such as a sub-partitions level sensitive arcs.
```
Startpoint: CPU_src2_value_a3_reg[0]
              (rising edge-triggered flip-flop clocked by MYCLK)
  Endpoint: CPU_jalr_tgt_pc_a3_reg[31]
            (rising edge-triggered flip-flop clocked by MYCLK)
  Path Group: MYCLK
  Path Type: max

  Des/Clust/Port     Wire Load Model       Library
  ------------------------------------------------
  rvmyth             5K_hvratio_1_1        NangateOpenCellLibrary

  Point                                                   Incr       Path
  --------------------------------------------------------------------------
  clock MYCLK (rise edge)                                 0.00       0.00
  clock network delay (ideal)                             3.00       3.00
  CPU_src2_value_a3_reg[0]/clocked_on (**SEQGEN**)        0.00 #     3.00 r
  CPU_src2_value_a3_reg[0]/Q (**SEQGEN**)                 0.00       3.00 r
  lt_161/B_0 (*LT_UNS_OP_32_32_1)                         0.00       3.00 r
  lt_161/*cell*20/B[0] (DW01_cmp2_width32)                0.00       3.00 r
  ...
  lt_161/*cell*20/LT_LE (DW01_cmp2_width32)               0.14       3.14 r
  lt_161/Z_0 (*LT_UNS_OP_32_32_1)                         0.00       3.14 r
  C5223/Z_0 (*SELECT_OP_2.1_2.1_1)                        0.00       3.14 r
  C5224/Z_0 (*SELECT_OP_22.32_22.1_32)                    0.00       3.14 r
  C5225/Z_0 (*SELECT_OP_3.32_3.1_32)                      0.00       3.14 r
  C5220/Z_0 (*SELECT_OP_2.32_2.1_32)                      0.00       3.15 r
  add_152/A_0 (*ADD_UNS_OP_32_32_32)                      0.00       3.15 r
  add_152/*cell*11/A[0] (DW01_add_width32)                0.00       3.15 r
  ...
  add_152/*cell*11/SUM[31] (DW01_add_width32)             0.06       3.21 r
  add_152/Z_31 (*ADD_UNS_OP_32_32_32)                     0.00       3.21 r
  CPU_jalr_tgt_pc_a3_reg[31]/next_state (**SEQGEN**)      0.00       3.21 r
  data arrival time                                                  3.21

  clock MYCLK (rise edge)                                10.00      10.00
  clock network delay (ideal)                             3.00      13.00
  clock uncertainty                                      -0.50      12.50
  CPU_jalr_tgt_pc_a3_reg[31]/clocked_on (**SEQGEN**)      0.00      12.50 r
  library setup time                                      0.00      12.50
  data required time                                                12.50
  --------------------------------------------------------------------------
  data required time                                                12.50
  data arrival time                                                 -3.21
  --------------------------------------------------------------------------
  slack (MET)                                                        9.29
  
  
  ```
  
 #### Place, CTS, Route
 
 * Placement is the process of finding a suitable physical location for each cell in the block.
Tool only determine the location of each standard cell on the die.
Placement does not just place the standard cell available in the synthesized netlist, it also optimized the design.
 
 * CTS is the process of connecting the clocks to all clock pin of sequential circuits by using inverters/buffers in order to balance the skew and to minimize the insertion delay. All the clock pins are driven by a single clock source. Clock balancing is important for meeting all the design constraints.
 
  * Routing is the stage after CTS and optimization where exact paths for the interconnection of standard cells and macros and I/O
pins are determined. Electrical connections using metals and vias are created in the layout, defined by the
logical connections present in the netlist (i.e. Logical connectivity converted as physical connectivity). After CTS, we have information of all the placed cells, blockages, clock tree buffers/inverters and I/O pins

![image](https://user-images.githubusercontent.com/55539862/189543551-d0ebc0ed-e782-489a-9384-99dde6966125.png)

Cells placed inside the core area:

![image](https://user-images.githubusercontent.com/55539862/189545454-75beed6e-cedf-487b-8c9e-1c5a5a2651cc.png)


### Timing Estimation Post Routing
```

****************************************
Report : timing
        -path full
        -delay max
        -max_paths 1
Design : rvmyth
Version: S-2021.06-SP5-1
Date   : Mon Sep 12 21:04:36 2022
****************************************

 # A fanout number of 1000 was used for high fanout net computations.

Operating Conditions: typical   Library: NangateOpenCellLibrary
Wire Load Model Mode: top

  Startpoint: CPU_is_sub_a3_reg
              (rising edge-triggered flip-flop clocked by MYCLK)
  Endpoint: CPU_Xreg_value_a4_reg[10][31]
            (rising edge-triggered flip-flop clocked by MYCLK)
  Path Group: MYCLK
  Path Type: max

  Des/Clust/Port     Wire Load Model       Library
  ------------------------------------------------
  rvmyth             5K_hvratio_1_1        NangateOpenCellLibrary

  Point                                                   Incr       Path
  --------------------------------------------------------------------------
  clock MYCLK (rise edge)                                 0.00       0.00
  clock network delay (propagated)                        5.03       5.03
  CPU_is_sub_a3_reg/CK (DFF_X1)                           0.00 #     5.03 r
  CPU_is_sub_a3_reg/Q (DFF_X1)                            0.12       5.15 r
  U5065/ZN (AND3_X1)                                      0.19       5.34 r
  U5491/Z (CLKBUF_X1)                                     0.17       5.51 r
  U5503/ZN (OR2_X1)                                       0.15       5.66 r
  U5522/Z (CLKBUF_X1)                                     0.14       5.79 r
  U5617/ZN (NAND2_X1)                                     0.04       5.84 f
  U5619/ZN (NAND2_X1)                                     0.03       5.87 r
  U5620/Z (XOR2_X1)                                       0.04       5.91 f
  DP_OP_214J1_122_1213/U33/CO (FA_X1)                     0.10       6.00 f
  DP_OP_214J1_122_1213/U32/CO (FA_X1)                     0.09       6.09 f
  DP_OP_214J1_122_1213/U31/CO (FA_X1)                     0.09       6.18 f
  DP_OP_214J1_122_1213/U30/CO (FA_X1)                     0.09       6.27 f
  DP_OP_214J1_122_1213/U29/CO (FA_X1)                     0.09       6.37 f
  DP_OP_214J1_122_1213/U28/CO (FA_X1)                     0.09       6.46 f
  DP_OP_214J1_122_1213/U27/CO (FA_X1)                     0.09       6.55 f
  DP_OP_214J1_122_1213/U26/CO (FA_X1)                     0.09       6.64 f
  DP_OP_214J1_122_1213/U25/CO (FA_X1)                     0.09       6.73 f
  DP_OP_214J1_122_1213/U24/CO (FA_X1)                     0.09       6.82 f
  DP_OP_214J1_122_1213/U23/CO (FA_X1)                     0.09       6.91 f
  DP_OP_214J1_122_1213/U22/CO (FA_X1)                     0.09       7.00 f
  DP_OP_214J1_122_1213/U21/CO (FA_X1)                     0.09       7.09 f
  DP_OP_214J1_122_1213/U20/CO (FA_X1)                     0.09       7.18 f
  DP_OP_214J1_122_1213/U19/CO (FA_X1)                     0.09       7.27 f
  DP_OP_214J1_122_1213/U18/CO (FA_X1)                     0.09       7.36 f
  DP_OP_214J1_122_1213/U17/CO (FA_X1)                     0.09       7.45 f
  DP_OP_214J1_122_1213/U16/CO (FA_X1)                     0.09       7.54 f
  DP_OP_214J1_122_1213/U15/CO (FA_X1)                     0.09       7.63 f
  DP_OP_214J1_122_1213/U14/CO (FA_X1)                     0.09       7.72 f
  DP_OP_214J1_122_1213/U13/CO (FA_X1)                     0.09       7.82 f
  DP_OP_214J1_122_1213/U12/CO (FA_X1)                     0.09       7.91 f
  DP_OP_214J1_122_1213/U11/CO (FA_X1)                     0.09       8.00 f
  DP_OP_214J1_122_1213/U10/CO (FA_X1)                     0.09       8.09 f
  DP_OP_214J1_122_1213/U9/CO (FA_X1)                      0.09       8.18 f
  DP_OP_214J1_122_1213/U8/CO (FA_X1)                      0.09       8.27 f
  DP_OP_214J1_122_1213/U7/CO (FA_X1)                      0.09       8.36 f
  DP_OP_214J1_122_1213/U6/CO (FA_X1)                      0.09       8.45 f
  DP_OP_214J1_122_1213/U5/CO (FA_X1)                      0.09       8.54 f
  DP_OP_214J1_122_1213/U4/CO (FA_X1)                      0.09       8.63 f
  DP_OP_214J1_122_1213/U3/CO (FA_X1)                      0.09       8.72 f
  U5912/Z (XOR2_X1)                                       0.06       8.78 r
  U5913/ZN (NAND2_X1)                                     0.12       8.90 f
  U7632/Z (CLKBUF_X1)                                     0.13       9.03 f
  U7641/ZN (OAI22_X1)                                     0.07       9.10 r
  CPU_Xreg_value_a4_reg[10][31]/D (DFF_X1)                0.01       9.11 r
  data arrival time                                                  9.11

  clock MYCLK (rise edge)                                10.00      10.00
  clock network delay (propagated)                        5.03      15.03
  clock uncertainty                                      -0.50      14.53
  CPU_Xreg_value_a4_reg[10][31]/CK (DFF_X1)               0.00      14.53 r
  library setup time                                     -0.06      14.47
  data required time                                                14.47
  --------------------------------------------------------------------------
  data required time                                                14.47
  data arrival time                                                 -9.11
  --------------------------------------------------------------------------
  slack (MET)                                                        5.37


```


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

* In Timing Estimation, voltage mismatches were there.This error was the consequence of the error faced in 28nm Technology LEF files.

![image](https://user-images.githubusercontent.com/55539862/189544098-9e25785f-d3db-4263-98c0-b3fee49881d5.png)


+ So for the training purpose and for better understanding of the  physical design flow, we used only Digital block i.e., rvmyth and removed the Analog IPs i.e., PLL and DAC.

+ Since majority of the errors were encountered due to the standard lef file of 28nm Technology we shifted to 45nm Opensource PDK.


## Final Output

![Screenshot 2022-09-09 111736](https://user-images.githubusercontent.com/55539862/189316956-c7f3bdc5-5e49-4adf-88e6-54944aacd371.png)


## Future Works

### Cross Talk Analysis in Physical Design

#### Crosstalk

Crosstalk refers to undesired or unintentional effects, which can cause functional failure in the chips. This functional failure refers to either change in the value of the signal voltage or change in timing.

There are two types of noise effects, namely,

1. Crosstalk Glitch: This refers to noise/glitch caused on a steady victim signal due to the coupling of switching activity of the neighboring aggressors.

![image](https://user-images.githubusercontent.com/55539862/189577996-984e68f2-10f9-431f-87e4-45f319d33650.png)



2.Crosstalk Delay: This is due to the coupling between the switching activity of the victim and the switching activity of the aggressors, which results in the change of timing on a particular victim signals.

![image](https://user-images.githubusercontent.com/55539862/189584201-779f12c2-fe43-45f8-9da5-34468b70189d.png)
 
 
 * Crosstalk delta delay analysis is to be done for this design.
 

## Contributors
[Irene Ann Zachariah](https://in.linkedin.com/in/irene-ann-zachariah231)


## ACKNOWLEDGEMENTS
* Kunal Ghosh, Co-founder (VSD Corp. Pvt. Ltd)
* Muthukrishnan C, CEO Semiconductor eFabless Accerlerator Lab

## REFERENCES

* https://github.com/ireneann713/AdvancedPhysicalDesign-with-OpenLane-using-Sky-130
* https://github.com/ireneann713/FunctionalNetlistingof-VSDBABYSoC
* https://github.com/ireneann713/vsdriscv
* https://github.com/ireneann713/AdvancedSynthesisandSTAwithDC
* https://github.com/ireneann713/PLL
* https://medium.com/@einfochips/crosstalk-analysis-and-its-impact-on-timing-in-7nm-technology-abcfb795190f

