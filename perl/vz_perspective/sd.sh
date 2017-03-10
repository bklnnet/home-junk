#!/bin/sh
############################################################
# This script invokes the Connect:Direct UNIX CLI
# and submits a process inline to copy a file from a remote
# node.
#  $1 is the source file.
#  $2 is the destination file.
#  $3 is the name of the remote node.
#  $4 is the name of the local node
#  $5 is the compression =EXT use only on large datasets
# Mark.G.Naumowicz@verizon.com 04/2007
###########################################################

set -v 
ndmcli -x << EOJ
submit proc1 process snode=$3  snodeid=(EBW002,FARGO)
step1  submit file="VD.P.NDM.PROCESS.LIB(LIUNIXD)"
         &FRMDSN=$1
         &TODSN=$2
	 &SNODE=$4
         $5
        subnode=snode
pend;
EOJ
