#!/usr/bin/perl

use Mail::Internet;


$messagefile = "/home/mark/mbox";

open(MESSAGE,"$messagefile") or die "Unable to open $messagefile:$!\n";

$message = new Mail::Internet \*MESSAGE;
#$message->tidy_body();
#$message->print_body();
$me = $message->body();
close(MESSAGE);



foreach $line(@$me){

print "$line" if $line=~/duh/ ;

}


#print "@$me\n";

#if ($_=~/duh/){
#        `ls -l /tmp > /home/mark/file$$.txt`;
#        }

