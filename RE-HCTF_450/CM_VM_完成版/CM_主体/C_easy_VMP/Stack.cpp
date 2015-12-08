#include "Stack.h"

//¼ÇµÃfree
VM_STACK::VM_STACK(int MaxSize)
{
	if (MaxSize < 1)
		Error("Error the Stack is too small\n");
	S = (VM_Stack *)malloc(sizeof(struct VM_Stack));
	if (S == NULL)
		Error("Create Stack Malloc Fail CODE 1");
	S->vmStack = (PDWORD)malloc(sizeof(DWORD)*MaxSize);
	if (S->vmStack == NULL)
		Error("Create Stack Malloc Fail CODE 2");
	memset(S->vmStack, sizeof(DWORD)*MaxSize, 0);
	S->capacity = MaxSize;
	S->TopOfStack = 0;

}
void VM_STACK::Stack_Push(DWORD xxx)
{
	S->vmStack[++S->TopOfStack] = xxx;
}
void VM_STACK::Stack_Pop(PDWORD xxx)
{
	*xxx = S->vmStack[S->TopOfStack--];
}
void VM_STACK::Error(char* xxx)
{
	printf("%s,LastError = %d", xxx, GetLastError());
	exit(-1);
}