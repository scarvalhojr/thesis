BEGIN {
	FS = " "
	OFS = "\t"
	
	dim = ""
}

match($0,/^SRA/) {

	# print last record
	if (dim != "") {
		if (window == "" || kvalue == "" || before == "-" || after == "-" || time == "-") {
			exit
		}
		print dim,window,kvalue,file,after,time,before
	}
	
	# new record
	dim = substr($1,5,7)
	file = substr($1,index($1,"25-")+3,2)
	
	# reset data
	window = "-"
	kvalue = "-"
	before = "-"
	after = "-"
	time = "-"
	
	next;
}

match($0,/^Running/) {
	match($2,/(BL|CI)\-[0-9]+/)
	window = substr($2,RSTART+3,RLENGTH-3)
	kvalue = substr($2,RSTART+RLENGTH+1,1)
}

match($0,/^Total border/) {
	if (before == "-") {
		before = $7
	} else if (after == "-") {
		after =  $7
	} else {
		exit
	}
	next;
}

match($0,/^Average conflict/) {
	if (before == "-") {
		before = $4
	} else if (after == "-") {
		after =  $4
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
	if (window == "" || kvalue == "" || before == "-" || after == "-" || time == "-") {
		printf ("Incomplete or inconsistent data for dimension %s, file %s, window %s, kvalue %s.\n",dim, file, window, kvalue)
		exit
	}
	print dim,window,kvalue,file,after,time,before
}
