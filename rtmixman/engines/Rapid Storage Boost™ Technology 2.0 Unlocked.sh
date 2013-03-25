#Rapid Storage Boost™ Technology 2.0 Unlocked
#i came across with this code by this awk ward imagination in my mind lol:
#dalvik compiler starts to collect garbages when amount of growing size have reached the limit.(the limit is called heapsize.)
#dirty data also gets written out to disk when its growing size reached the limit,
#either by dirty_ratio or dirty_writeback_centisecs.(i'll go with dirty_ratio this time:))
#these two works as very similar, so i just connected them with my new code. interesting thing, isn't it?
#dirty_ratio/2=dirty_background_ratio=so_much_performance:D
TOTALMEM=\`free | awk '{ print \$2 }' | sed -n 2p\`;
dalvikvmheapsize=\`getprop dalvik.vm.heapsize | sed 's/m//'\`;
if getprop | grep -q dalvik.vm.heapgrowthlimit;
	then
		dalvikvmheapgrowthlimit=\`getprop dalvik.vm.heapgrowthlimit | sed 's/m//'\`;
		lmao=\$((\$dalvikvmheapsize+\$dalvikvmheapgrowthlimit));
		asdf=\$((\$lmao/2));
		dalvik_ratio=\$((\$TOTALMEM/\$asdf));
		result=\$((102400/\$dalvik_ratio));
		if [ -e /proc/sys/vm/dirty_ratio ];
			then
				echo \$result > /proc/sys/vm/dirty_ratio;
		fi;
		if [ -e /proc/sys/vm/dirty_background_ratio ];
			then
				echo \$result > /proc/sys/vm/dirty_background_ratio;
		fi;
else
	dalvik_ratio=\$((\$TOTALMEM/\$dalvikvmheapsize));
	result=\$((102400/\$dalvik_ratio));
	if [ -e /proc/sys/vm/dirty_ratio ];
		then
			echo \$result > /proc/sys/vm/dirty_ratio;
	fi;
	if [ -e /proc/sys/vm/dirty_background_ratio ];
		then
			echo \$result > /proc/sys/vm/dirty_background_ratio;
	fi;
fi;
#we're also gonna push lease-break-time into the writeback parameters.
LEASES=\`cat /proc/sys/fs/lease-break-time\`;
L2W=\$((\$LEASES*100));
if [ -e /proc/sys/vm/dirty_writeback_centisecs ];
	then
		echo \$L2W > /proc/sys/vm/dirty_writeback_centisecs;
fi;
if [ -e /proc/sys/vm/dirty_expire_centisecs ];
	then
		echo \$L2W > /proc/sys/vm/dirty_expire_centisecs;
fi;
