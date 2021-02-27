#!/usr/bin/env bash

inputFile="$H/d/f1.tsv"
reportFile="$H/d/report.txt"

sed -r -e 's/[,\.]//g' -e 's/[ ]+/\n/g' "$inputFile" \
| tr '[:upper:]' '[:lower:]' \
| sort | uniq -c | sort -nr \
> "$reportFile"