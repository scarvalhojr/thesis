BEGIN {
	OFS = FS = "\t"
	
	dim = ""
	alg = ""
	file = ""
}

{
	if ($1 != dim || $2 != alg) {
	
		if (dim != "") {
			# print previous record
			printf ("%s\t%s\t%f\t%f\t%f\t%f\t%d\tx%d\n", dim, alg, before/c, time/c, (after/c), (after/c)/(numprobes), numprobes, c)
		}
		
		# start new record
		dim = $1
		size = substr($1,1,3)
		numprobes = size * size
		alg = $2
		file = $3
		
		before = $4
		after = $5
		time = $6 / 60
		c = 1
		
		next;
	}
	
	before = before + $4
	after = after + $5
	time = time + ($6 / 60)
	c = c + 1
}

END {
	# print last record
	printf ("%s\t%s\t%f\t%f\t%f\t%f\t%d\tx%d\n", dim, alg, before/c, time/c, (after/c), (after/c)/(numprobes), numprobes, c)
}
