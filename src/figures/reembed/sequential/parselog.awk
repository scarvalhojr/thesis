BEGIN {
	FS = " "
	OFS = "\t"
	
	mode = ""
}

match($0,/^SRA/) {

	# print last record
	if (mode != "") {
		if (passes == "-" || before == "-" || after == "-" || time == "-") {
			exit
		}
		print mode,dim,window,file,passes,before,time,after
	}
	
	# new record
	dim = substr($1,5,7)
	file = substr($1,index($1,"25-")+3,2)
	match($1,/(BL|CI)\-[0-9]+K?/)
	mode = substr($1, RSTART, 2)
	window = substr($1, RSTART + 3, RLENGTH - 3)
	
	# reset data
	passes = "-"
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

match($0,/^Number of passes/) {
	passes = $4
	next;
}

END {
	if (passes == "-" || before == "-" || after == "-" || time == "-") {
		printf ("Incomplete or inconsistent data for mode %s, dimension %s, file %s, window %s.\n",mode, dim, file, window)
		exit
	}
	print mode,dim,window,file,passes,before,time,after
}
