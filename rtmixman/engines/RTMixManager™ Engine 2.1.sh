#RTMixManager™ Engine 2.1
#replaced with renice command which is very complex as hell.
setprop ENFORCE_PROCESS_LIMIT false
#background app adj parameter changes to 7 or 8 by default.
VALUE6=\`cat /system/etc/usrsettings | grep VALUE6 | sed 's/VALUE6=//'\`;
if [ \$VALUE6 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/adj ];
			then
				echo 1,2,4,6,7,8 > /sys/module/lowmemorykiller/parameters/adj;
		fi;
elif [ \$VALUE6 == 2 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/adj ];
			then
				echo 0,1,2,4,6,7 > /sys/module/lowmemorykiller/parameters/adj;
		fi;
elif [ \$VALUE6 == 3 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/adj ];
			then
				echo 2,4,6,7,8,9 > /sys/module/lowmemorykiller/parameters/adj;
		fi;
else
	echo "an invalid value has been encountered in usrsettings.";
fi;
#retrieve current adj parameter settings.
adj1=\`awk -F , '{print \$1}' /sys/module/lowmemorykiller/parameters/adj\`;
adj2=\`awk -F , '{print \$2}' /sys/module/lowmemorykiller/parameters/adj\`;
adj3=\`awk -F , '{print \$3}' /sys/module/lowmemorykiller/parameters/adj\`;
adj4=\`awk -F , '{print \$4}' /sys/module/lowmemorykiller/parameters/adj\`;
adj5=\`awk -F , '{print \$5}' /sys/module/lowmemorykiller/parameters/adj\`;
adj6=\`awk -F , '{print \$6}' /sys/module/lowmemorykiller/parameters/adj\`;
#calculation based on optimal cachesize.
TOTALMEM=\`free | awk '{ print \$2 }' | sed -n 2p\`;
totalpage=\$((\$TOTALMEM/4));
cachepage=\$((\$totalpage/6));
#try to block service apps from being terminated, combined with Straight Flush Technology!
if [ \$adj1 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
			then
				echo 0,\$cachepage,\$cachepage,\$cachepage,\$cachepage,\$cachepage > /sys/module/lowmemorykiller/parameters/minfree;
		fi;
elif [ \$adj2 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
			then
				echo 0,0,\$cachepage,\$cachepage,\$cachepage,\$cachepage > /sys/module/lowmemorykiller/parameters/minfree;
		fi;
elif [ \$adj3 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
			then
				echo 0,0,0,\$cachepage,\$cachepage,\$cachepage > /sys/module/lowmemorykiller/parameters/minfree;
		fi;
elif [ \$adj4 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
			then
				echo 0,0,0,0,\$cachepage,\$cachepage > /sys/module/lowmemorykiller/parameters/minfree;
		fi;
elif [ \$adj5 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
			then
				echo 0,0,0,0,0,\$cachepage > /sys/module/lowmemorykiller/parameters/minfree;
		fi;
elif [ \$adj6 == 1 ];
	then
		if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
			then
				echo 0,0,0,0,0,0 > /sys/module/lowmemorykiller/parameters/minfree;
		fi;
else
	if [ -e /sys/module/lowmemorykiller/parameters/minfree ];
		then
			echo \$cachepage,\$cachepage,\$cachepage,\$cachepage,\$cachepage,\$cachepage > /sys/module/lowmemorykiller/parameters/minfree;
	fi;
fi;
#android.process.acore that shares the same mother process with android.process.media should also be locked in memory.

(while true;
	do
		if pidof android.process.acore;
			then
				echo -12 > /proc/\`pidof android.process.acore\`/oom_adj;
		fi 1>/dev/null;
		sleep 30;
	done &);

