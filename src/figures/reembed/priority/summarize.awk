BEGIN {
	OFS = FS = "\t"
	
	mode = ""
	dim = ""
	window = ""
	file = ""
}

{
	if ($1 != mode || $2 != dim || $3 != window) {
	
		if (dim != "") {
			# print previous record
			total_time = total_time - worse_time - best_time
			avg_time = total_time / (c - 2)
			#avg_time = total_time / c
			printf ("%s\t%s\t%d\t%f\t%f\t%f\t%d\tx%d\n", mode, dim, window, before/c, after/c, avg_time, passes, c)
		}
		
		# start new record
		mode = $1
		dim = $2
		window = $3
		passes = $5
		
		before = $6
		time = $7
		after = $8
		
		total_time = time
		best_time = time
		worse_time = time
		
		c = 1
		
		next;
	}
	
	before = before + $6
	time = $7
	after = after + $8
	c = c + 1
	
	if (time > worse_time) {
		worse_time = time
	} else if (time < best_time) {
		best_time = time
	}
	total_time = total_time + time
}

END {
	# print last record
	total_time = total_time - worse_time - best_time
	avg_time = total_time / (c - 2)
	#avg_time = total_time / c
	printf ("%s\t%s\t%d\t%f\t%f\t%f\t%d\tx%d\n", mode, dim, window, before/c, after/c, avg_time, passes, c)
}
