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
			printf ("%s\t%d\t%d\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, before/c, after/c, time/c, c)
		}
		
		# start new record
		dim = $1
		window = $2
		kvalue = $3
		
		after = $5
		time = $6 / 60
		before = $7
		c = 1
		
		next;
	}
	
	after = after + $5
	time = time + ($6 / 60)
	before = before + $7
	c = c + 1
}

END {
	# print last record
	printf ("%s\t%d\t%d\t%f\t%f\t%f\tx%d\n", dim, window, kvalue, before/c, after/c, time/c, c)
}
