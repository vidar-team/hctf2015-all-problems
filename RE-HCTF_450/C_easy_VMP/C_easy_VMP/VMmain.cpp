#include "VM.h"
#include"Stack.h"
void CODE_PUSH(Stack xxx, DWORD DATA)
{
	Stack_Push(DATA, xxx);
}
void CODE_PUSH_NUM(Stack xxx, PVMDATA vm_data)
{
	Stack_Push(*(vm_data->DATA), xxx);
	(vm_data->DATA)++;
}
void CODE_POP(Stack xxx, DWORD *REG)
{
	Stack_Pop(REG, xxx);
}
void CODE_ADD(Stack xxx, PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg, xxx);
	xxx->vmStack[xxx->TopOfStack] += reg;
	//FLAG改变
	vm_data->ZFLAG = ((xxx->vmStack[xxx->TopOfStack]) == 0);
	vm_data->SFLAG = ((xxx->vmStack[xxx->TopOfStack]) < 0);
}
void CODE_SUB(Stack xxx, PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg, xxx);
	xxx->vmStack[xxx->TopOfStack] -= reg;
	//FLAG改变
	vm_data->ZFLAG = ((xxx->vmStack[xxx->TopOfStack]) == 0);
	vm_data->SFLAG = ((xxx->vmStack[xxx->TopOfStack]) & 0x80000000);
}
void CODE_XOR(Stack xxx)
{
	DWORD reg = NULL;
	Stack_Pop(&reg, xxx);
	xxx->vmStack[xxx->TopOfStack] ^= reg;
}
void CODE_JMP(Stack xxx, PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg, xxx);
	vm_data->CODE = (vm_data->CODE) + (reg);
}
void CODE_JZ(Stack xxx, PVMDATA vm_data)
{
	DWORD reg = NULL;
	Stack_Pop(&reg, xxx);
	if (vm_data->ZFLAG)
		vm_data->CODE = (vm_data->CODE) + (reg);
}
void CODE_CMP(Stack xxx, PVMDATA vm_data)
{
	DWORD reg = NULL;
	reg = (xxx->vmStack[(xxx->TopOfStack) - 1]) - (xxx->vmStack[xxx->TopOfStack]);
	vm_data->ZFLAG = (reg == 0);
}
void CODE_BYTE_MEM_GET(Stack xxx)
{
	DWORD reg = NULL;
	Stack_Pop(&reg, xxx);
	reg = *(BYTE*)reg;
	Stack_Push(reg, xxx);
}
void CODE_BYTE_MEM_SET(Stack xxx)
{
	DWORD reg = NULL;
	DWORD Addr = NULL;
	BYTE  Data = NULL;
	Stack_Pop(&Addr, xxx); //result
	Stack_Pop(&reg, xxx);//address
	_asm
	{
		push eax
		xor eax, eax
		mov eax, reg
		mov Data,al
		pop eax

	}
	*(BYTE*)Addr = Data;
}
void CODE_STRLEN_CALL(Stack xxx)
{
	DWORD reg = NULL;
	DWORD STRLEN_RET = 0;
	Stack_Pop(&reg, xxx);
	STRLEN_RET = strlen((char*)(reg));
	Stack_Push(STRLEN_RET, xxx);
}
void CODE_EXIT(Stack xxx)
{
	free(xxx->vmStack);
	free(xxx);
}

BOOL StartVM(PBYTE vmCode,	PDWORD vmData)
{
	VMDATA vm_data;
	Stack vm_Stack = CreateVmStack(64);

	vm_data.OEP = vmCode;
	vm_data.CODE = vmCode;
	vm_data.DATA = vmData;
	//vm_data.PARAM = vmparam;
	//vm_data.PARAM1 = vmparam1;
	vm_data.EAX = 0;
	vm_data.EBX = 0;
	vm_data.ECX = 0;
	vm_data.EDX = 0;
	vm_data.EDI = 0;
	vm_data.ESI = 0;
	vm_data.ESP = 0;
	vm_data.SFLAG = FALSE;
	vm_data.ZFLAG = FALSE;


	while (vm_data.CODE++)
	{
		switch (*(vm_data.CODE))
		{
		case VM_PUSH_EAX:
			CODE_PUSH(vm_Stack, vm_data.EAX);
			break;
		case VM_POP_EAX:
			CODE_POP(vm_Stack, &(vm_data.EAX));
			break;
		case VM_PUSH_EBX:
			CODE_PUSH(vm_Stack, vm_data.EBX);
			break;
		case VM_POP_EBX:
			CODE_POP(vm_Stack, &(vm_data.EBX));
			break;
		case VM_PUSH_NUM:
			CODE_PUSH_NUM(vm_Stack, &vm_data);
			break;
		case VM_ADD:
			CODE_ADD(vm_Stack, &vm_data);
			break;
		case VM_SUB:
			CODE_SUB(vm_Stack, &vm_data);
			break;
		case VM_XOR:
			CODE_XOR(vm_Stack);
			break;
		case VM_JMP:
			CODE_JMP(vm_Stack, &vm_data);
			break;
		case VM_JZ:
			CODE_JZ(vm_Stack, &vm_data);
			break;

		case VM_STRLEN_CALL:
			CODE_STRLEN_CALL(vm_Stack);
			break;
		case VM_CMP:
			CODE_CMP(vm_Stack, &vm_data);
			break;
		case VM_BYTE_MEM_GET:
			CODE_BYTE_MEM_GET(vm_Stack);
			break;
		case VM_BYTE_MEM_SET:
			CODE_BYTE_MEM_SET(vm_Stack);
			break;
		case VM_EXIT:
			CODE_EXIT(vm_Stack);
			return TRUE;
		default:
			break;
		}
		
	}
	return FALSE;
}