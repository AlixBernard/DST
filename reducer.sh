#!/bin/bash


lastkey=""
count=0

while read line; do
    this_key="$(echo ${line} | awk '{print $1}')"
    value="$(echo ${line} | awk '{print $2}')"
    count="$(expr ${count} + 1)"

    if [ "${last_key}" != "${this_key}" ]; then
        if [ "${last_key}" != "" ]; then
            echo "${last_key} ${count}"
        fi
        count=0
        last_key="${this_key}"
    fi
done
