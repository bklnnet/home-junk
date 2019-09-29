#!/bin/bash


while true; do 

line=`html2text http://webrates.truefx.com/rates/connect.html\?f=html | head -1`
printf "$line\n";

sleep 1; 
clear;
done

#while read line; do
#     date_field=`echo $line | awk -F"[" '{ print $2 }' | awk ' {print $1 }'`
#     epoch=`date -j -f "%d/%b/%Y:%H:%M:%S" $date_field +%s`
#     back_from_epoch=`date -j -r $epoch '+%d/%b/%Y:%H:%M:%S'`
#     newline=`echo $line | sed -e s*$date_field*$epoch*`
#     printf "$newline\n"
#     echo $newline >> dlog.txt #converted to epoch
#done <$

