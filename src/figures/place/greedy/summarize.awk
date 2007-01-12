BEGIN {
	OFS = FS = "\t"
	
	dim = ""
	window = ""
	kvalue = ""
	file = ""
}

{
	if ($1 != dim || $2 != window || $3 != kvalue) {
	
		if (dim != "") {
			# print previous record
			total_time = total_time - best_time - worse_time
			avg_time = total_time / (c - 2)
			printf ("%s\t%d\t%d\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, before/c, after/c, avg_time, c)
		}
		
		# start new record
		dim = $1
		window = $2
		kvalue = $3
		
		after = $5
		time = $6 / 60
		best_time = time
		worse_time = time
		total_time = time
		before = $7
		c = 1
		
		next;
	}
	
	after = after + $5
	time = $6 / 60
	if (time > worse_time) {
		worse_time = time
	} else if (time < best_time) {
		best_time = time
	}
	total_time = total_time + time
	before = before + $7
	c = c + 1
}

END {
	# print last record
	total_time = total_time - best_time - worse_time
	avg_time = total_time / (c - 2)
	printf ("%s\t%d\t%d\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, before/c, after/c, avg_time, c)
}
