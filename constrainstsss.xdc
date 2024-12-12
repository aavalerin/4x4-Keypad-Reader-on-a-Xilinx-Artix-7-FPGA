## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

 


# LEDs for Key Value
set_property PACKAGE_PIN U16 [get_ports {key_value[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {key_value[0]}]
set_property PACKAGE_PIN E19 [get_ports {key_value[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {key_value[1]}]
set_property PACKAGE_PIN U19 [get_ports {key_value[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {key_value[2]}]
set_property PACKAGE_PIN V19 [get_ports {key_value[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {key_value[3]}]
	
	
set_property PACKAGE_PIN W18 [get_ports {flag}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {flag}]
	
	


##RESET BUTTON
set_property PACKAGE_PIN U18 [get_ports rst]						
	set_property IOSTANDARD LVCMOS33 [get_ports rst]



## Keypad - Pmod B pins (1-4,7-10)
set_property PACKAGE_PIN A14 [get_ports {keypad_rows[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_rows[0]}]

set_property PACKAGE_PIN A16 [get_ports {keypad_rows[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_rows[1]}]

set_property PACKAGE_PIN B15 [get_ports {keypad_rows[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_rows[2]}]

set_property PACKAGE_PIN B16 [get_ports {keypad_rows[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_rows[3]}]

set_property PACKAGE_PIN A15 [get_ports {keypad_cols[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_cols[3]}]

set_property PACKAGE_PIN A17 [get_ports {keypad_cols[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_cols[2]}]

set_property PACKAGE_PIN C15 [get_ports {keypad_cols[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_cols[1]}]

set_property PACKAGE_PIN C16 [get_ports {keypad_cols[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {keypad_cols[0]}]


