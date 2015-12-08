#!/usr/bin/env python
#-*- coding:utf-8 -*-

import threading
import os
import time

class op_file (threading.Thread):

	def __init__(self, url, header, data):
		try:
			if data == {}:
				data = "NULL"
			self.log = [str(url), str(header), str(data)]
			self.filename = ["cache/urllll_lllllll.log", "cache/headerrrrr_rrrrr.log", "cache/dataaaaa_aaaaaaa.log"]
			self.sync = threading.Event()
			self.sync.set()
			threading.Thread.__init__(self)
		except(Exception) as s:
			print s
	
	def run(self):
		try:
			self.sync.wait()
			self.test_file()
			for x in range(len(self.filename)):
				open(self.filename[x], "a").writelines(self.log[x]+"\n")
		except(Exception) as s:
			print s
	
	def test_file(self):
		self.sync.clear()
		for x in self.filename:
			try:
				if len(open(x, 'rU').readlines()) > 1000:
					os.rename(x, x + str(time.time()).replace('.',''))
			except(Exception) as s:
				print s
		self.sync.set()
