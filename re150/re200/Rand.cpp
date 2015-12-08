#include "IncludeAll.h"
int M_Rand()
{
	const int RandMax = 0x5;
	const int RandMin = 0x1;
	int ret = 0;

	for (; ret < RandMin;)
		ret = (int)(rand() % (RandMax + 1));
	return ret;
}