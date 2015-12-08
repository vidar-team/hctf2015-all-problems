/*————————————————————————————————————————*/
//题目名：来看看出题人疯了没有
//开发环境:VS2013
/*————————————————————————————————————————*/
/////////////////////////////////////////////////////////////////////

说声抱歉，本来这题没那么变态的，由于自己出题的时候不断有新的想法，不断往里面加所以出了6个版本，导致了这题代码上千，几乎不可能在几个小时内逆出来。

////////////////////////////////////////////////////////////////////
简介：
高分逆向题目，原来这道题没那么难的，但是越出越不对劲，你们自己看吧。
最初思路来源于BCTF的RE300码海寻踪，自己维护一个堆栈虚拟机，编码一套自己的字节码操作指令。
参考资料：加密与解密虚拟机加密部分。
////////////////////////////////////////////////////////////////////
文件：
C_easy_VMP,使用c语言编写的最简单demon
C_easy_VMP_2,改用c++了，将原来的switchcase变为一个跳转表。
C_easy_VMP_3,优化后将数据与操作混合了，使用单表形式。
C_easy_VMP_4,添加了更多的指令。。。。第四版的完成版在一次修改的时候不小心被覆盖了，就别看了。
C_easy_VMP_5,指令完成，参考x86。
完成版：就是题目了，添加虚拟call指令，部分混淆代码
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////


字节码指令：
跳转表。
	ControlTable[VM_X00_START] = 0x00;			
	ControlTable[VM_PUSH]	   = &VM_Function::CODE_PUSH;

	ControlTable[VM_POP]	  = &VM_Function::CODE_POP;
	ControlTable[VM_ADD]	  = &VM_Function::CODE_ADD;
	ControlTable[VM_SUB]	  = &VM_Function::CODE_SUB;
	ControlTable[VM_XOR]	  = &VM_Function::CODE_XOR;
	ControlTable[VM_JMP]	  = &VM_Function::CODE_JMP;
	ControlTable[VM_JZ]		  = &VM_Function::CODE_JZ;
	ControlTable[VM_CMP]	  = &VM_Function::CODE_CMP;

	ControlTable[VM_SHR] = &VM_Function::CODE_SHR;
	ControlTable[VM_SHL] = &VM_Function::CODE_SHL;
	ControlTable[VM_AND] = &VM_Function::CODE_AND;
	ControlTable[VM_OR] = &VM_Function::CODE_OR;

	ControlTable[VM_STRLEN_CALL]  = &VM_Function::CODE_STRLEN_CALL;
	ControlTable[VM_FAKE_CALL] = &VM_Function::CODE_FAKE_CALL;
	ControlTable[VM_EXIT_SUCCESS] = &VM_Function::CODE_EXIT_SUCCESS;
	ControlTable[VM_EXIT_FAIL] = &VM_Function::CODE_EXIT_FAIL;

#ifdef _DEBUG
	ControlTable[VM_DEBUG_BREAK] = &VM_Function::CODE_DBG_BREAK;
#endif



[VM_X00_START] 没用的标志，表示一个代码的起始。

[VM_PUSH]	   
enum Code_Push_Parameter
{
	PUSH_EAX = 0x10,
	PUSH_EBX = 0x20,
	PUSH_MEM = 0x30,
	PUSH_NUM = 0x40,
	PUSH_MEM_BYTE = 0x1,
	PUSH_MEM_WORD = 0x2,
	PUSH_MEM_DWORD= 0x4

};
向栈中PUSH一个数据，操作数为2元或3元，示例：
1.VM_PUSH, PUSH_MEM | PUSH_MEM_BYTE,出栈一个地址，取BYTE地址，入栈。
2.VM_PUSH,PUSH_NUM,0x0,入栈0

[VM_POP]	
enum Code_Pop_Parameter
{
	POP_EAX = 0x10,
	POP_EBX = 0x20,
	POP_MEM = 0x30,
	POP_DEL = 0x40,
	POP_MEM_BYTE = 0x1,
	POP_MEM_WORD = 0x2,
	POP_MEM_DWORD= 0x4
};同上。

[VM_ADD]	
出栈2个数据，相加之后，入栈

	  
[VM_SUB]	  
同上


[VM_XOR]	  
同上

[VM_JMP]	  
二元操作
出栈一个跳转长度
enum Code_JumpFun
{
	Jump_From_EIP = 0x10,	//下一个地址为跳转基地址
	Jump_From_OEP = 0X20	//入口点为跳转基地址
};
例如：
VM_PUSH,PUSH_NUM,0x0,
VM_JMP,Jump_From_OEP,
表示调到开头。

[VM_JZ]		  
同上，不过要判断Z标志位是否跳转。


[VM_CMP]	  
比较栈顶的2个值，设置Z与S flag，同x86


[VM_SHR] 
二元操作，出一个右移位数，再出一个数值，右移后放回栈中。


[VM_SHL] 
同上。

[VM_AND] 
同XOR

[VM_OR] 
同XOR

[VM_STRLEN_CALL]  
封装strlen

[VM_FAKE_CALL] 
启用一段新的虚拟字节码，与原字节码使用不同的寄存器，相同的栈。


[VM_EXIT_SUCCESS] 
返回成功（you got it）


[VM_EXIT_FAIL] 
返回失败（Try again）


[VM_DEBUG_BREAK] 
在Debug时用于debug字节码的指令，会显示堆栈与寄存器。


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

混淆方式：
1.垃圾指令。
例如：
		//垃圾指令//
		VM_PUSH,0x1000,
		VM_POP,0x1000,
不会被字节码解释器执行或者执行后没有任何意义的指令。

2.字节码自解密
例如：
		////需要解密的代码//////////////
		VM_X00_START ^ 0x28,
		VM_PUSH ^ 0x28,
		PUSH_NUM ^ 0x28,
		(DWORD)FUN_CHECK_3_FUN_2 ^ 0x28,
		VM_FAKE_CALL ^ 0x28,
		VM_PUSH ^ 0x28,
		PUSH_NUM ^ 0x28,
		58 ^ 0x28,
		VM_JMP ^ 0x28,
		Jump_From_EIP ^ 0x28,
		0xFFFFAAAA,

这段代码全部亦或了0x28，在运行时自解谜然后再运行。


3.乱序
出题人懒得写了。

4.循环位移
好麻烦啊，不写了。

/////////////////////////////////////////////////////////////////////////////////
源码都给你们了。。。。。自己吧
/////////////
