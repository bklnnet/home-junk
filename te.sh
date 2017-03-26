#!/bin/bash

#echo "look ma no hands"
#echo "passed $1"

dt=`which $1`
echo $dt

if [ $# -eq 0 ]
then
echo "no args given"
exit 1
fi

if [ -f $dt ]; then
  echo "exists"
else
  echo "does not"
fi

#if [[ -x "$dt" ]]
#then
#echo "can run it"
#else
#echo "cannot run it"
#fi

if [ -x $dt ] then
  echo "can run it"
else
  echo "cannot run it"
fi


