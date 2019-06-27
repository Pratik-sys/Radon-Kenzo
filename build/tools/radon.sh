#!/sbin/sh
 #
 # Type any shell commands here
 #
 # They will execute on every boot
 #
 # Lines starting with # are just comments
 #
 # Enjoy !
 #
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}
    #Set Low memory killer minfree parameters
    # 64 bit up to 2GB with use 14K, and above 2GB will use 18K
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # 64 bit will have 81K 
    chmod 0660 /sys/module/lowmemorykiller/parameters/minfree
    echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
    echo "18432,23040,27648,32256,36864,46080" > /sys/module/lowmemorykiller/parameters/minfree
    if [ $MemTotal -gt 2000000 ]; then
        echo 40 > /proc/sys/vm/swappiness
    else
	    echo 60 > /proc/sys/vm/swappiness
    fi
    
	swapoff /dev/block/zram0  > /dev/null 2>&1
    echo 1 > /sys/block/zram0/reset
	echo 805306368 > /sys/block/zram0/disksize
	mkswap /dev/block/zram0
	swapon /dev/block/zram0
	fi
	
	