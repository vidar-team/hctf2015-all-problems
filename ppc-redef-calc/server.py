#!/usr/bin/env python2.7
#encoding:utf-8
import SocketServer

from random import random,seed,randrange
from time import time,sleep
import zio
from hashlib import md5

ops = '+-*'

class MyServer(SocketServer.ThreadingTCPServer,object):
  allow_reuse_address = True
  def handle_timeout(self):
  	print '->>>>>>>>>>>>>>>>>>'


class MyHandler(SocketServer.StreamRequestHandler):
	TO_LV1 = 10
	TO_LV2 = 6
	TO_LV3 = 1.2
	TO_LV4 = 4
	def handle(self):
		print 'get connection from',self.client_address
		self.request.settimeout(10)
		self.wfile.write('TOKEN=')
		self.token = self.rfile.readline().strip()
		print 'TOKEN='+self.token
		if '' == self.token:
			self.wfile.write('\n\nwrong token\n')
			return
		print 'serving team {'+self.token+'} from ',self.client_address
		self.request.settimeout(50)
		self.wfile.write('GeruzoniAnsasu的舍友M大大最近去旁听了编译原理，回来问了一个问题把大家都难住了：\n')
		#sleep(0.6)
		self.wfile.write('为啥处理语法树的时候要有人为规定的优先级？\n')
		#sleep(0.6)
		self.wfile.write('如果优先级重新定义的话……\n\n')
		self.rfile.readline()
		self.wfile.write('example: 2*4+5\n')
		self.wfile.write('  (2*4)+5 = 13\n')
		self.wfile.write('  2*(4+5) = 18\n\n')
		#sleep(0.6)
		self.wfile.write('那么所有这些情况的结果和是多少呢？(31)\n')
		if self.rfile.readline().strip() != '31':
			return
		self.wfile.write('\n\n先来熟悉熟悉吧：\n')
		#sleep(0.8)
		smps = (('1*2+3',10),('4-3+7',2),('9*3-5',4),('6+7*8',166),('15+3*8-7',255),('3*8+11+4',316))
		for i in range(3):
			t1 = time()
			s,v = smps[randrange(6)]
			self.wfile.write(s+' sum = ?\n')
			ans = int(self.rfile.readline().strip())
			t2 = time()
			if ans != v or t2-t1 > 50:
				self.wfile.write('噫……\n')
				return
		
		#sleep(0.5)	
		self.wfile.write('\n\n还可以，我感觉你已经理解意思了。\n')
		#sleep(0.8)
		self.wfile.write('现在让我们换一种表达方式，如下：\n\n')
		self.wfile.write('6[2,5,10,9,3,34]++*-*\n')
		self.wfile.write('答案159001\n\n')
		#sleep(0.3)
		self.wfile.write('以防数字太大，所有答案mod 1e9+7.\n')
		self.rfile.readline()
		#sleep(0.1)
		self.wfile.write('那么，lv1,计时开始:)\n\n')
		self.request.settimeout(self.TO_LV1)
		#sleep(0.3)
		self.wfile.write('2[0,10]- \n')
		ans = int(self.rfile.readline().strip())
		if ans != 999999997:
			self.wfile.write('再想想\n')
			return
		seed(time())
		sz_calc = ''
		sz_send = ''
		print '--LV1--'
		for i in xrange(randrange(5,8)):#5到8组 LV1
			break
			n = randrange(8,18)#8到18个数
			sz_calc = str(n)+'\n'
			sz_send = str(n)
			l = []
			for j in xrange(n):
				num = randrange(1e9+7)
				sz_calc += str(num)+' '
				l.append(num)
			sz_calc += '\n'
			sz_send += repr(l)
			for j in xrange(n-1):
				sign = ops[randrange(3)]
				sz_calc += sign
				sz_send += sign
			io = zio.zio('./calc',print_read = lambda x:'',print_write = lambda x:'')
			io.writeline(sz_calc)
			right_ans = int(io.readline().strip())
			print 'R->',right_ans
			self.wfile.write(sz_send+'\n')
			#continue
			ans = int(self.rfile.readline().strip())
			print '<-A',ans
			if ans != right_ans:
				return
			io.close()

		print '--LV2--'	
		self.wfile.write('可喜可贺！\nlv2，时限更严:)\n\n')#LV2
		self.request.settimeout(self.TO_LV2)
		for i in xrange(randrange(10,20)):#10到20组
			n = randrange(12,30)#12到30个数
			sz_calc = str(n)+'\n'
			sz_send = str(n)
			l = []
			for j in xrange(n):
				num = randrange(1e9+7)
				sz_calc += str(num)+' '
				l.append(num)
			sz_calc += '\n'
			sz_send += repr(l)
			for j in xrange(n-1):
				sign = ops[randrange(3)]
				sz_calc += sign
				sz_send += sign
			io = zio.zio('./calc',print_read = lambda x:'',print_write = lambda x:'')
			io.writeline(sz_calc)
			right_ans = int(io.readline().strip())
			print 'R->',right_ans
			self.wfile.write(sz_send+'\n')
			#continue
			ans = int(self.rfile.readline().strip())
			print '<-A',ans
			if ans != right_ans:
				print ':('
				return
			io.close()

		print '--LV3--'
		self.wfile.write('有希望看到flag了！\nlv3，证明你是精英的时候:)\n\n')#LV3
		self.request.settimeout(self.TO_LV3)
		for i in xrange(10):#30组
			n = randrange(90,150)#90到150个数
			sz_calc = str(n)+'\n'
			sz_send = str(n)
			l = []
			for j in xrange(n):
				num = randrange(1e9+7)
				sz_calc += str(num)+' '
				l.append(num)
			sz_calc += '\n'
			sz_send += repr(l)
			for j in xrange(n-1):
				sign = ops[randrange(3)]
				sz_calc += sign
				sz_send += sign
			io = zio.zio('./calc',print_read = lambda x:'',print_write = lambda x:'')
			io.writeline(sz_calc)
			right_ans = int(io.readline().strip())
			print 'R->',right_ans
			self.wfile.write(sz_send+'\n')
			#continue
			ans = int(self.rfile.readline().strip())
			print '<-A',ans
			if ans != right_ans:
				return
			io.close()

		print '--LV4--'
		self.wfile.write('\nINSANE!!\n\n')#LV4
		self.request.settimeout(self.TO_LV4)
		for i in xrange(2):
			n = randrange(700,900)#700到900个数
			sz_calc = str(n)+'\n'
			sz_send = str(n)
			l = []
			for j in xrange(n):
				num = randrange(1e9+7)
				sz_calc += str(num)+' '
				l.append(num)
			sz_calc += '\n'
			sz_send += repr(l)
			for j in xrange(n-1):
				sign = ops[randrange(3)]
				sz_calc += sign
				sz_send += sign
			io = zio.zio('./calc',print_read = lambda x:'',print_write = lambda x:'')
			io.writeline(sz_calc)
			right_ans = int(io.readline().strip())
			print 'R->',right_ans
			self.wfile.write(sz_send+'\n')
			#continue
			ans = int(self.rfile.readline().strip())
			print '<-A',ans
			if ans != right_ans:
				return
			io.close()

		self.wfile.write('here you got the flag, but i removed some code from original file.\n')
                print 'team {%s} got the flag.' % self.token

if __name__ == "__main__":
	host = '0.0.0.0'
	port = 4799
	print 'started.'
	s = MyServer((host,port),MyHandler)
	s.serve_forever()
