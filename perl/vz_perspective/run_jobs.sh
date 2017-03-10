#!/bin/sh

for i in ls D*.*.H.*
	do ./pers_generic.pl $i
	sleep 1
done
