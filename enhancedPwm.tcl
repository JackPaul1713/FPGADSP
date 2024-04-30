#################################################################################
#Simulator TCL starts in: C:/Users/Chris/AppData/Roaming/Xilinx/Vivado
# cd C:/Users/Chris/Dropbox/Mycourses/EENG498/VHDL_fall2023/preLab01
# source pwm_tbWaveSetup.tcl
#################################################################################
restart
remove_wave [get_waves *]

add_wave -color cyan /enhancedPwm_tb/uut/clk
add_wave -color cyan /enhancedPwm_tb/uut/enb
add_wave -color green /enhancedPwm_tb/uut/pwmSignal
add_wave -color green /enhancedPwm_tb/uut/stepGtr
add_wave -color gold -radix unsigned /enhancedPwm_tb/uut/pwmCount
add_wave -color gold -radix unsigned /enhancedPwm_tb/uut/stepsHigh
add_wave -color orange -radix unsigned /enhancedPwm_tb/uut/dutyCycle
add_wave -color orange -radix unsigned /enhancedPwm_tb/dutyCycle_t
add_wave -color red -radix unsigned /enhancedPwm_tb/uut/rollOver















