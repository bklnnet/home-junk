#!/usr/bin/perl
####################################################
# FTP session to get all file pairs (Header and Data)
#
# 516.797.3803
# Mark G. Naumowicz 01/22/2007
####################################################

use Net::FTP;

$host 		= $ARGV[0];
$jobtype 	= $ARGV[1];
$job		= $ARGV[2];
$setname 	= $ARGV[3];

if((!$host) || (!$jobtype) || (!$job)){
print "Error: $0 hostname (e.g. nor1) | jobtype (e.g. fts, reg, hold, holdf) | job (e.g. visn, vnet, p800, done)\n";
	exit;
	}

if($jobtype=~/fts/i){
	$jt = "EB.P.Z.FT";
} elsif($jobtype=~/reg/i){
	$jt = "EB.P.Y.CD";
} elsif($jobtype=~/done/i){
        $jt = "EB.P.Y.DONE";
} elsif($jobtype=~/hold/i){
	$jt = "EB.P.Y.HOLD";
} elsif($jobtype=~/hf/i){
	$jt = "EB.P.Z.HFTS";
	}

$ftp = Net::FTP->new("mvs$host.mcilink.com", Debug => 0) or die "Cannot connect to $host: $@";
$ftp->login("EBW002",'fargo') or die "Cannot login ", $ftp->message;
$ftp->cwd("\'$jt\'") or die "Cannot change working directory ", $ftp->message;

if(!$setname){

$list = $ftp->ls() || die "Cannot retrieve files from directory\n".$ftp->message."\n"; 
foreach $line(@$list){
	if($line=~/D*.$job.*.D.*/i){
	print "$line\n";
	}
    }
} else {

	if($setname=~/\.D\./){
		

		if($host=~/nor/i){
                $ml = "N";
                } elsif($host=~/sac/i){
                $ml = "S";
                } elsif($host=~/pym/i){
                $ml = "P";
                }

		print "getting $setname in binary\n";
                $ftp->binary or die "switch to binary failed\n", $ftp->message;
                $ftp->get("$setname") or die "get $setname failed\n", $ftp->message;

		if ( -e $setname){

		 if($setname=~/$job.*.N$ml$/i){
	        $b_ren = $setname;
	        $a_ren = $setname;
	        $a_ren=~s/\.N$ml/\.CM/g;
	        $ftp->rename($b_ren, $a_ren) or die "Cannot rename $setname", $ftp->message;
	        print "new $b_ren -> $a_ren\n";
		}
               }

		$setname =~s/\.D\./\.H\./g;
		
		print "getting $setname in ascii\n";
		$ftp->ascii or die "switch to ascii failed\n", $ftp->message;
		$ftp->get("$setname") or die "get $setname failed\n", $ftp->message;

		if ( -e $setname){

                 if($setname=~/$job.*.N$ml$/i){
                $b_ren = $setname;
                $a_ren = $setname;
                $a_ren=~s/\.N$ml/\.CM/g;
                $ftp->rename($b_ren, $a_ren) or die "Cannot rename $setname", $ftp->message;
                print "new $b_ren -> $a_ren\n";
                }
              }	
	}
     }
$ftp->quit;
