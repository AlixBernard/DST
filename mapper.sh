#!/bin/bash


while read line; do
	for word in $line; do
		if [ -n $word ]; then
			echo -e "${word} 1"
		fi
	done
done
