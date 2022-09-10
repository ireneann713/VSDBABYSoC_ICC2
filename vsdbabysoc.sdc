###################################################################

# Created by write_sdc on Thu Sep 8 22:09:21 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 8000
set_load -pin_load 0.5 [get_ports {OUT[9]}]
set_load -pin_load 0.5 [get_ports {OUT[8]}]
set_load -pin_load 0.5 [get_ports {OUT[7]}]
set_load -pin_load 0.5 [get_ports {OUT[6]}]
set_load -pin_load 0.5 [get_ports {OUT[5]}]
set_load -pin_load 0.5 [get_ports {OUT[4]}]
set_load -pin_load 0.5 [get_ports {OUT[3]}]
set_load -pin_load 0.5 [get_ports {OUT[2]}]
set_load -pin_load 0.5 [get_ports {OUT[1]}]
set_load -pin_load 0.5 [get_ports {OUT[0]}]
set_load -min -pin_load 0.5 [get_ports {OUT[9]}]
set_load -min -pin_load 0.5 [get_ports {OUT[8]}]
set_load -min -pin_load 0.5 [get_ports {OUT[7]}]
set_load -min -pin_load 0.5 [get_ports {OUT[6]}]
set_load -min -pin_load 0.5 [get_ports {OUT[5]}]
set_load -min -pin_load 0.5 [get_ports {OUT[4]}]
set_load -min -pin_load 0.5 [get_ports {OUT[3]}]
set_load -min -pin_load 0.5 [get_ports {OUT[2]}]
set_load -min -pin_load 0.5 [get_ports {OUT[1]}]
set_load -min -pin_load 0.5 [get_ports {OUT[0]}]
