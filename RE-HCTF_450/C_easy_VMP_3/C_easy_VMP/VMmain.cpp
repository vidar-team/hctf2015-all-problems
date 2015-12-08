#include "VM.h"
VM_Function::VM_Function(int datax) :VM_STACK(datax)
{
	ControlTable[VM_X00_START] = 0x00;
	ControlTable[VM_PUSH]	   = &VM_Function::CODE_PUSH;

	ControlTable[VM_POP]	  = &VM_Function::CODE_POP;
	ControlTable[VM_ADD]	  = &VM_Function::CODE_ADD;
	ControlTable[VM_SUB]	  = &VM_Function::CODE_SUB;
	ControlTable[VM_XOR]	  = &VM_Function::CODE_XOR;
	ControlTable[VM_JMP]	  = &VM_Function::CODE_JMP;
	ControlTable[VM_JZ]		  = &VM_Function::CODE_JZ;
	ControlTable[VM_CMP]	  = &VM_Function::CODE_CMP;

	ControlTable[VM_STRLEN_CALL]  = &VM_Function::CODE_STRLEN_CALL;
	ControlTable[VM_EXIT]	  = &VM_Function::CODE_EXIT;
	//ProcessTest xxxx;
	//xxxx = &VM_Function::CODE_X00_START;
	//printf("VM_1:%x,  VM_1:%x\n", xxxx, *(int*)*(int*)(this));
	//calltest = xxxx;

	//(this->*calltest)();//这里的Clall是通过一个跳转表实现的？为什么？

	//typedef void(*Fun)(VOID);
	//Fun pFun = NULL;
	//pFun = (Fun)*((int*)*(int*)(this));
	//pFun();

}
void VM_Function::CODE_X00_START()
{
	printf("VM_Start\n");
}
void VM_Function::CODE_PUSH(PVMDATA vm_data)
{
	DWORD reg = *((vm_data->CODE)+2);
	switch ((*(++vm_data->CODE))&0x70)
	{
	case PUSH_EAX:
		Stack_Push(vm_data->EAX);
		break;
	case PUSH_EBX:
		Stack_Push(vm_data->EBX);
		break;
	case PUSH_MEM:
		Stack_Pop(&reg);
	
		switch ((*vm_data->CODE) & 0x7)
		{
		case PUSH_MEM_BYTE:
			reg = *(BYTE*)reg;
			break;
		case PUSH_MEM_WORD:
			reg = *(WORD*)reg;
			break;
		case PUSH_MEM_DWORD:
			reg = *(DWORD*)reg;
			break;
		default:
			break;
		}
		Stack_Push(reg);
		break;
	case PUSH_NUM:
		Stack_Push(reg);
		(vm_data->CODE)++;
		break;
	default:
		break;
	}
	
}
/*
void VM_Function::CODE_PUSH_EBX(PVMDATA vm_data)
{
	Stack_Push(vm_data->EBX);
}
void VM_Function::CODE_PUSH_NUM( PVMDATA vm_data)
{
	Stack_Push(*(vm_data->DATA));
	(vm_data->DATA)++;
}
void VM_Function::CODE_POP_EBX(PVMDATA vm_data)
{
Stack_Pop(&(vm_data->EBX));
}*/
void VM_Function::CODE_POP(PVMDATA vm_data)
{
	DWORD reg = 0;
	BYTE DataB = 0;
	WORD DataW = 0;
	DWORD DataDW = 0;
	DWORD Addr = 0;
	switch ((*(++vm_data->CODE)) & 0x70)
	{
	case POP_EAX:
		Stack_Pop(&(vm_data->EAX));
		break;
	case POP_EBX:
		Stack_Pop(&(vm_data->EBX));
		break;
	case POP_MEM:
		
		Stack_Pop(&Addr);
		Stack_Pop(&reg);
		
		switch ((*vm_data->CODE) & 0x7)
		{
		case POP_MEM_BYTE:
			
			_asm
			{
				push eax
				xor eax, eax
				mov eax, reg
				mov DataB, al
				pop eax
			}
			*(BYTE*)Addr = DataB;
			break;
		case POP_MEM_WORD:
			
			_asm
			{
				push eax
				xor eax, eax
				mov eax, reg
				mov DataW, ax
				pop eax
			}
			*(WORD*)Addr = DataW;
			break;
		case POP_MEM_DWORD:
			
			_asm
			{
				push eax
				xor eax, eax
				mov eax, reg
				mov DataDW,eax
				pop eax
			}
			*(DWORD*)Addr = DataDW;
			break;
		default:
			break;
		}
		//(vm_data->CODE)++;
		break;
	case POP_DEL:
		Stack_Pop(&reg);
		break;
	default:
		break;
	}

}

