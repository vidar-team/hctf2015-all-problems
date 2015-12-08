#!/usr/bin/python 
#encoding:utf-8
import Image as IM
import ImageDraw as IMDW
import ImageFont as IMF
from time import time,sleep
from random import random,seed
import sys
import json
ss = 'ABEFGHJKMNRSTVWXYZabdefghjmnpqrstu23456789'
w = 430
h = 130
seed(time())
for j in xrange(int(sys.argv[1])):
	rs = ''
	r = int(random()*100)%14-7
	for i in range(5):
		rs += ss[int(random()*100)%len(ss)]
		seed(time()*random())
	img = IM.new('RGB',(w,h))
	ft = IMF.truetype('msyh.ttc',80+r)	
	dw = IMDW.Draw(img)
	dw.text((5,0),rs,font=ft,fill=(255,255,255))
	seed(random()*time())
	rr = int(random()*1000)%160/10.0 - 8 #+ (int(random()*10)%2)*180
	rx = int(random()*100)%30
	ry = int(random()*100)%20
	fn = ''.join(rs.split(' '))
	print fn
	img.offset(rx,ry+8).rotate(rr,IM.BICUBIC).point(lambda p:(255-p)).save('/tmp/pic/{}.png'.format(fn))
	import os
	os.system('./picmatch detect  /tmp/pic/{0}.png  /tmp/pic/kp/kpsample{1}'.format(fn,str(j)))
