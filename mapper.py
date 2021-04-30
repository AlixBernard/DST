#!/usr/bin/env python


import sys

for line in sys.stdin:
	keys = line.strip().split()
	for key in keys:
		value = 1
		print(f"{key}\t{value}")
