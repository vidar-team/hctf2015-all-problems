//callee.c
#include <stdlib.h>
#include <stdio.h>
#include <memory.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
	
ssize_t read(int fd, void *buf, size_t count);
ssize_t write(int fd, const void *buf, size_t count);
extern char * _extern;
extern char* _extern_end;
char flgsz[128] = {"\nflag:hctf{Ye4h_u_g0"};
char fakesz[128] = {"什么的……当然是假的啦！"};

//tmp
extern char * FAKE_J1;
extern char * FAKE_J2;
extern char * FAKE_J3;
extern char * FAKE_J4;
extern char * FAKE_J5;
extern char * FAKE_J6;
extern char * FAKE_J7;
extern char * FAKE_J8;
extern char * FAKE_J9;
extern char * FAKE_J10;
extern char * FAKE_J11;
extern char * FAKE_J12;

void XOR(char *s1,char *s2,unsigned int len)
{
	unsigned int i=0;
	for(i=0;i<len;i++)
	{
		*(s1+i) ^= *(s2+(len-i));
	}
}

void  __fini(void) __attribute__((destructor));
void  __fini(void)//never here
{
XOR (FAKE_J1,FAKE_J2,0x30);
XOR (FAKE_J2,FAKE_J3,0x30);
XOR (FAKE_J3,FAKE_J4,0x30);
XOR (FAKE_J4,FAKE_J5,0x30);
XOR (FAKE_J5,FAKE_J6,0x30);
XOR (FAKE_J6,FAKE_J7,0x30);
XOR (FAKE_J7,FAKE_J8,0x30);
XOR (FAKE_J8,FAKE_J9,0x30);
XOR (FAKE_J9,FAKE_J10,0x30);
XOR (FAKE_J10,FAKE_J11,0x30);
XOR (FAKE_J11,FAKE_J12,0x30);
}
void __init(void) __attribute__((constructor));
void __init(void)
{

	__asm__ __volatile__ (
	"pushq %rbp;"
	"pushq %rsp;"
	"movq  %rsp,%rbp;"
	"leaq  _extern_end, %rsp;"//_extern_end
	"pushq  $write;"				//write
	"pushq $puts;"					//puts
	"pushq $read;"					//read
	"pushq $memcpy;"			//memcpy
	"pushq $XOR;"					//xor
	"leaq 8(%rbp) , %rsp;"
	"popq %rbp"
	);
}
void handle3()
{
	void handle2();
	puts(fakesz);
	signal(SIGALRM,handle2);  
    alarm(40); 
}
void handle2()
{
	puts(flgsz);
	signal(SIGALRM,handle3);  
    alarm(1); 
}
void handle()
{
	puts("\nTry the flag you got:");
	signal(SIGALRM,handle2);  
    alarm(10); 
}

int main(int argc, char **argv)
{
	 signal(SIGALRM,handle);  
    alarm(1); 
	//puts("本来这个程序有好多种运行方法的实在写不下去改简单了\n");
	asm volatile(
	"movq $0x0A86BAE4,%rax;"
	"push %rax;"
	"movq $0x958DE580AEE7B994,%rax;"
	"push %rax;"
	"movq $0xE6BB8EE58BB8E48D,%rax;"
	"push %rax;"
	"movq $0xB8E49986E5A89CE5,%rax;"
	"push %rax;"
	"movq $0x9EAEE5849AE795B3,%rax;"
	"push %rax;"
	"movq $0xE6B996E68CA1E890,%rax;"
	"push %rax;"
	"movq $0xBFE88DA7E79AA4E5,%rax;"
	"push %rax;"
	"movq $0xBDA5E5899CE68FBA,%rax;"
	"push %rax;"
	"movq $0xE58BA8E7AAB8E499,%rax;"
	"push %rax;"
	"movq $0xBFE8A59DE6AC9CE6,%rax;"
	"push %rax;"
	
	//"movq %rsp,%rdi;"
	"push %rsp;"
	"pop %rbx;"
	"push $_realstart;"//go start
	"push $JMP_RAX;"
	"push %rbx;"
	"push $POP_RDI;"
	//"lea  _extern_end, %rax;"
	"push $MOV_SELF_RAX;"
	"push $SUB_RAX_16;"
	"push $_extern_end;"
	"push $POP_RAX;"
	//"call -0x10(%rax);"
	"ret;"
	);
}
