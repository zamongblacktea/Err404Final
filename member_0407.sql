-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: final
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `mem_idx` int NOT NULL AUTO_INCREMENT,
  `mem_id` varchar(100) NOT NULL COMMENT '유니크',
  `mem_pwd` varchar(100) DEFAULT NULL,
  `mem_name` varchar(100) NOT NULL,
  `mem_nickname` varchar(100) NOT NULL,
  `mem_email` varchar(100) DEFAULT NULL COMMENT '인증 api',
  `mem_zipcode` varchar(200) NOT NULL,
  `mem_curaddr` varchar(200) NOT NULL,
  `mem_ip` varchar(100) NOT NULL,
  `mem_regdate` datetime NOT NULL,
  `mem_update` datetime DEFAULT NULL,
  `mem_grade` varchar(10) DEFAULT NULL COMMENT '일반/관리자',
  `mem_type` varchar(10) DEFAULT NULL COMMENT '소셜 로그인 경로',
  PRIMARY KEY (`mem_idx`),
  UNIQUE KEY `mem_id` (`mem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'lcyZzaIryHj8urinFokYFu0gUAdtTr_Q1U0xOcWkD8g',NULL,'박태섭','코길동','okaqua91@naver.com','08735','서울 서초구 효령로 292 남부터미널','0:0:0:0:0:0:0:1','2025-04-04 18:14:12',NULL,'일반','naver'),(3,'4205926803',NULL,'박태섭','박태',NULL,'06718','서울 서초구 효령로 292 남부터미널','0:0:0:0:0:0:0:1','2025-04-07 14:13:08',NULL,'일반','kakao');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner`
--

DROP TABLE IF EXISTS `owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner` (
  `owner_idx` int NOT NULL AUTO_INCREMENT,
  `owner_id` varchar(100) NOT NULL,
  `owner_pwd` varchar(100) NOT NULL,
  `owner_name` varchar(100) NOT NULL,
  `owner_email` varchar(100) NOT NULL,
  `owner_ip` varchar(100) NOT NULL,
  `owner_zipcode` varchar(100) NOT NULL,
  `owner_addr` varchar(100) NOT NULL,
  `owner_regdate` datetime NOT NULL,
  `owner_update` datetime DEFAULT NULL,
  `owner_num` varchar(100) NOT NULL,
  `owner_status` varchar(100) NOT NULL,
  PRIMARY KEY (`owner_idx`),
  UNIQUE KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
INSERT INTO `owner` VALUES (1,'owner','1234','사장님','owner@admin.com','127,0,0,1','서울시 관악구 에그옐로우 1720-2','글로벌 아이티','2025-03-28 15:09:34',NULL,'-265','대기');
/*!40000 ALTER TABLE `owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rider`
--

DROP TABLE IF EXISTS `rider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rider` (
  `rider_idx` int NOT NULL AUTO_INCREMENT,
  `rider_id` varchar(100) NOT NULL COMMENT '유니크',
  `rider_pwd` varchar(100) NOT NULL,
  `rider_name` varchar(100) NOT NULL,
  `rider_email` varchar(100) NOT NULL COMMENT '인증 api',
  `rider_ip` varchar(100) NOT NULL,
  `rider_regdate` datetime NOT NULL,
  `rider_update` datetime DEFAULT NULL,
  `rider_account` varchar(100) NOT NULL,
  `rider_loc` varchar(200) NOT NULL COMMENT '옵션형식으로 들어가야 함',
  `rider_type` varchar(200) NOT NULL COMMENT '자동차/자전거/도보/오토바이',
  `rider_status` varchar(200) NOT NULL COMMENT '자동차/자전거/도보/오토바이',
  `rider_img` varchar(200) DEFAULT NULL COMMENT '자동차/자전거/도보/오토바이',
  PRIMARY KEY (`rider_idx`),
  UNIQUE KEY `rider_id` (`rider_id`),
  UNIQUE KEY `rider_email_UNIQUE` (`rider_email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rider`
--

LOCK TABLES `rider` WRITE;
/*!40000 ALTER TABLE `rider` DISABLE KEYS */;
INSERT INTO `rider` VALUES (1,'rider','1234','김배달','rider@admin.com','127,0,0,1','2025-04-02 10:31:19',NULL,'127-912030131-78','관악구,동작구','오토바이','대기','이미지');
/*!40000 ALTER TABLE `rider` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-07 14:19:41
