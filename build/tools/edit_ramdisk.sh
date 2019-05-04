#!/sbin/sh

CONFIGFILE="/tmp/init.radon.rc"
INTERACTIVE=$(cat /tmp/aroma/interactive.prop | cut -d '=' -f2)
if [ $INTERACTIVE == 1 ]; then
TLS="80 400000:33 691200:25 806400:50 1017600:65 1190400:70 1305600:85 1382400:90 1401600:92"
TLB="74 998400:73 1056000:64 1113600:80 1190400:61 1248000:69 1305600:64 1382400:74 1612800:69 1747200:67 1804800:72"
BOOSTENB=1
BOOST="1017600 883200"
BOOSTMS=64
HSFS=1382400
HSFB=1305600
FMS=691200
FMB=883200
FMAS=1401600
FMAB=1804800
TR=40000
AID=N
ABST=0
TBST=1
GHLS=85
GHLB=90
SWAP=40
VFS=100
GLVL=6
GFREQ=266666667
IOSCHED=maple
elif [ $INTERACTIVE == 2 ]; then
TLS="80 1017600:85 1190400:99"
TLB="90 1056600:99"
BOOSTENB=0
BOOST="691200 883200"
BOOSTMS=0
HSFS=1190400
HSFB=1056000
FMS=691200
FMB=883200
FMAS=1305600
FMAB=1612600
TR=60000
AID=Y
ABST=0
TBST=0
GHLS=99
GHLB=99
SWAP=20
VFS=40
GLVL=6
GFREQ=266666667
IOSCHED=noop
elif [ $INTERACTIVE == 3 ]; then
TLS="40 1017600:50 1190400:60 1305600:70 1382400:75 1401600:80"
TLB="74 998400:73 1056000:64 1113600:80 1190400:61 1248000:69 1305600:64 1382400:74 1612800:69 1747200:67 1804800:72"
BOOSTENB=1
BOOST="1305600 1305600"
BOOSTMS=1000
HSFS=1401600
HSFB=1382400
FMS=691200
FMB=883200
FMAS=1401600
FMAB=1804800
TR=20000
AID=N
ABST=1
TBST=1
GHLS=80
GHLB=85
SWAP=40
VFS=100
GLVL=6
GFREQ=266666667
IOSCHED=maple
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
echo "# VARIABLES FOR SH" >> $CONFIGFILE
echo "# zrammode=$INTERACTIVE" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# USER TWEAKS" >> $CONFIGFILE
echo "service usertweaks /system/bin/sh /system/etc/radon.sh" >> $CONFIGFILE
echo "class main" >> $CONFIGFILE
echo "group root" >> $CONFIGFILE
echo "user root" >> $CONFIGFILE
echo "oneshot" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on boot" >> $CONFIGFILE
echo "# Improve boot time and let things settle fast" >> $CONFIGFILE
echo "write /dev/cpuset/foreground/cpus 0-5" >> $CONFIGFILE
echo "write /dev/cpuset/background/cpus 0-5" >> $CONFIGFILE
echo "write /dev/cpuset/system-background/cpus 0-5" >> $CONFIGFILE
echo "write /dev/cpuset/top-app/cpus 0-5" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Enable sched boost" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_boost 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on property:init.svc.vendor.qcom-post-boot=stopped" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# SWAPPINESS AND VFS CACHE PRESSURE" >> $CONFIGFILE
echo "write /proc/sys/vm/swappiness $SWAP" >> $CONFIGFILE
echo "write /proc/sys/vm/vfs_cache_pressure $VFS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Disable sched boost" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_boost 0" >> $CONFIGFILE
if [ $DT2W -ne 4 ]; then
echo "" >> $CONFIGFILE
echo "# DT2W" >> $CONFIGFILE
echo "write /sys/android_touch/doubletap2wake " $DTP >> $CONFIGFILE
echo "write /sys/android_touch/vib_strength " $VIBS >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
COLOR=$(cat /tmp/aroma/color.prop | cut -d '=' -f2)
echo "# KCAL" >> $CONFIGFILE
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
echo "# CHARGING RATE" >> $CONFIGFILE
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
echo "# DISABLE BCL & CORE CTL" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_soc_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "chmod 0644 /sys/module/msm_thermal/vdd_restriction/enable" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/vdd_restriction/enable 0" >> $CONFIGFILE
echo "chmod 0444 /sys/module/msm_thermal/vdd_restriction/enable" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# BRING CORES ONLINE" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/online 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# TWEAK A53 CLUSTER GOVERNOR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor \"interactive\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load $GHLS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate $TR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack -1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq $HSFS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads \"$TLS\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 50000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq $FMS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq $FMAS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis 166667" >> $CONFIGFILE

