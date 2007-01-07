BEGIN {
	FS = " "
	OFS = "\t"
	
	dim = ""
}

match($0,/^SRA/) {

	# print last record
	if (dim != "") {
		if (cost_before == "-" || kthread_cost == "-" || reptx_cost == "-" || time == "-") {
			exit
		}
		print dim,window,kvalue,file,cost_before,kthread_cost,reptx_cost,time
	}
	
	# new record
	dim = substr($1,5,7)
	file = substr($1,index($1,"25-")+3,2)
	kvalue = substr($2,index($2,"KTHREAD-")+8,1)
	window = substr($3,10,index($3,"K")-10)
	
	# reset data
	cost_before = "-"
	kthread_cost = "-"
	reptx_cost = "-"
	time = "-"
	
	next;
}

match($0,/^Total border/) {
	if (cost_before == "-") {
		cost_before = $7
	} else if (kthread_cost == "-") {
		kthread_cost =  $7
	} else if (reptx_cost == "-") {
		reptx_cost =  $7
	} else {
		exit
	}
	next;
}

match($0,/^Average conflict/) {
	if (cost_before == "-") {
		cost_before = $4
	} else if (kthread_cost == "-") {
		kthread_cost =  $4
	} else if (reptx_cost == "-") {
		reptx_cost =  $4
	} else {
		exit
	}
	next;
}

match($0,/^Total time/) {
	time = $3
	next;
}

END {
	if (cost_before == "-" || kthread_cost == "-" || reptx_cost == "-" || time == "-") {
		printf ("Incomplete or inconsistent data for dimension %s, file %s, window %s, kvalue %s.\n",dim, file, window, kvalue)
		exit
	}
	print dim,window,kvalue,file,cost_before,kthread_cost,reptx_cost,time
}
