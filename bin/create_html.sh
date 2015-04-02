#!/bin/bash
FILE=$1
if [[ -z "$FILE" ]]; then
	echo "Please provide a csv file to parse"
	return 1
fi

awk -F, '{ print $1; print "{ \"code\": 200, \"message\": \"OK\", \"data\": { \"country\": { \"code\" : \"" $1 "\" } } }" > "html/" $1 ".json" }' $FILE