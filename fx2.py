#!/usr/bin/env python

import feedparser; 
import string;
import time;
import datetime;
import os;
import subprocess;

while True:

 now = datetime.datetime.now()

 print "----------------------------------------------------------------------"
 print "EUR/USD as of", now.strftime("%D"), "at", now.strftime("%H:%M:%S %p")
 print "----------------------------------------------------------------------"

 output = subprocess.check_output(['html2text', 'http://webrates.truefx.com/rates/connect.html?f=html'])
 print output
 print "---------------------------------------------------------------------"
# time.sleep(0.0001)
# os.system('clear')
