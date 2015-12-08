#!/usr/bin/env python2.7
#encoding:utf-8

from zio import *
import time
target = ('127.0.0.1',9979)
target = ('120.55.113.21',4799)
io = zio(target,timeout=5,print_read=COLORED(REPR,'cyan'),print_write=COLORED(REPR,'red'))
io.writeline('thatsme')
io.writeline()
time.sleep(0.5)
io.writeline('31')
io.read_until('吧')
io.readline()
q = io.readline()
q = q[:q.find('sum')-1].strip()
smps = {'1*2+3':10,'4-3+7':2,'9*3-5':4,'6+7*8':166,'15+3*8-7':255,'3*8+11+4':316}
io.writeline(str(smps[q]))
q = io.readline()
q = q[:q.find('sum')-1].strip()
io.writeline(str(smps[q]))
q = io.readline()
q = q[:q.find('sum')-1].strip()
io.writeline(str(smps[q]))
io.writeline()
time.sleep(0.5)
io.read_until(':)')

io.readline()
io.readline()

while True:
	try:
		q = io.readline().strip()
		if q.find('[') < 0:
			raise 'E'
		n = q[:q.find('[')]
		nums = eval(q[q.find('['):q.find(']')+1])
		signs = q[q.find(']')+1:]
		#print n,nums,signs
		s = '{0}\n{1}\n{2}'.format(str(n),' '.join(map(str,nums)),signs)
		#print s
		calcio = zio('./calc',print_write=lambda x:'',print_read=lambda x:'')
		calcio.writeline(s)
		ans = calcio.readline().strip()
		#print 'ans:',ans
		io.writeline(ans)
		print '_______'
	except KeyboardInterrupt:
		break
	except:
		print '>>'
		if q.find('hctf') >= 0:
			print q
			break
		time.sleep(0.3)
		continue
