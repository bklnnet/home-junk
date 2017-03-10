#!/usr/bin/perl
####################################################
# FTP session to get all Header and Data files
#
# ./ftp.pl host(nor1) REG or FTS jobi(vnet) file(H/D)
#
# 516.797.3803
# Mark G. Naumowicz 01/22/2007
####################################################

use Net::FTP;

$host 		= $ARGV[0];
$jobtype 	= $ARGV[1];
$job		= $ARGV[2];
$keyword 	= $ARGV[3];

if((!$host) || (!$jobtype) || (!$job)){
	print "Error: $0 hostname (e.g. nor1) | jobtype (e.g. fts, reg) | job (e.g. visn, vnet, p800, done) | keyword (e.g. done or complete)\n";
	exit;
	}

if($jobtype=~/fts/i){
	$jt = "EB.P.Z.FT";
} elsif(($jobtype=~/reg/i) && ($keyword=~/done/i)){
	$jt = "EB.P.Y";
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
#$ftp->cwd("\'EB.P.Y\'") or die "Cannot change working directory ", $ftp->message;

if(!$keyword){

$list = $ftp->ls() || die "Cannot retrieve files from directory\n".$ftp->message."\n"; 
foreach $line(@$list){
	print "$line\n";
    }
	} else {
	if($host=~/nor/i){
	$ml = "N";
	} elsif($host=~/sac/i){
	$ml = "S";
	} elsif($host=~/pym/i){
	$ml = "P";
	}
	
$list = $ftp->ls() || die "Cannot retrieve files from directory\n".$ftp->message."\n";
foreach $line(@$list){
#	print "$line\n";

	if($keyword=~/done/i){
	if($line=~/^CD.*.$job.*.CM$/i){
	$b_ren = $line;
	$a_ren = $line;
	$a_ren=~s/CD\./DONE\./;
	$ftp->rename($b_ren, $a_ren) or die "Cannot rename $line", $ftp->message;
	print "new $b_ren -> $a_ren\n";
	}
}

	if($keyword=~/complete/i){
	if($line=~/$job.*.N$ml$/i){
        $b_ren = $line;
        $a_ren = $line;
	$a_ren=~s/\.N$ml/\.CM/g;
        $ftp->rename($b_ren, $a_ren) or die "Cannot rename $line", $ftp->message;
        print "new $b_ren -> $a_ren\n";
	}
     }
   }
}
$ftp->quit;
