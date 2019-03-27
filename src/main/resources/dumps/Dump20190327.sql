CREATE DATABASE  IF NOT EXISTS `elsign` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `elsign`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: elsign
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `link` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `iddocuments_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (1,'firstDoc','link1'),(2,'secondDoc','1W-c3XY_BWz5MgVUmvA-LwcJqZhQATsuD'),(3,'thirdDoc','1FA5vX2xjt7MzBr1ubQ7Qo2FiyoGfZ-H2'),(5,'lastDoc','1zFEcVOP71wkNrJJgbfpvYCju11woqOrF'),(7,'lastDoc1','17E8oAhLdF0kOU9x58EHKwJQDHKi9WuyQ'),(8,'lastDoc2','1Jaib0EGRmhzkUa2y5mlmYtE_dkffROuS'),(9,'lastDoc3','1mEv2_fpiw-uios5ECQXw8LUYiHJHV7vL'),(10,'lastDoc4','1jiDhLirpeGTQ9f08nHLlym9WsoPzKPT7'),(11,'–î–æ–∫—É–º–µ–Ω—Ç','1PTib_L_yzRVVtnaaYfjIUImr0WKu10Nr');
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idrole_UNIQUE` (`id`),
  UNIQUE KEY `rolecol_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (2,'ROLE_ADMIN'),(1,'ROLE_USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sign`
--

