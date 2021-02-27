#!/usr/bin/env bash

reportTxt="$H/d/report.txt"
reportCsv="$H/d/report.txt"

sed -r 's/^[ 	]+|[ 	]+$//g' "$reportTxt" \
| awk '
BEGIN {
	FS=" "
	print "word;frequency"
}
{
	print $2";"$1
}
' \
> "$reportCsv"
