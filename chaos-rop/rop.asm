;hctf_flag_:4Ux8dFnFy44XJzG4kvom4YQzC
vMagic1 equ 0x7c5f7cc4
vMagic2 equ 0xee91aeb5
vFinalL equ 0xea52a46b6abadc5f
vFinalH equ 0x8f5d96c766de3a00

BITS 64

extern flgsz
extern fakesz

global _realstart
global _extern
global _extern_end

;tmp
global JMP_RAX
global SUB_RAX_16
global POP_RAX
global POP_RDI
global MOV_SELF_RAX
global FAKE_J1, FAKE_J2, FAKE_J3, FAKE_J4, FAKE_J5, FAKE_J6,FAKE_J7,FAKE_J8,FAKE_J9,FAKE_J10,FAKE_J11,FAKE_J12

section .data write exec
CALL_HELPER9:;栈顶存放参数个数和go_addr
	pop r8;ret addr
	pop r9;self
	pop r9;arg cout
	lea r10,[rsp-8]
c2:
	cmp r9,0
	jg c1
	add r8,9
	mov [rsp-8],r8
	mov rsp,r10
	ret
c1:
	pop r11
	mov [rsp-0x10],r11
	dec r9
	jmp c2
	
FAKE_J1:
	db 0xeb
MOV_SELF_RAX:
	mov rax,[rax]
	ret
entry3:
	movaps xmm0,[rdi];save part2
	AESENC xmm1,xmm2;buff1
	;AESENC xmm1,xmm0
	push entry4
	push POP_RBX
	ret
_extern:
	NONE dq 0
	ext_XOR dq 0
	ext_memcpy dq 0
	ext_read dq 0
	ext_puts dq 0
	ext_write  dq 0
_extern_end:
	align 64 
	
_jmptable:;should use s4+3 to jmp here
	times 30 db 0x0c
	inc r14;flag
	lea rax, [JMPTABLE]
	jmp [rax+r15*8];r15-->select jmp pos
	
_ss:
	s1 db "Hello :)",0xa,0x0
	s2 db "菊苣们好·-·",0xa,0x0
	s3 db "皆さんごきげんようovo",0xa,0x0
	s4 db "안녕하세요:)",0x0a,0x0
	len equ $ - s1
_realstart:
	xor rdi,rdi
	inc rdi
	dec r14;clear jmp table flag
	push rdi
	push s4+3
	push len
	push POP_RDX
	push s1
	push POP_RSI
	ret
	db 0xeb
_c1:; first time to call write
	;sub rsp 8
	call [ext_write]
	push s4+3
	push 1
	push POP_R15
	ret
	db 0xeb
_out3:
	push _out4
	push vMagicStr
	push POP_RCX
	push ADD_RAX_RCX
	push MOV_SELF_RAX
	push vMagicStr
	push POP_RAX
	push rax
	push POP_RCX
	ret
	db 0xeb
_EXIT:
	pop rax
	xor rbx,rbx
	int 0x80
_read_input:
	cmp r14,1
	jz l1;from jmp table r14 should be 1
buff_all:
	times 1023 db 0x0;can be anything,but size is 256
	db 0
l1:;read  input to buffall
	dec r14
	push l2;continue to l2
	push qword[ext_read]
	push 0
	push POP_RDI
	push buff_all
	push POP_RSI
	push 1024
	push POP_RDX
	ret
	FAKE_J2:
	db 0xeb
JMP_RAX:
	jmp rax
	ret
FAKE_J3:
	db 0xeb
SUB_RAX_16:
	sub rax,16
	ret
l2:
	;rsi --> buff
	push MOV_SELF_RAX
	push rsi
	inc rsi
	push POP_RAX
	push 3
	push CALL_HELPER9
	call [rsp]
entry1:
	add r15,1;read_input / entry1_c
	jmp s4+3
;call return to here
hhh:
	mov rbx,entry1
	mov rcx,0x3732363034393931;19940627
	mov rdx,0x62d762d762d762d7
	xor rax,rcx
	shr rax,5
	xor rax,rdx
	movzx r12,al ; r12 --> times of sections --> 5
	shr rax,8
l4:;main loop
	inc rsi; point to secion data start
	cmp r12,0
	jg l3
;here out
_out:
	push _out1
	push MOV_SELF_RAX
	push buff1
	push POP_RAX
	ret
	db 0xeb
l3:
	dec r12
	movzx r13,al; r13 --> len of section -->8 for first
	test r14,r14
	jz l5
	align 128
buff1:
	times 0xff db 0xcc
FAKE_J5:
	db 0xeb
POP_RDI:
	pop rdi
	ret
_out1:
	push _out2
	push rax
	push POP_RCX
	ret
FAKE_J6:
	db 0xeb
POP_RSI:
	pop rsi
	ret
