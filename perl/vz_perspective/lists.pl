#!/usr/bin/perl
##############################################################
# Create regional lists
# it requires only one argument of a region
#
# Mark.G.Naumowicz@verizon.com 03/23/07 516.797.3803
##############################################################

use Date::Manip;
use Date::Parse;
use File::stat;
use File::Stat;
use Net::FTP;

 
# --- Definitions time ---------------------------------------------------
 
$date	= ParseDateString("today");
$date	= UnixDate($date,"%h%y");
$date	= uc($date);
# -----------------------------------------------------------------------


if(!$ARGV[0]){
	print "Error!: $0 region (sac pym or nor), product (p800 vnet or visn)\n";
	print "Example: $0 sac vnet\n";
	exit;
	}


$host 		= $ARGV[0];
$prd		= $ARGV[1];

	$fts = "EB.P.Z.FT";
	$reg = "EB.P.Y.CD";

$ftp = Net::FTP->new("mvs$host" . "1.mcilink.com", Debug => 0) or die "Cannot connect to $host: $@";
$ftp->login("EBW002",'fargo') or die "Cannot login ", $ftp->message;
$ftp->cwd("\'$fts\'") or die "Cannot change working directory ", $ftp->message;
$list = undef();
$list = $ftp->ls() || die "Cannot retrieve files from directory\n".$ftp->message."\n"; 

print "fts files...\n";

open(FT,">$host.fts");
foreach $line(@$list){
	if($line=~/D*.$prd.*.$date.*.D\.N*/i){
	print "$fts.$line\n" if $line;
	print FT "$fts.$line\n" if $line;
	}
    }
close FT;

$ftp->cwd("\'$reg\'") or die "Cannot change working directory ", $ftp->message;

print "regular files...\n";

$list = undef();
$list = $ftp->ls() || die "Cannot retrieve files from directory\n".$ftp->message."\n";

open(RG,">$host.reg");
foreach $line(@$list){
        if($line=~/D*.$prd.*.$date.*.D\.N*/i){
        print "$reg.$line\n" if $line;
	print RG "$reg.$line\n" if $line;
        }
    }
close RG;

$ftp->quit;
