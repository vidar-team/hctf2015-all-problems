#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *cmd1 = " ++ptr; ";
char *cmd2 = " --ptr; ";
char *cmd3 = " ++*ptr; ";
char *cmd4 = " --*ptr; ";
char *cmd5 = " putchar(*ptr); ";
char *cmd6 = " *ptr =getchar(); ";
char *cmd7 = " while (*ptr) { ";
char *cmd8 = " } ";
char *stdCode = "#include <stdio.h>\n #include <stdlib.h> \n  int main(void) {	setbuf(stdin,0); char code[0x200]; char *ptr = code; \n";

int toCode(char * codes);

int main(int argc, char *argv[])
{	
	setbuf(stdout,0);
	setbuf(stdin,0);
	int i;
	char *codes = malloc(0x100);
	char ch;
	for(i=0;i<0x100;i++)
	{
		ch = getchar();
		if(ch == 'q')
		{
			codes[i] = 0;
			break;
		}
		if(ch != '.' && ch != ',' && ch != '[' && ch != ']' && ch != '-' && ch != '+' && ch != '>' && ch != '<')
		{
			printf("some thing wrong\n");
			exit(0);
		}
		codes[i] = ch;
	}

	if(toCode(codes))
	{
		printf("some thing wrong\n");
	}
	if(system("gcc brainFuckCode.c -o brainFuckCode"))
	{
		remove("brainFuckCode.c");
		printf("some thing wrong\n");
		exit(0);
	}
	remove("brainFuckCode.c");
	system("./brainFuckCode");
	remove("brainFuckCode");
	free(codes);
	return 0;
}

int toCode(char * code)
{
	int i;
	FILE *fp;
	fp = fopen("brainFuckCode.c","w+");
	if(fp == 0)
	{
		return 1;
	}
	fputs(stdCode,fp);
	
	for(i=0;code[i];i++)
	{
		switch (code[i])
		{
			case '>':
				fputs(cmd1,fp);
				break;
			case '<':
				fputs(cmd2,fp);
				break;
			case '+':
				fputs(cmd3,fp);
				break;
			case '-':
				fputs(cmd4,fp);
				break;
			case '.':
				fputs(cmd5,fp);
				break;
			case ',':
				fputs(cmd6,fp);
				break;
			case '[':
				fputs(cmd7,fp);
				break;
			case ']':
				fputs(cmd8,fp);
				break;
		}
	}
	fclose(fp);
}

