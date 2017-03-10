#!/usr/bin/perl
#######################################################
# Daily script to burn any generic perspective files
# It will use data from the header file
#
# Mark G. Naumowicz@verizon.com         11/28/2006
########################################################

use open ':std', IO => ':bytes'; # Shut off perl8 UTF-8 encoding thingy
use POSIX qw(strftime);
use Date::Manip;
use Date::Parse;
use File::stat;
use File::Stat;
use DBI();

# --- Definitions time ---------------------------------------------------
($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdat)=localtime(time);
$mon            = sprintf("%02d", $mon+1);
$mday           = sprintf("%02d", $mday);
$year           = 1900+$year;
$hfile	        = $ARGV[0];
$daystamp       = "$mon-$mday-$year";
$watch_dir      = "/f5v1/perspective/";
$dest_dir       = "$watch_dir$daystamp";
# -----------------------------------------------------------------------
 
$dbh = DBI->connect("dbi:Sybase:server=licdtex1", 'sa', 'glaus1', {PrintError => 0});
die "Unable for connect to server $DBI::errstr" unless $dbh;
$dbh->do("use POF7");
 
$dbh2 = DBI->connect("dbi:Sybase:server=licdtex1", 'sa', 'glaus1', {PrintError => 0});
die "Unable for connect to server $DBI::errstr" unless $dbh2;
$dbh2->do("use POF7");

$dbh3 = DBI->connect("dbi:Sybase:server=licdtex1", 'sa', 'glaus1', {PrintError => 0});
die "Unable for connect to server $DBI::errstr" unless $dbh3;
$dbh3->do("use POF7");

$dbh4 = DBI->connect("dbi:Sybase:server=licdtex1", 'sa', 'glaus1', {PrintError => 0});
die "Unable for connect to server $DBI::errstr" unless $dbh4;
$dbh4->do("use POF7");

if(!$ARGV[0]){ print "Error!: Missing argument. Usage $0 Header file to process\n"; exit;}

$dfile = $hfile;
$dfile =~s/\.H\./\.D\./g;

if(-e $dfile){
	print "datafile $dfile present, starting procedures...\n";
	} else {
	print "datafile $dfile is missing, exiting...\n";
	}

open(FH, $hfile) or die "Cannot Open file $!\n";

