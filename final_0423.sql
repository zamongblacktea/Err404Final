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
-- Table structure for table `mem_addr`
--

DROP TABLE IF EXISTS `mem_addr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mem_addr` (
  `mcuraddr_idx` int NOT NULL AUTO_INCREMENT,
  `mem_idx` int DEFAULT NULL,
  `mem_addr1` varchar(300) DEFAULT NULL,
  `mem_addr2` varchar(300) DEFAULT NULL,
  `mem_latitude` decimal(10,7) DEFAULT NULL,
  `mem_longitude` decimal(10,7) DEFAULT NULL,
  PRIMARY KEY (`mcuraddr_idx`),
  KEY `fk_mem_memberaddr` (`mem_idx`),
  CONSTRAINT `fk_mem_memberaddr` FOREIGN KEY (`mem_idx`) REFERENCES `member` (`mem_idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mem_addr`
--

LOCK TABLES `mem_addr` WRITE;
/*!40000 ALTER TABLE `mem_addr` DISABLE KEYS */;
INSERT INTO `mem_addr` VALUES (1,10,'서울시 관악구 874-10','305호',NULL,NULL),(2,12,'서울시 관악구 봉천동 43-3','201호',NULL,NULL),(3,11,'서울시 관악구 봉천동 1639-7','702호',NULL,NULL);
/*!40000 ALTER TABLE `mem_addr` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-23 13:47:18