echo "" >> $CONFIGFILE
echo "# TWEAK A72 CLUSTER GOVERNOR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor \"interactive\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load $GHLB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate $TR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack -1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq $HSFB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads \"$TLB\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 30000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq $FMB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq $FMAB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 20000" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# GPU SETTINGS" >> $CONFIGFILE
echo "write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel $GLVL" >> $CONFIGFILE
echo "write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel $GLVL" >> $CONFIGFILE
echo "write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/min_freq $GFREQ" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# CPU BOOST PARAMETERS" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/enabled $BOOSTENB" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/ib_freqs \"$BOOST\"" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/ib_duration_ms $BOOSTMS" >> $CONFIGFILE
echo "write /sys/kernel/cpu_input_boost/fb_duration_ms $BOOSTMS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# TOUCH BOOST" >> $CONFIGFILE
echo "write /sys/module/msm_performance/parameters/touchboost $TBST" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# ADRENO IDLER" >> $CONFIGFILE
echo "write /sys/module/adreno_idler/parameters/adreno_idler_active $AID" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# ADRENO BOOST" >> $CONFIGFILE
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost $ABST" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# FSYNC" >> $CONFIGFILE
echo "write /sys/module/sync/parameters/fsync_enabled $DFS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# CPU & GPU UV" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"700 720 760 800 860 900 920 980 1020\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"720 740 800 900 960 1000 1030 1040 740 760 780 850 890 950 1000\"" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Some sched tweaks" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_upmigrate 90" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_downmigrate 85" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_use_shadow_scheduling 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_shadow_upmigrate 90" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_shadow_downmigrate 85" >> $CONFIGFILE
echo "# android background processes are set to nice 10. Never schedule these on the a57s." >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_upmigrate_min_nice 9" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_window_stats_policy 2" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_ravg_hist_size 5" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_inc_notify 10485760" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_dec_notify 10485760" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_enable_power_aware 0" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_enable_colocation 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_cpu_high_irqload 10000000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_child_runs_first 0" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_account_wait_time 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_grp_task_active_windows 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_account_wait_time 0" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_rt_period_us 1000000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_rt_timeslice_ms 10" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_rt_runtime_us 950000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_power_band_limit 20" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_min_runtime 0" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_migration_fixup 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_init_task_load 15" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_heavy_task 0" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_wakeup_load_threshold 110" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_spill_nr_run 10" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_spill_load 100" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_small_task 30" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run 3" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run 3" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run 3" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run 3" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run 3" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run 3" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# SET PROPER DEVFREQ GOVERNORS FOR CPU" >> $CONFIGFILE
echo "write /sys/class/devfreq/mincpubw/governor \"cpufreq\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/governor \"bw_hwmon\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/io_percent 20" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/guard_band_mbps 30" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# HMP Task packing settings for 8956" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_small_task 30" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/sched_mostly_idle_load 20" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/sched_mostly_idle_load 20" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/sched_mostly_idle_load 20" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/sched_mostly_idle_load 20" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/sched_mostly_idle_load 20" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/sched_mostly_idle_load 20" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Enable LPM Prediction" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/parameters/lpm_prediction 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Enable Low power modes" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/parameters/sleep_disabled 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Disable L2 GDHS on 8976" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/system/a53/a53-l2-gdhs/idle_enabled \"N\"" >> $CONFIGFILE
echo "write /sys/module/lpm_levels/system/a72/a72-l2-gdhs/idle_enabled \"N\"" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# Enable timer migration to little cluster" >> $CONFIGFILE
echo "write /proc/sys/kernel/power_aware_timer_migration 1" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# Enable sched colocation and colocation inheritance" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_grp_upmigrate 130" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_grp_downmigrate 110" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_enable_thread_grouping 1" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# set (super) packing parameters" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq 1017600" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq 0" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# ENABLE HIGH PERFORMANCE AUDIO MODE" >> $CONFIGFILE
echo "write /sys/module/snd_soc_msm8x16_wcd/parameters/high_perf_mode 1" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# Disable arch power" >> $CONFIGFILE
echo "write /sys/kernel/sched/arch_power 0" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# SET IO SCHEDULER AND READAHEAD" >> $CONFIGFILE
echo "setprop sys.io.scheduler \"$IOSCHED\"" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/scheduler $IOSCHED" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/iostats 1" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/nr_requests 128" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 128" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/scheduler $IOSCHED" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/iostats 1" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/nr_requests 128" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/read_ahead_kb 128" >> $CONFIGFILE
echo " " >> $CONFIGFILE
echo "# RUN USERTWEAKS SERVICE" >> $CONFIGFILE
echo "start usertweaks" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# Reconfigure cpuset to optimum values" >> $CONFIGFILE
echo "write /dev/cpuset/foreground/cpus 0-4" >> $CONFIGFILE
echo "write /dev/cpuset/foreground/boost/cpus 4-5" >> $CONFIGFILE
echo "# Enable 2 cores for background to improve app switching and usability" >> $CONFIGFILE
echo "write /dev/cpuset/background/cpus 0-1" >> $CONFIGFILE
echo "write /dev/cpuset/system-background/cpus 0-3" >> $CONFIGFILE
echo "write /dev/cpuset/top-app/cpus 0-5" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# CONFIGURE ZSWAP " >> $CONFIGFILE
echo "write /sys/module/zswap/parameters/compressor lz4" >> $CONFIGFILE
echo "write /sys/module/zswap/parameters/zpool zsmalloc" >> $CONFIGFILE
echo "write /sys/module/zswap/parameters/max_pool_percent 50" >> $CONFIGFILE
echo "write /sys/module/zswap/parameters/enabled 1" >> $CONFIGFILE