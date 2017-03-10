#!/bin/sh
############################################################
# This script invokes the Connect:Direct UNIX CLI
# and submits a process inline to copy a file from a remote
# node.
#  $1 is the source file.
#  $2 is the destination file.
#  $3 is the name of the remote node.
###########################################################

	set -v
	ndmcli  -x << EOJ
	submit proc2 process snode=$3 snodeid=(EBW002,FARGO)

	step1    copy from
	( file=$1 snode)
	compress=extended
	ckpt=2m
	to
	( file=$2 sysopts=":datatype=binary:xlate=no:")

	pend ;
	EOJ
