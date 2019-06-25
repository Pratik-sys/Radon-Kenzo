#!/sbin/sh

CONFIGFILE="/tmp/init.radon.sh"
INTERACTIVE=$(cat /tmp/aroma/interactive.prop | cut -d '=' -f2)
if [ $INTERACTIVE == 1 ]; then
TLS="50 1017600:60 1190400:70 1305600:80 1382400:90 1478400:95"
TLB="85 1382400:90 1747200:95"
BOOSTENB=1
BOOST="1190400 883200"
BOOSTMS=100
HSFS=1478400
HSFB=1382400
FMS=691200
FMB=883200
FMAS=1478400
FMAB=1843200
TR=20000
AID=N
ABST=0
TBST=1
GHLS=100
GHLB=90
GLVL=7
GLVLD=7
GFREQ=266666667
GMAX=621330000
IOSCHED=cfq
elif [ $INTERACTIVE == 2 ]; then
TLS="75 1017600:85 1190400:95"
TLB="90 1305600:95"
BOOSTENB=0
BOOST="0"
BOOSTMS=0
HSFS=1305600
HSFB=1612600
FMS=400000
FMB=400000
FMAS=1305600
FMAB=1612600
TR=40000
AID=Y
ABST=0
TBST=0
GHLS=100
GHLB=100
GLVL=8
GLVLD=8
GFREQ=200000000
GMAX=432000000
IOSCHED=noop
elif [ $INTERACTIVE == 3 ]; then
TLS="40 1017600:50 1190400:60 1305600:70 1382400:80 1478400:90"
TLB="75 1382400:80 1747200:85"
BOOSTENB=1
BOOST="1305600 998400"
BOOSTMS=1000
HSFS=1478400
HSFB=1382400
FMS=691200
FMB=883200
FMAS=1478400
FMAB=2035200
TR=20000
AID=N
ABST=2
TBST=1
GHLS=95
GHLB=80
GLVL=7
GLVLD=7
GFREQ=266666667
GMAX=710000000
IOSCHED=fiops
fi
DT2W=$(cat /tmp/aroma/dt2w.prop | cut -d '=' -f2)
if [ $DT2W == 1 ]; then
DTP=1
VIBS=50
elif [ $DT2W == 2 ]; then
DTP=1
VIBS=0
elif [ $DT2W == 3 ]; then
DTP=0
VIBS=50
fi
DFSC=$(cat /tmp/aroma/dfs.prop | cut -d '=' -f2)
if [ $DFSC == 1 ]; then
DFS=1
elif [ $DFSC == 2 ]; then
DFS=0
fi
echo "{" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo " sleep 30" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /proc/sys/vm/vfs_cache_pressure 100" >> $CONFIGFILE
echo "" >> $CONFIGFILE
if [ $DT2W -ne 4 ]; then
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /sys/android_touch/doubletap2wake " $DTP >> $CONFIGFILE
echo "write /sys/android_touch/vib_strength " $VIBS >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
COLOR=$(cat /tmp/aroma/color.prop | cut -d '=' -f2)
echo " " >> $CONFIGFILE
if [ $COLOR == 1 ]; then
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 269" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 256" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 256" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"254 252 230"\" >> $CONFIGFILE
elif [ $COLOR == 2 ]; then
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 269" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 256" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 256" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"254 254 240"\" >> $CONFIGFILE
elif [ $COLOR == 3 ]; then
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 255" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 255" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 255" >> $CONFIGFILE
echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"256 256 256"\" >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
CRATE=$(cat /tmp/aroma/crate.prop | cut -d '=' -f2)
if [ $CRATE == 1 ]; then
CHG=2000
elif [ $CRATE == 2 ]; then
CHG=2400
fi 
echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma" >> $CONFIGFILE
echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma" >> $CONFIGFILE
echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma" >> $CONFIGFILE
echo "write /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma $CHG" >> $CONFIGFILE
echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma $CHG" >> $CONFIGFILE
echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma $CHG" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_soc_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "chmod 0644 /sys/module/msm_thermal/vdd_restriction/enable" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/vdd_restriction/enable 0" >> $CONFIGFILE
echo "chmod 0444 /sys/module/msm_thermal/vdd_restriction/enable" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/online 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor \"interactive\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load $GHLS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate $TR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq $HSFS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads \"$TLS\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq $FMS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq $FMAS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor \"interactive\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay \"19000 1382400:39000\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load $GHLB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate $TR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq $HSFB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads \"$TLB\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq $FMB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq $FMAB" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/class/kgsl/kgsl-3d0/max_gpuclk $GMAX" >> $CONFIGFILE
echo "write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel $GLVLD" >> $CONFIGFILE
echo "write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel $GLVL" >> $CONFIGFILE
echo "write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/min_freq $GFREQ" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/enabled $BOOSTENB" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/ib_freqs \"$BOOST\"" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/ib_duration_ms $BOOSTMS" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/fb_duration_ms 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/msm_performance/parameters/touchboost 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/adreno_idler/parameters/adreno_idler_active $AID" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost $ABST" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/sync/parameters/fsync_enabled 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"720 740 800 890 945 980 1005 1010 740 760 780 870 930 965 990 1020\"" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_upmigrate 85" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_downmigrate 80" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_use_shadow_scheduling 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_shadow_upmigrate 85" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_shadow_downmigrate 80" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_upmigrate_min_nice 9" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_inc_notify 200000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_dec_notify 20000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_enable_power_aware 0" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_small_task 30" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run 6" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run 6" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run 6" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run 6" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run 6" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run 6" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/class/devfreq/mincpubw/governor \"cpufreq\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/governor \"bw_hwmon\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/io_percent 20" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/guard_band_mbps 30" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/sched_mostly_idle_load 25" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/sched_mostly_idle_load 25" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/sched_mostly_idle_load 25" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/sched_mostly_idle_load 25" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/sched_mostly_idle_load 25" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/sched_mostly_idle_load 25" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/parameters/lpm_prediction 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/parameters/sleep_disabled 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/system/a53/a53-l2-gdhs/idle_enabled \"N\"" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/system/a72/a72-l2-gdhs/idle_enabled \"N\"" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /proc/sys/kernel/power_aware_timer_migration 1" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_grp_upmigrate 130" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_grp_downmigrate 110" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_enable_thread_grouping 1" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq 0" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/snd_soc_msm8x16_wcd/parameters/high_perf_mode 1" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/kernel/sched/arch_power 0" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "setprop sys.io.scheduler \"$IOSCHED\"" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/scheduler $IOSCHED" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/iostats 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/nr_requests 128" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 128" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/scheduler $IOSCHED" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/iostats 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/nr_requests 128" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/read_ahead_kb 128" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "write /sys/module/lowmemorykiller/parameters/vmpressure_file_min 81250" >> $CONFIGFILE
echo "write /sys/module/process_reclaim/parameters/enable_process_reclaim 1" >> $CONFIGFILE
echo "write /sys/module/process_reclaim/parameters/pressure_min 10" >> $CONFIGFILE
echo "write /sys/module/process_reclaim/parameters/per_swap_size 1024" >> $CONFIGFILE
echo "write /sys/module/process_reclaim/parameters/swap_opt_eff 30" >> $CONFIGFILE
echo "write /sys/module/process_reclaim/parameters/pressure_max 70" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "sh /system/etc/radon.sh" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /dev/cpuset/foreground/cpus 0-5" >> $CONFIGFILE
echo "write /dev/cpuset/background/cpus 0-3" >> $CONFIGFILE
echo "write /dev/cpuset/system-background/cpus 0-3" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/zswap/parameters/enabled 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_boost 0" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "}&" >> $CONFIGFILE