void VM_Function::CODE_ADD( PVMDATA vm_data)
{
	
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] += reg;
	//FLAG改变
	vm_data->ZFLAG = ((S->vmStack[S->TopOfStack]) == 0);
	vm_data->SFLAG = ((S->vmStack[S->TopOfStack]) < 0);
}
void VM_Function::CODE_SUB(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] -= reg;
	//FLAG改变
	vm_data->ZFLAG = ((S->vmStack[S->TopOfStack]) == 0);
	vm_data->SFLAG = ((S->vmStack[S->TopOfStack]) & 0x80000000);
}
void VM_Function::CODE_XOR(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] ^= reg;
	
}
void VM_Function::CODE_JMP( PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg );
	(vm_data->CODE)++;
	if (Jump_From_EIP == *(vm_data->CODE))
		vm_data->CODE = (vm_data->CODE) + (reg);
	if (Jump_From_OEP == *(vm_data->CODE))
		vm_data->CODE = (PDWORD)(vm_data->OEP) + (reg);
	
}
void VM_Function::CODE_JZ( PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	(vm_data->CODE)++;
	if (vm_data->ZFLAG)
	{
		if (Jump_From_EIP == *(vm_data->CODE))
			vm_data->CODE = (vm_data->CODE) + (reg);
		if (Jump_From_OEP == *(vm_data->CODE))
			vm_data->CODE = (PDWORD)(vm_data->OEP) + (reg);

		vm_data->ZFLAG = 0;
	}
	
}
void VM_Function::CODE_CMP(PVMDATA vm_data)
{
	DWORD reg = NULL;
	reg = (S->vmStack[(S->TopOfStack) - 1]) - (S->vmStack[S->TopOfStack]);
	vm_data->ZFLAG = (reg == 0);
	
}
/*
void VM_Function::CODE_BYTE_MEM_GET(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	reg = *(BYTE*)reg;
	Stack_Push(reg);
}
void VM_Function::CODE_BYTE_MEM_SET(PVMDATA vm_data)
{
	DWORD reg = NULL;
	DWORD Addr = NULL;
	BYTE  Data = NULL;
	Stack_Pop(&Addr); //result
	Stack_Pop(&reg);//address
	_asm
	{
		push eax
		xor eax, eax
		mov eax, reg
		mov Data,al
		pop eax

	}
	*(BYTE*)Addr = Data;
}*/
void VM_Function::CODE_STRLEN_CALL(PVMDATA vm_data)
{
	DWORD reg = NULL;
	DWORD STRLEN_RET = 0;
	Stack_Pop(&reg);
	STRLEN_RET = strlen((char*)(reg));
	Stack_Push(STRLEN_RET);
}
void VM_Function::CODE_FAKE_CALL(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	StartVM((PDWORD)reg);
	Stack_Push(VM_RET);
}
void VM_Function::CODE_EXIT(PVMDATA vm_data)
{
	//free(xxx->vmStack);
	//free(xxx);
	vm_data->CODE = 0x0;
	
}
//
BOOL VM_Function::StartVM(PDWORD vmCode)
{
	VMDATA vm_data;
	//Stack vm_Stack = CreateVmStack(64);

	vm_data.OEP = (DWORD)vmCode;
	vm_data.CODE = vmCode;
	//vm_data.DATA = vmData;
	//vm_data.PARAM = vmparam;
	//vm_data.PARAM1 = vmparam1;
	vm_data.EAX = 0;
	vm_data.EBX = 0;
	//vm_data.ECX = 0;
	//vm_data.EDX = 0;
	//vm_data.EDI = 0;
	//vm_data.ESI = 0;
	//vm_data.ESP = 0;
	vm_data.SFLAG = FALSE;
	vm_data.ZFLAG = FALSE;
	
	
	while (vm_data.CODE++)
	{
		DWORD XXXX = *(vm_data.CODE);
		callname = ControlTable[*(vm_data.CODE)];
		(this->*callname)(&vm_data);
		
		/*switch (*(vm_data.CODE))
		{
		case VM_PUSH_EAX:
			CODE_PUSH_EAX(&vm_data);
			break;
		case VM_POP_EAX:
			CODE_POP_EAX(&vm_data);
			break;
		case VM_PUSH_EBX:
			CODE_PUSH_EBX(&vm_data);
			break;
		case VM_POP_EBX:
			CODE_POP_EBX(&vm_data);
			break;
		case VM_PUSH_NUM:
			CODE_PUSH_NUM(&vm_data);
			break;
		case VM_ADD:
			CODE_ADD(&vm_data);
			break;
		case VM_SUB:
			CODE_SUB(&vm_data);
			break;
		case VM_XOR:
			CODE_XOR(&vm_data);
			break;
		case VM_JMP:
			CODE_JMP(&vm_data);
			break;
		case VM_JZ:
			CODE_JZ(&vm_data);
			break;

		case VM_STRLEN_CALL:
			CODE_STRLEN_CALL(&vm_data);
			break;
		case VM_CMP:
			CODE_CMP(&vm_data);
			break;
		case VM_BYTE_MEM_GET:
			CODE_BYTE_MEM_GET(&vm_data);
			break;
		case VM_BYTE_MEM_SET:
			CODE_BYTE_MEM_SET(&vm_data);
			break;
		case VM_EXIT:
			CODE_EXIT(&vm_data);
			return TRUE;
		default:
			break;
		}*/
		
	}
	return FALSE;
}