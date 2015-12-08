#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAXNUM 100

void AddStudent(void);
void DeleteStudent(void);
void ChangeStudent(void);

typedef struct studentInfo{			//overflow it
	char name[20];
	char information[0x81];
}studentInfo;

typedef struct student{				
	int number;
	unsigned char InfoLen;
	studentInfo * stuInfo;			//point to stuInfo,overwrite when heap overflow
}student;

student students[MAXNUM];

int NumCount = 0;

void putMenu(void)
{
	puts("So what do you want?\n");
	puts("Add a student to database.");
	puts("Delete a student from database.");
	puts("Change a student's information.");
}

int main(int argc, char *argv[])
{
	setbuf(stdin,0);
	setbuf(stdout,0);
	setbuf(stderr,0);

	char ch;
	puts("Welcome to my student database.\n");
	while(1)
	{
		putMenu();
		ch = getchar();

		while(getchar()!='\n');		//throw left char
		if(ch == 'a')
		{
				AddStudent();
		}
		else if(ch == 'd')
		{		
			DeleteStudent();
		}
		else if(ch == 'c')
		{		
			ChangeStudent();
		}
		else
		{
			puts("See you.");
			exit(0);
		}
	}
	return 0;
}

void AddStudent(void)
{
	studentInfo *info = malloc(sizeof(studentInfo));	
	char NUM[4];
	unsigned char num;
	char *p = malloc(0x200); 
	char *str;
	char *ch;
	int StuFindCount;
	student *stu;

	for(StuFindCount = 0;StuFindCount < MAXNUM;StuFindCount++)	//find a free place in students array
	{
		if(students[StuFindCount].InfoLen == 0)
			break;
	}
	
	if(StuFindCount == MAXNUM)						//no place
	{
		puts("Sorry, no place for a new student");
		return;
	}

	stu = students + StuFindCount;

	puts("Add a new student\n");

	printf("Show me student's information:");
	read(0,p,0x200);							//give a read function
	//printf("aaa");

	str = p;									
	NUM[0] = str[0];
	NUM[1] = str[1];
	NUM[2] = 0;
	
	num = atoi(NUM);							
	if(num>=20)
	{
		puts("Sorry you name is to long.");
		exit(0);
	}
	if(num == 0)
	{
		puts("Must enter number");
		exit(0);
	}

	str = p+2;
	strncpy(info->name,str,(unsigned int)num);
	str += num;
	(info->name)[num] = 0;

	NUM[3] = 0;
	NUM[1] = str[1];
	NUM[0] = str[0];
	NUM[2] = str[2];

	num = atoi(NUM);	//all right if num is 127, maybe~
	if(num>127)
	{
		puts("It's too long");
		exit(0);
	}
	if(num == 0)
	{
		puts("0 is not allow");
		exit(0);
	}

	str += 3;
	strncpy(info->information,str,(unsigned int)num);
	ch = strchr(info->information,'\n');
	if(ch)
	{
		*ch = 0;
	}
	else
	{
		(info->information)[num] = 0;
	}

	stu->InfoLen = strlen(info->information);			//make this more difficult.

	free(p);

	stu->number = NumCount++;
	stu->stuInfo = info;
	
	printf("The student number is %d\n",stu->number);	//give student number,use to change and delete
}

void DeleteStudent(void)						//nothing just free
{
	int StuFindCount;
	int num;
	student *stu;
	puts("So give me student number");
	
	scanf("%d",&num);							//find student use number
	getchar();
	for(StuFindCount=0;StuFindCount < MAXNUM;StuFindCount++)
	{
		if(students[StuFindCount].InfoLen != 0 && students[StuFindCount].number == num)
			break;
	}
	
	if(StuFindCount == MAXNUM)					//no find
	{	
		puts("Sorry I can't find");
		return;
	}

	stu = students + StuFindCount;
	free(stu->stuInfo);							//all clean
	stu->stuInfo = 0;
	stu->InfoLen = 0;
	stu->number = 0;

	puts("delete success");
}

void ChangeStudent(void)
{
	int i;
	student *stu;
	int num;
	int StuFindCount;
	char len,ch;
	char *information;
	puts("So who's information you want to change");
	scanf("%d",&num);
	getchar();

	for(StuFindCount=0;StuFindCount < MAXNUM;StuFindCount++)
	{
		if(students[StuFindCount].InfoLen != 0 && students[StuFindCount].number == num)
			break;
	}
	
	if(StuFindCount == MAXNUM)
	{
		puts("Sorry I can't find");
		return;
	}

	stu = students + StuFindCount;
	len = stu->InfoLen;
	information = stu->stuInfo->information;

	for(i=0;i != len;i++)					//here is importent,overflow if len is 0xff
	{
		ch = getchar();
		if(ch == '\n')
			break;
		information[i] = ch;
	}
	information[i] = 0;
	
	puts("Success");
}
