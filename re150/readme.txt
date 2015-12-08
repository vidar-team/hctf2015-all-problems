//题目名：友善的逆向
出这题只是为了好玩，也没什么地方特别恶心。

这是一道100~200分的windows简单逆向。
真的好简单
FLAG格式：
falg：HCTF{xxxxxxxxxxxx1234}
falg：HCTF{UareS0cLeVer1234}


//
代码流程：
CheckRemoteDebuggerPresent一个简单的反调试。
开2个线程不断的去修改一个用于比较的数值。
movewindow实现按钮3点变换。
先减去	char maomaomao[] = "316754"; 验证HCTF{			}
然后进行一次编码，二叉查找表中内容，其实很简单。
代码给了去看吧。
进行一次写死的换位。
亦或比较上面线程修改的数值。
写死的验证线程修改值
循环100次。
then
返回you got it














