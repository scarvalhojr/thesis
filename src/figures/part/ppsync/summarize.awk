BEGIN {
	OFS = FS = "\t"
	
	mode = ""
	dim = ""
	depth = ""
	window = ""
	file = ""
}

{
	if ($1 != mode || $2 != dim || $3 != depth || $4 != window) {
	
		if (mode != "") {
			# print previous record
			total_place_time = total_place_time - worse_place_time - best_place_time
			place_time = total_place_time / (c - 2)
			total_embed_time = total_embed_time - worse_embed_time - best_embed_time
			embed_time = total_embed_time / (c - 2)
			printf ("%s\t%s\t%d\t%d\t%8.4f\t%8.4f\t%8.4f\t%8.5f\t%8.5f\tx%d\n", mode, dim, depth, window, before/c, place/c, embed/c, place_time, embed_time, c)
		}
		
		# start new record
		mode = $1
		dim = $2
		depth = $3
		window = $4
		
		before = $6
		place = $7
		embed = $8
		place_time = $9
		embed_time = $10

		match($2,/[0-9]+x/)
		d = substr($2, RSTART, RLENGTH - 1)
		
		worse_place_time = place_time
		 best_place_time = place_time
		total_place_time = place_time
		
		worse_embed_time = embed_time
		 best_embed_time = embed_time
		total_embed_time = embed_time
		
		c = 1
		
		next;
	}

	before = before + $6
	place = place + $7
	embed = embed + $8
	
	place_time = $9
	if (place_time > worse_place_time) {
		worse_place_time = place_time
	} else if (place_time < best_place_time) {
		best_place_time = place_time
	}
	total_place_time = total_place_time + place_time

	embed_time = $10
	if (embed_time > worse_embed_time) {
		worse_embed_time = embed_time
	} else if (embed_time < best_embed_time) {
		best_embed_time = embed_time
	}
	total_embed_time = total_embed_time + embed_time
	
	c = c + 1
}

END {
	# print last record
	total_place_time = total_place_time - worse_place_time - best_place_time
	place_time = total_place_time / (c - 2)
	total_embed_time = total_embed_time - worse_embed_time - best_embed_time
	embed_time = total_embed_time / (c - 2)
	printf ("%s\t%s\t%d\t%d\t%8.4f\t%8.4f\t%8.4f\t%8.5f\t%8.5f\tx%d\n", mode, dim, depth, window, before/c, place/c, embed/c, place_time, embed_time, c)
}