while($single_line=<FH>){
 
        if($single_line=~/TIME_STAMP\=/){
        $ts = "$'";
	$ts =~s/\s+$//g;
        chomp($ts);
        print "Found time_stamp - $ts\n";
        
	} elsif ($single_line=~/CUSTOMER_ID\=/){
        $cid = "$'";
	$cid =~s/\s+$//g;
        chomp($cid);
        print "Found customer_id - $cid\n";
 	
	} elsif ($single_line=~/CUSTOMER_NAME\=/){
        $c_name = "$'";
	$c_name =~s/\s+$//g;
        chomp($c_name);
        print "Found customer_name - $c_name\n";
        
	} elsif ($single_line=~/ATTENTION_TO\=/){
        $att = "$'";
	$att =~s/\s+$//g;
        chomp($att);
        print "Found attention_to - $att\n"; 
        
	} elsif ($single_line=~/ADDRESS_1\=/){
        $add1 = "$'";
        $add1 =~s/\s+$//g;
        chomp($add1);
        print "Found address1 - $add1\n";
	
	} elsif ($single_line=~/ADDRESS_2\=/){
        $add2 = "$'";
        $add2 =~s/\s+$//g;
        chomp($add2);
        print "Found address2 - $add2\n";
	
	} elsif ($single_line=~/ADDRESS_3\=/){
        $add3 = "$'";
        $add3 =~s/\s+$//g;
        chomp($add3);
        print "Found address3 - $add3\n";
	
	} elsif ($single_line=~/CITY\=/){
        $city = "$'";
        $city =~s/\s+$//g;
        chomp($city);
        print "Found city - $city\n";
        
	} elsif ($single_line=~/STATE\=/){
        $state = "$'";
        $state =~s/\s+$//g;
        chomp($state);
        print "Found state - $state\n";
        	
	} elsif ($single_line=~/ZIPCODE\=/){
        $zip = "$'";
        $zip =~s/\s+$//g;
        chomp($zip);
        print "Found zip - $zip\n";

        } elsif ($single_line=~/ZIP4\=/){
        $z4 = "$'";
        $z4 =~s/\s+$//g;
        chomp($z4);
        print "Found zip4 - $z4\n";

        } elsif ($single_line=~/POSTAL_CODE\=/){
        $pc = "$'";
        $pc =~s/\s+$//g;
        chomp($pc);
        print "Found postal_code - $pc\n";

        } elsif ($single_line=~/COUNTRY\=/){
        $ctry = "$'";
        $ctry =~s/\s+$//g;
        chomp($ctry);
        print "Found country - $ctry\n";

        } elsif ($single_line=~/PHONE\=/){
        $ph = "$'";
        $ph =~s/\s+$//g;
        chomp($ph);
        print "Found phone - $ph\n";

        } elsif ($single_line=~/PHONE_EXT\=/){
        $phx = "$'";
        $phx =~s/\s+$//g;
        chomp($phx);
        print "Found phone_ext - $phx\n";

        } elsif ($single_line=~/PRODUCT\=/){
        $prd = "$'";
        $prd =~s/\s+$//g;
        chomp($prd);
        print "Found product - $prd\n";

        } elsif ($single_line=~/VERSION\=/){
        $v = "$'";
        $v =~s/\s+$//g;
        chomp($v);
        print "Found version - $v\n";

        } elsif ($single_line=~/DATA_DATE\=/){
        $dd = "$'";
        $dd =~s/\s+$//g;
        chomp($dd);
        print "Found date of data - $dd\n";

        } elsif ($single_line=~/NUM_COPIES\=/){
        $nc = "$'";
        $nc =~s/\s+$//g;
	$nc =~s/^0+//g;
        chomp($nc);
	if($nc==''){ $nc = 1}
        print "Found number of copies - $nc\n";

        } elsif ($single_line=~/ZIPPED_FLAG\=/){
        $zf = "$'";
        $zf =~s/\s+$//g;
        chomp($zf);
        print "Found zipped flag - $zf\n";

        } elsif ($single_line=~/JOB_SIZE\=/){
        $js = "$'";
        $js =~s/\s+$//g;
        chomp($js);
        print "Found job size - $js\n";

        } elsif ($single_line=~/ISO_LEVEL\=/){
        $il = "$'";
        $il =~s/\s+$//g;
        chomp($il);
        print "Found iso level - $il\n";

        } elsif ($single_line=~/BARCODE\=/){
        $bc = "$'";
        $bc =~s/\s+$//g;
        chomp($bc);
        print "Found barcode - $bc\n";

        } elsif ($single_line=~/BARCODE_STANDARD\=/){
        $bs = "$'";
        $bs =~s/\s+$//g;
        chomp($bs);
        print "Found barcode standard - $bs\n";

        } elsif ($single_line=~/AUXILIARY_FILE_FLAG\=/){
        $aff = "$'";
        $aff =~s/\s+$//g;
        chomp($aff);
        print "Found Aux file flag - $aff\n";

        } elsif ($single_line=~/AUX_FILE_CD_LOC_FLAG\=/){
        $aff2 = "$'";
        $aff2 =~s/\s+$//g;
        chomp($aff2);
        print "Found Aux file flag2 - $aff2\n";

        } elsif ($single_line=~/DEBUG_FLAG\=/){
        $df = "$'";
        $df =~s/\s+$//g;
        chomp($df);
        print "Found debug fag - $df\n";

        } elsif ($single_line=~/LOGGING_COMMENT_1\=/){
        $lc1 = "$'";
        $lc1 =~s/\s+$//g;
        chomp($lc1);
        print "Found logging comment1 - $lc1\n";

        } elsif ($single_line=~/LOGGING_COMMENT_2\=/){
        $lc2 = "$'";
        $lc2 =~s/\s+$//g;
        chomp($lc2);
        print "Found logging comment2 - $lc2\n";

        } elsif ($single_line=~/LOGGING_COMMENT_3\=/){
        $lc3 = "$'";
        $lc3 =~s/\s+$//g;
        chomp($lc3);
        print "Found logging comment3 - $lc3\n";

        } elsif ($single_line=~/NUM_VOLUMNS\=/){
        $nv = "$'";
        $nv =~s/\s+$//g;
        chomp($nv);
        print "Found number of volumes - $nv\n";

        } elsif ($single_line=~/SHIPPER\=/){
        $ship = "$'";
        $ship =~s/\s+$//g;
        chomp($ship);
        print "Found Shipper - $ship\n";

        } elsif ($single_line=~/LABEL_TEMPLATE\=/){
        $lt = "$'";
        $lt =~s/\s+$//g;
        chomp($lt);
        print "Found label template - $lt\n";

        } elsif ($single_line=~/LOGFILENAME\=/){
        $log = "$'";
        $log =~s/\s+$//g;
        chomp($log);
        print "Found log file - $log\n";

        } elsif($single_line=~/FILE_NAME\=/){
        $f_name = "$'";
	$f_name =~s/\s+$//g;
        chomp($f_name);
	($file_name, $start, $size, $volume) = split(/\,/, $f_name);
	$start =~s/^0+//g;
	$size =~s/^0+//g;
	$volume =~s/^0+//g;
	if($start==''){ $start = 0}
	print "Filename - $file_name
		size - $size
		start byte - $start
		volume - $volume\n";

		system("./header.pl $start $size $dfile $file_name");

        } elsif ($single_line=~/CDR_RECORDCOUNT\=/){
        $crc = "$'";
        $crc =~s/\s+$//g;
	$crc =~s/^0+//g;
        chomp($crc);
        print "Found CDR recordcount - $crc\n";

        } elsif ($single_line=~/NM_RECORDCOUNT\=/){
        $nrc = "$'";
        $nrc =~s/\s+$//g;
	$nrc =~s/^0+//g;
        chomp($nrc);
        print "Found NM recordcount - $nrc\n";

        } elsif ($single_line=~/ENDOFHEADER\=/){
        $eh = "$'";
        $eh =~s/\s+$//g;
        chomp($eh);
        print "Found end of header - $eh\n";


                }
	}
