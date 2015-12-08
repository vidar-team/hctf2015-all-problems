;半成品版本，少一层壳，反调试不是很好
assume cs:code

code	segment
	db 25,?,25 dup (0)
	db 33 dup (0)
	db 33 dup (0)
	db 55h,6Fh,6EH,5AH,45H,60H,45H,45H,54H,51H,5DH,45H,64H,45H,4EH,5DH,5BH,6BH,4BH,79H,4BH,76H,48H,3CH,40H,7EH,54H,77H,7EH,6FH,40H,74H,0
	db "you got it",'$'
	db "try again",'$'
start:
	mov ax,code
	mov ds,ax
	mov ss,ax
	mov sp,offset base64
	mov bp,offset base64
	mov di,offset base64

base_start:
	cmp byte ptr [bp],23
	jnz	s1

	mov byte ptr [di],0
	jmp main_end

s1:
	;mov ax,[si]
	pop ax
	dec sp
	xor ax,1717h
	mov bx,1 ;offset r1
	jmp change

r1:
	mov cl,2
	shl al,cl
	mov cl,4
	shr ah,cl
	add al,ah
	mov [di],al


	cmp byte ptr [bp+2],42
	jnz s2
	mov byte ptr [di+1],0
	jmp main_end
s2:
	;mov ax,[si+1]
	pop ax
	dec sp
	xor ax,1717h
	mov bx,2 ;offset r2
	jmp change
r2:
	mov cl,4
	shl al,cl
	mov cl,2
	shr ah,cl
	add al,ah
	mov [di+1],al


	cmp byte ptr [bp+3],42
	jnz s3
	mov byte ptr [di+2],0
	jmp main_end
s3:
	;mov ax,[si+2]
	pop ax
	;dec sp
	xor ax,1717h
	mov bx,3 ;offset r3
	jmp change
r3:
	mov cl,6
	shl al,cl
	add al,ah
	mov [di+2],al

	add di,3
	add bp,4
	jmp base_start

main_end:

base64:	
	db 97, 112, 94, 86, 97, 111, 100, 86, 98, 112, 86, 86, 99, 86, 101
	db 89, 94, 116, 77, 81, 56, 96, 84, 34, 84, 86, 84, 92, 85, 84, 67
	db 47, 126, 46, 80, 111, 86, 99, 91, 120, 126, 47, 102, 32, 86, 70
	db 83, 103, 100, 112, 85, 95, 126, 112, 70, 124, 86, 35, 97, 69, 100
	db 70, 67, 68, 35, 94, 97, 92, 126, 122, 70, 85, 112, 88, 67, 96, 126
	db 46, 80, 111, 85, 89, 91, 100, 126, 47, 120, 84, 111, 91, 100, 84
	db 86, 88, 122, 71, 86, 82, 114, 92, 69, 86, 82, 124, 83, 35, 97, 69
	db 100, 70, 91, 68, 35, 94, 97, 92, 126, 122, 70, 84, 112, 88, 67, 86
	db 126, 46, 80, 111, 85, 99, 91, 100, 126, 47, 120, 84, 111, 91, 100
	db 83, 86, 88, 99, 100, 124, 82, 114, 92, 69, 86, 94, 124, 71, 32, 100
	db 82, 86, 88, 99, 112, 124, 82, 114, 83, 111, 112, 71, 126, 123, 117
	db 47, 117, 86, 91, 124, 70, 86, 94, 120, 81, 126, 122, 66, 70, 89, 86
	db 114, 86, 46, 86, 110, 94, 69, 69, 84, 94, 93, 66, 113, 126, 32, 101
	db 35, 47, 86, 91, 47, 117, 86, 91, 124, 70, 86, 94, 100, 81, 126, 86
	db 68, 94, 77, 85, 84, 83, 111, 96, 93, 80, 35, 97, 88, 56, 71, 86, 84
	db 60, 79, 70, 84, 34, 94, 70, 84, 92, 85, 78, 120, 124, 88, 100, 69
	db 38, 83, 124, 115, 80, 35, 97, 68, 33, 113, 112, 84, 39, 84, 116, 39
	db 127, 33, 96, 126, 70, 98, 120, 124, 86, 99, 86, 121, 89, 94, 117
	db 112, 86, 67, 90, 39, 127, 71, 85, 123, 36, 85, 70, 69, 85, 33, 110
	db 92, 70, 71, 83, 89, 36, 85, 96, 69, 127, 91, 85, 101, 101, 81, 34
	db 86, 47, 71, 121, 66, 81, 100, 84, 97, 101, 83, 103, 86, 47, 71, 36
	db 66, 81, 100, 84, 56, 101, 85, 77, 86, 82, 90, 84, 96, 39, 126, 86, 64
	db 83, 60, 96, 81, 39, 83, 35, 71, 32, 86, 121, 70, 89, 112, 56, 100, 83
	db 115, 86, 98, 83, 60, 96, 69, 39, 84, 114, 124, 91, 56, 60, 124, 101
	db 56, 60, 123, 90, 56, 60, 123, 65, 56, 96, 42, 42
	mov ax,4c00h
	int 21h

change:
	mov dx,bx
	mov cl,al
	mov bx,1 ;offset c1
	jmp c
c1:	
	mov al,cl
	mov cl,ah
	mov bx,2 ;offset c2
	jmp c
c2:
	mov ah,cl
	mov bx,dx
	cmp bx,1
	jz k1
	cmp bx,2
	jz k2
	cmp bx,3
	jz k3


c:
	cmp cl,'a'
	jb ca
	sub cl,'a'
	add cl,26
	jmp c_end
ca:
	cmp cl,'A'
	jb cb
	sub cl,'A'
	jmp c_end
cb:
	cmp cl,'0'
	jb cc
	sub cl,'0'
	add cl,52
	jmp c_end
cc:
	cmp cl,'+'
	jnz cd
	mov cl,62
	jmp c_end
cd:
	mov cl,63
c_end:
	cmp bx,1
	jz k4
	cmp bx,2
	jz k5

k1:	jmp r1
k2:	jmp r2
k3:	jmp r3
k4:	jmp c1
k5:	jmp c2


code	ends
end	start

