BEGIN {
	FS = " "
	OFS = "\t"
	
	dim = ""
}

match($0,/^SRA/) {

	# print last record
	if (dim != "") {
		if (mode == "-" || window == "-" || kvalue == "-" || before == "-" || placement == "-" || time == "-") {
			exit
		}
		print mode,dim,window,kvalue,file,before,placement,time
	}
	
	# new record
	dim = substr($1,5,7)
	file = substr($1,index($1,"25-")+3,2)
	
	# reset data
	mode = "-"
	window = "-"
	kvalue = "-"
	before = "-"
	placement = "-"
	time = "-"
	
	next;
}

match($0,/^Running Greedy/) {
	match($2,/(BL|CI)\-[0-9]+/)
	mode = substr($2, RSTART, 2)
	window = substr($2, RSTART + 3, RLENGTH - 3)
	
	match($2,/\-[0-9]+\.\.\./)
	kvalue = substr($2, RSTART + 1, RLENGTH - 4)
}

match($0,/^Total border/) {
	if (before == "-") {
		before = $7
	} else if (placement == "-") {
		placement =  $7
	} else {
		exit
	}
	next;
}

match($0,/^Average conflict/) {
	if (before == "-") {
		before = $4
	} else if (placement == "-") {
		placement =  $4
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
	if (mode == "-" || window == "-" || kvalue == "-" || before == "-" || placement == "-" || time == "-") {
		printf ("Incomplete or inconsistent data for mode %s, dimension %s, file %s, window %s, kvalue %s:\n",mode, dim, file, window, kvalue)
		printf ("  -> before=%10.6f, placement=%10.6f, optimiz=%10.6f, time=%10.2f\n", before, placement, time)
		exit
	}
	print mode,dim,window,kvalue,file,before,placement,optimiz,time
}
