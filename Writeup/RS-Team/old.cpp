// old.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char check(char a)
{
	if (a <= 0x19)
	{
		a = a + 0x41;
		return a;
	}	
	else if (a <= 0x33)
	{
		a = a + 0x47;
		return a;
	}
	if (a == 0x3e)
	{
		a = 0x2b;
		return a;
	}
	else
	{	
		if (a == 0x3f)
			a = 0x2f;
		else
			a -= 4;
	}
	return a;
}

void Setp_1(char * a)
{
	int len = strlen((char *)a);
	char b[64] = {0};
	int k = 0;
	int i = 0;

	printf("%c ",a[23]);
	
	unsigned BX = 1;

	unsigned char AL = 0,AH = 0;
	AL = (a[i] & 0xFC) >> 2;
	BX = 1;

	b[k] = check(AL);

	printf("%c",b[k]);
	k ++;

	unsigned char CX = 8;
	while (1)
	{
		if (BX == 1)
		{
			AL = (a[i] & 0x03) << 4;
			AH = ((a[i+1]) & 0xF0) >> 4;
			AL = AL+AH;

			b[k] = check(AL);
			
			printf("%c",b[k]);
			BX = 2;
			k ++;
		}
		if (BX == 2)
		{
			AL = ((a[i+1]) & 0x0F) << 2;
			AH = ((a[i+2]) & 0xC0) >> 6;
			AL = AL+AH;

			b[k] = check(AL);

			BX = 3;
			printf("%c",b[k]);
			k ++;
		}
		if (BX == 3)
		{
			AL = (a[i+2]) & 0x3F;

			b[k] = check(AL);

			printf("%c ",b[k]);
			BX = 4;
			k ++;
		}

		i += 3;
		CX --;
		if (CX == 0)
		{
			break;
		}

		if (BX == 4)
		{
			AL = (a[i] & 0xFC) >> 2;
			BX = 1;
			b[k] = check(AL);
			printf("%c",b[k]);
			k ++;
		}
	}
	printf("\n");
/*	for (int i = 0 ;i < 16;i ++)
	{
		AL = b[i] ^ 0x7;
		AH = b[i+16] ^ 0xC;
		
		b[i] = AH;
		b[i+16] = AL;
	}
	printf("\n%s",b);*/
}

//EHIvAHokVHNbouJ5f@I7]isB]CEiNCA}
//EHIvAHokVHNbouJ5f@I7]isB]CEiNCA}

void rev1 ()
{
	char a[64] = "EHIvAHokVHNbouJ5f@I7]isB]CEiNCA}";
	char b[64] = {0};
	unsigned char AL = 0,AH = 0;
	for (int i = 0;i < 16;i ++)
	{
		AH = a[i];
		AL = a[i+16];
		b[i] = AL ^ 0x7;
		b[i+16] = AH ^ 0xC;
	}
	//aGN0ZntEZDBnIDFzIDEzMDcgZDBncyF9
	printf("%s\n",b);
}
void rev2 ()
{//	24			 "hctf{Do xxxx  xxxx xxxx xxx }"
//	char a[64] = "aGN0 ZntE ZDBn IDFz IDEz MDcg ZDBn cyF9";
	char a[64] = "ntEZDBnIDFzIDEzMDcgZDBncyF";
	char b[64] = {0};
	char t[19] = {0};
	
	
	for (int i = 0;i < 127;i ++)
	{
		memset(t,1+i,18);  //每次变换得到一个flag值，减一
		//"hctf{Dd0g 1s 1307 d0gs!}"
		strcpy(b,"hctf{");  //==> 一步变换此处，似的运行的程序结果等于 aGN0ZntEZDBnIDFzIDEzMDcgZDBncyF9, 这个串有rev1 ()跑出来的
		strcat(b,t);
		strcat(b,"}");
		//printf("%s\n",b);
		Setp_1(b);
	}
}

int _tmain(int argc, _TCHAR* argv[])
{
	//多次运行
	rev2 ();
	getchar();
	return 0;
}

