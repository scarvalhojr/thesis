BEGIN {
	OFS = FS = "\t"
	
	alg = ""
}

{
	if ($1 != alg) {
	
		if (alg != "") {
			# print previous record
			total_time = total_time - worse_time - best_time
			avg_time = total_time / (c - 2)
			# total_time = total_time - worse_time
			# avg_time = total_time / (c - 1)
			# avg_time = total_time / c
			printf ("%s\t%8.4f\t%8.4f\t%8.1f\tx%d\n", alg, before/c, placement/c, avg_time, c)
		}
		
		# start new record
		alg = $1
		
		before = $3
		placement = $4
		time = $5 / 60
		worse_time = time
		best_time = time
		total_time = time
		
		c = 1
		
		next;
	}

	before = before + $3
	placement = placement + $4
	time = $5 / 60
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
	printf ("%s\t%8.4f\t%8.4f\t%8.1f\tx%d\n", alg, before/c, placement/c, avg_time, c)
}
