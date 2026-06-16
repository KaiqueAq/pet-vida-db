-- MySQL dump 10.13  Distrib 9.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: db_pet_vida
-- ------------------------------------------------------
-- Server version	9.7.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'ae0d40be-4e07-11f1-866b-50a1320097c6:1-576';

--
-- Current Database: `db_pet_vida`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_pet_vida` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_pet_vida`;

--
-- Table structure for table `animais`
--

DROP TABLE IF EXISTS `animais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animais` (
  `id_animais` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `raca` varchar(30) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `tutores_id_tutores` int unsigned NOT NULL,
  `especies_id_especies` int unsigned NOT NULL,
  PRIMARY KEY (`id_animais`),
  KEY `fk_animais_tutores1_idx` (`tutores_id_tutores`),
  KEY `fk_animais_especies1_idx` (`especies_id_especies`),
  CONSTRAINT `animais_ibfk_29` FOREIGN KEY (`tutores_id_tutores`) REFERENCES `tutores` (`id_tutores`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `animais_ibfk_30` FOREIGN KEY (`especies_id_especies`) REFERENCES `especies` (`id_especies`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animais`
--

LOCK TABLES `animais` WRITE;
/*!40000 ALTER TABLE `animais` DISABLE KEYS */;
INSERT INTO `animais` VALUES (1,'Rex','Vira-lata',NULL,1,1),(2,'Mia','Siamês',NULL,1,2),(3,'Thor','Pitbull',NULL,2,1),(4,'Loki','Persa',NULL,3,2),(5,'Mel','Poodle',NULL,4,1),(6,'Pipoca','Calopsita',NULL,4,3),(7,'Nemo','Palhaço',NULL,5,4),(8,'Fred','Iguana',NULL,6,5),(9,'Luna','Husky',NULL,7,1),(10,'Simba','Angorá',NULL,8,2),(11,'Max','Boxer',NULL,2,1),(12,'Bela','Golden',NULL,3,1),(13,'Chico','Papagaio',NULL,5,3),(14,'Bubbles','Goldfish',NULL,6,4),(15,'Ziggy','Gecko',NULL,7,5),(16,'Rex Teste',NULL,NULL,18,1),(17,'Oliver','Beagle','2024-05-20',1,1),(18,'Oliver','Beagle','2024-05-20',1,1),(19,'Bidu','Schnauzer','2025-08-10',1,1);
/*!40000 ALTER TABLE `animais` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_insert_animal` AFTER INSERT ON `animais` FOR EACH ROW BEGIN
     INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
	 VALUES ('animais', 'INSERT', NEW.id_animais,  CONCAT('Novo animal cadastrado: ', NEW.nome));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consultas` (
  `id_consultas` int unsigned NOT NULL AUTO_INCREMENT,
  `animais_id_animais` int unsigned NOT NULL,
  `veterinarios_id_veterinarios` int unsigned NOT NULL,
  `data_hora` datetime NOT NULL,
  `diagnostico` varchar(45) DEFAULT NULL,
  `valor` decimal(10,2) unsigned NOT NULL,
  `status` enum('agendada','em_atendimento','concluida','cancelada') NOT NULL,
  PRIMARY KEY (`id_consultas`),
  KEY `fk_consultas_animais_idx` (`animais_id_animais`),
  KEY `fk_consultas_veterinarios1_idx` (`veterinarios_id_veterinarios`),
  KEY `idx_consultas_data_hora` (`data_hora`),
  CONSTRAINT `consultas_ibfk_29` FOREIGN KEY (`animais_id_animais`) REFERENCES `animais` (`id_animais`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `consultas_ibfk_30` FOREIGN KEY (`veterinarios_id_veterinarios`) REFERENCES `veterinarios` (`id_veterinarios`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,1,'2026-05-01 09:00:00',NULL,150.00,'concluida'),(2,2,2,'2026-05-01 10:00:00',NULL,180.00,'concluida'),(3,3,1,'2026-05-02 14:00:00',NULL,150.00,'concluida'),(4,4,2,'2026-05-03 11:00:00',NULL,180.00,'concluida'),(5,5,1,'2026-05-04 16:00:00',NULL,150.00,'concluida'),(6,6,3,'2026-05-05 09:30:00',NULL,200.00,'concluida'),(7,7,3,'2026-05-06 13:00:00',NULL,200.00,'concluida'),(8,8,3,'2026-05-07 15:00:00',NULL,250.00,'concluida'),(9,9,1,'2026-05-08 10:00:00',NULL,150.00,'concluida'),(10,10,2,'2026-05-09 11:00:00',NULL,180.00,'concluida'),(11,11,1,'2026-05-10 14:00:00',NULL,150.00,'cancelada'),(12,12,1,'2026-05-11 09:00:00',NULL,150.00,'concluida'),(13,13,3,'2026-05-12 10:30:00',NULL,200.00,'concluida'),(14,14,3,'2026-05-13 14:00:00',NULL,200.00,'concluida'),(15,15,3,'2026-05-14 16:00:00',NULL,250.00,'concluida'),(16,1,1,'2026-05-21 09:00:00','Paciente recuperado. Recomenda-se repouso.',150.00,'concluida'),(17,2,2,'2026-05-21 14:00:00',NULL,180.00,'agendada'),(18,3,1,'2026-05-22 10:00:00',NULL,150.00,'cancelada'),(19,4,2,'2026-05-22 15:00:00',NULL,180.00,'agendada'),(20,5,1,'2026-05-23 09:00:00',NULL,150.00,'agendada'),(21,16,1,'2026-05-28 14:02:42','Exame de rotina',150.00,'concluida'),(22,1,2,'2026-06-15 10:00:00',NULL,150.00,'agendada'),(23,1,1,'2026-09-01 10:00:00',NULL,150.00,'agendada'),(24,1,1,'2026-09-01 10:00:00',NULL,150.00,'em_atendimento');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_insert_consulta` AFTER INSERT ON `consultas` FOR EACH ROW BEGIN
    
    INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
	VALUES ('consultas', 'INSERT', NEW.id_consultas, 'Nova consulta agendada');
  
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_after_update_consulta_status` AFTER UPDATE ON `consultas` FOR EACH ROW BEGIN
    
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_auditoria (tabela_afetada, acao, registro_id, detalhes)
        VALUES ('consultas', 'UPDATE', NEW.id_consultas, CONCAT('Status alterado de ', OLD.status, ' para ', NEW.status));
    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_delete_consulta` BEFORE DELETE ON `consultas` FOR EACH ROW BEGIN
    DECLARE v_pago INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_pago 
    FROM pagamentos
    WHERE consultas_id_consultas = OLD.id_consultas AND status = 'pago';
    
    IF v_pago > 0 THEN -- Corrigido de iv_pago para v_pago
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Nao eh possivel excluir uma consulta cujo pagamento ja foi realizado';
    END IF;
       
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `especies`
--

DROP TABLE IF EXISTS `especies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especies` (
  `id_especies` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`id_especies`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  UNIQUE KEY `nome` (`nome`),
  UNIQUE KEY `nome_2` (`nome`),
  UNIQUE KEY `nome_3` (`nome`),
  UNIQUE KEY `nome_4` (`nome`),
  UNIQUE KEY `nome_5` (`nome`),
  UNIQUE KEY `nome_6` (`nome`),
  UNIQUE KEY `nome_7` (`nome`),
  UNIQUE KEY `nome_8` (`nome`),
  UNIQUE KEY `nome_9` (`nome`),
  UNIQUE KEY `nome_10` (`nome`),
  UNIQUE KEY `nome_11` (`nome`),
  UNIQUE KEY `nome_12` (`nome`),
  UNIQUE KEY `nome_13` (`nome`),
  UNIQUE KEY `nome_14` (`nome`),
  UNIQUE KEY `nome_15` (`nome`),
  UNIQUE KEY `nome_16` (`nome`),
  UNIQUE KEY `nome_17` (`nome`),
  UNIQUE KEY `nome_18` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especies`
--

LOCK TABLES `especies` WRITE;
/*!40000 ALTER TABLE `especies` DISABLE KEYS */;
INSERT INTO `especies` VALUES (1,'Cachorro'),(2,'Gato'),(3,'Pássaro'),(4,'Peixe'),(5,'Réptil');
/*!40000 ALTER TABLE `especies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_auditoria`
--

DROP TABLE IF EXISTS `log_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_auditoria` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tabela_afetada` varchar(50) NOT NULL,
  `acao` varchar(20) NOT NULL,
  `registro_id` int NOT NULL,
  `detalhes` varchar(255) NOT NULL,
  `data_hora` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_auditoria`
--

LOCK TABLES `log_auditoria` WRITE;
/*!40000 ALTER TABLE `log_auditoria` DISABLE KEYS */;
INSERT INTO `log_auditoria` VALUES (1,'consultas','INSERT',23,'Nova consulta agendada','2026-06-11 18:13:53'),(2,'consultas','INSERT',24,'Nova consulta agendada','2026-06-11 18:14:00'),(3,'consultas','UPDATE',24,'Status alterado de agendada para em_atendimento','2026-06-11 18:14:59'),(4,'animais','INSERT',19,'Novo animal cadastrado: Bidu','2026-06-11 18:17:10');
/*!40000 ALTER TABLE `log_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamentos`
--

DROP TABLE IF EXISTS `pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamentos` (
  `id_pagamentos` int unsigned NOT NULL AUTO_INCREMENT,
  `consultas_id_consultas` int unsigned NOT NULL,
  `valor_pago` decimal(10,2) unsigned NOT NULL,
  `forma_pagamento` enum('pix','cartao','dinheiro','convênio') NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `status` enum('pago','pendente','cancelado') NOT NULL,
  PRIMARY KEY (`id_pagamentos`),
  KEY `fk_pagamentos_consultas1_idx` (`consultas_id_consultas`),
  CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`consultas_id_consultas`) REFERENCES `consultas` (`id_consultas`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamentos`
--

LOCK TABLES `pagamentos` WRITE;
/*!40000 ALTER TABLE `pagamentos` DISABLE KEYS */;
INSERT INTO `pagamentos` VALUES (1,1,150.00,'pix','2026-05-01 09:30:00','pago'),(2,2,180.00,'cartao','2026-05-01 10:45:00','pago'),(3,3,150.00,'dinheiro','2026-05-02 14:30:00','pago'),(4,4,180.00,'convênio','2026-05-03 11:15:00','pago'),(5,5,150.00,'pix','2026-05-04 16:20:00','pago'),(6,6,200.00,'cartao','2026-05-05 10:10:00','pago'),(7,7,200.00,'pix','2026-05-06 13:40:00','pago'),(8,8,250.00,'cartao','2026-05-07 15:55:00','pago'),(9,9,150.00,'dinheiro','2026-05-08 10:20:00','pago'),(10,10,180.00,'pix','2026-05-09 11:30:00','pago'),(11,11,0.00,'pix','2026-05-10 14:00:00','cancelado'),(12,12,150.00,'convênio','2026-05-11 09:40:00','pago'),(13,13,200.00,'cartao','2026-05-12 11:00:00','pago'),(14,14,200.00,'pix','2026-05-13 14:30:00','pago'),(15,15,250.00,'dinheiro','2026-05-14 16:45:00','pago'),(16,16,150.00,'pix','2026-06-11 15:17:56','pago'),(17,17,180.00,'pix','2026-05-20 23:00:00','pago'),(18,18,150.00,'pix','2026-05-20 23:00:00','cancelado'),(19,19,180.00,'convênio','2026-05-20 23:00:00','pendente'),(20,20,150.00,'dinheiro','2026-05-20 23:00:00','pendente'),(21,21,0.00,'cartao','2026-05-28 00:00:00','pendente'),(22,22,0.00,'dinheiro','2026-06-15 10:00:00','pendente');
/*!40000 ALTER TABLE `pagamentos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_before_update_pagamento` BEFORE UPDATE ON `pagamentos` FOR EACH ROW BEGIN
    
    IF NEW.status = 'pago' AND OLD.status <> 'pago' THEN
	SET NEW.data_pagamento = NOW();

	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tutores`
--

DROP TABLE IF EXISTS `tutores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutores` (
  `id_tutores` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_tutores`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `cpf_2` (`cpf`),
  UNIQUE KEY `cpf_3` (`cpf`),
  UNIQUE KEY `cpf_4` (`cpf`),
  UNIQUE KEY `cpf_5` (`cpf`),
  UNIQUE KEY `cpf_6` (`cpf`),
  UNIQUE KEY `cpf_7` (`cpf`),
  UNIQUE KEY `cpf_8` (`cpf`),
  UNIQUE KEY `cpf_9` (`cpf`),
  UNIQUE KEY `cpf_10` (`cpf`),
  UNIQUE KEY `cpf_11` (`cpf`),
  UNIQUE KEY `cpf_12` (`cpf`),
  UNIQUE KEY `cpf_13` (`cpf`),
  UNIQUE KEY `cpf_14` (`cpf`),
  UNIQUE KEY `cpf_15` (`cpf`),
  UNIQUE KEY `cpf_16` (`cpf`),
  UNIQUE KEY `cpf_17` (`cpf`),
  UNIQUE KEY `cpf_18` (`cpf`),
  UNIQUE KEY `cpf_19` (`cpf`),
  UNIQUE KEY `cpf_20` (`cpf`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `email_3` (`email`),
  UNIQUE KEY `email_4` (`email`),
  UNIQUE KEY `email_5` (`email`),
  UNIQUE KEY `email_6` (`email`),
  UNIQUE KEY `email_7` (`email`),
  UNIQUE KEY `email_8` (`email`),
  UNIQUE KEY `email_9` (`email`),
  UNIQUE KEY `email_10` (`email`),
  UNIQUE KEY `email_11` (`email`),
  UNIQUE KEY `email_12` (`email`),
  UNIQUE KEY `email_13` (`email`),
  UNIQUE KEY `email_14` (`email`),
  UNIQUE KEY `email_15` (`email`),
  UNIQUE KEY `email_16` (`email`),
  UNIQUE KEY `email_17` (`email`),
  UNIQUE KEY `email_18` (`email`),
  UNIQUE KEY `email_19` (`email`),
  UNIQUE KEY `email_20` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutores`
--

LOCK TABLES `tutores` WRITE;
/*!40000 ALTER TABLE `tutores` DISABLE KEYS */;
INSERT INTO `tutores` VALUES (1,'Ana Oliveira','111.111.111-11','ana@email.com',NULL),(2,'Bruno Santos','222.222.222-22','bruno@email.com',NULL),(3,'Carla Souza','333.333.333-33','carla@email.com',NULL),(4,'Diego Lima','444.444.444-44','diego@email.com',NULL),(5,'Elena Ribeiro','555.555.555-55','elena@email.com',NULL),(6,'Fábio Costa','666.666.666-66','fabio@email.com',NULL),(7,'Gisele Almeida','777.777.777-77','gisele@email.com',NULL),(8,'Hugo Pereira','888.888.888-88','hugo@email.com',NULL),(18,'Claudio de Teste','123.456.789-00',NULL,'11999998888');
/*!40000 ALTER TABLE `tutores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veterinarios`
--

DROP TABLE IF EXISTS `veterinarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veterinarios` (
  `id_veterinarios` int unsigned NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `crmv` varchar(20) NOT NULL,
  `especialidade` varchar(45) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_veterinarios`),
  UNIQUE KEY `crmv_UNIQUE` (`crmv`),
  UNIQUE KEY `crmv` (`crmv`),
  UNIQUE KEY `crmv_2` (`crmv`),
  UNIQUE KEY `crmv_3` (`crmv`),
  UNIQUE KEY `crmv_4` (`crmv`),
  UNIQUE KEY `crmv_5` (`crmv`),
  UNIQUE KEY `crmv_6` (`crmv`),
  UNIQUE KEY `crmv_7` (`crmv`),
  UNIQUE KEY `crmv_8` (`crmv`),
  UNIQUE KEY `crmv_9` (`crmv`),
  UNIQUE KEY `crmv_10` (`crmv`),
  UNIQUE KEY `crmv_11` (`crmv`),
  UNIQUE KEY `crmv_12` (`crmv`),
  UNIQUE KEY `crmv_13` (`crmv`),
  UNIQUE KEY `crmv_14` (`crmv`),
  UNIQUE KEY `crmv_15` (`crmv`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinarios`
--

LOCK TABLES `veterinarios` WRITE;
/*!40000 ALTER TABLE `veterinarios` DISABLE KEYS */;
INSERT INTO `veterinarios` VALUES (1,'Dr. Carlos Silva','CRMV-SP1234','Clínica Geral',NULL),(2,'Dra. Juliana Mendes','CRMV-SP5678','Felinos',NULL),(3,'Dr. Roberto Souza','CRMV-SP9012','Animais Silvestres',NULL);
/*!40000 ALTER TABLE `veterinarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_agenda_hoje`
--

DROP TABLE IF EXISTS `vw_agenda_hoje`;
/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_agenda_hoje` AS SELECT 
 1 AS `data_hora`,
 1 AS `consultas_status`,
 1 AS `diagnostico`,
 1 AS `valor`,
 1 AS `animais_nome`,
 1 AS `especies_nome`,
 1 AS `tutores_nome`,
 1 AS `telefone`,
 1 AS `veterinarios_nome`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `pagamentos_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_animais_detalhados`
--

DROP TABLE IF EXISTS `vw_animais_detalhados`;
/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_animais_detalhados` AS SELECT 
 1 AS `animais_nome`,
 1 AS `tutores_nome`,
 1 AS `especies_nome`,
 1 AS `total_consultas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_consultas_completas`
--

DROP TABLE IF EXISTS `vw_consultas_completas`;
/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_consultas_completas` AS SELECT 
 1 AS `data_hora`,
 1 AS `consultas_status`,
 1 AS `diagnostico`,
 1 AS `valor`,
 1 AS `animais_nome`,
 1 AS `especies_nome`,
 1 AS `tutores_nome`,
 1 AS `telefone`,
 1 AS `veterinarios_nome`,
 1 AS `especialidade`,
 1 AS `forma_pagamento`,
 1 AS `pagamentos_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_faturamento_mensal`
--

DROP TABLE IF EXISTS `vw_faturamento_mensal`;
/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_faturamento_mensal` AS SELECT 
 1 AS `ano`,
 1 AS `mes`,
 1 AS `veterinarios_nome`,
 1 AS `total_consultas`,
 1 AS `faturamento_total`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_inadimplentes`
--

DROP TABLE IF EXISTS `vw_inadimplentes`;
/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_inadimplentes` AS SELECT 
 1 AS `data_hora`,
 1 AS `tutores_nome`,
 1 AS `telefone`,
 1 AS `forma_pagamento`,
 1 AS `pagamentos_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'db_pet_vida'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_classificar_valor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_classificar_valor`(valor_consulta DECIMAL(10,2)) RETURNS varchar(50) CHARSET utf8mb3
    DETERMINISTIC
BEGIN
    DECLARE v_classificacao VARCHAR(50);
    
    IF valor_consulta < 100.00 THEN
        SET v_classificacao = 'Consulta Simples';
    ELSEIF valor_consulta BETWEEN 100.00 AND 300.00 THEN
        SET v_classificacao = 'Consulta Padrão';
    ELSE
        SET v_classificacao = 'Procedimento Especial';
    END IF;
    
    RETURN v_classificacao;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_idade_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_idade_animal`(data_nascimento DATE) RETURNS varchar(50) CHARSET utf8mb3
    DETERMINISTIC
BEGIN
    DECLARE v_anos INT;
    DECLARE v_meses INT;
    DECLARE v_resultado VARCHAR(50);
    
    IF data_nascimento IS NULL OR data_nascimento > CURDATE() THEN
        RETURN '0 anos e 0 meses';
    END IF;
    
    SET v_anos = TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE());
    SET v_meses = TIMESTAMPDIFF(MONTH, data_nascimento, CURDATE()) - (v_anos * 12);
    SET v_resultado = CONCAT(v_anos, ' anos e ', v_meses, ' meses');
    
    RETURN v_resultado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_qtd_consultas_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_qtd_consultas_animal`(animal_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_qtd INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_qtd
    FROM consultas
    WHERE animais_id_animais = animal_id;
    
    RETURN v_qtd;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_status_emoji` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_status_emoji`(status_consulta VARCHAR(20)) RETURNS varchar(50) CHARSET utf8mb3
    DETERMINISTIC
BEGIN
    DECLARE v_status_visual VARCHAR(50);
    
    CASE status_consulta
        WHEN 'agendada' THEN SET v_status_visual = 'Agendada';
        WHEN 'em_atendimento' THEN SET v_status_visual = 'Em Atendimento';
        WHEN 'concluida' THEN SET v_status_visual = 'Concluída';
        WHEN 'cancelada' THEN SET v_status_visual = 'Cancelada';
        ELSE SET v_status_visual = 'Desconhecido';
    END CASE;
    
    RETURN v_status_visual;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_total_gasto_tutor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_total_gasto_tutor`(tutor_id INT) RETURNS decimal(10,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;
    
    SELECT IFNULL(SUM(c.valor), 0.00) INTO v_total
    FROM consultas c
    JOIN animais a ON c.animais_id_animais = a.id_animais
    WHERE a.tutores_id_tutores = tutor_id 
      AND c.status <> 'cancelada';
      
    RETURN v_total;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_agendar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agendar_consulta`(
	
    IN p_animal_id INT,
    IN p_vet_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN
	
    DECLARE v_existe_animal INT DEFAULT NULL;
    DECLARE v_existe_veterinarios INT DEFAULT NULL;
    DECLARE v_horario_ocupado INT DEFAULT NULL;
    
    SELECT id_animais INTO v_existe_animal
    FROM animais
    WHERE id_animais = p_animal_id;

	SELECT id_veterinarios INTO v_existe_veterinarios
    FROM veterinarios
    WHERE id_veterinarios = p_vet_id;
    
    SELECT COUNT(*) INTO v_horario_ocupado
    FROM consultas
    WHERE data_hora = p_data_hora AND veterinarios_id_veterinarios = p_vet_id;

    IF (v_existe_veterinarios IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: O veterinário informado não existe no sistema!';
    END IF;

    IF (v_horario_ocupado > 0) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: Este veterinário já possui um agendamento neste horário!';
    END IF;
    IF (v_existe_animal IS NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: O animal informado não existe no sistema!';
        END IF;

    
    START TRANSACTION;
        
       
        INSERT INTO db_pet_vida.consultas(animais_id_animais, veterinarios_id_veterinarios, data_hora, valor, status)
        VALUES(p_animal_id, p_vet_id, p_data_hora, p_valor, 'agendada');
       
        INSERT INTO db_pet_vida.pagamentos(consultas_id_consultas, valor_pago, forma_pagamento, data_pagamento, status)
        VALUES (LAST_INSERT_ID(), 0.00, 'dinheiro', p_data_hora, 'pendente');

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cadastrar_animal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cadastrar_animal`(
	
    IN p_nome VARCHAR(50),
    IN p_especie_id INT,
    IN p_raca VARCHAR(30),
    IN p_nascimento DATE,
    IN P_tutor_id INT,
    OUT p_novo_id INT
)
BEGIN
	
    DECLARE v_existe_tutor INT DEFAULT NULL;
    DECLARE v_existe_especie INT DEFAULT NULL;
    
    
    SELECT id_tutores INTO v_existe_tutor
    FROM tutores
    WHERE id_tutores = P_tutor_id;

	SELECT id_especies INTO v_existe_especie
    FROM especies
    WHERE id_especies = p_especie_id;
    

    IF (v_existe_tutor IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '"Erro: O tutor informado não existe no sistema!';
    END IF;

    IF (v_existe_especie IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A espécie informada não existe no sistema!';
    END IF;

    
    START TRANSACTION;
        
       
        
        INSERT INTO animais (nome, raca, data_nascimento, tutores_id_tutores, especies_id_especies)
        VALUES (p_nome, p_raca, p_nascimento, p_tutor_id, p_especie_id);
       
        
        SET p_novo_id = LAST_INSERT_ID();
        
    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cancelar_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cancelar_consulta`(
	
    IN p_consulta_id INT
    
    
)
BEGIN
	
    DECLARE v_consultas_id INT DEFAULT NULL;
    
    
    SELECT id_consultas INTO v_consultas_id
    FROM consultas
    WHERE id_consultas = p_consulta_id;

    IF (v_consultas_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A consulta informada não existe no sistema!';
    END IF;

    
    START TRANSACTION;
        
       
        UPDATE consultas
        SET 
			consultas.status= 'cancelada'
            WHERE id_consultas = p_consulta_id;
		
        UPDATE pagamentos
        SET status = 'cancelado'
        WHERE consultas_id_consultas = p_consulta_id;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_concluir_consulta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_concluir_consulta`(
	
    IN p_consulta_id INT,
    IN p_diagnostico VARCHAR(45)
    
)
BEGIN
	
    DECLARE v_consultas_id INT DEFAULT NULL;
    
    
    SELECT id_consultas INTO v_consultas_id
    FROM consultas
    WHERE id_consultas = p_consulta_id;

    IF (v_consultas_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A consulta informada não existe no sistema!';
    END IF;

    
    START TRANSACTION;
        
       
        UPDATE consultas
        SET 
			consultas.status= 'concluida',
            consultas.diagnostico = p_diagnostico
            WHERE id_consultas = p_consulta_id;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registrar_pagamento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registrar_pagamento`(
	
    IN p_consulta_id INT,
    IN p_forma_pagamento VARCHAR(20)
    
)
BEGIN
	
    DECLARE v_pagamento_id INT DEFAULT NULL;
    DECLARE v_status_atual VARCHAR(20) DEFAULT NULL;
    
    
    SELECT id_pagamentos, status INTO v_pagamento_id, v_status_atual
    FROM pagamentos
    WHERE consultas_id_consultas = p_consulta_id;

    IF (v_pagamento_id IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: O pagamentos informado não existe no sistema!';
    END IF;
    IF (v_status_atual = 'pago') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: Este pagamento já foi realizado anteriormente!.';
    END IF;

    
    START TRANSACTION;
        
       
        UPDATE pagamentos
        SET 
			pagamentos.status= 'pago',
            pagamentos.forma_pagamento = p_forma_pagamento
            WHERE consultas_id_consultas = p_consulta_id;


    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `db_pet_vida`
--

USE `db_pet_vida`;

--
-- Final view structure for view `vw_agenda_hoje`
--

/*!50001 DROP VIEW IF EXISTS `vw_agenda_hoje`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_agenda_hoje` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`consultas_status` AS `consultas_status`,`vw_consultas_completas`.`diagnostico` AS `diagnostico`,`vw_consultas_completas`.`valor` AS `valor`,`vw_consultas_completas`.`animais_nome` AS `animais_nome`,`vw_consultas_completas`.`especies_nome` AS `especies_nome`,`vw_consultas_completas`.`tutores_nome` AS `tutores_nome`,`vw_consultas_completas`.`telefone` AS `telefone`,`vw_consultas_completas`.`veterinarios_nome` AS `veterinarios_nome`,`vw_consultas_completas`.`especialidade` AS `especialidade`,`vw_consultas_completas`.`forma_pagamento` AS `forma_pagamento`,`vw_consultas_completas`.`pagamentos_status` AS `pagamentos_status` from `vw_consultas_completas` where (cast(`vw_consultas_completas`.`data_hora` as date) = curdate()) order by `vw_consultas_completas`.`data_hora` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_animais_detalhados`
--

/*!50001 DROP VIEW IF EXISTS `vw_animais_detalhados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_animais_detalhados` AS select `animais`.`nome` AS `animais_nome`,`tutores`.`nome` AS `tutores_nome`,`especies`.`nome` AS `especies_nome`,count(`consultas`.`id_consultas`) AS `total_consultas` from (((`animais` join `tutores` on((`tutores`.`id_tutores` = `animais`.`tutores_id_tutores`))) join `especies` on((`especies`.`id_especies` = `animais`.`especies_id_especies`))) left join `consultas` on((`consultas`.`animais_id_animais` = `animais`.`id_animais`))) group by `animais`.`nome`,`tutores`.`nome`,`especies`.`nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_consultas_completas`
--

/*!50001 DROP VIEW IF EXISTS `vw_consultas_completas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_consultas_completas` AS select `consultas`.`data_hora` AS `data_hora`,`consultas`.`status` AS `consultas_status`,`consultas`.`diagnostico` AS `diagnostico`,`consultas`.`valor` AS `valor`,`animais`.`nome` AS `animais_nome`,`especies`.`nome` AS `especies_nome`,`tutores`.`nome` AS `tutores_nome`,`tutores`.`telefone` AS `telefone`,`veterinarios`.`nome` AS `veterinarios_nome`,`veterinarios`.`especialidade` AS `especialidade`,`pagamentos`.`forma_pagamento` AS `forma_pagamento`,`pagamentos`.`status` AS `pagamentos_status` from (((((`consultas` join `animais` on((`animais`.`id_animais` = `consultas`.`animais_id_animais`))) join `especies` on((`especies`.`id_especies` = `animais`.`especies_id_especies`))) join `tutores` on((`tutores`.`id_tutores` = `animais`.`tutores_id_tutores`))) join `veterinarios` on((`veterinarios`.`id_veterinarios` = `consultas`.`veterinarios_id_veterinarios`))) left join `pagamentos` on((`consultas`.`id_consultas` = `pagamentos`.`consultas_id_consultas`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_faturamento_mensal`
--

/*!50001 DROP VIEW IF EXISTS `vw_faturamento_mensal`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_faturamento_mensal` AS select year(`vw_consultas_completas`.`data_hora`) AS `ano`,month(`vw_consultas_completas`.`data_hora`) AS `mes`,`vw_consultas_completas`.`veterinarios_nome` AS `veterinarios_nome`,count(0) AS `total_consultas`,sum(`vw_consultas_completas`.`valor`) AS `faturamento_total` from `vw_consultas_completas` group by `ano`,`mes`,`vw_consultas_completas`.`veterinarios_nome` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_inadimplentes`
--

/*!50001 DROP VIEW IF EXISTS `vw_inadimplentes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_inadimplentes` AS select `vw_consultas_completas`.`data_hora` AS `data_hora`,`vw_consultas_completas`.`tutores_nome` AS `tutores_nome`,`vw_consultas_completas`.`telefone` AS `telefone`,`vw_consultas_completas`.`forma_pagamento` AS `forma_pagamento`,`vw_consultas_completas`.`pagamentos_status` AS `pagamentos_status` from `vw_consultas_completas` where ((`vw_consultas_completas`.`consultas_status` = 'concluida') and ((`vw_consultas_completas`.`pagamentos_status` = 'pendente') or (`vw_consultas_completas`.`forma_pagamento` is null))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-15 22:53:41
