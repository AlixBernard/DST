#!/usr/bin/env bash


dir=$(dirname "${0}")
cat "$dir"/dst-stu/d/mr/tf-idf/* | "$dir/mapper.py" | sort | "$dir/reducer.py"
