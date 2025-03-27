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
  `mem_pwd` varchar(100) NOT NULL,
  `mem_name` varchar(100) NOT NULL,
  `mem_nickname` varchar(100) NOT NULL,
  `mem_email` varchar(100) NOT NULL COMMENT '인증 api',
  `mem_curaddr` varchar(200) NOT NULL,
  `mem_ip` varchar(100) NOT NULL,
  `mem_regdate` datetime NOT NULL,
  `mem_update` datetime DEFAULT NULL,
  `mem_grade` varchar(100) DEFAULT NULL COMMENT '일반/관리자',
  PRIMARY KEY (`mem_idx`),
  UNIQUE KEY `mem_id` (`mem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'admin','1234','관리자','김관리','admin@admin.com','서울시 관악구 에그옐로우','127,0,0,1','2025-03-27 15:37:21',NULL,'관리자'),(2,'dlfrlfehd','1234','일길동','일길동','admin@admin.com','서울시 관악구 에그옐로우','127,0,0,1','2025-03-27 15:37:24',NULL,'일반');
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
  `owner_regdate` datetime NOT NULL,
  `owner_update` datetime DEFAULT NULL,
  `owner_num` varchar(100) NOT NULL,
  `owner_account` varchar(100) NOT NULL,
  `owner_status` varchar(100) NOT NULL,
  PRIMARY KEY (`owner_idx`),
  UNIQUE KEY `owner_id` (`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner`
--

LOCK TABLES `owner` WRITE;
/*!40000 ALTER TABLE `owner` DISABLE KEYS */;
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
  `rider_account` varchar(100) NOT NULL,
  `rider_loc` varchar(200) NOT NULL COMMENT '옵션형식으로 들어가야 함',
  `rider_type` varchar(200) NOT NULL COMMENT '자동차/자전거/도보/오토바이',
  PRIMARY KEY (`rider_idx`),
  UNIQUE KEY `rider_id` (`rider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rider`
--

LOCK TABLES `rider` WRITE;
/*!40000 ALTER TABLE `rider` DISABLE KEYS */;
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

-- Dump completed on 2025-03-27 17:41:59
