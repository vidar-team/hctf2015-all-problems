#include <Windows.h>
#include "Stack.h"
#include <map>
#include <cstdio>
enum myVm
{
	VM_X00_START = 0,
	VM_PUSH_EAX,
	VM_POP_EAX,

	VM_PUSH_EBX,
	VM_POP_EBX,

	VM_PUSH_NUM,
	VM_BYTE_MEM_GET,
	VM_BYTE_MEM_SET,

	VM_ADD,
	VM_SUB,
	VM_XOR,
	VM_JMP,
	VM_JZ,
	VM_EXIT,
	VM_CMP,

	VM_STRLEN_CALL

};

class VM_Function:public VM_STACK
{
	typedef struct _VMDATA
	{
		DWORD ESP;
		DWORD EAX;
		DWORD EBX;
		DWORD ECX;
		DWORD EDX;
		DWORD ESI;
		DWORD EDI;
		DWORD EIP;
		PBYTE OEP;
		PBYTE CODE;
		PDWORD DATA;
		//PBYTE PARAM;
		//PBYTE PARAM1;
		BOOL  SFLAG;		//符号标志
		BOOL  ZFLAG;		//零标志
	} VMDATA, *PVMDATA;

	typedef void(VM_Function::*ProcessFuncPtr)(PVMDATA);

	typedef void(VM_Function::*ProcessTest)();
	ProcessTest calltest;

	std::map<int, ProcessFuncPtr> ControlTable;
	ProcessFuncPtr callname;
	
public:
	VM_Function(int datax) ;
	BOOL StartVM(PBYTE vmCode, PDWORD vmData);

private:
	virtual void CODE_X00_START();
	void CODE_PUSH_EAX(PVMDATA vm_data);
	void CODE_POP_EAX(PVMDATA vm_data);
	void CODE_PUSH_EBX(PVMDATA vm_data);
	void CODE_POP_EBX(PVMDATA vm_data);
	void CODE_PUSH_NUM(PVMDATA vm_data);
	
	void CODE_ADD(PVMDATA vm_data);
	void CODE_SUB(PVMDATA vm_data);
	void CODE_XOR(PVMDATA vm_data);
	void CODE_JMP(PVMDATA vm_data);
	void CODE_JZ(PVMDATA vm_data);
	void CODE_CMP(PVMDATA vm_data);
	void CODE_BYTE_MEM_GET(PVMDATA vm_data);
	void CODE_BYTE_MEM_SET(PVMDATA vm_data);
	//CALL指令
	void CODE_STRLEN_CALL(PVMDATA vm_data);
	//虚拟环境变化指令
	void CODE_EXIT(PVMDATA vm_data);

};