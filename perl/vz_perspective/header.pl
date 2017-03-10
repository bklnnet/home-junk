#!/usr/bin/perl
#####################################
# Extract file from file
# header.pl start size IN OUT
####################################
  
  $offset = $ARGV[0];
  $size = $ARGV[1];
  $infile = $ARGV[2];
  $outfile = $ARGV[3];

  open (IN,"<$infile") || die "Can't open IN file!\n";
  open (OUT,">$outfile") || die "Can't open OUT file!\n";

  binmode (IN);
  binmode (OUT);

  seek(IN, $offset, 0) or die "Couldn't seek to $offset : $!\n";

  while(read( IN, $buff, $size )){
  	$data=$buff;
	$pos = tell(IN);
	print "I'm $pos bytes from the start of INFILE.\n";
	print OUT $data;
	exit;
  }                     
  
  close(IN);
  close(OUT);
  print "\nFile created!\n";
