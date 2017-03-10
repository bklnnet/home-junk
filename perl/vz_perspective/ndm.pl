#!/usr/bin/perl
##############################################################
# Download Perspective files by ndm 
# it requires only 2 arguments a list of dataset names target node
#
# Mark.G.Naumowicz@verizon.com 03/23/07 516.797.3803
##############################################################

if((!$ARGV[0]) || (!$ARGV[1])){
	print "Error!: $0 list_of_data_files_to_process target_node\n";
	print "Example: $0 nor.reg ndmli01\n";
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
$dest		= "$v[4].$v[5].$v[6].$v[7].$v[8].$v[9].$v[10]";

if($source=~/N$/){ 	$node = "mcinor";
} elsif($source=~/S$/){ $node = "mcisac";
} elsif($source=~/P$/){ $node = "mcipym";
} else {
$node = "mcinor"
}

if($v[6]!~/V01/){
	print "multivolume, adding compression...\n";

system("./sd.sh $source $dest $node $ARGV[1] \&COMPRESS=EXT");
print "./sd.sh $source $dest $node $ARGV[1] \&COMPRESS=EXT\n";
} else {
system("./sd.sh $source $dest $node $ARGV[1]");
print "./sd.sh $source $dest $node $ARGV[1]\n";
}
# don't forget to pull the header file as well

$source_header = $source;
$source_header =~s/\.D\./\.H\./g;

$dest_header = $dest;
$dest_header =~s/\.D\./\.H\./g;

system("./sh.sh $source_header $dest_header $node $ARGV[1]");
print "./sh.sh $source_header $dest_header $node $ARGV[1]\n"; 
sleep 1;
$count++;

if($count eq 10){
	print "submitted 10 files, taking a break...\n";
	sleep 600; 			# give them some time to cool off
	$count = 0;
	}
}
