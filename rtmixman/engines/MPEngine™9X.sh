#MPEngine™ integrated
#if you're running this engine on a terminal emulator, keep that terminal running in the background.
#MPEngine™9X

(while true;
	do
		VALUE7=\`cat /system/etc/usrsettings | grep VALUE7 | sed 's/VALUE7=//'\`;
		#value check.
		if [ \$VALUE7 -le 2 ];
			then
				echo "an invalid value has been encountered in usrsettings.";
				exit 0;
		fi;
		SKIP=\$((\$VALUE7/2));
		SLUG=\$((\$VALUE7*2));
		MFK=\`cat /proc/sys/vm/min_free_kbytes\`;
		FREEMEM=\`free | awk '{ print \$4 }' | sed -n 2p\`;
		CACHESIZE=\`cat /proc/meminfo | grep Cached | awk '{print \$2}' | sed -n 1p\`;
		TOTALMEM=\`free | awk '{ print \$2 }' | sed -n 2p\`;
		REALTOTALMEM=\$((\$TOTALMEM-\$MFK));
		MEMINUSE=\$((\$CACHESIZE+\$FREEMEM));
		VALUE8=\`cat /system/etc/usrsettings | grep VALUE8 | sed 's/VALUE8=//'\`;
		VALUE9=\`cat /system/etc/usrsettings | grep VALUE9 | sed 's/VALUE9=//'\`;
		#value check.
		if [ \$VALUE8 -le 0 ];
			then
				echo "an invalid value has been encountered in usrsettings.";
				exit 0;
		fi;
		if [ \$VALUE9 -le 0 ];
			then
				echo "an invalid value has been encountered in usrsettings.";
				exit 0;
		fi;
		VALUE10=\`cat /system/etc/usrsettings | grep VALUE10 | sed 's/VALUE10=//'\`;
		DEADLINE=\$((\$REALTOTALMEM-\$MEMINUSE));
		DEADEND=\$((\$DEADLINE/\$VALUE8));
		DEADEND2=\$((\$DEADEND/\$VALUE9));
		if [ \$FREEMEM -le \$MFK ];
			then
				if [ \$VALUE10 == 0 ];
					then
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
				elif [ \$VALUE10 == 1 ];
					then
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
				else
					echo "an invalid value has been encountered in usrsettings.";
					sleep \$SLUG;
				fi;
		elif [ \$FREEMEM -gt \$MFK -a \$FREEMEM -le \$DEADEND2 ];
			then
				if [ \$VALUE10 == 0 ];
					then
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
				elif [ \$VALUE10 == 1 ];
					then
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$SKIP;
				else
					echo "an invalid value has been encountered in usrsettings.";
					sleep \$VALUE7;
				fi;
		elif [ \$FREEMEM -gt \$DEADEND2 -a \$FREEMEM -le \$DEADEND ];
			then
				if [ \$VALUE10 == 0 ];
					then
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$VALUE7;
				elif [ \$VALUE10 == 1 ];
					then
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$VALUE7;
						busybox sync; echo 1 > /proc/sys/vm/drop_caches;
						sleep \$VALUE7;
				else
					echo "an invalid value has been encountered in usrsettings.";
					sleep \$VALUE7;
				fi;
		elif [ \$FREEMEM -gt \$DEADEND -a \$FREEMEM -le \$MEMINUSE ];
			then
				if [ \$VALUE10 == 0 ];
					then
						sleep \$VALUE7;
				elif [ \$VALUE10 == 1 ];
					then
						sleep \$SLUG;
				else
					echo "an invalid value has been encountered in usrsettings.";
					sleep \$VALUE7;
				fi;
		else
			if [ \$VALUE10 == 0 ];
				then
					sleep \$VALUE7;
			elif [ \$VALUE10 == 1 ];
				then
					sleep \$SLUG;
			else
				echo "an invalid value has been encountered in usrsettings.";
				sleep \$VALUE7;
			fi;
		fi;
	done &);
