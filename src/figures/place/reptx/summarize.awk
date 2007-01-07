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
			printf ("%s\t%d\t%d\t%f\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, cost_before/c, kthread_cost/c, reptx_cost/c, time/c, c)
		}
		
		# start new record
		dim = $1
		window = $2
		kvalue = $3
		
		cost_before = $5
		kthread_cost = $6
		reptx_cost = $7
		time = $8 / 60
		c = 1
		
		next;
	}

	cost_before = cost_before + $5
	kthread_cost = kthread_cost + $6
	reptx_cost = reptx_cost + $7
	time = time + ($8 / 60)
	c = c + 1
}

END {
	# print last record
	printf ("%s\t%d\t%d\t%f\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, cost_before/c, kthread_cost/c, reptx_cost/c, time/c, c)
}
