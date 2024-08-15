#!/bin/bash

if [ $# -eq 0 ]; then
	echo "usage: $0 filename" >&2
	exit 1
fi

cc -o readtest readtest.c

filename=$1
sum=0
count=0
for i in $(seq 200 200 5000); do
	time_taken=$(./readtest $filename $i)
	echo "Time taken for the file reading using $i bytes is $time_taken milliseconds"
	sum=$((sum+time_taken))
	count=$((count+1))
done
avg=$((sum/count))

echo "Average time taken is $avg milliseconds"
