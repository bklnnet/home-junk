#################################################################
# Short and sweet Pro Football Talk RSS feed, parses 10 headlines
# It runs until you kill it with ctrl-C
# usage: python pft_feed.py
#
# Mark.Naumowicz@protonmail.com       03/08/2017
#################################################################
import feedparser; 
import string;
import time;
import datetime;
import os;

while True:

 d = feedparser.parse("http://profootballtalk.nbcsports.com/category/rumor-mill/feed/atom/")

#-- length of feed in case you need it -- print len(d['entries'])

 now = datetime.datetime.now()

 print "----------------------------------------------------------------------"
 print d['feed']['title'], "as of", now.strftime("%D"), "at", now.strftime("%H:%M:%S %p")
 print "----------------------------------------------------------------------"

 for i in range(0,11):

    l = d['entries'][i]['title']
    l = string.replace(l, "&#8216;", "'")
    l = string.replace(l, "&#8217;", "'")
    l = string.replace(l, "&#8220;", "\"")
    l = string.replace(l, "&#8221;", "\"")

    print l

 print "---------------------------------------------------------------------"
 time.sleep(300)
os.system('clear')

