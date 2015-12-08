#include <iostream>

using namespace std;
#include <stdio.h>
#include <string.h>

int xor_test()
{
    int a[2] = {1,2};
    int b[4] = {0x03,0x0c,0x30,0xffffffc0};

    for(int ai=0;ai<2;ai++)
    {
        for(int bi=0;bi<4;bi++)
        {
            printf("%08x^%08x=%08x\r\n",a[ai],b[bi],a[ai]^b[bi]);
        }
    }

    return 0;
}

int abc()
{
    for(int i=0;i<26;i++)
    {
        printf("%02x  %c\r\n",i,'A'+i);
    }

    for(int i=0;i<26;i++)
    {
        printf("%02x  %c\r\n",0x64+i,'a'+i);
    }
    return 0;
}

int xor02()
{
    int a[4] = {0x4a,0x63,0x31,0x34};
    for(int i=0;i<4;i++)
    {
        printf("%02x  %c\r\n",a[i]^0x02,a[i]^0x02);
    }
    return 0;
}

int main(int argc, char* argv[])
{
    xor02();
    return 0;
}
