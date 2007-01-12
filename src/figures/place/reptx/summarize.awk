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
			printf ("%s\t%d\t%d\t%f\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, cost_before/c, kthread_cost/c, reptx_cost/c, avg_time, c)
		}
		
		# start new record
		dim = $1
		window = $2
		kvalue = $3
		
		cost_before = $5
		kthread_cost = $6
		reptx_cost = $7
		time = $8 / 60
		best_time = time
		worse_time = time
		total_time = time
		c = 1
		
		next;
	}

	cost_before = cost_before + $5
	kthread_cost = kthread_cost + $6
	reptx_cost = reptx_cost + $7
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
	total_time = total_time - best_time - worse_time
	avg_time = total_time / (c - 2)
	printf ("%s\t%d\t%d\t%f\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, cost_before/c, kthread_cost/c, reptx_cost/c, avg_time, c)
}
