## Black Eat black

by Hcameal

一开始是DNS劫持，劫持到题目服务器，通过nmap扫描得知三个filtered端口，然后通过修改host，127.0.0.1:4444进入内网的gayhub gayhub可任意文件读取，读取到/etc/passwd，得知要getshell，然后通过文件可上传到上级目录的漏洞，把自己的公钥传到/home/hctf2015/.ssh/authorized_keys 然后getshell

//详情请见 http://lazysheep.cc
