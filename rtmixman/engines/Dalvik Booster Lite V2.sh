#Dalvik Booster Lite V2
#(dalvikvmheapsize+dalvikvmheapgrowthlimit)/2=dalvikvmheapsized=pureawesomeness:D
if getprop | grep -q dalvik.vm.heapgrowthlimit;
	then
		dalvikvmheapsize=\`getprop dalvik.vm.heapsize | sed 's/m//'\`;
		dalvikvmheapgrowthlimit=\`getprop dalvik.vm.heapgrowthlimit | sed 's/m//'\`;
		dalvikvmheapsized=\$((\$dalvikvmheapsize/2));
		if [ \$dalvikvmheapsized -lt \$dalvikvmheapgrowthlimit ];
			then
				setprop persist.sys.vm.heapsize "\$dalvikvmheapgrowthlimit"m
				setprop dalvik.vm.heapsize "\$dalvikvmheapgrowthlimit"m;
		else
			setprop persist.sys.vm.heapsize "\$dalvikvmheapsized"m
			setprop dalvik.vm.heapsize "\$dalvikvmheapsized"m;
		fi;
else
	TOTALMEM=\`free | awk '{ print \$2 }' | sed -n 2p\`;
	dalvikvmheapsize=\$((\$TOTALMEM/6144));
	setprop persist.sys.vm.heapsize "\$dalvikvmheapsize"m
	setprop dalvik.vm.heapsize "\$dalvikvmheapsize"m;
	if [ \$TOTALMEM -le 524288 ];
		then
			setprop dalvik.vm.heapstartsize 5m;
	elif [ \$TOTALMEM -le 1048576 ];
		then
			setprop dalvik.vm.heapstartsize 8m;
	elif [ \$TOTALMEM -le 2097152 ];
		then
			setprop dalvik.vm.heapstartsize 16m;
	else
		setprop dalvik.vm.heapstartsize 16m;
	fi;
fi;
