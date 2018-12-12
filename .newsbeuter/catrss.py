#!/usr/bin/python3

import fileinput
import xml.dom.minidom
import urllib.request
import time
import sys

headers={'User-Agent': 'newsboat/2.13 (Linux x86_64)'}
print('<?xml version="1.0" encoding="utf-8"?>')
print('<feed xmlns="http://www.w3.org/2005/Atom">')
if len(sys.argv) > 1:
	n = sys.argv[1].translate(str.maketrans('', '', '~/. :'))
	print('<title>ConcatRSS - {}</title>'.format(n))
else:
	print('<title>ConcatRSS</title>')
for feed in fileinput.input():
	r = urllib.request.Request(feed, headers=headers)
	with urllib.request.urlopen(r) as p:
		assert p.status is 200
		with xml.dom.minidom.parse(p) as x:
			for i in x.getElementsByTagName('entry'):
				print(i.toxml())
	time.sleep(10)
print('</feed>')
