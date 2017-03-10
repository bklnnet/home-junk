#!/usr/bin/perl
##############################################################
# Download Perspective files by ndm 
# it requires only one argument a list if dataset names
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
chomp($file);
$source 	= "$file";
@v		= split(/\./, $source);
$dest		= "$v[4].$v[5].$v[6].$v[7].$v[8].$v[9].$v[10].$v[11]";
chop($dest);

if($source=~/N$/){ 	$node = "mcinor";
} elsif($source=~/S$/){ $node = "mcisac";
} elsif($source=~/P$/){ $node = "mcipym";
}

system("./rd.sh $source $dest $node");
print "./rd.sh $source $dest $node\n";

# don't forget to pull the header file as well

$source_header = $source;
$source_header =~s/\.D\./\.H\./g;

$dest_header = $dest;
$dest_header =~s/\.D\./\.H\./g;

system("./rh.sh $source_header $dest_header $node");
print "./rh.sh $source_header $dest_header $node\n"; 
$count++;

if($count eq 6){
	print "submitted 6 files, taking a break...\n";
	sleep 300;
	$count = 0;
	}
}

