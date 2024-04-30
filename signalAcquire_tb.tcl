#################################################################################
# Simulator starts in: C:/Users/Chris/AppData/Roaming/Xilinx/Vivado
# Add this file as a simulation source in Vivado and it will automatically 
# load when you start a simulation.
#################################################################################
restart
remove_wave [get_waves *]

## general ##
set groupColor WHITE
set GENID [add_wave_group "general"]
add_wave -into $GENID -color white /signalAcquire_tb/uut/clk
add_wave -into $GENID -color white /signalAcquire_tb/uut/resetn

## control ##
set groupColor RED
set CTRLID [add_wave_group "control"]
add_wave -into $CTRLID -color maroon /signalAcquire_tb/uut/ctrlpath/state
add_wave -into $CTRLID -color red -radix hex /signalAcquire_tb/uut/cw
add_wave -into $CTRLID -color red -radix hex /signalAcquire_tb/uut/sw
add_wave -into $CTRLID -color red -radix hex /signalAcquire_tb/uut/trigger
# add_wave -into $CTRLID -color red -radix hex /signalAcquire_tb/uut/an7606busy # DEBUG
# add_wave -into $CTRLID -color red -radix hex /signalAcquire_tb/uut/ctrlpath/busy # DEBUG
# add_wave -color purple -radix bin /signalAcquire_tb/uut/datapath/shortCntCtrl # DEBUG
# add_wave -color purple -radix bin /signalAcquire_tb/uut/datapath/longCntCtrl # DEBUG
# add_wave -color purple -radix bin /signalAcquire_tb/uut/datapath/regCntCtrl # DEBUG

## sample ##
set groupColor CYAN
set SAMPID [add_wave_group "sample"]
add_wave -into $SAMPID -color cyan -radix hex /signalAcquire_tb/uut/sample
add_wave -into $SAMPID -color cyan -radix dec /signalAcquire_tb/uut/datapath/sampleCount
add_wave -into $SAMPID -color cyan -radix bin /signalAcquire_tb/uut/datapath/sampleCntCtrl
add_wave -into $SAMPID -color cyan -radix unsigned /signalAcquire_tb/uut/datapath/shortd0
add_wave -into $SAMPID -color cyan -radix unsigned /signalAcquire_tb/uut/datapath/longd0
add_wave -into $SAMPID -color cyan -radix unsigned /signalAcquire_tb/uut/datapath/regd0

## an7606 ##
set groupColor GOLD
set AN7606ID [add_wave_group "an7606"]
add_wave -into $AN7606ID -color gold -radix hex /signalAcquire_tb/uut/an7606data
add_wave -into $AN7606ID -color gold /signalAcquire_tb/uut/an7606convst
add_wave -into $AN7606ID -color gold /signalAcquire_tb/uut/an7606cs
add_wave -into $AN7606ID -color gold /signalAcquire_tb/uut/an7606rd
add_wave -into $AN7606ID -color gold /signalAcquire_tb/uut/an7606reset
add_wave -into $AN7606ID -color gold /signalAcquire_tb/uut/an7606busy

# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q0
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q1
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q2
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q3
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q4
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q5
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q6
# add_wave -color gold -radix hex	/signalAcquire_tb/uut/datapath/chSamples/q7

# add_wave -color khaki /signalAcquire_tb/uut/trigger # DEBUG
# add_wave -color khaki /signalAcquire_tb/uut/currbtn # DEBUG
# add_wave -color khaki /signalAcquire_tb/uut/prevbtn # DEBUG
# add_wave -color khaki -radix bin /signalAcquire_tb/uut/btn # DEBUG


