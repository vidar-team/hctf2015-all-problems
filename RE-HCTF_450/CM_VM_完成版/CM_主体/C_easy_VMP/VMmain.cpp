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

}
#ifdef _DEBUG
void VM_Function::CODE_DBG_BREAK(PVMDATA vm_data)
{
	printf("\n===== VM Debug BreakPoint  =====\n");
	Debug_PrintStack();
	printf(" EAX:  %x\n EBX:  %x\n Zflag: %d\n Sflag: %d\n", vm_data->EAX, vm_data->EBX, vm_data->ZFLAG, vm_data->SFLAG);
	getchar();
}
#endif
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
void VM_Function::CODE_SHR(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] = S->vmStack[S->TopOfStack] >> reg;
}
void VM_Function::CODE_SHL(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] = S->vmStack[S->TopOfStack] << reg;
}
void VM_Function::CODE_OR(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] |= reg;
}
void VM_Function::CODE_AND(PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg);
	S->vmStack[S->TopOfStack] &= reg;
}
void VM_Function::CODE_JMP( PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg );
	(vm_data->CODE)++;
	if (Jump_From_EIP == *(vm_data->CODE))
		vm_data->CODE = (vm_data->CODE) + (reg);
	else if (Jump_From_OEP == *(vm_data->CODE))
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
		else if (Jump_From_OEP == *(vm_data->CODE))
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
	StartVM((PDWORD)reg+2);
	Stack_Push(VM_RET);
}
void VM_Function::CODE_EXIT_SUCCESS(PVMDATA vm_data)
{
	vm_data->CODE = 0x0;
#ifdef _DEBUG
	Debug_PrintStack();
#endif
}
void VM_Function::CODE_EXIT_FAIL(PVMDATA vm_data)
{
	vm_data->CODE = 0x0;
	printf("Sorry Fail, Try Again\n");
	getchar();
	exit(1);
#ifdef _DEBUG
	printf("============END===========\n");
	printf("============END===========\n");
	printf("============END===========\n");
	Debug_PrintStack();
	exit(1);
#endif
}
//
BOOL VM_Function::StartVM(PDWORD vmCode)
{
	VMDATA vm_data;
	//Stack vm_Stack = CreateVmStack(64);

	vm_data.OEP = (DWORD)(vmCode-2);
	vm_data.CODE = vmCode;

	vm_data.EAX = 0;
	vm_data.EBX = 0;
	//vm_data.ECX = 0;

	vm_data.SFLAG = FALSE;
	vm_data.ZFLAG = FALSE;
	
	
	while (vm_data.CODE++)
	{
		DWORD XXXX = *(vm_data.CODE);
		callname = ControlTable[*(vm_data.CODE)];
		(this->*callname)(&vm_data);
		
	
		
	}
	return FALSE;
}