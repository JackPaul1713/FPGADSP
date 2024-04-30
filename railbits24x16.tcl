#################################################################################
#Simulator TCL starts in: C:/Users/Chris/AppData/Roaming/Xilinx/Vivado
# cd C:/Users/Chris/Dropbox/Mycourses/EENG498/VHDL_fall2023/preLab01
# source pwm_tbWaveSetup.tcl
#################################################################################
restart
remove_wave [get_waves *]

add_wave -color white /railbits24x16_tb/clk_t
add_wave -color cyan -radix dec /railbits24x16_tb/uut/twos24
add_wave -color cyan -radix dec /railbits24x16_tb/uut/twos16

run 1200 ns














