#!/usr/bin/perl
use warnings;

print "dropping to shell and do something with command subs\n";

$lcl = system("ls -l");
print "$lcl\n";

for (my $i=2; $i <= 9; $i++) {
   print "the wheels on the bus go $i times\n";
}

