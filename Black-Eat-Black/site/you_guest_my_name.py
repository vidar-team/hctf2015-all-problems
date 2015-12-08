#!/usr/bin/env python
#-*- coding:utf-8 -*-

from flask import Flask
from flask import request
from flask import Response
from werkzeug.routing import BaseConverter
import requests
import io_file
import urllib
import time
#import sys
#reload(sys)
#sys.setdefaultencoding('utf8')

class MyanyConverter(BaseConverter):
	weight = 200
	regex = '.*'
	
app = Flask(__name__, static_folder = "nononono")
app.url_map.converters['myany'] = MyanyConverter
#app.debug = True
#app.host = '127.0.0.1'
#app.port = 8888
#app.threaded = True

@app.route('/<myany:url>', methods = ['GET', 'POST'])
def index(url):
	print "-----------start-------------"
	resp = load_url(url)
	if resp == 444:
		return "", 404
	return load_resp(resp)
	

def load_resp(resp):
	infom = resp.content
	infom = infom.replace('https', 'http')
	h = {}
	r = resp.headers
	for x, y in r.items():
		if y == "" or 'gzip' in y:
			continue
		h[x] = y
	response = Response(infom, resp.status_code, h)
	print "--------------end--------------------------"
	return response
	
def load_url(u = ""):
	#print request.host
	if "120.55.181.136" in request.host:
		request.host = 'www.baidu.com'
	if u == "":
		url = "http://" + request.host
	else:
		url = "http://" + request.host + "/" + u
	#if request.host == "ss1.bdstatic.com":
	#	url = "https://" + request.host + "/" + u
	header = {}
	data = {}
	my_file = {}
	#首先拼凑url
	if len(request.args) > 0:
		url += "?"
		for x, y in request.args.items():
			url += x + "=" + y + "&"
	#然后拼凑header
	for x in request.headers:
		if x[1] == '':
                        continue
		header[x[0]] = x[1]
	#print request.headers
	io = io_file.op_file(urllib.quote(url), header, data)
	io.start()
	if request.method == 'GET':
		try:
			print url
			req = requests.get(url, headers = header, timeout = 2)
			print req.text
			return req
		except(Exception) as s:
			print s
			return 444
	 #如果是POST方法，拼凑data
	if request.method == 'POST':
		try: 	
			print request.files
			if len(request.files) == 1:
				te = request.files
				fie = te.keys()[0]
				f = request.files[fie]
				set_name = 'cache/file/' + f.filename + str(time.time()).replace('.', '')
				f.save(set_name)
				my_file = {fie: (f.filename, open(set_name, 'rb'))}
			for a, b in request.form.items():
				data[a] = b
			if my_file == {}:
				req = requests.post(url, headers = header, data = data, timeout = 2)
			else:
				print "right!"
				header.pop('Content-Type')
				req = requests.post(url, headers = header, data = data, files = my_file)
			return req
		except(Exception) as s:
			print s
			return 444
	else:
		return '404'

	
if __name__ == '__main__':
	app.run(debug = True, port = 80, host = '0.0.0.0', threaded = True)
	#app.run()
