BEGIN {
	FS = " "
	OFS = "\t"
	
	dim = ""
}

match($0,/^SRS/) {

	# print last record
	if (dim != "") {
		if (before == "-" || after == "-" || time == "-") {
			exit
		}
		print dim,alg,file,before,after,time
	}
	
	# new record
	dim = substr($1,5,7)
	file = substr($1,index($1,"25_")+3,2)
	alg = substr($2,11,2)
	
	# reset data
	before = "-"
	after = "-"
	time = "-"
	
	next;
}

match($0,/before/) {
	before = $5
	next;
}

match($0,/^Elapsed time/) {
	time = $4
	next;
}

match($0,/^Final/) {
	after = $4
	next;
}

END {
	if (before == "-" || after == "-" || time == "-") {
		printf ("Incomplete data for measure %s, type %s, dimension %s, algorithm %s, file #%s.\n",measure, type, dim, alg, file)
		exit
	}
	print dim,alg,file,before,after,time
}
