# fuck===
## 出题思路：
忘记最早是那里见到的了，现在能找到的就是这篇文章。
[http://www.secbox.cn/hacker/1889.html](http://www.secbox.cn/hacker/1889.html)

## payload:
?a[]=adsa&b[]=dsadsa

## writeup:
大部分人想到的都是之前比赛常见的md5,类似于0exxx==0exxx这样的，但是如果是===的话，这样是不成立的，所以这里利用的是md5不能加密数组，所以就会返回Null,而Null===Null,get flag.