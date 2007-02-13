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
		print mode,dim,window,kvalue,file,before,placement,optimiz,place_time,optimiz_time,total_time
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

	# pre-placement	
	phase = 0
	
	next;
}

match($0,/^Running [0-9]+\-threading/) {
	match($2,/[0-9]+\-threading/)
	kvalue = substr($2, RSTART, RLENGTH - 10)
	
	# placement
	phase = 1
	
	next
}

match($0,/^Running RowEpitaxial/) {
	match($2,/(BL|CI)\-[0-9]+/)
	mode = substr($2, RSTART, 2)
	window = substr($2, RSTART + 3, RLENGTH - 3)
	
	# placement
	phase = 1
	
	next
}

match($0,/^Running Greedy/) {
	match($2,/(BL|CI)\-[0-9]+/)
	mode = substr($2, RSTART, 2)
	window = substr($2, RSTART + 3, RLENGTH - 3)
	kvalue = substr($2, RSTART + RLENGTH + 1,1)
	
	# placement
	phase = 1
	
	next
}

match($0,/^Running SequentialReembedding/) {
	# re-embedding
	phase = 2
	
	next
}

match($0,/^Total border/) {
	if (phase == 0) {
		before = $7
	} else if (phase == 1) {
		placement =  $7
	} else if (phase == 2) {
		optimiz =  $7
	} else {
		exit
	}
	next
}

match($0,/^Average conflict/) {
	if (phase == 0) {
		before = $4
	} else if (phase == 1) {
		placement =  $4
	} else if (phase == 2) {
		optimiz =  $4
	} else {
		exit
	}
	next
}

match($0,/^Elapsed time/) {
	if (phase == 1) {
		if (place_time == "-") {
			place_time = 0.0
			place_time = place_time + $3
		} else {
			place_time = place_time + $3
		}
	} else if (phase == 2) {
		if (optimiz_time == "-") {
			optimiz_time = $3
		} else {
			exit
		}
	} else {
		exit
	}
	next
}

match($0,/^Total time/) {
	total_time = $3
	next
}

END {
	if (delta > 0.01 || mode == "-" || window == "-" || kvalue == "-" || before == "-" || placement == "-" || optimiz == "-" || place_time == "-" || optimiz_time == "-" || total_time == "-") {
		printf ("Incomplete or inconsistent data for mode %s, dimension %s, file %s, window %s, kvalue %s:\n",mode, dim, file, window, kvalue)
		printf ("  -> before=%10.6f, placement=%10.6f, optimiz=%10.6f\n", before, placement, optimiz)
		printf ("  -> placement time=%20.12f, optimization time=%20.12f, total time=%20.12f\n", place_time, optimiz_time, total_time)
		exit
	}
	print mode,dim,window,kvalue,file,before,placement,optimiz,place_time,optimiz_time,total_time
}
