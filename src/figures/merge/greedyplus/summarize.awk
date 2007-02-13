BEGIN {
	OFS = FS = "\t"
	
	mode = ""
	dim = ""
	window = ""
	kvalue = ""
	file = ""
}

{
	if ($1 != mode || $2 != dim || $3 != window || $4 != kvalue) {
	
		if (mode != "") {
			# print previous record
			total_time = total_time - worse_time - best_time
			avg_time = total_time / (c - 2)
			# total_time = total_time - worse_time
			# avg_time = total_time / (c - 1)
			# avg_time = total_time / c
			printf ("%s\t%s\t%d\t%d\t%8.4f\t%8.4f\t%8.1f\tx%d\n", mode, dim, window, kvalue, before/c, placement/c, avg_time, c)
		}
		
		# start new record
		mode = $1
		dim = $2
		window = $3
		kvalue = $4
		
		before = $6
		placement = $7
		time = $8 / 60
		worse_time = time
		best_time = time
		total_time = time
		
		c = 1
		
		next;
	}

	before = before + $6
	placement = placement + $7
	time = $8 / 60
	if (time > worse_time) {
		worse_time = time
	} else if (time < best_time) {
		best_time = time
	}
	total_time = total_time + time
	c = c + 1
}

END {
	# print last record
	total_time = total_time - worse_time - best_time
	avg_time = total_time / (c - 2)
	# total_time = total_time - worse_time
	# avg_time = total_time / (c - 1)
	# avg_time = total_time / c
	printf ("%s\t%s\t%d\t%d\t%8.4f\t%8.4f\t%8.1f\tx%d\n", mode, dim, window, kvalue, before/c, placement/c, avg_time, c)
}
