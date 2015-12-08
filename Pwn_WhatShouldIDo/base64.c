#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <ctype.h>

#define MAXLEN 0xa0

void b64Decode(void);
int getCode(char * buf, int mx_strlen);
void copy(char *dest, char *str, int cpyLen);

int main(void)
{	
	int pid;
	char ch;

	/* set buf for socket */
	setbuf(stdin,0);
	setbuf(stdout,0);
	setbuf(stderr,0);

	printf("I am a simple program\n");
	printf("So what should I do?\n");
	
	
	while(1)
	{
		printf("\nMay be I can know if you give me some data[Y/N]\n");
		if(getchar()=='Y')
		{
			ch = getchar();
			while(ch != '\n' && ch != 0); //throw char
		}
		else
		{
			break;
		}

		/* fork a new thread to do decode */
		pid = fork();
		if(pid == 0)
		{
			b64Decode();
			printf("\nback\n");
			exit(0);
		}
		else if(pid > 0)
		{
			wait(NULL);
		}
		else if(pid == -1)
		{
			puts("Something Wrong");
			exit(0);
		}
	}

	printf("At last I did some thing (:\n");

	return 0;
}

void copy(char *dest, char *src, int cpyLen)
{
	int i;
	for(i = 0; i<cpyLen; i++)
	{
		dest[cpyLen - i - 1] = src[i]; 
	}
}

void b64Decode(void)
{
	int ch;
	int i,tmp = 0,flag = 1;

	char BaseCode[MAXLEN];
	char SourceCode[MAXLEN+1] = {0};
	char *pToSource = SourceCode;

	printf("So give me some data\n");
	getCode(BaseCode, MAXLEN);
	
	for(i = 0; BaseCode[i]; i++)
	{
		if((!(i%4)) && i)
		{
			copy(pToSource,(char *) &tmp, 3);
			pToSource += 3;
			tmp = 0;
		}

		ch = BaseCode[i];
		if(isupper(ch))
		{
			ch -= 'A';
		}
		else if(islower(ch))
		{
			ch -= 'a' - 26;
		}
		else if(isdigit(ch))
		{
			ch -= '0' - 52;
		}
		else if(ch - 61)
		{
			ch -= '+' - 62;
			if(ch > 63)
			{
				ch = 63;
			}
		}
		else
		{
			break;
		
		}

		tmp = tmp | (ch<<(6*(3 - i%4)));

	}
	if(i%4)
	{
		tmp = tmp >> ((4 - i%4)*8);
		copy(pToSource,(char *)&tmp, (i%4)-1);
	}
	printf("%s",SourceCode);

}

int getCode(char * buf, int mx_strlen)
{
	int getLen,i;
	char *base64Code = malloc(mx_strlen + 1);
	getLen =  read(0, base64Code, mx_strlen);
	
	for(i = 0; i < getLen; i++)
	{
		if(!isalnum(base64Code[i]))
		{
			if((base64Code[i]-61)&&(base64Code[i]-43)&&(base64Code[i]-47))
			{
				break;
			}
		}
	}
	base64Code[i] = 0;
	
	if(i%4)
	{
		puts("Something is wrong\n");
		exit(0);
	}
	strncpy(buf, base64Code, mx_strlen);
	return i;
}
