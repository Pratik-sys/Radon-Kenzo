#!/system/bin/sh
# SPECTRUM KERNEL MANAGER
# Profile initialization by Zile995
# Kanged shamelessly by ScreaMySkrillEX to phix cores stuck cuz moi nub af.

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}

value=`getprop persist.spectrum.profile`

# Set CPU profile (Some rom developers like to mess with these settings, so make sure these settings are applied properly)

if [[ $value -eq 0 ]]; then
    write /sys/devices/system/cpu/cpu0/online 1
    write /sys/devices/system/cpu/cpu1/online 1
    write /sys/devices/system/cpu/cpu2/online 1
    write /sys/devices/system/cpu/cpu3/online 1
    write /sys/devices/system/cpu/cpu4/online 1
    write /sys/devices/system/cpu/cpu5/online 1
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 691200
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1478400
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1478400
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "50 1017600:60 1190400:70 1305600:80 1382400:90 1478400:95"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 883200
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1843200
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 90
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1382400
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "85 1382400:90 1747200:95"
    write /sys/kernel/cpu_input_boost/enabled 1
	write /sys/kernel/cpu_input_boost/ib_freqs "1190400 883200"
	write /sys/kernel/cpu_input_boost/ib_duration_ms 100
    write /sys/module/adreno_idler/parameters/adreno_idler_active N
    write /sys/class/kgsl/kgsl-3d0/max_gpuclk 621330000
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel 7
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel 7
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/min_freq 266666667
    write /sys/block/mmcblk0/queue/scheduler cfq
    write /sys/block/mmcblk1/queue/scheduler cfq
    write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 0
elif [[ $value -eq 1 ]]; then
    write /sys/devices/system/cpu/cpu0/online 1
    write /sys/devices/system/cpu/cpu1/online 1
    write /sys/devices/system/cpu/cpu2/online 1
    write /sys/devices/system/cpu/cpu3/online 1
    write /sys/devices/system/cpu/cpu4/online 1
    write /sys/devices/system/cpu/cpu5/online 1
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 691200
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1478400
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 95
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1478400
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "40 1017600:50 1190400:60 1305600:70 1382400:80 1478400:90"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 883200
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 2035200
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 80
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1382400
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "75 1382400:80 1747200:85"
    write /sys/kernel/cpu_input_boost/enabled 1
	write /sys/kernel/cpu_input_boost/ib_freqs "1305600 998400"
	write /sys/kernel/cpu_input_boost/ib_duration_ms 1000
    write /sys/module/adreno_idler/parameters/adreno_idler_active N
    write /sys/class/kgsl/kgsl-3d0/max_gpuclk 710000000
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel 7
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel 7
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/min_freq 266666667
    write /sys/block/mmcblk0/queue/scheduler fiops
    write /sys/block/mmcblk1/queue/scheduler fiops
    write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 1
elif [[ $value -eq 2 ]]; then
    write /sys/devices/system/cpu/cpu0/online 1
    write /sys/devices/system/cpu/cpu1/online 1
    write /sys/devices/system/cpu/cpu2/online 1
    write /sys/devices/system/cpu/cpu3/online 1
    write /sys/devices/system/cpu/cpu4/online 1
    write /sys/devices/system/cpu/cpu5/online 1
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 400000
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1305600
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1190400
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 40000
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "75 1017600:85 1190400:95"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 400000
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1190400
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 100
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1056000
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 40000
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "90 1056000:95"
    write /sys/kernel/cpu_input_boost/enabled 0
	write /sys/kernel/cpu_input_boost/ib_freqs "691200 883200"
	write /sys/kernel/cpu_input_boost/ib_duration_ms 0
    write /sys/module/adreno_idler/parameters/adreno_idler_active Y
    write /sys/class/kgsl/kgsl-3d0/max_gpuclk 432000000
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel 8
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel 8
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/min_freq 200000000
    write /sys/block/mmcblk0/queue/scheduler noop
    write /sys/block/mmcblk1/queue/scheduler noop
    write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 0
    write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
else [[ $value -eq 3 ]];
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 691200
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1478400
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 883200
    write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 2035200
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 80
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1478400
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
    write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "40 1017600:50 1190400:60 1305600:70 1382400:80 1478400:90"
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 85
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1843200
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000
    write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "75 1382400:80 1747200:85"
    write /sys/kernel/cpu_input_boost/enabled 1
	write /sys/kernel/cpu_input_boost/ib_freqs "1305600 998400"
	write /sys/kernel/cpu_input_boost/ib_duration_ms 1000
    write /sys/module/adreno_idler/parameters/adreno_idler_active N
    write /sys/class/kgsl/kgsl-3d0/max_gpuclk 710000000
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel 7
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel 7
	write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/min_freq 266666667
    write /sys/block/mmcblk0/queue/scheduler fiops
    write /sys/block/mmcblk1/queue/scheduler fiops
	write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 2
fi
