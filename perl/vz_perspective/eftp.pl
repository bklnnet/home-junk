#!/usr/bin/perl
##############################################################
# Download Perspective files by ndm 
# it requires only one argument a list of dataset names
#
# Mark.G.Naumowicz@verizon.com 03/23/07 516.797.3803
##############################################################

if(!$ARGV[0]){
	print "Error!: $0 list_of_data_files_to_process\n";
	exit;
	}

$list = $ARGV[0];

open(FH, $list);
@l = <FH>;
close FH;

$count = 0;

foreach $file(@l){
$file =~s/\s+//g;
chomp($file);
$source 	= "$file";

if($source=~/N$/){ 	$node = "nor1";
} elsif($source=~/S$/){ $node = "sac1";
} elsif($source=~/P$/){ $node = "pym1";
}

system("./ftp.pl $node fts vnet $source &");
print "./ftp.pl $node fts vnet $source &\n";

$count++;

if($count eq 10){
	print "submitted 10 files, taking a break...\n";
	sleep 300; 			# give them some time to cool off
	$count = 0;
	}
}
