#!/bin/sh
#
SUM=0
#
while read NUM
do
	echo "SUM: $SUM";
	SUM=`echo $SUM + $NUM | bc`
	echo "+ $SUM: $SUM";
done < temp2.txt
