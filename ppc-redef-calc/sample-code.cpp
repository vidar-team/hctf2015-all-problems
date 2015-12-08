#include<map>
#include<string>
#include<cstring>
#include<cstdio>
#include<cstdlib>
#include<cmath>
#include<queue>
#include<vector>
#include<iostream>
#include<algorithm>
#include<bitset>
#include<climits>
#include<list>
#include<iomanip>
#include<stack>
#include<set>
#define inf 0x3f3f3f3f
#define LL long long
#define clr(a,b) memset(a,b,sizeof(a))

using namespace std;

int a[1055];
char s[1055];
LL c[1055][1055];
LL dp[1055][1055];
LL f[1055];
const int mod = 1e9 + 7;

void init()
{
    c[0][0] = 1;
    for(int i =1; i <= 1050; i++)
    {
        c[i][0] = c[i][i] = 1;
        for(int j = 1; j < i; j++)
            c[i][j] = (c[i-1][j] + c[i-1][j-1])%mod;
    }
    f[0] = f[1] = 1;
    for(int i =2; i <= 1050; i++)
        f[i] = i*f[i-1]%mod;
}

int main(int argc,char *argv[])
{
    int n;
    init();
    if(scanf("%d",&n) || 1 )// patched from while
    {
        for(int i =1; i <= n; i++)
            scanf("%d",a+i);
        scanf("%s",s+1);
        clr(dp,0);
        for(int i = 1; i <= n; i++)
            dp[1][i] = a[i];
        for(int i = 2; i <= n; i++)
        {
            for(int t = 1; t + i -1 <= n; t++)
            {
                for(int d = 1; d <=i-1; d++)
                {
                    int w = t+d-1;
                    char ch = s[w];
                    if(ch=='+')
                        dp[i][t] = (dp[i][t] + (c[i-2][d-1]*(dp[d][t]*f[i-1-d]%mod + dp[i-d][t+d]*f[d-1]%mod)%mod)%mod)%mod;
                    else if(ch=='-')
                        dp[i][t] = (dp[i][t] + (c[i-2][d-1]*(dp[d][t]*f[i-1-d]%mod - dp[i-d][t+d]*f[d-1]%mod)%mod)%mod)%mod;
                    else
                        dp[i][t] = (dp[i][t] + (c[i-2][d-1]*(dp[d][t]*dp[i-d][t+d]%mod)%mod)%mod)%mod;
                }
            }
        }
        LL ans = dp[n][1];
        if(ans < 0 ) ans += mod;
        printf("%lld\n",ans);
    }
}
