# file: audioDsp.tcl
# purp: setup waveforms for audiodsp simulation
# run: cd C:\...
#      source audioDsp.tcl
#      run 4 ms

#### reset ####
restart
remove_wave [get_waves *]

#### general waves ####
set groupColor WHITE
set GENID [add_wave_group "general"]
add_wave -into $GENID -color $groupColor /audiodsp_tb/uut/clk
add_wave -into $GENID -color $groupColor /audiodsp_tb/uut/resetn

#### adc interface waves ####
set groupColor RED
set ADCID [add_wave_group "adcinter"]
add_wave -into $ADCID -color $groupColor /audiodsp_tb/uut/adcInterface/ctrlpath/state

add_wave -into $ADCID -color $groupColor -radix dec /audiodsp_tb/uut/adcInterface/sample
add_wave -into $ADCID -color $groupColor -radix hex /audiodsp_tb/uut/an7606data
add_wave -into $ADCID -color $groupColor /audiodsp_tb/uut/adcInterface/an7606convst
add_wave -into $ADCID -color $groupColor /audiodsp_tb/uut/adcInterface/an7606cs
add_wave -into $ADCID -color $groupColor /audiodsp_tb/uut/adcInterface/an7606rd
add_wave -into $ADCID -color $groupColor /audiodsp_tb/uut/adcInterface/an7606reset
add_wave -into $ADCID -color $groupColor /audiodsp_tb/uut/adcInterface/an7606busy

# add_wave -into $ADCID -color $groupColor -radix hex	/audiodsp_tb/uut/adcInterface/datapath/chSamples/q0
# add_wave -into $ADCID -color $groupColor -radix hex	/audiodsp_tb/uut/adcInterface/datapath/chSamples/q1
# add_wave -into $ADCID -color $groupColor -radix hex	/audiodsp_tb/uut/adcInterface/datapath/chSamples/q2
# add_wave -into $ADCID -color $groupColor -radix hex	/audiodsp_tb/uut/adcInterface/datapath/chSamples/q3

#### epwm waves ####
set groupColor GOLD
set EPWMID [add_wave_group "epwm"]
add_wave -into $EPWMID -color $groupColor /audiodsp_tb/uut/ePwm/enb
add_wave -into $EPWMID -color $groupColor /audiodsp_tb/uut/ePwm/pwmSignal
add_wave -into $EPWMID -color $groupColor /audiodsp_tb/uut/pwmSignal
add_wave -into $EPWMID -color $groupColor /audiodsp_tb/uut/ePwm/rollReload
add_wave -into $EPWMID -color $groupColor -radix dec /audiodsp_tb/uut/ePwm/pwmCount
add_wave -into $EPWMID -color $groupColor -radix dec /audiodsp_tb/uut/ePwm/stepsHigh
add_wave -into $EPWMID -color $groupColor -radix dec /audiodsp_tb/uut/ePwm/dutyCycle

#### aff waves ####
set groupColor CYAN
set AFFID [add_wave_group "aff"]
add_wave -into $AFFID -color $groupColor /audiodsp_tb/uut/sampready
add_wave -into $AFFID -color $groupColor /audiodsp_tb/uut/AAFsampready
add_wave -into $AFFID -color $groupColor -radix dec /audiodsp_tb/uut/sample
add_wave -into $AFFID -color $groupColor -radix dec /audiodsp_tb/uut/AAFsample24
add_wave -into $AFFID -color $groupColor -radix dec /audiodsp_tb/uut/AAFsample

#### downsamplerx4 waves ####
set groupColor CYAN
set DWNSID [add_wave_group "downsampler x4"]
add_wave -into $DWNSID -color $groupColor /audiodsp_tb/uut/D4sampler/sampready
add_wave -into $DWNSID -color $groupColor /audiodsp_tb/uut/D4sampler/sampreadyd4
add_wave -into $DWNSID -color $groupColor -radix dec /audiodsp_tb/uut/D4sampler/sample
add_wave -into $DWNSID -color $groupColor -radix dec /audiodsp_tb/uut/D4sampler/sampled4
add_wave -into $DWNSID -color $groupColor -radix dec /audiodsp_tb/uut/D4sampler/count

#### lpf waves ####
set groupColor CYAN
set LPFID [add_wave_group "lpf"]
add_wave -into $LPFID -color $groupColor /audiodsp_tb/uut/D4sampready
add_wave -into $LPFID -color $groupColor /audiodsp_tb/uut/LPFsampready
add_wave -into $LPFID -color $groupColor -radix dec /audiodsp_tb/uut/D4sample
add_wave -into $LPFID -color $groupColor -radix dec /audiodsp_tb/uut/LPFsample24
add_wave -into $LPFID -color $groupColor -radix dec /audiodsp_tb/uut/LPFsample

# #### bpf waves ####
# set groupColor CYAN
# set BPFID [add_wave_group "bpf"]
# add_wave -into $BPFID -color $groupColor /audiodsp_tb/uut/D4sampready
# add_wave -into $BPFID -color $groupColor /audiodsp_tb/uut/BPFsampready
# add_wave -into $BPFID -color $groupColor -radix unsigned /audiodsp_tb/uut/D4sample
# add_wave -into $BPFID -color $groupColor -radix unsigned /audiodsp_tb/uut/BPFsample

# #### hpf waves ####
# set groupColor CYAN
# set HPFID [add_wave_group "hpf"]
# add_wave -into $HPFID -color $groupColor /audiodsp_tb/uut/D4sampready
# add_wave -into $HPFID -color $groupColor /audiodsp_tb/uut/HPFsampready
# add_wave -into $HPFID -color $groupColor -radix unsigned /audiodsp_tb/uut/D4sample
# add_wave -into $HPFID -color $groupColor -radix unsigned /audiodsp_tb/uut/HPFsample

# author: jack martin, raul gerhardus
# date: 4/26/2024