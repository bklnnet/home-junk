#!/usr/bin/env python

import urllib
import os
import time
import subprocess


while True:
 link = "http://webrates.truefx.com/rates/connect.html?f=html"
 f = urllib.urlopen(link)
 myfile = f.read()

 print  myfile
time.sleep (1)
os.system('clear')
