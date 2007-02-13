BEGIN {
	FS = " "
	OFS = "\t"
	
	dim = ""
}

match($0,/^SRA/) {

	# print last record
	if (dim != "") {
		delta = total_time - place_time - optimiz_time
		if (delta < 0) delta = - delta
		
		if (mode == "-" || window == "-" || kvalue == "-" || before == "-" || placement == "-" || optimiz == "-" || place_time == "-" || optimiz_time == "-" || total_time == "-") {
			exit
		} else if (delta > 0.01) {
			exit
		}
		print mode,dim,window,kvalue,file,before,placement,optimiz,place_time,optimiz_time
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
	optimiz = "-"
	place_time = "-"
	optimiz_time = "-"
	total_time = "-"
	
	next;
}

match($0,/^Running Greedy/) {
	match($2,/(BL|CI)\-[0-9]+/)
	mode = substr($2, RSTART, 2)
	window = substr($2, RSTART + 3, RLENGTH - 3)
	kvalue = substr($2, RSTART + RLENGTH + 1,1)
}

match($0,/^Total border/) {
	if (before == "-") {
		before = $7
	} else if (placement == "-") {
		placement =  $7
	} else if (optimiz == "-") {
		optimiz =  $7
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
	} else if (optimiz == "-") {
		optimiz =  $4
	} else {
		exit
	}
	next;
}

match($0,/^Elapsed time/) {
	if (place_time == "-") {
		place_time = $3
	} else if (optimiz_time == "-") {
		optimiz_time = $3
	} else {
		exit
	}
	next;
}

match($0,/^Total time/) {
	total_time = $3
	next;
}

END {
	if (delta > 0.01 || mode == "-" || window == "-" || kvalue == "-" || before == "-" || placement == "-" || optimiz == "-" || place_time == "-" || optimiz_time == "-" || total_time == "-") {
		printf ("Incomplete or inconsistent data for mode %s, dimension %s, file %s, window %s, kvalue %s:\n",mode, dim, file, window, kvalue)
		printf ("  -> before=%10.6f, placement=%10.6f, optimiz=%10.6f, time=%10.2f\n", before, placement, optimiz, time)
		printf ("  -> placement time=%20.12f, optimization time=%20.12f, total time=%20.12f\n", place_time, optimiz_time, total_time)
		exit
	}
	print mode,dim,window,kvalue,file,before,placement,optimiz,place_time,optimiz_time
}
