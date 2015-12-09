web 275

这道题其实非常简单，打开就一个上传点，源码中title提示upload image，注释提示要小于20KB，于是尝试png、jpg、bmp，发现png可以上传

上传之后发现会输出png到页面，猜想上传包含webshell的图getshell

提示文件上传后会被重命名为一段hash，其实是md5(time()+filename)这一点其实很好猜

如果不猜一样很容易找到，因为一秒内上传多次会提示重命名后的文件已存在

down下来文件会发现所有图片都会被缩放成64x64，如果上传64x64的图片可能会被原样输出

这个方法出题人本地测试过，于是禁止了64x64图片上传，那么只有一种方法

构造缩放后能够出现webshell的正常png图片，在上传之后会输出到upload.php

之前还有两个坑，一个是重命名后的文件名，还有一个是filename如果包含`'`会强行echo报错(XD

不过老赛棍都能一眼看出来是个坑

在出题之后出题人才发现这篇文章freebuf已经有了翻译，所以把缩放大小改成了64

并且删除了原题目中2s清空upload的sh脚本，保留了上传太快会暴露重命名后的图片名，分值降为275

这道题目直到最后一天上午只有4支队伍开出来，导致很多队伍没有时间做题，所以最终没有队伍做出来



Referer:[https://www.idontplaydarts.com/2012/06/encoding-web-shells-in-png-idat-chunks/](https://www.idontplaydarts.com/2012/06/encoding-web-shells-in-png-idat-chunks/)


