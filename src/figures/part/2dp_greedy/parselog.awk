BEGIN {
	FS = " "
	OFS = "\t"
	
	alg = ""
}

match($0,/^SRA/) {

	# print last record
	if (alg != "") {
		if (before == "-" || placement == "-" || time == "-") {
			exit
		}
		print alg,file,before,placement,time
	}
	
	# new record
	file = substr($1,index($1,"25-")+3,2)
	
	if (match($3,/^2DCENTRALPART/)) {
		alg = "2DP-" substr($3,15,2)
	} else if (match($3,/^GREEDYPLACER/)) {
		alg = "GREEDY"
	} else {
		alg = $3
	}
	
	# reset data
	before = "-"
	placement = "-"
	time = "-"
	
	next;
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
	if (before == "-" || placement == "-" || time == "-") {
		printf ("Incomplete or inconsistent data for algorithm %s on file %s:\n",alg, file)
		printf ("  -> before=%10.6f, placement=%10.6f, time=%10.2f\n", before, placement, time)
		exit
	}
	print alg,file,before,placement,time
}
