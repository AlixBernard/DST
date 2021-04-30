#!/usr/bin/env python


import sys

last_key = None
running_total = 0

for input_line in sys.stdin:
	this_key, value = input_line.strip().split("\t", 1)
	value = int(value)
	running_total += value
	
	if last_key != this_key:
		if last_key is not None:
			print(f"{last_key}\t{running_total}")
		running_total = 0
		last_key = this_key
