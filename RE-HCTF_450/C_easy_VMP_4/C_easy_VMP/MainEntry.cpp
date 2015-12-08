#include <cstdio>
#include <Windows.h>
#include "Stack.h"
#include "VM.h"

int main()
{

	char Check_HCTF[] = "\x7b\x70\x6a\x67\x72\x73\x75\x55\x44\x32\x48\x50\x11\x12\x13\x14\x15";
#ifdef _DEBUG
	char stringIn[] = "HCTF{123456789123456789}";
	printf("addr1 = %x \n", stringIn);
	printf("addr2 = %d \n", Check_HCTF);
#else
	char stringIn[40] = {0};
	scanf_s("%s", stringIn, 40);
#endif
	/*
	DWORD CODE[] =
	{ 
	VM_X00_START, 
	VM_PUSH, PUSH_NUM, (DWORD)stringIn, //NUM1  push addr of input Str
		
	VM_POP,POP_EBX,
	VM_PUSH,PUSH_EBX,				//EBX = ADDR STR

	VM_STRLEN_CALL, //pop addr, call strlen, push result

	VM_PUSH, PUSH_NUM, 0x0,	//NUNM2 push 0x0 i = 0
	VM_CMP,			//cmp <-----

	VM_PUSH, PUSH_NUM, 0x23,	//push NUM3 is jum to exit
	VM_JZ, Jump_From_EIP,		//pop NUM3 JZ  (18)
	 
	VM_POP,POP_EAX,		//pop eax  ;eax = i

	VM_PUSH,PUSH_EBX,	//EBX: push addr of input Str
	VM_PUSH,PUSH_EAX,	//PUSH i
	
	VM_ADD,				//Pop i ,add i str
	VM_PUSH,PUSH_MEM|PUSH_MEM_BYTE, //POP STR, FIND BYTE STR, PUSH result
	VM_PUSH,PUSH_NUM,0x6,    //num push 6 (6)
	VM_XOR,					 //pop 6,top xor 6

	VM_PUSH,PUSH_EBX,	//EBX: push addr of input Str
	VM_PUSH,PUSH_EAX,	//PUSH i
	VM_ADD,				//Pop i ,add i str
	VM_POP,POP_MEM|POP_MEM_BYTE,//pop addr,pop result, Set That addr      

	VM_PUSH,PUSH_EAX,	//EAX = i
	VM_PUSH,PUSH_NUM,0x1,	//NUM = 1
	VM_ADD,			//I = I+1
	VM_POP,POP_EAX,		//eax = i
	VM_PUSH,PUSH_EAX,	//

	VM_PUSH,PUSH_NUM,-0x29,	//NUM5  jmp code
	VM_JMP, Jump_From_EIP,		//circle jmp
	VM_EXIT };
	*/
	DWORD CODE[] =
	{
		/////////////////////////Data and function/////////////////////
		VM_EXIT,
		VM_EXIT,
		/////////////////////////Code Start/////////////////////////////
		VM_X00_START,
		/////////////////////////fun1 strlen////////////////////////////////
		VM_PUSH, PUSH_NUM, (DWORD)stringIn, //NUM1  push addr of input Str  *stack 1
		VM_POP, POP_EBX,
		VM_PUSH, PUSH_EBX,					//EBX = ADDR STR
		VM_PUSH, PUSH_EBX,					//保存一次 addr of input str
		VM_STRLEN_CALL,						//pop addr, call strlen, push result *stack1
		VM_PUSH, PUSH_NUM, 0x18,			
		VM_CMP,								//计算长度是否为24  *stack 2

		VM_PUSH, PUSH_NUM, 0x7,			    //push jmp next func(jmpto_fun2)  *stack 3
		VM_JZ, Jump_From_EIP,				//pop and JZ  (18)	*stack 2
		VM_PUSH, PUSH_NUM, 0,				//jmp code to Fail   *stack 3
		VM_JMP, Jump_From_OEP,				//jmp   *stack 2
		///////////////////////fun2 xor HCTF{//////////////////////////////

		VM_POP, POP_DEL,					//平衡栈空间（可以删除）*Stack 1 topofStack:length of addr 
		VM_PUSH, PUSH_NUM, 0x5,				//HCTF{ 5个
		VM_PUSH, PUSH_NUM, 0x0,				//push 0x0 i = 0  *Stack 2
		VM_CMP,			//cmp <-----

		VM_PUSH, PUSH_NUM, 0x23,	//push NUM3 is jum to exit
		VM_JZ, Jump_From_EIP,		//pop NUM3 JZ  (18)

		VM_POP, POP_EAX,		//pop eax  ;eax = i
		VM_PUSH, PUSH_EBX,	//EBX: push addr of input Str
		VM_PUSH, PUSH_EAX,	//PUSH i
		VM_ADD,				//Pop i ,add i str
		VM_PUSH, PUSH_MEM | PUSH_MEM_BYTE, //POP STR, FIND BYTE STR, PUSH result
		VM_PUSH, PUSH_NUM, 0x33,    //num push 0x33 
		VM_XOR,					 //pop 0x33,top xor 0x33

		VM_PUSH, PUSH_EBX,			   //EBX: push addr of input Str
		VM_PUSH, PUSH_EAX,			   //PUSH i
		VM_ADD,						   //Pop i ,add i str
		VM_POP, POP_MEM | POP_MEM_BYTE,//pop addr,pop result, Set That addr     

		VM_PUSH, PUSH_EAX,	//EAX = i
		VM_PUSH, PUSH_NUM, 0x1,	//NUM = 1
		VM_ADD,			//I = I+1
		VM_POP, POP_EAX,		//eax = i
		VM_PUSH, PUSH_EAX,	//

		VM_PUSH, PUSH_NUM, -0x29,	//NUM5  jmp code
		VM_JMP, Jump_From_EIP,		//circle jmp
		////////////////func check last '}'///////////////////////////
		VM_POP, POP_DEL,					//平衡栈空间
		VM_POP, POP_DEL,					//平衡栈空间 *Stack 2 topofStack:length of addr X 2
		VM_PUSH, PUSH_EBX,					//EBX: push addr of input Str
		VM_ADD,								 //Pop STR ,add 24  str
		VM_PUSH, PUSH_NUM, 0x1,
		VM_SUB,
		VM_PUSH, PUSH_MEM | PUSH_MEM_BYTE,
	
		VM_PUSH, PUSH_NUM, 0x33,		//num push 0x33 
		VM_XOR,							//pop 0x33,top xor 0x33
		VM_PUSH, PUSH_NUM, 0x4E,		//num push 0x4e
		VM_CMP,
		VM_PUSH, PUSH_NUM, 0x5,
		VM_JZ, Jump_From_EIP,
		VM_PUSH, PUSH_NUM, 0,				//jmp code to Fail   *stack 3
		VM_JMP, Jump_From_OEP,
		///////////////////func push HCTF{ xor 0x33////////////////////////////////

		VM_POP, POP_DEL,					//平衡栈空间
		VM_POP, POP_DEL,					//平衡栈空间 
		

		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_NUM,0x1,
		VM_SUB,
		VM_POP, POP_EAX,
		VM_PUSH, PUSH_EAX,
		VM_PUSH,PUSH_EBX,
		VM_ADD,
		VM_PUSH, PUSH_MEM | PUSH_MEM_BYTE,
		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_NUM,0,
		VM_CMP,
		VM_POP,POP_DEL,
		VM_POP, POP_DEL,
		VM_PUSH,PUSH_NUM,0x5,		//Jmp to next Fun
		VM_JZ, Jump_From_EIP,
		
		VM_PUSH,PUSH_NUM, -0x23,	//Circle Jmp
		VM_JMP, Jump_From_EIP,
		///////////////////fun check HCTF{/////////////////////////////////////


		VM_PUSH,PUSH_NUM,0,
		VM_POP,POP_EBX,				//EBX = i		
		VM_PUSH, PUSH_NUM, (DWORD)Check_HCTF,
		VM_POP,POP_EAX,				//EAX = ADDR Check_HCTF

		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_EBX,
		VM_ADD,
		VM_POP,POP_EAX,
		VM_PUSH,PUSH_EAX,			//EAX = EAX+i
		VM_PUSH, PUSH_MEM | PUSH_MEM_BYTE,
		VM_CMP,
		VM_PUSH,PUSH_NUM,0x5,  // <------ok
		
		VM_JZ,Jump_From_EIP,
		VM_PUSH,PUSH_NUM,0x0,
		VM_JMP,Jump_From_OEP,  //  <----- Fail

		VM_POP, POP_DEL,					//平衡栈空间
		VM_POP, POP_DEL,					//平衡栈空间 
		
		VM_PUSH,PUSH_EBX,
		VM_PUSH,PUSH_NUM,1,

		VM_ADD,
		VM_POP,POP_EBX,

		VM_PUSH,PUSH_EBX,
		VM_PUSH,PUSH_NUM,0x5,
		VM_CMP,
		VM_POP, POP_DEL,					//平衡栈空间
		VM_POP, POP_DEL,					//平衡栈空间 
		VM_PUSH,PUSH_NUM,0x5,
		VM_JZ,Jump_From_EIP,
		VM_PUSH, PUSH_NUM, -0x36,
		VM_JMP,Jump_From_EIP,

		///////////////////fun 压缩入栈模块//////////////////////////////

		
		VM_POP,POP_EAX,					//EAX = strlen(Input Str)
		VM_PUSH,PUSH_EBX,
		VM_ADD,
		VM_POP,POP_EBX,					//EBX = ADDR STR IN
		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_EBX,

		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_EAX,
		VM_XOR,
		VM_POP,POP_EAX,
		VM_PUSH, PUSH_EAX,					//这个空间存放着那个结果
		
		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_NUM,0x4,//！！！
		VM_CMP,
		VM_PUSH,PUSH_NUM,0x0,
		VM_JZ,Jump_From_EIP,
		VM_POP, POP_DEL,					//平衡栈空间
		VM_PUSH,PUSH_EBX,
		VM_ADD,
		VM_PUSH, PUSH_MEM | PUSH_MEM_BYTE,
		VM_PUSH, PUSH_EAX,
		VM_PUSH, PUSH_NUM,0x3,
		VM_SHL,
		VM_SHL,
		VM_OR,

		VM_PUSH,PUSH_EAX,
		VM_PUSH,PUSH_NUM,0x1,
		VM_ADD,
		VM_POP,POP_EAX,
		VM_PUSH,PUSH_NUM,0,//！！！
		VM_JMP,Jump_From_EIP,

		VM_DEBUG_BREAK,
		
		




		VM_EXIT
		

		
		
		
	};
	VM_Function Fun1(64);
	Fun1.StartVM(CODE+2);
	/*printf("VM_2:%x\n", (int*)*(int*)(&Fun1));
	
	if (!strcmp(stringIn, "745230"))
	{
		printf("YOU GOT IT\n");
	}
	else
	{
		printf("SORRY FAIL\n");
	}*/
#ifdef _DEBUG
	printf("%s\n", stringIn);
	for (int i = 0; i < strlen(stringIn); i++)
	{
		printf("%3d  ( %3x ) ( %3c )\n", i, stringIn[i], stringIn[i]);
	}
#endif
	return 0;
}