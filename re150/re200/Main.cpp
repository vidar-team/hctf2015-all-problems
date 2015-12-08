#include "IncludeAll.h"

int rou = 0;

LRESULT CALLBACK DlgProc(HWND hDlg, UINT Message, WPARAM wParam, LPARAM lParam);

unsigned _stdcall Make_HunTun1(void* param);

unsigned _stdcall Make_HunTun2(void* param);

int WINAPI WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPSTR lpCmdLine, _In_ int nShowCmd)
{
#ifdef _DEBUG
	FILE *stream;	//debug下需要一个控制台输出调试信息
	AllocConsole();
	freopen_s(&stream, "CONOUT$", "w", stdout);
#endif
	srand((int)time(NULL));

	//反调试检查1
	//CheckRemoteDebuggerPresent
	if (OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, GetCurrentProcessId()) == NULL)
		printf("甜党万岁\n");
	else
	{
		BOOL judge;

		if (0 == CheckRemoteDebuggerPresent(OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, GetCurrentProcessId()), &judge))
			printf("甜党万岁\n");
		else
		{
			if (judge == TRUE)
			{
				//
				exit(-1);
			}
			else
			{
				//
			}
		}
	}
	//

	HANDLE handle_huntun1 = (HANDLE)_beginthreadex(NULL, 0, Make_HunTun1, NULL, NULL, NULL);
	if (NULL == handle_huntun1)
	{
		printf("甜党万岁\n");
	}
	HANDLE handle_huntun2 = (HANDLE)_beginthreadex(NULL, 0, Make_HunTun2, NULL, NULL, NULL);
	if (NULL == handle_huntun2)
	{
		CloseHandle(handle_huntun1);
		printf("甜党万岁\n");
	}

	DialogBoxW(hInstance, MAKEINTRESOURCE(IDD_DIALOG1), NULL, (DLGPROC)DlgProc);

	CloseHandle(handle_huntun1);
	CloseHandle(handle_huntun2);
	return 0;
}

unsigned _stdcall Make_HunTun1(void* param)
{
	for (;;)
	{

		rou = 1;
		Sleep(10);

	}
	return 0;
}
unsigned _stdcall Make_HunTun2(void* param)
{
	for (;;)
	{

		rou = 2;
		Sleep(10);

	}
	return 0;
}