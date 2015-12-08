#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

/* 
 * The define of struct of the sword
 * */
typedef struct sword{
	char name[63];
	int damage;				//give a int to help ret
	int cost;
	int id;					//Every sword have a id,for delete and edit
	char * profile;
}sword;



int getStr(char * str,int len);
void addSword(void);
void deleteSword(void);
void editSword(void);
void showSword(void);
void openShop(void);


sword * Swords[100];		//all point to swords,max number of sword is 100


/* just put a choose menu */
void putMenu(void)
{
	puts("Now what you want to do?");
	puts("1.put a new sword on sale.");
	puts("2.put a sword off shelves.");
	puts("3.chang a sword's information.");
	puts("4.show sword's information");
	puts("5.Open a new shop");
	puts("6.quit\n");
}

int main(void)
{
	/* set buf for socket */
	setbuf(stdin,0);
	setbuf(stdout,0);
	setbuf(stderr,0);

	int pid;
	char temp;
	char choose;
	openShop();		

	puts("Welcome back to you sword shop");

	while(1)
	{
		putMenu();

		choose = getchar();
		while( (temp = getchar()) != '\n' )			//throw all char after
		{
			if(temp == 0)
				break;
			if(temp == -1)
				break;
		}

		switch (choose)
		{
			case '1':
				addSword();
				break;
			case '2':
				deleteSword();
				break;
			case '3':
				editSword();
				break;
			case '4':
				showSword();
				break;
			case '5':
				pid = fork();						//fork a new thread for a new shop,and east to pwn
				if(pid == 0)
				{
					openShop();						//child thread 
				}
				else if(pid > 0)
				{
					wait(NULL);						//father thread wait child thread return
				}
				else if(pid == -1)
				{
					puts("Something Wrong");
					exit(0);
				}	
				break;
			case '6':
				exit(0);
				break;
		}
	}
}


void addSword(void)
{
	sword * aSword;
	char num[20];
	int i = 0;

	aSword = (sword *)malloc(sizeof(sword));		

	for(i = 0;i<100;i++)							//find where is free to save point
	{
		if(Swords[i] == 0)
			break;
	}


	if (i == 100)									//no place
	{
		puts("Sorry I can't sale so many thing");
		return;
	}
	aSword->id = i;
	Swords[i] = aSword;								//always call getStr function to get string

	puts("So what kind of sword do you want to sale");


	puts("first give me the name of you Sword");

	getStr(aSword->name,63);

	printf("OK you sword name is %s \n",aSword->name);


	puts("So what is the damage of sword");
	
	getStr(num,20);

	aSword->damage = atoi(num);						//don't care of int overflow

	printf("oh a %d damage sword!!\n",aSword->damage);


	puts("So how much do you want to sale?");

	getStr(num,20);

	aSword->cost = atoi(num);
	
	printf("Ok this sword will sale as %d\n",aSword->cost);


	puts("Now the last thing,give me some sword's profile,but not to much");
	aSword->profile = malloc(0x100);				

	getStr(aSword->profile,255);

	puts("Ok the sword is in sale\n");
	printf("The sword's id is %d\n\n",aSword->id);
}


/* get sword's id and free it 
 * no changce to double free
 * */
void deleteSword(void)
{
	char num[4];
	int n;
	puts("Now give me the id of sword you don't want to sale.");
	getStr(num,4);
	n = atoi(num);
	if(n<0 || n>=100)
	{
		puts("It seem you are not enter a right id.");
		return;
	}

	if(Swords[n] == 0)
	{
		puts("It seems the the sword is not on sele");
		return;
	}
	free(Swords[n]->profile);
	free(Swords[n]);
	Swords[n] = 0;
	puts("Delete success\n");


}

/* a show function,nothing */
void showSword(void)
{
	char num[4];
	int n;

	puts("So what sword do you want to show?");
	getStr(num,4);
	n = atoi(num);
	if(n<0 || n>=100)
	{
		puts("It seem you are not enter a right id.");
		return;
	}

	if(Swords[n] == 0)
	{
		puts("It seems the the sword is not on sele");
		return;
	}

	puts("================== Swords ==================");
	printf("name:    %s\n",Swords[n]->name);
	printf("damage:  %d\n",Swords[n]->damage);
	printf("cost:    %d\n",Swords[n]->cost);
	printf("profile: %s\n",Swords[n]->profile);
	puts("==================  END   ==================\n");

}


/* change sword's information
 * user a new way to get input */
void editSword(void)
{
	char str[0x110];
	char num[4];
	int n;
	puts("chang a sword's information?");
	puts("Give me id");
	getStr(num,4);
	n = atoi(num);
	if(n<0 || n>=100)
	{
		puts("It seem you are not enter a right id.");
		return;
	}
		
	if(Swords[n] == 0)
	{
		puts("It seems the the sword is not on sele");
		return;
	}


	/* Only change one at a time
	 * user strcmp to judge 
	 * no place to overflow */
	puts("I am lazy so give me all one times");
	getStr(str,0x110);
	if(!strncmp(str,"damage:",7))
	{
		Swords[n]->damage = atoi(&str[7]);
	}
	else if(!strncmp(str,"cost:",5))
	{
		Swords[n]->cost = atoi(&str[5]);
	}
	else if(!strncmp(str,"name:",5))
	{
		strncpy(Swords[n]->name,&str[5],63);
	}
	else if(!strncmp(str,"profile:",8))
	{
		strncpy(Swords[n]->profile,&str[8],255);
	}
	else
	{
		puts("It seems something wrong\n");
	}

	puts("Ok change success\n");

}


/* function to get input and not add \0 when give to much char 
 * so when overwrite ebp will not change ret_addr
 * but will have bug.so I change every buf's size.Make every buf's size not fix 4 byte*/
int getStr(char *str,int len)
{
	char ch;
	int i = 0;
	for(i=0;i<len-1;i++)
	{
		ch = getchar();
		if(ch == '\n' || ch == 0 || ch == -1)
		{	
			str[i] = 0;
			break;
		}
		str[i] = ch;
	}
	//str[i] = 0;
	return i+1;
}


/* a function will change esp when overwrite ebp*/
void openShop(void)
{
	void getInformation(void);


	puts("So let's open a shop to sale sword");
	puts("Please enter a some information\n");

	//Here exploit 
	getInformation();

	puts("\nSo open shop success\nbut my memory is not good\n");
}


/* The overflow function*/
void getInformation(void)
{
	char introduce[100];
	char name[40];

	puts("The name of you shop:");
	getStr(name,40);

	puts("Give me the introduce of shop");
	getStr(introduce,112);			//only can reach ebp
}

//forgive my poor English
