set target_library [list /home/irene/workshop/icc2_workshop/nangate_typical.db ]
set link_library [list  /home/irene/workshop/icc2_workshop/nangate_typical.db ] 
set symbol_library ""

#read_verilog /home/irene/workshop/icc2_workshop/vsdbabysoc.v
read_verilog /home/irene/VSDBabySoC/src/module/rvmyth.v
#read_verilog /home/irene/VSDBabySoC/src/module/clk_gate.v

#read_lib -lib /home/irene/VSDBabySoC/src/module/avsdpll.lib
#read_lib -lib /home/irene/VSDBabySoC/src/module/avsddac.lib

analyze -library WORK -format verilog {/home/irene/workshop/icc2_workshop/vsdbabysoc.v}
elaborate vsdbabysoc -architecture verilog -library WORK
analyze {}

create_clock -name MYCLK -per 10 [get_ports CLK];
set_clock_latency -source 2 [get_clocks MYCLK];
set_clock_latency 1 [get_clocks MYCLK];
set_clock_uncertainty -setup 0.5 [get_clocks MYCLK];
set_clock_uncertainty -hold 0.1 [get_clocks MYCLK];
set_input_delay -max 5 -clock [get_clocks MYCLK] [get_ports reset];
set_input_delay -max 5 -clock [get_clocks MYCLK] [get_ports CLK];
set_input_delay -min 1 -clock [get_clocks MYCLK] [get_ports reset];
set_input_delay -min 1 -clock [get_clocks MYCLK] [get_ports CLK];
set_input_transition -max 0.4 [get_ports reset];
set_input_transition -max 0.4 [get_ports CLK];
set_input_transition -min 0.1 [get_ports reset];
set_input_transition -min 0.1 [get_ports CLK];
#create_generated_clock -name MYGEN_CLK -master MYCLK -source [get_ports CLK] -div 1 [get_ports out_clk];
#create_generated_clock -name MYGEN_DIV_CLK -master MYCLK -source [get_ports clk] -div 2 [get_ports out_div_clk]; 
#set_output_delay -max 5 -clock [get_clocks MYGEN_CLK] [get_ports OUT];
#set_output_delay -min 1 -clock [get_clocks MYGEN_CLK] [get_ports OUT];
set_load -max 0.4 [get_ports OUT];
set_load -min 0.1 [get_ports OUT];

check_design

compile_ultra

file mkdir report
write -hierarchy -format verilog -output /home/irene/workshop/icc2_workshop/report/rvmyth.v
write_sdc -nosplit -version 2.0 /home/irene/workshop/icc2_workshop/report/rvmyth.sdc
report_area -hierarchy > /home/irene/workshop/icc2_workshop/report/vsdbabysoc.area
report_timing > /home/irene/workshop/icc2_workshop/report/vsdbabysoc.timing
report_power -hierarchy > /home/irene/workshop/icc2_workshop/report/vsdbabysoc.power

gui_start
