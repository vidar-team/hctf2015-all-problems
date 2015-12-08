assume cs:code

data	segment
	db 25,?,25 dup (0)
	db 33 dup (0)
	db 33 dup (0)
	db 55h,6Fh,6EH,5AH,45H,60H,45H,45H,54H,51H,5DH,45H,64H,45H,4EH,5DH,5BH,6BH,4BH,79H,4BH,76H,48H,3CH,40H,7EH,54H,77H,7EH,6FH,40H,74H,0
	db "you got it",'$'
	db "try again",'$'
data ends


code	segment
start:
	mov si,2
	mov di,27

	mov dx,0
	mov ah,0ah
	int 21h

	mov byte ptr [di-1],0

	mov cx,8
base:	mov al,[si]
	and al,0FCh

	mov dx,cx
	mov cl,2
	shr al,cl
	mov cx,dx

	mov bx,1;offset a1
	jmp m
a1:
	inc di
	mov al,[si]
	and al,3

	mov dx,cx
	mov cl,4
	shl al,cl
	mov cx,dx
	
	mov ah,[si+1]
	and ah,0F0h
	
	mov dx,cx
	mov cl,4
	shr ah,cl
	mov cx,dx

	add al,ah
	mov bx,2;offset a2
	jmp m
a2:
	inc di
	mov al,[si+1]
	and al,0Fh
	
	mov dx,cx
	mov cl,2
	shl al,cl
	mov cx,dx

	mov ah,[si+2]
	and ah,0C0h
	
	mov dx,cx
	mov cl,6
	shr ah,cl
	mov cx,dx

	add al,ah
	mov bx,3;offset a3
	jmp m
a3:
	inc di
	mov al,[si+2]
	and al,03Fh
	mov bx,4;offset a4
	jmp m
a4:
	inc di
	add si,3
	loop base


	mov di,27
	mov cx,16
xor_loop:
	mov al,[di]
	mov ah,[di+16]
	xor al,7
	xor ah,12
	mov [di+16],al
	mov [di],ah
	inc di
	loop xor_loop

	mov si,60
	mov di,27
	mov cx,16
l:
	mov ax,[di]
	mov [si],al
	mov [si+16],ah
	add di,2
	inc si
	loop l

	mov di,60
	mov si,93
	mov cx,33
cmp_loop:
	mov al,[di]
	mov ah,[si]
	cmp al,ah
	jnz f
	inc di
	inc si
	loop cmp_loop

	mov dx,126
	mov ah,9
	int 21h
	jmp exit
f:
	mov dx,137
	mov ah,9
	int 21h

exit:
	mov ax,4c00h
	int 21h

m:	cmp al,25
	ja s1
	add al,'A'
	jmp EN
s1:
	cmp al,51
	ja s2
	add al,'a'
	sub al,26
	jmp EN
s2:
	cmp al,62
	jnz s3
	mov al,'+'
	jmp EN
s3:
	cmp al,63
	jnz s4
	mov al,'/'
	jmp EN
s4:
	add al,'0'
	sub al,52

EN:
	mov [di],al

	cmp bx,1
	jz k1
	cmp bx,2
	jz k2
	cmp bx,3
	jz k3
	cmp bx,4
	jz k4

k1:	jmp a1	
k2:	jmp a2
k3:	jmp a3
k4:	jmp a4

code	ends
end	start
	