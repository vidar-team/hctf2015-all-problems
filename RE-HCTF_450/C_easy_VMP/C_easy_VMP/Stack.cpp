#include "Stack.h"
#include <stdio.h>
//¼ÇµÃfree
Stack CreateVmStack(int MaxSize)
{
	Stack S;
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
	return S;
	
}
void Stack_Push(DWORD xxx, Stack S)
{
	S->vmStack[++S->TopOfStack] = xxx;
}
void Stack_Pop(PDWORD xxx, Stack S)
{
	*xxx = S->vmStack[S->TopOfStack--];
}
void Error(char* xxx)
{
	printf("%s,LastError = %d", xxx,GetLastError());
	exit(-1);
}