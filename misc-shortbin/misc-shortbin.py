#!/usr/bin/python
#coding:utf-8

import SocketServer
#from zio import *
import string
import os
from hashlib import md5
import subprocess

class MyServer(SocketServer.ThreadingTCPServer,object):
    allow_reuse_address = True

class MyHandler(SocketServer.StreamRequestHandler):
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

        self.wfile.write('\nProgrammers are alwas trying to write shorter code, \
so that they can finish their work earlier and enjoy a cup of java.\n')
        self.rfile.readline()
        self.wfile.write('Since I am a very lazy programmer, a typical "Hello world" program wrote by me usually has only 56 bytes.\n')
        self.rfile.readline()
        self.wfile.write("But I think that's enough. There has been a lot of things can be done, within 60 bytes.\n")
        self.rfile.readline()
        self.wfile.write('We are all programmers. Do you agree with me?\n')
        rpl = self.rfile.readline().strip()
        if rpl.lower().find('no') >= 0:
            self.wfile.write('Ah... what a pitty:(\n')
            return
        elif rpl.lower().find('yes') >= 0:
            self.wfile.write("Hmm.. I'm happy to hear that:) But I must test your honesty.\n")
            self.rfile.readline()
            self.wfile.write("I will ask you some questions, please answer them in our PROGRAMmer WAY:)\n")
            self.wfile.write('Remember that famous word? Talk is cheap, show me the CODE :)\n\n')
            self.wfile.write('***Hey your codes never compiled? <<<-I AM THE LAST HINT.\n\n')
            
            QnA = (('Q1:Do you enjoy tea or coffee?','coffee'),('Q2:Do you like hacking things?','yes'),('Q3:Will you hack me?','no'))
            rply = {\
            'coffee':\
                ("Haha nice:)\n",\
                "Hey don't you like java? There is nothing worth talking with you:( BYE\n"),\
            'yes':\
                ('Great! We are the same:)\n',\
                "Are you really a hacker? Why do you come here?\n"),\
            'no':\
                (':) Alright, give you the flag:',
            'FxxK YOU!\n')}
            LEN_LIMIT = 60
            for i,t in enumerate(QnA):
                q,a = t
                self.wfile.write(q+'\n')
                d = self.request.recv(200)
                print '-'*30+'\n{}\n'.format(repr(d))+'-'*30+'\n'*2
                if len(d) > LEN_LIMIT:
                    self.wfile.write('Wow too long!\n')
                    return
                if d.find('ELF')<0 or d.find('main')>=0 :
                    self.wfile.write('Huh..?Are your sure you understood me?\n')
                    return
                h = md5(d).hexdigest();
                print h
                with open('/tmp/'+h,'wb') as f:
                    f.write(d)
                os.system('chmod 777 /tmp/'+h)
                #io = zio('/tmp/'+h,timeout = 0.1)
                pp = subprocess.Popen('/tmp/'+h,stdout=subprocess.PIPE)
                pp.wait()
                ans = pp.stdout.read().strip('\x00 \n')
                pp.stdout.close()
                #ans = ''
                #try:
                #    ans = io.read(100).strip('\0 \n\t')[:len(a)]
                #except EOF:
                #    pass
                #except TIMEOUT:
                #    pass
                os.system('pkill -9 '+h)
                os.system('rm -f /tmp/'+h)
                print '**{}----------{}**'.format(str(list(a)),str(list(ans)))
                print cmp(ans ,a.strip())
                if ans != a.strip():
                    self.wfile.write(rply[a][1])
                    break
                else: 
                    if i < 2:
                        self.wfile.write(rply[a][0]+"\n...Oh lazy me... This time can you give me shorter answer?\n\n")
                    LEN_LIMIT -= 4
            else:
		self.wfile.write('here you got the flag, but i removed some code from original file.\n')
                print 'team {%s} got the flag.' % self.token
        else:
            self.wfile.write(':( You are not listening.\n')
        


if __name__ == "__main__":
    host = '0.0.0.0'
    port =  9999
    s = MyServer((host, port), MyHandler)
    s.serve_forever()