l6:
	inc r15
	call rbx
	push l4; jmp l4
	push MOV_SELF_RAX
	push rsi;	 this rsi must be original
	push POP_RAX
	ret
	FAKE_J7:
	db 0xeb
POP_RDX:	
	pop rdx
	ret
FAKE_J8:
	db 0xeb
POP_RCX:
	pop rcx
	ret
l8:
	mov ebx,eax
	;call rcx ;go out  --> entry2
	pop rsi
	push _sub
	push rsi; rsi --> beg of buff_all
	push POP_RAX
	push (l1-1);rdi --> endof buff_all
	push POP_RDI
	ret
	showstr	db "fl"
	db "agiswhat"
 	vMagicStr db "thefuck?",0 ; thefuck?  --> youinput
FAKE_J9:
	db 0xeb
POP_R15:
	pop r15
	ret
FAKE_J10:
	db 0xeb
ADD_RSI_R13:
	add rsi,r13
	ret
l5:
;copy data to buff1
	push l6
	push ADD_RSI_R13
	push qword[ext_memcpy];memcpy(buff1,rsi,r13_len)
	push r13
	push POP_RDX
	push buff1
	push POP_RDI
	ret
	FAKE_J4:
	db 0xeb
POP_RAX:
	pop rax
	ret
;entry1:
;	add r15,1;read_input / entry1_c
;	jmp s4+3	
entry1_c:
	dec r14
	push rsi ;save rsi
	push l7
	push qword[ext_XOR]
	push buff1
	push POP_RDI
	push $-3;self locating  || may be entry2?
	push POP_RSI
	push r13
	push POP_RDX
	ret
FAKE_J11:
	db 0xeb
ADD_RAX_RCX:
	add rax,rcx
	ret
FAKE_J12:
	db 0xeb
XOR_RAX_RCX:
	xor rax,rcx
	ret
entry2_c:
	dec r14
	movaps xmm2,[rdi];save part1
	;AESENC xmm1,xmm2;buff1
	movzx rcx, byte[buff1]
	lea rcx, [rcx*8]  ; must be 4*8
	push l9
	push MOV_SELF_RAX
	push ADD_RAX_RCX
	ret
	db 0xeb
sj5:
	xor r15, r15
	jmp entry3
POP_RBX:
	pop rbx
	ret
l7:	
	movaps xmm1,[buff1] ;AES KEY  0x3f6709877f3f661c
	;AESENC xmm1,xmm2
	;inc r15;r15=1+2 --> entry2 --> entry2_c
	push l8
	push XOR_RAX_RCX
	push MOV_SELF_RAX
	push buff1
	push POP_RAX
	;magic equ (0x3f6709877f3f661c)^(entry2-$$)
  ;%assign magic $^FAKE_J1
	push vMagic1 ; entry2 --> entry2_c  = entry2 ^ 0x7f3f661c
	;push $$
	push POP_RCX
	ret
	db 0xeb
_out2:
	mov rax,vFinalL
	xor rax,rcx
	test rax,rax
	jnz _EXIT;wrong,can't see any change
	mov rcx,vFinalH
	push _out3
	push XOR_RAX_RCX
	push MOV_SELF_RAX
	push buff1+8
	push POP_RAX
	ret	
	db 0xeb
entry2:
	add r15,2
	jmp s4+3
_sub:
	sub byte[rax], 0x30
	inc rax
	cmp rdi,rax
	jne _sub
	ret
	db 0xeb
sj4:
	xor r15, r15
	jmp entry2_c
l10:
	mov ebx,eax
	ret
	db 0xe8
entry4:
	movaps xmm3,[rdi];save part3
	AESENC xmm1,xmm0
	;AESENC xmm1,xmm3
	pxor xmm0,xmm2
	pxor xmm0,xmm3
	pxor xmm0,[rdi+128]
	movaps [rdi],xmm0
	push l10
	push XOR_RAX_RCX
	push vMagic2;magic2 --> entry5
	push POP_RCX
	push MOV_SELF_RAX
	push rdi
	push POP_RAX
	ret
	db 0xeb
sj3:
	xor r15, r15
	jmp entry1_c
sj1:
	xor r15, r15
	jmp _c1
JMPTABLE:
	dq sj1
	dq sj2
	dq sj3
	dq sj4
	dq sj5
entry5:
	AESENC xmm1,xmm3
	AESENC xmm1,[rdi]
	movaps [rdi],xmm1
	ret
l9:
	push buff1
	push POP_RDI
	push rax
	push POP_RBX
	ret
	db 0xeb
sj2:
	xor r15, r15
	jmp _read_input
	db 0xeb
_out4:
	mov [rcx],rax
	push _EXIT
	push qword[ext_puts]
	push showstr
	push POP_RDI
	ret
