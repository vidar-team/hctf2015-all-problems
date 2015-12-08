-- MySQL dump 10.13  Distrib 5.5.46, for Linux (x86_64)
--
-- Host: localhost    Database: mcshop
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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uid` varchar(64) NOT NULL,
  `username` varchar(64) NOT NULL,
  `server_id` int(10) NOT NULL,
  `price` int(10) NOT NULL,
  `cnt` int(10) NOT NULL,
  `sum_price` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (6,'2','Aklis',1,10,1,930),(12,'3','lightless',2,20,0,180),(14,'2','Aklis',2,20,1,60),(37,'13','xuesheng',2,20,9,180),(38,'13','xuesheng',3,35,275,9625),(41,'13','xuesheng',5,120,2,240),(42,'13','xuesheng',6,180,2,360),(44,'13','xuesheng',1,10,2,20),(45,'13','xuesheng',4,50,39369,1968450),(50,'4','admin',5,120,1,120),(52,'4','admin',1,10,1,10);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flagma`
--

DROP TABLE IF EXISTS `flagma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flagma` (
  `flagfuck` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flagma`
--

LOCK TABLES `flagma` WRITE;
/*!40000 ALTER TABLE `flagma` DISABLE KEYS */;
INSERT INTO `flagma` VALUES ('hctf{1s_Mc+lsFun@Bu71d0n07-7hinkS0}');
/*!40000 ALTER TABLE `flagma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mcshop_admin`
--

DROP TABLE IF EXISTS `mcshop_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mcshop_admin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `password` varchar(512) NOT NULL,
  `email` varchar(128) NOT NULL,
  `token` varchar(64) NOT NULL,
  `level` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mcshop_admin`
--

LOCK TABLES `mcshop_admin` WRITE;
/*!40000 ALTER TABLE `mcshop_admin` DISABLE KEYS */;
INSERT INTO `mcshop_admin` VALUES (1,'mcshop_admin','6471ed64f102429d4bdfdcd3840645ca','mcshop_admin@hack123.xyz','nUWg5R3M7IxA3lfZk4VT0cgsC9saUBBSU55YCxl3FLUr4FwQEV4Zq1mIvfQzo3DN','0'),(2,'mcshop_sale','4909ccbd5734add765b4be6668f8c48c','mcshop_sale@hack123.xyz','QaJuOdcB9xN1BFLfbk98D8jMLO7VaOZkpTyFCqrWL2nF718bp9sS4ACsh6POnhlG','1'),(3,'kirie','24d846d86f30d7044c280ce62095b368','kirie@hack123.pw','qAHUpdcB9zs2BFLfbO98D8jMLO7VaOZkpFyFCqrWL2nF718bp9sS4ACsh6POnhls','2');
/*!40000 ALTER TABLE `mcshop_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mcshop_user`
--

DROP TABLE IF EXISTS `mcshop_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mcshop_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `password` varchar(512) NOT NULL,
  `email` varchar(128) NOT NULL,
  `token` varchar(64) NOT NULL,
  `bank` varchar(64) NOT NULL,
  `history_bank` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mcshop_user`
--

LOCK TABLES `mcshop_user` WRITE;
/*!40000 ALTER TABLE `mcshop_user` DISABLE KEYS */;
INSERT INTO `mcshop_user` VALUES (1,'test','309031d05eb343448b725b09a3635f13','test@test.com','7ClEs9RBtKJEuFSrxjpSLkNAqcFPc90Bh5eTfd0aj3V8jJWmvQzKBxjT56rhYbmp','999999','2348'),(2,'Aklis','bbdab7cdd82331485272002f90ee3d46','a@qq.com','Cet65hreTN6yZF8FJU9SYvAlB2ft7KE6EdDdtF1ChvyAY61eKBSUnsvmj0x4Jb5Z','100000','0'),(3,'lightless','e10adc3949ba59abbe56e057f20f883e','1@qq.com','FvaBQWSlKwZm21RDQtgnTOb5lf5TGvnTuOsR8IqMmxutxfqiCA0RHW6ae4YtM9UP','60000','0'),(4,'admin','e10adc3949ba59abbe56e057f20f883e','123456@qq.com','9fUNFCq5gDnUdZLKEfCQdRYDV0RkYnlYefPtjucP7hKb5os1QtUOCANepoLDIBAj','500500000','0'),(5,'lightless123','e10adc3949ba59abbe56e057f20f883e','1@qq.com','2NsOx00kraC5GE4uyvP7LOLBMrhQNRBQLl3jZOz1YKoJHeFk199HbsRCibkw77oq','0','0'),(6,'jeje','21dbd9ee5a8e54ec3157e76b32ce450c','aaa@qq.com','q2KzyIONXI2nEkCAVlu5srgRdYrZSO6byTvOOVssO3SvECLLsuYJYwMb3D69rX6A','0','0'),(7,'admin1','e00cf25ad42683b3df678c61f42c6bda','admin@admin.com','AFTU0uDjA92oLEfUH6EA5JjvmbBdQR6zlkxSMswTMAQxjyPiw5KRys9dDn1aRfPy','0','0'),(8,'q','7694f4a66316e53c8cdd9d9954bd611d','q@q.com','bEG9PCvfmzwsOys4yoVit6SN4LvH4mF0Y8f16bU33saGbLbbFDz53XbeRuOTJspY','0','0'),(9,'h','8277e0910d750195b448797616e091ad','t@t.cn','GxXaZB94B6ZLUbbJOlF9KRilQlymx9nLLaQmfWcyF7LTOV8Fxuo93dcIMe57UHVU','0','0'),(10,'fuckkk','96e79218965eb72c92a549dd5a330112','fuckkk@qq.com','esal62GLS63xYbgiDEqmTb2VHLB3BxR5YoBZAuXx3WcRRQr1DO0VrZwMUPVbLlMn','0','0'),(11,'nnnnnnnn','adbc91a43e988a3b5b745b8529a90b61','1@qq.com','0l1Korwz1uvFjJPcjcHIJr4N0mtbtGwL6W88PmZYQjGIPTl4M6nVdn6yaOZSeoIh','0','0'),(12,'123','698d51a19d8a121ce581499d7b701668','123@qq.com','J9UAWHaUABuRzRT1XClyr6L3oIAf9SIzO2XhK10ttpDIyrRzEaKcedcFE0dBSU0g','0','0'),(13,'xuesheng','1a2617ff99ccf1e1481e806e249c5a44','xuesheng@163.com','m1FIdN4sxUx7HPSI24h6PaAF68i34qCpJULT8sHafEsJyRf7lgGILE7OzOaXdA3h','500000000000','0'),(14,'adminadmin','f6fdffe48c908deb0f4c3bd36c032e72','adminadmin@dd','bNmjEyNvTbyk18bnTdGaznO7u5k9Cb0UfD4tPWZd17iZ3oa44hf8sQzRDt7OGnoY','0','0'),(15,'fuckgank','1786a39c136815dc549d1825ca7c95c9','scriptteam@163.com','4FUpBz41wbD2MGcdFfLviyhYhQRk688p14RMV6E2jstmP2Z1jBLSEv9wGCobdq1i','0','0'),(16,'test123','4297f44b13955235245b2497399d7a93','123123@1.com','YkA8vuuOTmhws3upUFdA3FiOP8gLrsj5WNvFDVKAKWiJeGJFmsdeK3eaVYE2hN9m','0','0'),(17,'aaaaaad','698d51a19d8a121ce581499d7b701668','123@qq.com','hqrGaY5cizFjtIjXCxHM4OgRwEo5qmbC4bAGkIyYJSO31E6jVcTvwu5A49r4NBZc','0','0'),(18,'aaa','74b87337454200d4d33f80c4663dc5e5','sads@aaa.cim','mQyv7KBHlmWamma9VSsPu4dgsQZaDnGm2h7vnGjRQCGf6hOSkPEmUKdHPXNO7pI8','0','0'),(19,'1\' OR \'1\'=\'1','c4ca4238a0b923820dcc509a6f75849b','123@qq.com','7Sm9IpWqNTYvH5aqMggWVaxgnsauOrNWApVWUQQxzM6oG2rczWGTG8U51al5IaNE','0','0'),(20,'\'fdd\"||updatexml(1,concat(0x7e,(select(replace((select(group_con','c4ca4238a0b923820dcc509a6f75849b','123@qq.com','i1kKJeEU2kVrYaH6XCVlNXWBGyhIR4QnmmRDcRabw1srZWymA4E3SLOjE7AozvZF','0','0'),(21,'fdd\'||updatexml(1,concat(0x7e,select(1),\'xxx))),1),1)#\'','c4ca4238a0b923820dcc509a6f75849b','123@qq.com','DOspIvFcJnOzJgGyZryiVrCKZlZtlZs1ECxVXpV0YuFNNY3X9CgcwG6CYlR9fvFB','0','0'),(22,'bibi','8115153332991997460b9f236e0da71a','zsbpro@163.com','fEh7uK2zFVuZgwZ96HBRlhy7OegMu2yaOFMDag2Nb4MmM5LwKYMAtqUfe7ewHAbk','0','0'),(23,'bibi\'','8115153332991997460b9f236e0da71a','zsbpro@163.com','ikdNYDxmghTwGvoiarS9poljD5v8PzOkveff96Ta2vUnSvM11Glj8PjbKynkEAwe','0','0'),(24,'DeadSoul','76d80224611fc919a5d54f0ff9fba446','qwe@qwe.qwe','gIQDLnV9CwzWmzeGqYC91g8tdvSmvdGAY08nPQB1mS7BqsjgsrM1dueENCvztavY','0','0'),(25,'wabzsy','e046ada646cb223ff252a0ef486a8141','wabzsy@hotmail.com','mIpeOrmcCTwMcVmQBzvMqp9qt36dMqRYvGZrDKFkv48Zr0P54PARLp0QQBlbNuC6','0','0'),(26,'admin\'','25f9e794323b453885f5181f1b624d0b','123456789@qq.com','ad8D1hS6npSTBNmELaKSG5gTWPmh1hUyrFJUcGuUjhzQPglNVsdZN5SKt3hlDRxY','10000000','0'),(27,'admin\\','e10adc3949ba59abbe56e057f20f883e','admin@qq.com','mWmUHyXIvYf5DvJeieWtveyD5uzQhMDf1uYooTK5paKtX0kg43oXYbgYfZEFW4OK','11111','0'),(28,'Peter','202cb962ac59075b964b07152d234b70','peterqi37@163.com','g7xAhmQ78RO7Jxd0Ype6BQbNNUSC4Kcdgdlr6lpNl2Kwv01edc4Nc867FE5hYNET','0','0'),(29,'1\' or\'','1b9d89871a4318e454509bf43688cff2','1\' or\'@qq.com','CF43jrK4Rsk2vZo59OVhYQTYwgTYAOhw5vnsdfePFCP6pgJna8dF1Kpqqwalf3eU','0','0'),(30,'1','c4ca4238a0b923820dcc509a6f75849b','1@1.com','mrhs6bwvNdiMN2zQydnNb5TiqZI0CWAvVkKhc7A22WWwwJDUqJyppVSl7gXnmr09','0','0'),(31,'admin\', \'admin\', \'admin\') --','c4ca4238a0b923820dcc509a6f75849b','admin@qq.com','UVoKI7ZoI25wQf6Covaj8yiWodGfybQ9Koo2U48B7qzLtpivja48RVSNoeXEjcc0','0','0'),(32,'username','5f4dcc3b5aa765d61d8327deb882cf99','1@1.com','K9mTf3NhcfKqbgbx14ji6Do6jiGFX6XhNEoQKCI6w9RSYX82fq0qtpaMPg0Aa8RD','0','0'),(33,'a','0cc175b9c0f1b6a831c399e269772661','a@q.c','iiL0kmbyjA8kRqDWZwfDiU71c2cF7aNAljGN98rsL6NU5WOHjYhIFsQyLVAqBeDn','0','0'),(34,'asswecan','63a9f0ea7bb98050796b649e85481845','admin@qq.com','5pKBfhnjVlaXmuuwDnowZbhfOfks8tuzIp6agAoF2hHlpYQfKmZT6C4gB6kCsQYj','0','0'),(35,'rootkits','63a9f0ea7bb98050796b649e85481845','root@qq.com','ubTR6dMGCgm03UfKw6vEfIAN3wnBWOZ4ahFKSitZXPlfdi3dJzvg8AmUov18jpvT','0','0'),(36,'testluo\\\'','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','0tFIScCW3QFvgzFh1CEfjvCQhqg2whwDt5sOoYawI9cCbRy3Z3R9TjaIyVbrpro4','0','0'),(37,'test1luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','oNZscXtzkC6pgNQgPX3g9LnQsK6AAQ6HRXhYSJ0vKO6EOYqMvMjpX9QLen2Xuyvq','0','0'),(38,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','5UUV89VHJ495YhaKxsMz68diybzB7pXmfDV6t33dzrrgGYj7QFOy3pTs3MsAZDTZ','0','0'),(39,'test2luo\'','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','F0YQ03N76MusnGxFdwKxqAsM6RjP4aHaStiAn6tBmInHjb59C9t0EiaDyw2V26g0','0','0'),(40,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','Hy0zUZySjEnT4t3V8RiyETvvkMsH4J3mKXMHAdDnSfeeLoBiLQ8ZurWvGHImdzc3','0','0'),(41,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','IQtqNZWNYFAbMbZpzHGpydLXsAYVyVqT9652a7sURkOsEcxbkIQDxPaGWOaqE5kj','0','0'),(42,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','nfq1uFoqb93LXfDB9MQJMwb5BXprRFrKss2qNwi2iaWXIpvkzz9lVWoZluxU5Mvq','0','0'),(43,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','dujbCTEe9glnu5i9Roz6dq2i0VMZZncYDIVzCaAR23z5zaKoPL0oo3TgTKpH1HLs','0','0'),(44,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','2ueWGPID9Eulpjb58ZHDPEjI7PDJG1lbXRzaX1B5T4LVXjTafXl5klCuHmGji8Zc','0','0'),(45,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','ogiwEm7aCvjEOFe02vC5boZSUbIGGGLe82Hytb4XDgDvYxUXFXY23woqj5Lf9hTf','0','0'),(46,'test2luo1','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','mgWcDKOyBWZ9mqDRdQQmel0qKfB7jOv3YT4onBtOYMpkN5ZqHdEfqv02eLP2fZAJ','0','0'),(47,'test2luoa\'','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','lQLO39AzHi37nsVvpSW3AnLez2U9xwAedYULEWPlbbyxJlbgWGt4ew6b7sDkPYqi','0','0'),(48,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','B6k07s3iGuZrZq0dcD9k5cgPUtrCedKH0jWhRpAZp9uooczF4MAmg5p8QPvSOIc2','0','0'),(49,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','4kb5vUtJk5BezgzzZ3JvPVo5a5W7pNOeZRLXPCmvQdspQLx6UK8zMQXdp84gzQSl','0','0'),(50,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','6ZomRnzbdLIFY1D0IFAMDdRhmVTwF9k5KHxgw7VxllETlEOacDyZbnsEtvpGeroU','0','0'),(51,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','fhByXnltHsAYJ1KKabTMRqkqmccVXC2gBLJXgFsVKcIDaqqnaOFz4SANHUVkUZmY','0','0'),(52,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','2n5fTn9nOYnSo3vz42zRoqX7F8qLuwZlUQ5yRsb4PyJeSoj96k7qyLUrDqqq97Ph','0','0'),(53,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','6RKWJggNRL5r361K7IVR3OJPrLruxhl4rWmjEf6RIZisQ6nErZ2VKIh8vljxF9Pb','0','0'),(54,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','Z6OnDrGqrp9FDWydcuXsJv1mFeF30HSEb4AWkG9qi1pdJCIFxKB72CqxP4L4jDEJ','0','0'),(55,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','NL9IG04EcntU0Woe71Q735j884J4lKNSUbw3wHvmAAwyOLrbdX3tWEMnqbVNA6ln','0','0'),(56,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','x3G9aYg5xckakIYk7FS8lM55QtBmaLPWAq5HiHiI8Z9P6uXylrttRid34z9dptkK','0','0'),(57,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','6hU79eOSyv09cuV0513U7rOd53kObtMsqNVhNm9rBOo0ubIH0tLEOeb1EHZPLiRg','0','0'),(58,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','lsVOLQudHZnM8qu3swA19EQfDoWi2zBhfTDEKVhQY27uEtGg7Q9PXIsL613Yxr9i','0','0'),(59,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','n272yzF27b3xPz417cAWopQ2kya9wABQPGSNcd5BO4PmNEiUvpMvOvyJeFUyeWNV','0','0'),(60,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','uONKXF0FKVU5Kb2utJhrlTGW2gypmF17a00SBkGFTadRtgKUmTbjT0V8IqDMHdug','0','0'),(61,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','azAUnpLBTbMkEZj6sgJuCBzUXXOPhyWUFxhv8m6hetziQ5gdExlpECwkidNU52QK','0','0'),(62,'test2luo','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','lmdy4Fb3IEZlTh193p190re6Uoyo7DEZurgCfXhiEJHBOYpIq5BLfsIK1o1vOxBe','0','0'),(63,'test2luo22','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','2ia3HyCimP7UtH59Yi1WB2Ttlt1aXWEHZyIw8HaQuJ7wftVFIrRHe4gNk7bCbuKW','0','0'),(64,'test2luo223','e10adc3949ba59abbe56e057f20f883e','199407186@qq.com','1PEu6SaEe6VCNPqCM8XUYQZOBIuKTwdJZLfEQZgAWk9PVDJfJ0od7Tyro5LHywR9','0','0'),(65,'test2luo22311','e10adc3949ba59abbe56e057f20f883e','1','KKR7s5IAZHkVVyUGcgtDJIt0Rv983F5cQiJQ5IyFTKNBbwOSvMzzoNdmGNILc01j','0','0'),(66,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','wJuOdf6PcqqZTSkqSall0Ptkf6pPlOGxvu5dWpksqvgl7OEnCjSvLd1yNG1Xffk1','0','0'),(67,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','rBN2OU0UWxpJXE1nDrwGoCG6ta3cjkK7hFxWKYmNUNLDWPiM8MoNQBunysrYdXVJ','0','0'),(68,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','Nk6cvMrVGutPwGGCcITzV8Yyg1q10WJBCAQ3NhmJqaCLkhVupMbUftakDS0LFcHr','0','0'),(69,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','HBmhmYgli6BFO5ZQoE2SRIqNVXaOHisiMc5UKr1lYN1xkoiyim8seZeT3Uxg0Gzx','0','0'),(70,'test2luo\'1','e10adc3949ba59abbe56e057f20f883e','1','VAz21X11GtKmoFip1z5fHTBiMhOHURmI8pkhOciQwBHGZXGAUeVzF62sI3AbAG1f','0','0'),(71,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','Ml4Lne0T9rYgTsYVvLHPdVLrTnDSAAL6J339HyqDcElViceu9zRJMHFeqbE9ohJC','0','0'),(72,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','R6oJREx1MJgiKfFCt3OD4lNHIiimx5C8poH5lfPWhZWvkxDWZTJSm1JiU620NurQ','0','0'),(73,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','5cW12DinaBSQyA7I8cbJveHoprpLLsusuWnKs0L0sb2r4KXZmOAfFDuKvDyvdLUi','0','0'),(74,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','n6hi2oHe0T9eHbsARQLabiCNd0ckFRS8oXw9szvfyGI2jKd683izbTRwBDDsDXOf','0','0'),(75,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','D0SxJq5fiebxNc3I8CDRuO40cSXhsQeiTPy8KJGVguFVMAPvJ5ANP1KnLOPCnnux','0','0'),(76,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','eac4XxiSSr5tq7OULg1fkj5u1lozc87ooWODRaoLL4ZcPOYlrjjbj4h0PnNLdE9u','0','0'),(77,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','nYt3EFMNPfkZqc7zibsysdAb2OBa7tH1pqFeek23ZtpsV0fUGoV19lyUhLYzfVR6','0','0'),(78,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','spdFwtD5uFDQAh2q2zg5HXzzvesW6hPwqbwHwK8bxpskCJ6DET7eJtz41vHkrugV','0','0'),(79,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','R50ChMoUTATpCy29DXRzEkRqlcxEIcBLGRaekpF4e88lITKkCnG3jKpx4MZ2PUvU','0','0'),(80,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','Qg4oPWr8LY0DfA8uVrGlK7ajtN3YKH8TIBW0EDogFMqju6HPjaD0gidSEefOtd5s','0','0'),(81,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','dpLTmRzgc3p7a27aEJZ41kGvF6C0j0BrMhqQmRW9c193cHZIjOEeUO3yG3PhlEys','0','0'),(82,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','xd6xHacJwwqaUymP1pcbe4bZhrGuugEjHoO4IXBR24WdEBk7bumHfE0bRwujOLc0','0','0'),(83,'test2luo','e10adc3949ba59abbe56e057f20f883e','1','tdEjVXaq9dmWqaSxwRktmoTljsLc2UT6uWEfhq5zBHv79lObgJ0S9BB46DV9MLDP','0','0'),(84,'test3luo\\\'or\\\'1\\\'=\\\'1','e10adc3949ba59abbe56e057f20f883e','1','HJyXQVr16XqF6ImGxRrfwKX5swkF707YNrGuRrdbAIvHw5AgYKdnAwqBH2pEcgKr','0','0'),(85,'test3luo\'or\'1\'=\'1','e10adc3949ba59abbe56e057f20f883e','1','MKRma9dXCunTlwo7frAyiJfRjKCezV5pDCSEZlHJeZmOprIhT1ieXDBIvxxBlSR3','11111111111111','0'),(86,'test123\'','4297f44b13955235245b2497399d7a93','ricter@qq.com','jXW9DI5K8FHqeZBGZCOtM9HBvWbWzmcjl0NIiKU9Eja3nTHzHqNMdvMJXGiko7D6','0','0'),(87,'test123aaa','4297f44b13955235245b2497399d7a93','ricter@qq.com','gBMynpChxNclbHxpylO1jvI6EaOtLIU0GXW9zi5uZkFa6Y4cLnRiqPfC7J9hSsct','0','0'),(88,'payne','50ac9c8856c464e33edba5d1086fbc18','payne138@qq.com','ViqwzT6ekA4RZEdye3sQzkbxbJBfGRLXCu6ITEsiplEeQ5f2HDRNfO43UCiz0AKd','0','0'),(89,'phukkk','21232f297a57a5a743894a0e4a801fc3','admin@admin.admin','3ypoelJLnEMuKYbWxhdcVefHzjpx0dDtygVNH4PcCOAMpDjodRC6BW7U2oiguGL5','0','0');
/*!40000 ALTER TABLE `mcshop_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `server_list`
--

DROP TABLE IF EXISTS `server_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `server_name` varchar(64) NOT NULL,
  `cpu` varchar(64) NOT NULL,
  `memory` varchar(64) NOT NULL,
  `harddisk` varchar(64) NOT NULL,
  `ssd` varchar(64) NOT NULL,
  `sum_number` varchar(64) NOT NULL,
  `inuse_number` varchar(64) NOT NULL,
  `left_number` varchar(64) NOT NULL,
  `price` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `server_list`
--

LOCK TABLES `server_list` WRITE;
/*!40000 ALTER TABLE `server_list` DISABLE KEYS */;
INSERT INTO `server_list` VALUES (1,'server-a','1','1','1024','0','9.223372036854776e18','9.223372036854776e18','0','10'),(2,'server-b','2','2','1024','0','301','299','2','20'),(3,'server-c','2','3','1024','1','301','301','0','35'),(4,'server-d','4','4','1024','1','9.223372036865886e18','9.223372036865858e18','12797','50'),(5,'server-e','8','8','1024','1','70','70','0','120'),(6,'server-f','8','16','1024','1','41','41','0','180');
/*!40000 ALTER TABLE `server_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-08 15:28:10