close FH; 

$SQL="insert into cdrom (jobname,priority,format,numbytes,volumelabel,copies,datetime_submitted,label1,label2,label3,label4,label5,label6,label7,label8) values ('GENR',1,40,999,'GENRTEMP','$c',getdate(),'$jn','$aa','$rp','$n1','$n2','$a1','$a2','$csz')";

#print "$SQL\n";

exit;

	foreach $file(@files){
	
	$file_there = "$dest_dir\/$file";
	if (-e $file_there){
	# do nothing
	} else {

        label_me:
        if(-d $dest_dir){
        print "Destination dir exists moving $file over...\n";
	system("/bin/mv $file $dest_dir");
        print "file $file moved...\n";
        } else {
        print "Dest dir $dest_dir doesn't exists, creating it now\n";
        system("mkdir $dest_dir");
        system("chmod 777 $dest_dir");
        print "$dest_dir created\n";
        goto label_me;
          }
	}
      }


$SQL="insert into cdrom (jobname,priority,format,numbytes,volumelabel,copies,datetime_submitted,label1,label2,label3,label4,label5,label6,label7,label8) values ('GENR',1,40,999,'GENRTEMP','$c',getdate(),'$jn','$aa','$rp','$n1','$n2','$a1','$a2','$csz')";

#print "$SQL\n";
		$sth = $dbh->prepare("$SQL");
                $sth->execute() || die "Failed EXECUTE:".$dbh->errstr;
                $sth->finish;

                $SQL2="select cdromid from cdrom where volumelabel = 'GENRTEMP' ";
                $sth2 = $dbh2->prepare("$SQL2");
                if($sth2->execute) {
                    while(@dat = $sth2->fetchrow) {
                        $cdromid = $dat[0];
                        print "cdromid - $cdromid\n";
                    }
                }
           $sth2->finish;

           $SQL3="update cdrom set volumelabel = 'GENR_$daystamp' where cdromid=$cdromid";
           $sth3 = $dbh3->prepare("$SQL3");
           $sth3->execute() || die "Failed EXECUTE:".$dbh3->errstr;
           $sth3->finish;

		foreach $file(@files){

           $SQL4="insert into \[file\] (cdromid,burnfile,burn_prefix,getpath) values ($cdromid,'','\\','\\$daystamp\\$file')";
           $sth4 = $dbh4->prepare("$SQL4");
           $sth4->execute() || die "Failed EXECUTE:".$dbh4->errstr;
           $sth4->finish;
	#print "$SQL4\n";
		}

#system("/bin/mv $lfile done/$lfile.orig");
 
print "done...\n";

$dbh->disconnect();
$dbh2->disconnect();
$dbh3->disconnect();
$dbh4->disconnect();
