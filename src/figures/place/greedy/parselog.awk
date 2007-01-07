BEGIN {
	FS = " "
	OFS = "\t"
	
	dim = ""
}

match($0,/^SRA/) {

	# print last record
	if (dim != "") {
		if (before == "-" || after == "-" || time == "-") {
			exit
		}
		print dim,window,kvalue,file,after,time,before
	}
	
	# new record
	dim = substr($1,5,7)
	file = substr($1,index($1,"25-")+3,2)
	window = substr($2,17,index($2,"K-")-17)
	kvalue = substr($2,index($2,"K-")+2,1)
	
	# reset data
	before = "-"
	after = "-"
	time = "-"
	
	next;
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
	if (before == "-" || after == "-" || time == "-") {
		printf ("Incomplete or inconsistent data for dimension %s, file %s, window %s, kvalue %s.\n",dim, file, window, kvalue)
		exit
	}
	print dim,window,kvalue,file,after,time,before
}