DROP TABLE IF EXISTS `sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `sign` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_document` int(11) NOT NULL,
  `date_sign` varchar(45) NOT NULL,
  `public_key` varbinary(1024) NOT NULL,
  `enc_hash` varbinary(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_owner_idx` (`id_user`),
  KEY `fk_document_idx` (`id_document`),
  CONSTRAINT `fk_doc` FOREIGN KEY (`id_document`) REFERENCES `document` (`id`),
  CONSTRAINT `fk_signer` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sign`
--

LOCK TABLES `sign` WRITE;
/*!40000 ALTER TABLE `sign` DISABLE KEYS */;
INSERT INTO `sign` VALUES (1,16,1,'','',''),(2,19,1,'2018.12.10','',''),(3,12,2,'2018.12.11','',''),(4,12,9,'2018.12.11','',''),(5,20,2,'2019.03.18',_binary '0Ç\"0\r	*ÜHÜ˜\r\0Ç\00Ç\nÇ\0õôM\r¡P=¿,¶\È´t¨P´∂¿C˘Ö\r\∆\ﬁ@§ûÜ7ÄÚ4é≠l(£\‰m§±Ç`6\”òwß˚Xé\\wfO˘∏@™\Â\Ó_mŒÇ0N†GòÛåﬁåΩc_¯k{,T\„\Ío2¿b\ﬂt%\Ã&\√(@(\Ìoà∞\«t$u\Â¢¯∏◊òe~\ÕS\"±4ùÑ=:˚ôÂû≠N\ÊÒ/≠mywÃè´6I\Õ{d\‚\ﬂ\◊Õê∏E\‰U\Ã[oNΩ%yêŸÜße\"1d´˘\„k∑wn˛SÚ∑jë\‰y\€<3ã Ω\"§]Y¸\⁄¸æ#Qû*\ÓlH\ÎÄ¬ö!k\Ì\‚<LH&¥æ.iu\Ê\ŸD\…-¢D\√\0',_binary 'D\Ôˆù9á/@/∂JôPÏ®®{x•é/\Ëx±ø†˚+;°¢¡¶\–\◊\ÕDIªRl%7\ÎAt\„Sòô$\≈\œh¯m-Ø\∆≠Púç5:¢ÚV4kW\›W˙\ÔÄ<¿\‚r∑\À\„êlçW\›dL\Œ¯éõ2v[;!Ω\ŸDeé•_µ≠ÆáTy\rê√Ö\›yç ït\0¯`ÛÜXA>•É#|Åì\¬ÙzHø/Ω∫√Æ˘m\À\Êun\Íº\ÀmªÑ\Î\“n\ÁBj6:æ_˛îÜaREí;ûv7â¢5]k\√—≠%å\„tZYQLöeë\Ì6œã©3÷ã@û`\„2\r\ÈR¥∫ãh—ø\Î˛'),(6,20,3,'2019.03.18',_binary '0Ç\"0\r	*ÜHÜ˜\r\0Ç\00Ç\nÇ\0ê\‚L?bü˜\≈OÆ“éN\‰w!-˙ﬁø\√Sº\œ\‘l¿\Õdä\Õ\…\Ô<{\÷\ÕkÅs	7êk\Ÿp5sπB9º\‹î$\‚9+ô\Ê4Bº_©¶lç\Ë*\…\ﬂ[óA{N≈üc\…æ\»\0a<‘ã\Áò∂öw\ \Ÿ*∑˜∏H\Á™w3∫\◊E1o¿wmöø\Œ,πc\›g˜hV\‚}ì\nd	∏¶|›≠ç[•πŒ§ïçpﬂ§xRÆ)3M_Ö\rE6øKxëè$\“˜8\Ïe\"˛˙7	]aºDØπâ;nÅ∏∑ˇÏß™Eöd\œ9s\ÔKJJO<\Ô´0á[‹õ\rô[¯3÷í\∆\ƒ˚ò\“Tw1#}¡läåa\0',_binary 'Ä\ \⁄\≈\ÃL8ú¥£õÒLEêc«°‰°π:˝i\„7œî⁄ìLG\n=¢$¥˚.¿7[ø´√§\ﬁ.\‰¸ûsú*\ÊfÑÛs\ƒ\¬\ﬁC©\–\‡MW.)\—†)°äÄ}\“ p¶la¥+ù;\⁄k:ë>∫KIäº\„¿öı\\\‘\ ∑xÀΩ®o∏\‡≥\ÂB0+lõÚ;TD{úò\œ˘¡Ç\…6aΩäã\ÂRà‰≥öx)Z\Ô∫˘\ƒ\Z(Û%\ÕÙm;≥ÚÄ™-¸â˜z°π≈ì\Ÿ\Óe˚Ûû#ˇaînæ§πâ≠Ln|qÚ@E‘è:\nØ¨mCzàY¸\Œ˚◊Æuë_z6ë¸7rq∑˜ô\ƒIOs\÷TQ[c\⁄˘'),(7,20,8,'2019.03.18',_binary '0Ç\"0\r	*ÜHÜ˜\r\0Ç\00Ç\nÇ\0óñ—úl	á=\‚\Î/ˇ¡XEù˚åO2ù\√\◊UÑ£œ¶\‚Ü\«¢iz\ÿr\Ê\÷Z∫≤™¯å%¬™(\0∫ŒÜñ¥\⁄`\Ê	<†\ÀK\œ*B˜_\÷-ó\‰\Î4\Íõﬁ∏öeQB}†j’ìgbÅ-\nº\√mÙ¢#\…r\‚\Á$˝\0Æ¥BÙ»¨\Ê¿\ZL$\≈käUÒüa\rtå≠\Ï\\ñæÙ•õuóî\Ítec‡•≥^P⁄ÖZ9Åéq@ö™±9\√Fß8°Û\"ÿªæ\ﬁsõQùèúnm|2\Õ+¸\«º\“5≥Gëµ\»“Æ˝˝ÉHÜõ\√v\≈q|ø¨^…Éq,uô6∏\—rˇ\‘¡Q\ŒC∫$\—\'IÙ*É £nˇ\0',_binary '.ºÖ±\«\œ»äpπ_\Õ|l’ÜTì9k\¬R\\Cs\√ÑqDÒgó’Öu(l[ß\¬8\„Oj\»dÛ∑bl#öAmè\Î¯¶]U\\\ÓK%+\√\‡%WK\Ê4$\›XÆål˚l GR+â’è\Ÿ}(ˆùóºF∫vö~úM¶≠>DãCGu5@˝¡Ò\›¸?π™ˆÒ`Ø\né„ûóÒÿ•\¬\€e£\Z\€ˆ¬õ\Á§\Ô†\–\Ã˛h≈áıˇã8ß\»–†\◊1+u4™To[c¸†é\r>	z\»S\À1\⁄v\¬\Z\ÿ˝¡†SÑ\‰n\’Ùut˜¥¡¨–î+˛nª9∂ûSâ¥å\≈4˚î˛˘A\Ô™¶¿ ®');
/*!40000 ALTER TABLE `sign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(45) NOT NULL,
  `fio` varchar(100) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `birth` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `createDate` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `photo` varchar(45) NOT NULL,
  `sex` varchar(45) NOT NULL,
  `secret` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'IvanTkachev','$2a$11$uSXS6rLJ91WjgOHhEGDx..VGs7MkKZV68Lv5r1uwFu7HgtRn3dcXG','1','','','','','','','','',''),(2,'nikak123','$2a$11$qWmKH9T0HbMGQu64hNnN/u.qkri75.mFLRqhgG9zOoEXKi6WA0kfe','2','','','','','','','','',''),(4,'DarmentAdmin','$2a$11$dnJ4HUnu8jnk0vhpueNABOibZxBxwe2V70v9DkbxMRzhFWZON/7Fy','3','','','','','','','','',''),(5,'Administrator','$2a$11$CjLi9FGdtKsMMOy61LLp4uiRl.13O72Psrj4Qc/8eX2W/zAmDgi2m','4','','','','','','','','',''),(7,'DarmentUser','$2a$11$g42udDedEoSEQM41oryEeujlV3rNW2/ymKRv1Q3eYDawksqCoFnFO','5','','','','','','','','',''),(8,'Tanushka','$2a$11$xd4r4cCOstvIb.6N8CX/3ebCy1fk5d2bUF4W7hosNCitQL.EZfjxK','6','','','','','','','','',''),(9,'UserBlocked','$2a$11$2nAfF0eJg26g2qZOZL9qx.jkKiZJNgnUvI/RtFnW2AGxPmHFP0Mc.','7','','','','','','','','',''),(10,'UserUnblocked','$2a$11$NnamIpoMcV5U4AWxiTYXD.dHiJIH1f4RWEVC1y3O073o642M8.bMC','8','','','','','','','','',''),(11,'UserBlocked2','$2a$11$Qvp/cWGSvlO1K3fgxelfhekQCmOzOwfcC/gf7ngx7Z.1Y9IXOG1Ou','9','','','','','','','','',''),(12,'TestUser1','$2a$11$nxCpWtHSEyccIm5UU7vdZeF5/sfAdpM4XLl0HbCY5DetA0EW6r4tK','10','','','','','','','','',''),(13,'TestUser2','$2a$11$JRZ.rQgXYmlTLqUgUR2z/uYS6SMSSN028e4Xh.jSmDHvRT7Nw6/2K','11','','','','','','','','',''),(14,'TestUser3','$2a$11$V8tbIhbxls8hEd9/89CKpOWMW8PSk.3/Papg1tX0Ct4Vy0LFfqabW','12','','','','','','','','',''),(15,'TestUser4','$2a$11$IIG/wkRbcMp5TKYIe3OUOu22CIHx3b8IKKXZ8o9Fhxqp7SOcXz9oK','13','','','','','','','','',''),(16,'TestUser5','$2a$11$CgUkIs8hsGfPssqcQIpPRuQSaSS/GI8EoFc70/RXwwxRp9nQ1mfgS','asd1@mail.com','','','','Minsk','','','-1','',''),(17,'TestUser6','$2a$11$OfMd2AfFvCy1nGRXroZmFOh8RXAqdAVHwEaSXcgctcUDzRANkWRBe','asd2@mail.com','','','','','2018.12.08','UNBLOCKED','-1','',''),(18,'TestUser7','$2a$11$xZHEBLyaH1t7vJiOxtBUae.QkxDu4vS1K4UgV8Ynl49TgDYwKvKpW','asd3@mail.com','','','','','2018.12.09','UNBLOCKED','-1','','useruser'),(19,'TestUser8','$2a$11$iUF2zxbYDMCoJeDfgMJibOtY5qqJZvPk0KMcgNlwXLSE0asvW2tXy','ivan.tkachev1997@yandex.ru','','','','','2018.12.10','UNBLOCKED','-1','M','SecretWord'),(20,'TestUser','$2a$11$cFnmx6SJHA7qRukk9hoRLeRdpzS/ILRQJUAABoIf.8fG0Q5DhRSjO','ivan.tkachev1998@yandex.ru','','','','','2019.03.04','UNBLOCKED','-1','','SecretWord');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_documents`
--

DROP TABLE IF EXISTS `user_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_documents` (
  `id_user` int(11) NOT NULL,
  `id_document` int(11) NOT NULL,
  KEY `fk_user_idx` (`id_user`),
  KEY `fk_document_idx` (`id_document`),
  CONSTRAINT `fk_document` FOREIGN KEY (`id_document`) REFERENCES `document` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_documents`
--

LOCK TABLES `user_documents` WRITE;
/*!40000 ALTER TABLE `user_documents` DISABLE KEYS */;
INSERT INTO `user_documents` VALUES (16,1),(19,2),(19,3),(19,5),(19,7),(19,8),(19,9),(19,10),(20,11);
/*!40000 ALTER TABLE `user_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_role` (
  `id_user` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  KEY `fk_idx` (`id_user`),
  KEY `fk_role_id_idx` (`id_role`),
  CONSTRAINT `fk_role_id` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (7,1),(8,1),(9,1),(10,1),(11,1),(1,2),(2,2),(4,2),(5,2),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-27 21:15:50
