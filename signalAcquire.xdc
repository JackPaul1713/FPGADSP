#### general ####
## clk:
set_property PACKAGE_PIN U18 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
create_clock -period 20.000 -waveform {0.000 10.000} [get_ports clk]

## resetn:
set_property PACKAGE_PIN F16 [get_ports resetn]
set_property IOSTANDARD LVCMOS33 [get_ports resetn]

## sampled ##
set_property PACKAGE_PIN F20 [get_ports sampled]
set_property IOSTANDARD LVCMOS33 [get_ports sampled]

## leds:
# led 1, led 2, led 3, led 4
set_property PACKAGE_PIN M14 [get_ports leds[3]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[3]]
set_property PACKAGE_PIN M15 [get_ports leds[2]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[2]]
set_property PACKAGE_PIN K16 [get_ports leds[1]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[1]]
set_property PACKAGE_PIN J16 [get_ports leds[0]]
set_property IOSTANDARD LVCMOS33 [get_ports leds[0]]

## buttons:
# key 1, key 2, key 3, key 4
set_property PACKAGE_PIN N15 [get_ports buttons[3]]
set_property IOSTANDARD LVCMOS33 [get_ports buttons[3]]
set_property PACKAGE_PIN N16 [get_ports buttons[2]]
set_property IOSTANDARD LVCMOS33 [get_ports buttons[2]]
set_property PACKAGE_PIN T17 [get_ports buttons[1]]
set_property IOSTANDARD LVCMOS33 [get_ports buttons[1]]
set_property PACKAGE_PIN R17 [get_ports buttons[0]]
set_property IOSTANDARD LVCMOS33 [get_ports buttons[0]]

#### pwm ####
set_property PACKAGE_PIN F17 [get_ports pwmSignal]
set_property IOSTANDARD LVCMOS33 [get_ports pwmSignal]

#### adc ####
## conversion trigger:
set_property PACKAGE_PIN R14 [get_ports an7606convst]
set_property IOSTANDARD LVCMOS33 [get_ports an7606convst]

## reset:
set_property PACKAGE_PIN Y16 [get_ports an7606reset]
set_property IOSTANDARD LVCMOS33 [get_ports an7606reset]

## chip select:
set_property PACKAGE_PIN V15 [get_ports an7606cs]
set_property IOSTANDARD LVCMOS33 [get_ports an7606cs]

## read:
set_property PACKAGE_PIN Y17 [get_ports an7606rd]
set_property IOSTANDARD LVCMOS33 [get_ports an7606rd]

## busy signal:
set_property PACKAGE_PIN W15 [get_ports an7606busy]
set_property IOSTANDARD LVCMOS33 [get_ports an7606busy]

## oversample setting:
set_property PACKAGE_PIN W18 [get_ports an7606od[0]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606od[0]]
set_property PACKAGE_PIN W19 [get_ports an7606od[1]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606od[1]]
set_property PACKAGE_PIN P14 [get_ports an7606od[2]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606od[2]]

## sample:
set_property PACKAGE_PIN U15 [get_ports an7606data[0]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[0]]
set_property PACKAGE_PIN U14 [get_ports an7606data[1]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[1]]
set_property PACKAGE_PIN P16 [get_ports an7606data[2]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[2]]
set_property PACKAGE_PIN P15 [get_ports an7606data[3]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[3]]

set_property PACKAGE_PIN U17 [get_ports an7606data[4]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[4]]
set_property PACKAGE_PIN T16 [get_ports an7606data[5]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[5]]
set_property PACKAGE_PIN V18 [get_ports an7606data[6]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[6]]
set_property PACKAGE_PIN V17 [get_ports an7606data[7]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[7]]

set_property PACKAGE_PIN T15 [get_ports an7606data[8]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[8]]
set_property PACKAGE_PIN T14 [get_ports an7606data[9]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[9]]
set_property PACKAGE_PIN V13 [get_ports an7606data[10]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[10]]
set_property PACKAGE_PIN U13 [get_ports an7606data[11]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[11]]

set_property PACKAGE_PIN W13 [get_ports an7606data[12]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[12]]
set_property PACKAGE_PIN V12 [get_ports an7606data[13]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[13]]
set_property PACKAGE_PIN U12 [get_ports an7606data[14]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[14]]
set_property PACKAGE_PIN T12 [get_ports an7606data[15]]
set_property IOSTANDARD LVCMOS33 [get_ports an7606data[15]]
