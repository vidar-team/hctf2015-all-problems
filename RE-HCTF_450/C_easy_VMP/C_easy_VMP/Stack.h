#include <Windows.h>
typedef struct VM_Stack *Stack;
BOOL StartVM(PBYTE vmCode, PDWORD vmData);
Stack CreateVmStack(int MaxSize);
void Stack_Push(DWORD xxx, Stack S);
void Stack_Pop(PDWORD xxx, Stack S);
void Error(char* xxx);
struct VM_Stack
{
	int capacity;
	int TopOfStack;
	PDWORD vmStack;
};