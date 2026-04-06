-- MySQL dump 10.13  Distrib 9.6.0, for Win64 (x86_64)
--
-- Host: localhost    Database: test_2vet_db_20260324_123401
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '86e0a75a-28cb-11f1-87d3-f83dc6303c87:1-8718';

--
-- Table structure for table `activity_logs`
--

DROP TABLE IF EXISTS `activity_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `branch_id` int NOT NULL,
  `activity_type` varchar(100) NOT NULL,
  `code_number` varchar(255) DEFAULT NULL,
  `pet_uid` varchar(100) DEFAULT NULL,
  `c_uid` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `old_data` text,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=747 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `additional_money`
--

DROP TABLE IF EXISTS `additional_money`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_money` (
  `id` int NOT NULL AUTO_INCREMENT,
  `additional_money_type` int NOT NULL DEFAULT '-1',
  `additional_money_total` float NOT NULL DEFAULT '0',
  `detail` varchar(100) DEFAULT NULL,
  `logged_user_id` int NOT NULL DEFAULT '-1',
  `add_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `additional_money_category` int DEFAULT '-1',
  `money_type` int DEFAULT '1',
  `affect_sale_report_flag` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `logged_user_id` (`logged_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `additional_money_category`
--

DROP TABLE IF EXISTS `additional_money_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_money_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) DEFAULT NULL,
  `additional_money_type` int DEFAULT '-1',
  `affect_summary_report_flag` tinyint DEFAULT '1',
  PRIMARY KEY (`category_id`),
  KEY `additional_money_type` (`additional_money_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `additional_money_summey_report_per_day`
--

DROP TABLE IF EXISTS `additional_money_summey_report_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_money_summey_report_per_day` (
  `date` date NOT NULL,
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `other_revenues` double DEFAULT NULL,
  `other_expenses` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `additional_money_type`
--

DROP TABLE IF EXISTS `additional_money_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_money_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `adjust_stock`
--

DROP TABLE IF EXISTS `adjust_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adjust_stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int DEFAULT '-1',
  `stock_warehouse_id` int DEFAULT '-1',
  `qty_before_adjust` float DEFAULT '0',
  `qty_after_adjust` float DEFAULT '0',
  `qty_diff` float DEFAULT '0',
  `ml_before_adjust` float DEFAULT '0',
  `ml_after_adjust` float DEFAULT '0',
  `ml_diff` float DEFAULT '0',
  `adjust_unit` varchar(20) DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT '1',
  `more_info` varchar(512) DEFAULT NULL,
  `adjust_datetime` datetime DEFAULT NULL,
  `adjust_user_id` int DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `stock_warehouse_id` (`stock_warehouse_id`),
  KEY `adjust_user_id` (`adjust_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_add_cut_stock`
--

DROP TABLE IF EXISTS `admit_add_cut_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_add_cut_stock` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `payment_id` int NOT NULL,
  `related_item_id` int NOT NULL,
  `item_uid` int NOT NULL,
  `rate` varchar(100) NOT NULL,
  `volume` varchar(100) NOT NULL,
  `note` text NOT NULL,
  `checked_time` text NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `payment_id` (`payment_id`),
  KEY `related_item_id` (`related_item_id`),
  KEY `item_uid` (`item_uid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_configuration`
--

DROP TABLE IF EXISTS `admit_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_configuration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number_of_cages` int NOT NULL DEFAULT '0',
  `number_of_hotel_cages` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_history`
--

DROP TABLE IF EXISTS `admit_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_history` (
  `admit_history_id` int NOT NULL AUTO_INCREMENT,
  `queue_uid` int NOT NULL,
  `pet_uid` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `admit_since_date` datetime NOT NULL,
  `admit_to_date` datetime DEFAULT NULL,
  `admit_price` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admit_status` int DEFAULT '1',
  `cage_id` int DEFAULT '-1',
  `doctor_id` int DEFAULT '-1',
  `logged_in_user` int NOT NULL,
  `assistant_1` int NOT NULL,
  `assistant_2` int NOT NULL,
  `admit_add_datetime` datetime NOT NULL,
  `admit_modify_datetime` datetime NOT NULL,
  `admit_type` int NOT NULL DEFAULT '-1',
  `ward_type` int DEFAULT '-1',
  `history` blob,
  `physical` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `differential` blob,
  `final` blob,
  `prognosis` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grooming_style_id` int NOT NULL,
  `expense_uid` int NOT NULL,
  `suggestion` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reportlab` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admit_status_text` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admit_color_cause` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0',
  PRIMARY KEY (`admit_history_id`),
  KEY `queue_uid` (`queue_uid`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `admit_status` (`admit_status`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_ah_branch_status_type` (`branch_id`,`admit_status`,`admit_type`),
  KEY `idx_ah_pet_uid` (`pet_uid`),
  KEY `idx_ah_queue_uid` (`queue_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=44968 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_history_expense_info`
--

DROP TABLE IF EXISTS `admit_history_expense_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_history_expense_info` (
  `admit_history_id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `admit_since_date` datetime NOT NULL,
  `admit_to_date` datetime DEFAULT NULL,
  `admit_status` int DEFAULT '1',
  `cage_id` int DEFAULT '-1',
  `doctor_id` int DEFAULT '-1',
  `ward_type` int DEFAULT '-1',
  `expense_uid` int NOT NULL,
  `last_payment_item_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`admit_history_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `admit_status` (`admit_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_lab`
--

DROP TABLE IF EXISTS `admit_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_lab` (
  `lab_id` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `pet_uid` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `lab_type_id` int NOT NULL,
  `product` longtext NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `lab_status` int DEFAULT NULL,
  `is_idexx` int DEFAULT '0',
  `logged_in_user` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`lab_id`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `lab_type_id` (`lab_type_id`),
  KEY `status` (`status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18884 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_mode`
--

DROP TABLE IF EXISTS `admit_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_mode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mode` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_body`
--

DROP TABLE IF EXISTS `admit_monitor_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_body` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_body_f_time` varchar(50) NOT NULL,
  `monitor_body_f` varchar(200) NOT NULL,
  `monitor_body_hr_time` varchar(50) NOT NULL,
  `monitor_body_hr` varchar(200) NOT NULL,
  `monitor_body_rr_time` varchar(50) NOT NULL,
  `monitor_body_rr` varchar(200) NOT NULL,
  `monitor_body_ls_time` varchar(50) NOT NULL,
  `monitor_body_ls` varchar(200) NOT NULL,
  `monitor_body_bp_time` varchar(50) NOT NULL,
  `monitor_body_bp` varchar(200) NOT NULL,
  `monitor_body_mm_time` varchar(50) NOT NULL,
  `monitor_body_mm` varchar(200) NOT NULL,
  `monitor_body_crt_time` varchar(50) NOT NULL,
  `monitor_body_crt` varchar(200) NOT NULL,
  `monitor_body_uop_time` varchar(50) NOT NULL,
  `monitor_body_uop` varchar(200) NOT NULL,
  `monitor_body_hs` varchar(200) DEFAULT NULL,
  `monitor_body_hs_time` varchar(50) DEFAULT NULL,
  `monitor_body_crt2` varchar(200) DEFAULT NULL,
  `monitor_body_crt2_time` varchar(50) DEFAULT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=13530 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_eat`
--

DROP TABLE IF EXISTS `admit_monitor_eat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_eat` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_eat_time` varchar(50) NOT NULL,
  `monitor_eat_type` varchar(200) NOT NULL,
  `monitor_eat_isme` varchar(200) NOT NULL,
  `monitor_eat_cc` varchar(200) NOT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=120311 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_general`
--

DROP TABLE IF EXISTS `admit_monitor_general`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_general` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_general_urine_time` varchar(50) NOT NULL,
  `monitor_general_urine` varchar(200) NOT NULL,
  `monitor_general_urine_cc` varchar(50) NOT NULL,
  `monitor_general_vomit_time` varchar(50) NOT NULL,
  `monitor_general_vomit` varchar(200) NOT NULL,
  `monitor_general_vomit_cc` varchar(50) NOT NULL,
  `monitor_general_oh_time` varchar(50) NOT NULL,
  `monitor_general_oh` varchar(200) NOT NULL,
  `monitor_general_oh_cc` varchar(50) NOT NULL,
  `monitor_general_cough_time` varchar(50) NOT NULL,
  `monitor_general_cough` varchar(200) NOT NULL,
  `monitor_general_whip_time` varchar(50) NOT NULL,
  `monitor_general_whip` varchar(200) NOT NULL,
  `monitor_general_whip_long` varchar(200) NOT NULL,
  `monitor_general_coma_time` varchar(50) NOT NULL,
  `monitor_general_coma` varchar(200) NOT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=119857 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_other`
--

DROP TABLE IF EXISTS `admit_monitor_other`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_other` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_other_time` varchar(50) NOT NULL,
  `monitor_other_content` text NOT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=88757 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_plan`
--

DROP TABLE IF EXISTS `admit_monitor_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_plan` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_plan_time_set1` text NOT NULL,
  `monitor_plan_time_set2` text NOT NULL,
  `monitor_plan_content` text NOT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=18341 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_talk`
--

DROP TABLE IF EXISTS `admit_monitor_talk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_talk` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_talk_time` varchar(50) NOT NULL,
  `monitor_talk_content` text NOT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=34142 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_monitor_treatment`
--

DROP TABLE IF EXISTS `admit_monitor_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_monitor_treatment` (
  `uid` int unsigned NOT NULL AUTO_INCREMENT,
  `admit_history_id` int NOT NULL,
  `monitor_other_time` varchar(50) NOT NULL,
  `monitor_other_content` text NOT NULL,
  `veterinary` varchar(200) NOT NULL,
  `assistant` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=22653 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_status`
--

DROP TABLE IF EXISTS `admit_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_status` (
  `admit_status_id` int NOT NULL AUTO_INCREMENT,
  `admit_status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`admit_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_to_null_view`
--

DROP TABLE IF EXISTS `admit_to_null_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_to_null_view` (
  `admit_history_id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `admit_since_date` datetime NOT NULL,
  `admit_to_date` datetime DEFAULT NULL,
  `admit_status` int DEFAULT '1',
  `cage_id` int DEFAULT '-1',
  `doctor_id` int DEFAULT '-1',
  `admit_add_datetime` datetime NOT NULL,
  `admit_modify_datetime` datetime NOT NULL,
  `admit_type` int NOT NULL DEFAULT '-1',
  `ward_type` int DEFAULT '-1',
  `expense_uid` int NOT NULL,
  `last_bill_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`admit_history_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `admit_type` (`admit_type`),
  KEY `expense_uid` (`expense_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admit_type`
--

DROP TABLE IF EXISTS `admit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admit_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  `mode` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `pet_uid` int NOT NULL,
  `image_type` varchar(100) NOT NULL,
  `image_priority_id` int NOT NULL DEFAULT '1',
  `image_path` text NOT NULL,
  `albums_name` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_albums_name_timestamp` (`albums_name`,`timestamp` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=90988 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `albums_pet_note`
--

DROP TABLE IF EXISTS `albums_pet_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums_pet_note` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `pet_uid` int NOT NULL,
  `pet_note` text NOT NULL,
  `albums_name` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19656 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `all_stock_warehouse_info`
--

DROP TABLE IF EXISTS `all_stock_warehouse_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `all_stock_warehouse_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int DEFAULT '-1',
  `warehouse` varchar(60) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `price_unit_name` varchar(20) DEFAULT NULL,
  `warehouse_type_id` int DEFAULT '3',
  PRIMARY KEY (`id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `warehouse_type_id` (`warehouse_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment` (
  `appointment_uid` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `opd_id` int DEFAULT '0',
  `admit_history_id` int DEFAULT '0',
  `surgery_uid` int DEFAULT '0',
  `branch_id` int NOT NULL DEFAULT '1',
  `room_id` int DEFAULT '4',
  `appointment_from_datetime` datetime DEFAULT NULL,
  `appointment_to_datetime` datetime DEFAULT NULL,
  `appointment_mode_id` int DEFAULT '1',
  `vaccine_stock_subcategory_id` int NOT NULL,
  `special_clinic_id` int DEFAULT '-1',
  `specific_doctor_id` int DEFAULT '-1',
  `specific_doctor_name` varchar(64) DEFAULT NULL,
  `come_for_list` longtext,
  `more_info` longtext,
  `appointment_status` int DEFAULT '1',
  `appointment_add_datetime` datetime DEFAULT NULL,
  `appointment_modify_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `queue_priority_id` int DEFAULT '4',
  `all_day_appointment` tinyint DEFAULT '0',
  `appointment_from_time` varchar(5) DEFAULT NULL,
  `appointment_to_time` varchar(5) DEFAULT NULL,
  `appointment_user_id` int DEFAULT '-1',
  `appointment_todo_list` varchar(100) DEFAULT NULL,
  `appointment_ref_id` varchar(45) DEFAULT NULL,
  `follow_appointment_flag` tinyint DEFAULT '0',
  `call_status` int DEFAULT '0',
  `call_status_detail` text,
  `call_detail` text,
  `pet_symptoms` varchar(100) DEFAULT NULL,
  `satisfaction` varchar(100) DEFAULT NULL,
  `added_detail_user_id` varchar(100) DEFAULT NULL,
  `sms_sent_flag` tinyint DEFAULT '0',
  PRIMARY KEY (`appointment_uid`),
  KEY `pet_uid` (`pet_uid`),
  KEY `specific_doctor_name` (`specific_doctor_name`),
  KEY `room_id` (`room_id`),
  KEY `branch_id` (`branch_id`),
  KEY `surgery_uid` (`surgery_uid`),
  KEY `admit_history_id` (`admit_history_id`),
  KEY `opd_id` (`opd_id`),
  KEY `idx_appt_branch_status` (`branch_id`,`appointment_status`),
  KEY `idx_appt_pet_uid` (`pet_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=105257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment_list_item`
--

DROP TABLE IF EXISTS `appointment_list_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_list_item` (
  `item_uid` int NOT NULL AUTO_INCREMENT,
  `item_name` varchar(200) NOT NULL,
  `mode_type` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment_mode`
--

DROP TABLE IF EXISTS `appointment_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_mode` (
  `mode_uid` int NOT NULL AUTO_INCREMENT,
  `mode_name` varchar(200) NOT NULL,
  `mode_type` int NOT NULL,
  `mode_status` int NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mode_uid`),
  KEY `mode_status` (`mode_status`),
  KEY `mode_type` (`mode_type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment_status`
--

DROP TABLE IF EXISTS `appointment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(25) NOT NULL,
  `status` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment_todo_list`
--

DROP TABLE IF EXISTS `appointment_todo_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointment_todo_list` (
  `todo_id` int NOT NULL AUTO_INCREMENT,
  `todo_detail` varchar(128) NOT NULL,
  `appointment_mode_id` int NOT NULL DEFAULT '1',
  `todo_en_detail` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`todo_id`),
  KEY `appointment_mode_id` (`appointment_mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text,
  `detail` longtext,
  `type` varchar(12) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_history`
--

DROP TABLE IF EXISTS `bill_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_history` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `bill_id` varchar(45) DEFAULT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `cuid` int DEFAULT '0',
  `expense_uid` int NOT NULL DEFAULT '-1',
  `bill_history_type` int NOT NULL DEFAULT '-1',
  `bill_pay_type_id` int NOT NULL DEFAULT '-1',
  `total` float(10,2) DEFAULT NULL,
  `net_total` float(10,2) DEFAULT NULL,
  `has_deposit_used_flag` tinyint NOT NULL DEFAULT '0',
  `deposit_used` float NOT NULL DEFAULT '0',
  `reward` int NOT NULL,
  `money_reward` float(10,2) NOT NULL,
  `receive_money` float(10,2) DEFAULT NULL,
  `return_money` float(10,2) DEFAULT NULL,
  `bill_receive_option` varchar(500) DEFAULT '0',
  `change_money` float NOT NULL DEFAULT '0',
  `more_info` varchar(64) DEFAULT NULL,
  `vatable_total` float NOT NULL DEFAULT '0',
  `non_vat_total` float(10,2) DEFAULT NULL,
  `vat_total` float NOT NULL DEFAULT '0',
  `logged_user_id` int NOT NULL DEFAULT '-1',
  `bill_history_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `bill_payment_id_items_list` longtext,
  `has_admit_expense_flag` tinyint DEFAULT '0',
  `admit_expense_id` int DEFAULT '-1',
  `bill_history_status` int DEFAULT '0',
  `items_discount_amount` float DEFAULT '0',
  `other_discount_amount` float DEFAULT '0',
  `bill_vat_type_id` int NOT NULL DEFAULT '1',
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `ref_info` varchar(64) DEFAULT NULL,
  `charge_percentage` float DEFAULT '0',
  `charge_value` float DEFAULT '0',
  `gift_percent` float(10,2) DEFAULT '0.00',
  `gift_code` varchar(255) DEFAULT NULL,
  `gift_id` int DEFAULT '0',
  `gift_discount` float(10,2) DEFAULT '0.00',
  `create_date_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `bill_id` (`bill_id`),
  KEY `expense_uid` (`expense_uid`),
  KEY `bill_history_status` (`bill_history_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=159074 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_history_status`
--

DROP TABLE IF EXISTS `bill_history_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_history_status` (
  `id` int NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_history_tax`
--

DROP TABLE IF EXISTS `bill_history_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_history_tax` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `bill_id` varchar(45) DEFAULT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `expense_uid` int NOT NULL DEFAULT '-1',
  `bill_history_type` int NOT NULL DEFAULT '-1',
  `bill_pay_type_id` int NOT NULL DEFAULT '-1',
  `total` float(10,2) DEFAULT NULL,
  `net_total` float(10,2) DEFAULT NULL,
  `has_deposit_used_flag` tinyint NOT NULL DEFAULT '0',
  `deposit_used` float NOT NULL DEFAULT '0',
  `reward` float(10,2) NOT NULL,
  `money_reward` float(10,2) NOT NULL,
  `receive_money` float(10,2) DEFAULT NULL,
  `change_money` float NOT NULL DEFAULT '0',
  `more_info` varchar(64) DEFAULT NULL,
  `vatable_total` float NOT NULL DEFAULT '0',
  `non_vat_total` float(10,2) DEFAULT NULL,
  `vat_total` float NOT NULL DEFAULT '0',
  `logged_user_id` int NOT NULL DEFAULT '-1',
  `bill_history_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `bill_payment_id_items_list` varchar(11000) DEFAULT NULL,
  `has_admit_expense_flag` tinyint DEFAULT '0',
  `admit_expense_id` int DEFAULT '-1',
  `bill_history_status` int DEFAULT '0',
  `items_discount_amount` float DEFAULT '0',
  `other_discount_amount` float DEFAULT '0',
  `bill_vat_type_id` int NOT NULL DEFAULT '1',
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `ref_info` varchar(64) DEFAULT NULL,
  `charge_percentage` float DEFAULT '0',
  `charge_value` float DEFAULT '0',
  `bill_id_for_tax` varchar(45) DEFAULT NULL,
  `reserved_account_id` int NOT NULL,
  `bill_history_tax_status` int NOT NULL DEFAULT '1',
  `recalculate_vat` tinyint DEFAULT '0',
  `gift_percent` float(10,2) DEFAULT '0.00',
  `gift_code` varchar(255) DEFAULT NULL,
  `gift_id` int DEFAULT '0',
  `gift_discount` float(10,2) DEFAULT '0.00',
  PRIMARY KEY (`uid`),
  KEY `bill_id` (`bill_id`),
  KEY `expense_uid` (`expense_uid`),
  KEY `bill_history_type` (`bill_history_type`),
  KEY `bill_history_status` (`bill_history_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=159074 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_history_tax_status`
--

DROP TABLE IF EXISTS `bill_history_tax_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_history_tax_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_multiple_payment_summary_report_per_day`
--

DROP TABLE IF EXISTS `bill_multiple_payment_summary_report_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_multiple_payment_summary_report_per_day` (
  `date` date DEFAULT NULL,
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `m_sum_cash` double DEFAULT NULL,
  `m_sum_credit_debit` double DEFAULT NULL,
  `m_sum_others` double DEFAULT NULL,
  `m_total_expenses` double DEFAULT NULL,
  `m_total_discount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_pay_type`
--

DROP TABLE IF EXISTS `bill_pay_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_pay_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_sale`
--

DROP TABLE IF EXISTS `bill_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_sale` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `expense_uid` int DEFAULT '-1',
  `bill_sale_no` varchar(100) DEFAULT NULL,
  `bill_sale_add_datetime` datetime DEFAULT NULL,
  `bill_sale_modify_datetime` datetime DEFAULT NULL,
  `disc_amount` float DEFAULT '0',
  `tax_rate` float DEFAULT '0',
  `tax_amount` float DEFAULT '0',
  `sum_amount_1` float DEFAULT '0',
  `total_amount` float DEFAULT '0',
  `debt_amount` float DEFAULT '0',
  `bill_sale_doc_date` datetime DEFAULT NULL,
  `bill_sale_due_date` datetime DEFAULT NULL,
  `bill_sale_doc_type` int DEFAULT '1',
  `tax_no` varchar(100) DEFAULT NULL,
  `tax_type_id` int DEFAULT '2',
  `exchange_rate` float DEFAULT '1',
  `currency_code` varchar(10) DEFAULT '01',
  `credit_code` varchar(10) DEFAULT 'C07',
  `doc_group` varchar(10) DEFAULT 'BL',
  `bill_sale_status_id` int DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `bill_sale_status_id` (`bill_sale_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_sale_status`
--

DROP TABLE IF EXISTS `bill_sale_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_sale_status` (
  `id` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_summary_report_per_day`
--

DROP TABLE IF EXISTS `bill_summary_report_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_summary_report_per_day` (
  `date` date DEFAULT NULL,
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `total_revenue_cash` double DEFAULT NULL,
  `total_revenue_credit_debit` double DEFAULT NULL,
  `total_revenue_others` double DEFAULT NULL,
  `total_expenses` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bill_type`
--

DROP TABLE IF EXISTS `bill_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bill_type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_head` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage`
--

DROP TABLE IF EXISTS `cage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cage` (
  `cage_id` int NOT NULL AUTO_INCREMENT,
  `cage_name` varchar(20) NOT NULL,
  `cage_price` int NOT NULL,
  `cage_size_id` int NOT NULL DEFAULT '2',
  `cage_status` int NOT NULL DEFAULT '1',
  `cage_price_per_night` float DEFAULT '0',
  `cage_category_id` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`cage_id`),
  KEY `cage_status` (`cage_status`),
  KEY `cage_category_id` (`cage_category_id`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_category`
--

DROP TABLE IF EXISTS `cage_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cage_category` (
  `cage_category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`cage_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_size`
--

DROP TABLE IF EXISTS `cage_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cage_size` (
  `size_id` int NOT NULL AUTO_INCREMENT,
  `size_name` varchar(20) NOT NULL,
  PRIMARY KEY (`size_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cage_status`
--

DROP TABLE IF EXISTS `cage_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cage_status` (
  `cage_status_id` int NOT NULL AUTO_INCREMENT,
  `cage_status_name` varchar(10) NOT NULL,
  PRIMARY KEY (`cage_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashier`
--

DROP TABLE IF EXISTS `cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashier` (
  `cashier_id` int NOT NULL AUTO_INCREMENT,
  `cashier_name` varchar(50) NOT NULL,
  `cashier_detail` varchar(100) DEFAULT NULL,
  `cashier_status` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`cashier_id`),
  KEY `cashier_status` (`cashier_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashier_activity`
--

DROP TABLE IF EXISTS `cashier_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashier_activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cashier_date` date DEFAULT NULL,
  `cashier_id` int DEFAULT '-1',
  `cashier_period_id` int DEFAULT '-1',
  `cashier_activity_status` int DEFAULT '1',
  `cashier_open_datetime` datetime DEFAULT NULL,
  `cashier_close_datetime` datetime DEFAULT NULL,
  `add_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `user_display_name` varchar(64) DEFAULT NULL,
  `heartbeat_datetime` datetime DEFAULT NULL,
  `logged_user_id` int DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `cashier_id` (`cashier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashier_activity_status`
--

DROP TABLE IF EXISTS `cashier_activity_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashier_activity_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashier_period`
--

DROP TABLE IF EXISTS `cashier_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashier_period` (
  `cashier_period_id` int NOT NULL AUTO_INCREMENT,
  `cashier_period_name` varchar(50) DEFAULT NULL,
  `cashier_period_from_time` varchar(5) DEFAULT NULL,
  `cashier_period_to_time` varchar(5) DEFAULT NULL,
  `tomorrow_to_time_flag` tinyint DEFAULT '0',
  PRIMARY KEY (`cashier_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashier_status`
--

DROP TABLE IF EXISTS `cashier_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashier_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `check_payment_type`
--

DROP TABLE IF EXISTS `check_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `check_payment_type` (
  `id` int NOT NULL,
  `name_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checked_pet_history`
--

DROP TABLE IF EXISTS `checked_pet_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checked_pet_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int DEFAULT '-1',
  `queue_uid` int DEFAULT '-1',
  `checked_pet_status` int DEFAULT '1',
  `doctor_id` int DEFAULT '-1',
  `checked_pet_add_datetime` datetime NOT NULL,
  `checked_pet_modify_datetime` datetime NOT NULL,
  `expense_uid` int DEFAULT '-1',
  `room_id` int NOT NULL DEFAULT '-1',
  `doctor_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `queue_uid` (`queue_uid`),
  KEY `expense_uid` (`expense_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `checked_pet_status`
--

DROP TABLE IF EXISTS `checked_pet_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checked_pet_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `checked_pet_status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost`
--

DROP TABLE IF EXISTS `cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cost` (
  `cost_uid` int NOT NULL AUTO_INCREMENT,
  `cost_type` int DEFAULT '0',
  `branch_id` int NOT NULL DEFAULT '1',
  `manufacturer_id` int NOT NULL,
  `cost_id` varchar(100) NOT NULL,
  `cost_payment_id` varchar(200) NOT NULL,
  `bill_id` varchar(100) NOT NULL,
  `stock_uid` int DEFAULT '0',
  `stock_capital_price` int DEFAULT '0',
  `cost_category` int NOT NULL,
  `cost_info` longtext NOT NULL,
  `cost_date` date NOT NULL,
  `cost_date_paid` date NOT NULL,
  `cost_bank` varchar(100) NOT NULL,
  `cost_before_vat` decimal(10,2) NOT NULL,
  `cost_vat` decimal(10,2) NOT NULL,
  `cost_total_vat` decimal(10,2) NOT NULL,
  `cost_no_vat` decimal(10,2) NOT NULL,
  `cost_tax` decimal(10,2) NOT NULL,
  `logged_in_user` int NOT NULL,
  `cost_payment_type` float NOT NULL,
  `cost_number_check` int NOT NULL,
  `cost_interest` float(10,2) NOT NULL,
  `cost_discount` float(10,2) NOT NULL,
  `cost_pay_actual` float(10,2) NOT NULL,
  `cost_pay_vat` float(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cost_uid`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `cost_payment_id` (`cost_payment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `cost_type` (`cost_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost_category`
--

DROP TABLE IF EXISTS `cost_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cost_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cost_payment_type`
--

DROP TABLE IF EXISTS `cost_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cost_payment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_type` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `customerid` varchar(64) NOT NULL,
  `device_token` longtext NOT NULL,
  `userId` longtext NOT NULL,
  `lineUserId` varchar(255) DEFAULT NULL,
  `linePassword` varchar(255) DEFAULT NULL,
  `avatar` varchar(200) NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  `firstname` varchar(64) NOT NULL,
  `lastname` varchar(64) DEFAULT NULL,
  `birthday` varchar(50) NOT NULL,
  `tel_1` varchar(100) DEFAULT NULL,
  `mobile_1` varchar(100) DEFAULT NULL,
  `lineid` varchar(50) NOT NULL,
  `fax_1` varchar(100) DEFAULT NULL,
  `address` text,
  `province` varchar(64) DEFAULT NULL,
  `zipcode` varchar(20) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `otherinfo` varchar(512) DEFAULT NULL,
  `address2` varchar(512) DEFAULT NULL,
  `soi` varchar(64) DEFAULT NULL,
  `road` varchar(64) DEFAULT NULL,
  `tumbon` varchar(64) DEFAULT NULL,
  `ampor` varchar(64) DEFAULT NULL,
  `taxid` varchar(64) DEFAULT NULL,
  `passport` varchar(255) DEFAULT NULL,
  `rating_id` int DEFAULT '0',
  `is_auto_upgrade` tinyint(1) DEFAULT '1',
  `branch_id` int DEFAULT NULL,
  `note` longtext,
  PRIMARY KEY (`uid`),
  KEY `customerid` (`customerid`),
  KEY `idx_customer_branch_uid` (`branch_id`,`uid`),
  KEY `idx_customer_search` (`firstname`,`tel_1`,`mobile_1`),
  KEY `idx_customer_branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19518 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_deposit`
--

DROP TABLE IF EXISTS `customer_deposit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_deposit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cuid` int NOT NULL,
  `deposit` decimal(15,2) NOT NULL,
  `modify_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cuid` (`cuid`)
) ENGINE=InnoDB AUTO_INCREMENT=8378 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_rating`
--

DROP TABLE IF EXISTS `customer_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_rating` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `point` int NOT NULL,
  `minimum` int DEFAULT NULL,
  `is_auto_upgrade` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_rating_item`
--

DROP TABLE IF EXISTS `customer_rating_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_rating_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rating_id` int NOT NULL,
  `stock_type_id` int NOT NULL,
  `stock_sub_category_id` int NOT NULL,
  `percent` int NOT NULL,
  `timestamp` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_registration`
--

DROP TABLE IF EXISTS `customer_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_registration` (
  `cuid` int NOT NULL AUTO_INCREMENT,
  `registration_datetime` datetime NOT NULL,
  PRIMARY KEY (`cuid`)
) ENGINE=InnoDB AUTO_INCREMENT=19518 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_special`
--

DROP TABLE IF EXISTS `customer_special`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_special` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `cuid` int NOT NULL,
  `reward` int NOT NULL,
  `discount_petshop` int NOT NULL,
  `discount_saline` int NOT NULL,
  `discount_equipment` int NOT NULL,
  `discount_other` int NOT NULL,
  `discount_lap` int NOT NULL,
  `discount_surgical` int NOT NULL,
  `discount_diagnose` int NOT NULL,
  `discount_medicines` int NOT NULL,
  `expire_datetime` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `cuid` (`cuid`)
) ENGINE=InnoDB AUTO_INCREMENT=16591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cutting_stock_mode`
--

DROP TABLE IF EXISTS `cutting_stock_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cutting_stock_mode` (
  `mode_id` int NOT NULL AUTO_INCREMENT,
  `mode_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `df_item_exclude_status`
--

DROP TABLE IF EXISTS `df_item_exclude_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_item_exclude_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `df_items_exclude_list`
--

DROP TABLE IF EXISTS `df_items_exclude_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_items_exclude_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `df_item_exclude_id` varchar(50) DEFAULT NULL,
  `df_item_exclude_detail` varchar(125) DEFAULT NULL,
  `add_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `df_item_exclude_status` tinyint DEFAULT '1',
  `df_item_level` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `df_item_exclude_status` (`df_item_exclude_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `df_rate`
--

DROP TABLE IF EXISTS `df_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `df_rate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_price` float DEFAULT '0',
  `to_price` float DEFAULT '0',
  `df_price` float DEFAULT '0',
  `cashier_period_id` int DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `cashier_period_id` (`cashier_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diagnose`
--

DROP TABLE IF EXISTS `diagnose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnose` (
  `diagnose_id` int NOT NULL AUTO_INCREMENT,
  `diagnose_name` varchar(200) NOT NULL,
  `diagnose_content` text NOT NULL,
  `history` text NOT NULL,
  `cost_dog` longtext NOT NULL,
  `cost_cat` longtext NOT NULL,
  `diagnose_status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recomment` text NOT NULL,
  `results` text NOT NULL,
  `checkbox_diagnose` int NOT NULL,
  PRIMARY KEY (`diagnose_id`),
  KEY `diagnose_status` (`diagnose_status`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `differtial_system`
--

DROP TABLE IF EXISTS `differtial_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `differtial_system` (
  `id` int NOT NULL AUTO_INCREMENT,
  `system_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `differtial_system_disease`
--

DROP TABLE IF EXISTS `differtial_system_disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `differtial_system_disease` (
  `id` int NOT NULL AUTO_INCREMENT,
  `system_id` int NOT NULL,
  `disease_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=854 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_label_eat_unit`
--

DROP TABLE IF EXISTS `drug_label_eat_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_label_eat_unit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(10) NOT NULL,
  `unit_name_en` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_room`
--

DROP TABLE IF EXISTS `drug_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_room` (
  `rx_req_id` int NOT NULL AUTO_INCREMENT,
  `rx_req_daily_id` varchar(10) DEFAULT NULL,
  `expense_uid` int NOT NULL DEFAULT '-1',
  `drug_room_status_id` int NOT NULL DEFAULT '-1',
  `rx_req_datetime` datetime DEFAULT NULL,
  `rx_req_modify_datetime` datetime DEFAULT NULL,
  `rx_done_user_id` int DEFAULT '-1',
  `rx_req_user_id` int DEFAULT '-1',
  PRIMARY KEY (`rx_req_id`),
  KEY `rx_req_daily_id` (`rx_req_daily_id`),
  KEY `drug_room_status_id` (`drug_room_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug_room_status`
--

DROP TABLE IF EXISTS `drug_room_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drug_room_status` (
  `id` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense` (
  `expense_uid` int NOT NULL AUTO_INCREMENT,
  `expense_id` varchar(50) DEFAULT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `room_id` int DEFAULT '0',
  `doctor_id` int NOT NULL,
  `pet_uid` int NOT NULL DEFAULT '-1',
  `expense_for_date` date DEFAULT NULL,
  `expense_total_net_price` float(10,2) DEFAULT NULL,
  `expense_status` int DEFAULT '-1',
  `expense_type` int NOT NULL DEFAULT '-1',
  `expense_add_datetime` datetime DEFAULT NULL,
  `expense_modify_datetime` datetime DEFAULT NULL,
  `expense_total_remaining` float(10,2) DEFAULT NULL,
  `expense_total_deposit` float NOT NULL DEFAULT '0',
  `expense_total_deposit_remaining` float NOT NULL DEFAULT '0',
  `expense_total_discount` float(10,2) DEFAULT NULL,
  `return_money_to_customer` float DEFAULT '0',
  `expense_vat` float NOT NULL DEFAULT '0',
  `expense_total_non_vat_price` float(10,2) DEFAULT NULL,
  `expense_total_vatable` float(10,2) DEFAULT NULL,
  `expense_vat_percentage` float DEFAULT '7',
  `calculate_vat_flag` tinyint DEFAULT '1',
  `expense_total_other_discount` float DEFAULT '0',
  `expense_vat_type_id` int NOT NULL DEFAULT '1',
  `receive_medicine_id` int NOT NULL,
  `create_date_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`expense_uid`),
  KEY `expense_id` (`expense_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_type` (`expense_type`),
  KEY `expense_status` (`expense_status`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_expense_branch_medicine` (`branch_id`,`receive_medicine_id`,`expense_uid`),
  KEY `idx_expense_branch_datetime_status` (`branch_id`,`expense_add_datetime`,`expense_status`,`expense_type`),
  KEY `idx_expense_pet_uid` (`pet_uid`),
  KEY `idx_expense_add_datetime_branch` (`expense_add_datetime`,`branch_id`),
  KEY `idx_expense_add_datetime_status` (`expense_add_datetime`,`expense_status`),
  KEY `idx_expense_modify_datetime_branch` (`expense_modify_datetime`,`branch_id`),
  KEY `idx_expense_modify_datetime_status` (`expense_modify_datetime`,`expense_status`),
  KEY `idx_expense_branch` (`branch_id`),
  KEY `idx_expense_pet_status` (`pet_uid`,`expense_status`)
) ENGINE=InnoDB AUTO_INCREMENT=158915 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expense_admit_info`
--

DROP TABLE IF EXISTS `expense_admit_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_admit_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `expense_uid` int NOT NULL,
  `admit_since_date` datetime DEFAULT NULL,
  `admit_to_date` datetime DEFAULT NULL,
  `admit_per_night_price` float NOT NULL DEFAULT '0',
  `discount_percentage` float NOT NULL DEFAULT '0',
  `total_net_price` float NOT NULL DEFAULT '0',
  `no_to_admit_date_flag` tinyint NOT NULL DEFAULT '0',
  `payment_status` int NOT NULL DEFAULT '1',
  `logged_user_id` int DEFAULT '-1',
  `added_timestamp` datetime DEFAULT NULL,
  `modify_timestamp` datetime DEFAULT NULL,
  `discount_price` float NOT NULL DEFAULT '0',
  `discard_price_cal_flag` tinyint NOT NULL DEFAULT '0',
  `exclude_vat_flag` tinyint NOT NULL DEFAULT '0',
  `calculate_vat_flag` tinyint DEFAULT '1',
  `vat_percentage` float DEFAULT '7',
  `vat` float DEFAULT '0',
  `vatable` float DEFAULT '0',
  `bill_uid` int DEFAULT '-1',
  `admit_type` int DEFAULT '-1',
  `admit_history_id` int DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `expense_uid` (`expense_uid`),
  KEY `payment_status` (`payment_status`),
  KEY `bill_uid` (`bill_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expense_status`
--

DROP TABLE IF EXISTS `expense_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expense_tax`
--

DROP TABLE IF EXISTS `expense_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_tax` (
  `expense_uid` int NOT NULL AUTO_INCREMENT,
  `expense_id` varchar(50) DEFAULT NULL,
  `pet_uid` int NOT NULL DEFAULT '-1',
  `expense_for_date` date DEFAULT NULL,
  `expense_total_net_price` float NOT NULL DEFAULT '0',
  `expense_status` int DEFAULT '-1',
  `expense_type` int NOT NULL DEFAULT '-1',
  `expense_add_datetime` datetime DEFAULT NULL,
  `expense_modify_datetime` datetime DEFAULT NULL,
  `expense_total_remaining` float NOT NULL DEFAULT '0',
  `expense_total_deposit` float NOT NULL DEFAULT '0',
  `expense_total_deposit_remaining` float NOT NULL DEFAULT '0',
  `expense_total_discount` float NOT NULL DEFAULT '0',
  `return_money_to_customer` float DEFAULT '0',
  `expense_vat` float NOT NULL DEFAULT '0',
  `expense_total_non_vat_price` float NOT NULL DEFAULT '0',
  `expense_total_vatable` float NOT NULL DEFAULT '0',
  `expense_vat_percentage` float DEFAULT '7',
  `calculate_vat_flag` tinyint DEFAULT '1',
  `expense_total_other_discount` float DEFAULT '0',
  `expense_vat_type_id` int NOT NULL DEFAULT '1',
  `expense_id_for_tax` varchar(50) DEFAULT NULL,
  `reserved_account_id` int NOT NULL,
  `expense_tax_status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`expense_uid`),
  KEY `expense_id` (`expense_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_status` (`expense_status`),
  KEY `expense_type` (`expense_type`),
  KEY `expense_tax_status` (`expense_tax_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expense_tax_status`
--

DROP TABLE IF EXISTS `expense_tax_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_tax_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expense_type`
--

DROP TABLE IF EXISTS `expense_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(40) NOT NULL,
  `quick_type` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expired_check_approval`
--

DROP TABLE IF EXISTS `expired_check_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expired_check_approval` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expired_md_status`
--

DROP TABLE IF EXISTS `expired_md_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expired_md_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_status` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expired_md_type`
--

DROP TABLE IF EXISTS `expired_md_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expired_md_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_type` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expired_medicine`
--

DROP TABLE IF EXISTS `expired_medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expired_medicine` (
  `expired_md_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `expired_md_id` varchar(200) NOT NULL,
  `expired_md_type` int NOT NULL,
  `expired_md_status` int NOT NULL,
  `check_approval_user` int NOT NULL,
  `user_login` int NOT NULL,
  `expired_md_datetime` datetime NOT NULL,
  `expired_md_modify_datetime` datetime NOT NULL,
  `approval_datetime` datetime NOT NULL,
  `description` varchar(200) NOT NULL,
  `check_approval_status` int NOT NULL,
  PRIMARY KEY (`expired_md_uid`),
  KEY `expired_md_id` (`expired_md_id`),
  KEY `expired_md_type` (`expired_md_type`),
  KEY `expired_md_status` (`expired_md_status`),
  KEY `check_approval_status` (`check_approval_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expired_medicine_list`
--

DROP TABLE IF EXISTS `expired_medicine_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expired_medicine_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `expired_md_uid` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `exp_list_stock_type_id` int NOT NULL,
  `exp_list_sub_category_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `exp_list_id` varchar(200) NOT NULL,
  `exp_list_name` varchar(200) NOT NULL,
  `exp_list_unit` varchar(11) NOT NULL,
  `exp_list_qty` float(10,2) NOT NULL,
  `exp_list_cost` float(10,2) NOT NULL,
  `exp_list_total_cost` float(10,2) NOT NULL,
  `exp_list_status` int NOT NULL,
  `add_date` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expired_md_uid` (`expired_md_uid`),
  KEY `exp_list_stock_type_id` (`exp_list_stock_type_id`),
  KEY `exp_list_stock_type_id_2` (`exp_list_stock_type_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `exp_list_id` (`exp_list_id`),
  KEY `exp_list_sub_category_id` (`exp_list_sub_category_id`),
  KEY `exp_list_status` (`exp_list_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expired_medicine_list_status`
--

DROP TABLE IF EXISTS `expired_medicine_list_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expired_medicine_list_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_status` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `food_and_drug`
--

DROP TABLE IF EXISTS `food_and_drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_and_drug` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `add_datetime` date NOT NULL,
  `grantee` varchar(200) NOT NULL,
  `licenses` varchar(200) NOT NULL,
  `category` varchar(200) NOT NULL,
  `foodanddrug_type_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `foodanddrug_type_id` (`foodanddrug_type_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `foodanddrug_type`
--

DROP TABLE IF EXISTS `foodanddrug_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foodanddrug_type` (
  `foodanddrug_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`foodanddrug_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gateway_type`
--

DROP TABLE IF EXISTS `gateway_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateway_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `general_item_unit`
--

DROP TABLE IF EXISTS `general_item_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `general_item_unit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(20) NOT NULL,
  `unit_name_en` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_voucher`
--

DROP TABLE IF EXISTS `gift_voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_voucher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_amount` int NOT NULL,
  `type` int NOT NULL,
  `percent` int NOT NULL,
  `discount` float(10,2) NOT NULL,
  `expire` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_voucher_code`
--

DROP TABLE IF EXISTS `gift_voucher_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_voucher_code` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gift_id` int NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_voucher_item`
--

DROP TABLE IF EXISTS `gift_voucher_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_voucher_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gift_id` int NOT NULL,
  `stock_type_id` int NOT NULL,
  `stock_sub_category_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_note`
--

DROP TABLE IF EXISTS `global_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `global_note` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `main_id` int NOT NULL,
  `main_type` varchar(100) NOT NULL,
  `note` longblob,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grooming_style`
--

DROP TABLE IF EXISTS `grooming_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grooming_style` (
  `grooming_style_id` int NOT NULL AUTO_INCREMENT,
  `grooming_name` varchar(100) NOT NULL,
  `grooming_img` varchar(200) NOT NULL,
  PRIMARY KEY (`grooming_style_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `heal`
--

DROP TABLE IF EXISTS `heal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heal` (
  `heal_id` int NOT NULL AUTO_INCREMENT,
  `diagnose_id` int NOT NULL,
  `heal_content` longtext NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`heal_id`),
  KEY `diagnose_id` (`diagnose_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital` (
  `hos_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `hos_name_th` varchar(200) NOT NULL,
  `hos_name_en` varchar(200) NOT NULL,
  `header_color` varchar(50) NOT NULL,
  `font_color` varchar(50) NOT NULL,
  `hos_status` int NOT NULL,
  `footer_title` varchar(300) NOT NULL,
  `hos_point` int NOT NULL,
  `hos_reward` int NOT NULL,
  `hos_logo` varchar(300) NOT NULL,
  `hos_logo_print` varchar(255) DEFAULT NULL,
  `hos_logo_drug` varchar(255) DEFAULT NULL,
  `is_default` int NOT NULL,
  `hos_company` varchar(255) NOT NULL,
  `hos_company_en` varchar(255) NOT NULL,
  `hos_address` varchar(255) NOT NULL,
  `hos_tax_id` varchar(50) NOT NULL,
  `hos_phone` varchar(20) NOT NULL,
  `hos_bill_format` int DEFAULT '1',
  `set_category_tax` varchar(200) NOT NULL,
  `set_opd_required` int DEFAULT '0',
  `set_opd_fixed_required` int DEFAULT '0',
  `set_opd_fixed_double_required` int DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `set_change_price` int DEFAULT '1',
  `set_print_expense` int DEFAULT '0',
  `set_print_extra_point` int DEFAULT '1',
  `set_alert_menu_waiting` int NOT NULL DEFAULT '1',
  `is_auto_upgrade_type` tinyint(1) DEFAULT '0',
  `is_auto_date_start` timestamp NULL DEFAULT NULL,
  `is_auto_date_end` timestamp NULL DEFAULT NULL,
  `is_button_block` tinyint(1) NOT NULL DEFAULT '1',
  `json_setting_stock_profit` varchar(255) DEFAULT '{"low_start": "0", "low_end": "40", "mid_start": "41", "mid_end": "79", "high_start": "80", "high_end": "100"}',
  PRIMARY KEY (`hos_id`),
  KEY `is_default` (`is_default`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_opd_required_log`
--

DROP TABLE IF EXISTS `hospital_opd_required_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_opd_required_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `user_id` int NOT NULL,
  `set_opd_required_type` int NOT NULL DEFAULT '1',
  `set_opd_required` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_open_time`
--

DROP TABLE IF EXISTS `hospital_open_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_open_time` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` int NOT NULL DEFAULT '-1',
  `open_time` varchar(5) DEFAULT NULL,
  `close_time` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_open_time_type`
--

DROP TABLE IF EXISTS `hospital_open_time_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_open_time_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_room`
--

DROP TABLE IF EXISTS `hospital_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_room` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_name` varchar(30) NOT NULL,
  `room_name_en` varchar(255) NOT NULL,
  `room_type` int NOT NULL,
  `room_status` int NOT NULL DEFAULT '1',
  `branch_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`room_id`),
  KEY `room_status` (`room_status`),
  KEY `room_type` (`room_type`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_room_type`
--

DROP TABLE IF EXISTS `hospital_room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_room_type` (
  `room_type_id` int NOT NULL AUTO_INCREMENT,
  `room_type_name` varchar(15) NOT NULL,
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_set_change_price_log`
--

DROP TABLE IF EXISTS `hospital_set_change_price_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_set_change_price_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `user_id` int NOT NULL,
  `data` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hospital_setting`
--

DROP TABLE IF EXISTS `hospital_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospital_setting` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(225) NOT NULL,
  `setting_value` varchar(225) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexx_pdf_reports`
--

DROP TABLE IF EXISTS `idexx_pdf_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idexx_pdf_reports` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `lab_request_id` int DEFAULT '-1',
  `report_date` date DEFAULT NULL,
  `report_time` varchar(5) DEFAULT NULL,
  `report_status` int DEFAULT '3',
  `report_name` varchar(512) DEFAULT NULL,
  `report_path` varchar(1024) DEFAULT NULL,
  `report_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  KEY `lab_request_id` (`lab_request_id`),
  KEY `report_status` (`report_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `idexx_requisition_number`
--

DROP TABLE IF EXISTS `idexx_requisition_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `idexx_requisition_number` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `number` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1999 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incoming_stock_info`
--

DROP TABLE IF EXISTS `incoming_stock_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incoming_stock_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lot_id` varchar(100) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `incoming_date` date DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `incoming_stock_number` float DEFAULT '0',
  `stock_uid` int NOT NULL,
  `other_info` varchar(30) DEFAULT NULL,
  `is_checked` tinyint DEFAULT '0',
  `purchase_price` float(11,2) DEFAULT '0.00',
  `incoming_stock_unit_id` int DEFAULT '-1',
  `total_cutting_stock_number` float DEFAULT '0',
  `cutting_stock_number_per_each` int DEFAULT '0',
  `everage_purchase_price_per_each` float DEFAULT '0',
  `is_add_to_stock` tinyint DEFAULT '1',
  `calculate_cost_flag` int DEFAULT '2',
  `manufacturer_id` int DEFAULT '-1',
  `current_logged_user_id` int DEFAULT '-1',
  `received_stock_bill_uid` int NOT NULL DEFAULT '-1',
  `stock_warehouse_id` int DEFAULT '-1',
  `total_discount` float DEFAULT '0',
  `stock_unit_price` float DEFAULT '0',
  `vat_total` float DEFAULT '0',
  `non_vat_flag` tinyint DEFAULT '0',
  `vat_rate` float DEFAULT '7',
  `vatable` float DEFAULT '0',
  `vat_type` int DEFAULT '0',
  `mfg_date` date DEFAULT NULL,
  `reference_id` varchar(100) DEFAULT NULL,
  `lot_number` varchar(100) DEFAULT NULL,
  `total_current` float(11,2) DEFAULT NULL,
  `total_current_old` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lot_id` (`lot_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `received_stock_bill_uid` (`received_stock_bill_uid`),
  KEY `idx_incoming_stock_uid` (`stock_uid`),
  KEY `idx_incoming_stock_uid_expired` (`stock_uid`,`expired_date`)
) ENGINE=InnoDB AUTO_INCREMENT=31483 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_group`
--

DROP TABLE IF EXISTS `lab_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_group` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_item_request_status`
--

DROP TABLE IF EXISTS `lab_item_request_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_item_request_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_items_info`
--

DROP TABLE IF EXISTS `lab_items_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_items_info` (
  `lab_item_id` int NOT NULL AUTO_INCREMENT,
  `lab_item_name` varchar(100) NOT NULL,
  `lab_group_id` int NOT NULL DEFAULT '-1',
  `related_stock_uid` int DEFAULT '-1',
  `has_sub_items` tinyint DEFAULT '0',
  `normal_value_canine` varchar(255) DEFAULT NULL,
  `normal_value_feline` varchar(255) DEFAULT NULL,
  `normal_value_others` varchar(255) DEFAULT NULL,
  `lab_item_unit` varchar(100) DEFAULT NULL,
  `form_id` int DEFAULT '-1',
  PRIMARY KEY (`lab_item_id`),
  KEY `lab_group_id` (`lab_group_id`),
  KEY `related_stock_uid` (`related_stock_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_items_request`
--

DROP TABLE IF EXISTS `lab_items_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_items_request` (
  `lab_item_request_id` int NOT NULL AUTO_INCREMENT,
  `lab_item_id` int NOT NULL DEFAULT '-1',
  `lab_request_id` int NOT NULL DEFAULT '-1',
  `info_1` varchar(100) DEFAULT NULL,
  `info_2` varchar(100) DEFAULT NULL,
  `opd_payment_item_id` int DEFAULT '-1',
  `lab_item_result` varchar(255) DEFAULT NULL,
  `add_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `lab_item_request_status` int DEFAULT '1',
  `lab_vendor_id` int DEFAULT '-1',
  PRIMARY KEY (`lab_item_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_request`
--

DROP TABLE IF EXISTS `lab_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_request` (
  `lab_request_id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL DEFAULT '-1',
  `opd_id` int DEFAULT '-1',
  `expense_uid` int DEFAULT '-1',
  `lab_request_status` int DEFAULT '0',
  `lab_request_user_id` int DEFAULT '-1',
  `lab_request_datetime` datetime DEFAULT NULL,
  `lab_request_modify_datetime` datetime DEFAULT NULL,
  `lab_officer_user_id` int DEFAULT '-1',
  `lab_officer_verify_user_id` int DEFAULT '-1',
  `lab_vendor_id` int DEFAULT '-1',
  `lab_detail` varchar(1000) DEFAULT NULL,
  `lab_result_datetime` datetime DEFAULT NULL,
  `lab_result_open_status` tinyint DEFAULT '0',
  `lab_result_opened_user_id` int DEFAULT '-1',
  `report_path` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`lab_request_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `opd_id` (`opd_id`),
  KEY `expense_uid` (`expense_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_request_status`
--

DROP TABLE IF EXISTS `lab_request_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_request_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_sub_item_request`
--

DROP TABLE IF EXISTS `lab_sub_item_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_sub_item_request` (
  `lab_sub_item_request_id` int NOT NULL AUTO_INCREMENT,
  `lab_item_request_id` int NOT NULL DEFAULT '-1',
  `lab_sub_item_id` int DEFAULT '-1',
  `lab_sub_item_result` varchar(255) DEFAULT NULL,
  `add_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `lab_item_request_status` int DEFAULT '1',
  PRIMARY KEY (`lab_sub_item_request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_sub_items_info`
--

DROP TABLE IF EXISTS `lab_sub_items_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_sub_items_info` (
  `lab_sub_item_id` int NOT NULL AUTO_INCREMENT,
  `lab_sub_item_name` varchar(100) NOT NULL,
  `lab_item_id` int DEFAULT '-1',
  `lab_sub_item_unit` varchar(100) DEFAULT NULL,
  `lab_sub_item_normal_value_canine` varchar(255) DEFAULT NULL,
  `lab_sub_item_normal_value_feline` varchar(255) DEFAULT NULL,
  `lab_sub_item_normal_value_others` varchar(255) DEFAULT NULL,
  `form_id` int DEFAULT '-1',
  PRIMARY KEY (`lab_sub_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lab_vendor`
--

DROP TABLE IF EXISTS `lab_vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lab_vendor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line` (
  `idLine` varchar(50) NOT NULL,
  `cuid` varchar(30) NOT NULL,
  `cups` varchar(200) NOT NULL,
  PRIMARY KEY (`idLine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_setting`
--

DROP TABLE IF EXISTS `line_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_setting` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `line_name` varchar(255) NOT NULL,
  `branch_id` varchar(15) DEFAULT NULL,
  `line_mode` varchar(255) DEFAULT NULL,
  `line_data` text NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_setting_richmenu`
--

DROP TABLE IF EXISTS `line_setting_richmenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_setting_richmenu` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` varchar(15) DEFAULT NULL,
  `position_name` varchar(255) NOT NULL,
  `position_a` varchar(255) DEFAULT NULL,
  `position_b` varchar(255) DEFAULT NULL,
  `position_c` varchar(255) DEFAULT NULL,
  `position_d` varchar(255) DEFAULT NULL,
  `position_e` varchar(255) DEFAULT NULL,
  `position_f` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `richmenu_line_id` varchar(255) DEFAULT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_queue`
--

DROP TABLE IF EXISTS `log_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_queue` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `queue_uid` int NOT NULL,
  `pet_uid` int NOT NULL,
  `queue_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `doctor_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `log_queue_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_datetime` datetime DEFAULT NULL,
  `opd_datetime` datetime DEFAULT NULL,
  `expense_datetime` datetime DEFAULT NULL,
  `treat_datetime` datetime DEFAULT NULL,
  `start_datetime` datetime DEFAULT NULL,
  `finish_datetime` timestamp NULL DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `queue_uid` (`queue_uid`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_log_queue_timestamp_branch` (`timestamp`,`branch_id`,`queue_type`)
) ENGINE=InnoDB AUTO_INCREMENT=128828 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manufacturer_contact_info`
--

DROP TABLE IF EXISTS `manufacturer_contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturer_contact_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `manufacturer_name` varchar(100) NOT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_number` varchar(100) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `address` varchar(512) DEFAULT NULL,
  `tax_id` varchar(50) DEFAULT NULL,
  `reference_info_1` varchar(200) DEFAULT NULL,
  `reference_info_2` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=558 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_uid` int NOT NULL DEFAULT '-1',
  `pet_uid` int DEFAULT '-1',
  `member_start_date` date DEFAULT NULL,
  `member_end_date` date DEFAULT NULL,
  `forever_flag` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `customer_uid` (`customer_uid`),
  KEY `pet_uid` (`pet_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_discount`
--

DROP TABLE IF EXISTS `member_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `stock_type_id` int NOT NULL,
  `discount_percentage` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_status`
--

DROP TABLE IF EXISTS `member_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_open`
--

DROP TABLE IF EXISTS `menu_open`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_open` (
  `menu_id` int NOT NULL AUTO_INCREMENT,
  `menu_group` varchar(255) DEFAULT NULL,
  `menu_main` varchar(255) DEFAULT NULL,
  `menu_sub` varchar(255) DEFAULT NULL,
  `is_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_open_block`
--

DROP TABLE IF EXISTS `menu_open_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_open_block` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `url` text NOT NULL,
  `users` text NOT NULL,
  `branch` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `version` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ml_price_scheme`
--

DROP TABLE IF EXISTS `ml_price_scheme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ml_price_scheme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int NOT NULL,
  `ml_price_name` varchar(100) NOT NULL,
  `ml_price_type_id` int NOT NULL,
  `ml_price` float NOT NULL DEFAULT '0',
  `ml_use` float NOT NULL DEFAULT '0',
  `ml_use_to` float NOT NULL DEFAULT '0',
  `flag_ceil_float_ml_use` tinyint NOT NULL DEFAULT '1',
  `ml_special_price` float DEFAULT '0',
  `ml_unit_type` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `ml_price_type_id` (`ml_price_type_id`),
  KEY `idx_mlps_stock_uid` (`stock_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=985 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ml_price_type`
--

DROP TABLE IF EXISTS `ml_price_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ml_price_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ml_price_type_name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ml_unit_type`
--

DROP TABLE IF EXISTS `ml_unit_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ml_unit_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `multiple_payment_info`
--

DROP TABLE IF EXISTS `multiple_payment_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multiple_payment_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cash_amount` float NOT NULL DEFAULT '0',
  `credit_debit_amount` float NOT NULL DEFAULT '0',
  `cheque_amount` float NOT NULL DEFAULT '0',
  `money_transfer_amount` float NOT NULL DEFAULT '0',
  `total_amount` float NOT NULL DEFAULT '0',
  `bill_history_uid` int NOT NULL DEFAULT '-1',
  `credit_debit_machine_type` varchar(64) DEFAULT NULL,
  `credit_debit_id` varchar(64) DEFAULT NULL,
  `cheque_id` varchar(64) DEFAULT NULL,
  `cheque_bank` varchar(64) DEFAULT NULL,
  `money_transfer_bank_account` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd`
--

DROP TABLE IF EXISTS `opd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd` (
  `opd_id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `queue_uid` int NOT NULL,
  `expense_uid` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `opd_datetime` datetime DEFAULT NULL,
  `opd_add_datetime` datetime DEFAULT NULL,
  `opd_modify_datetime` datetime DEFAULT NULL,
  `doctor_id` int NOT NULL DEFAULT '-1',
  `room_id` int NOT NULL DEFAULT '-1',
  `opd_T` float DEFAULT NULL,
  `opd_P` float DEFAULT NULL,
  `opd_R` float DEFAULT NULL,
  `opd_weight_kg` float DEFAULT NULL,
  `opd_html_detail` mediumtext,
  `opd_status` int DEFAULT '1',
  `logged_in_user_id` int DEFAULT '-1',
  `assistant_user_id` int DEFAULT '-1',
  `is_opd_editable` tinyint DEFAULT '1',
  `opd_pain_score` varchar(10) DEFAULT NULL,
  `opd_cc` varchar(1024) DEFAULT NULL,
  `opd_ht` varchar(1024) DEFAULT NULL,
  `opd_pe_head_to_tail_list` varchar(128) DEFAULT NULL,
  `opd_pe` varchar(1024) DEFAULT NULL,
  `opd_dx` varchar(1024) DEFAULT NULL,
  `opd_final_diag` varchar(1024) DEFAULT NULL,
  `opd_client_education` varchar(1024) DEFAULT NULL,
  `opd_bcs` varchar(20) DEFAULT NULL,
  `opd_pe_c1` int DEFAULT '-1',
  `opd_pe_c2` int DEFAULT '-1',
  `opd_pe_c3` int DEFAULT '-1',
  `opd_pe_c4` int DEFAULT '-1',
  `opd_pe_c5` int DEFAULT '-1',
  `opd_pe_c6` int DEFAULT '-1',
  `opd_pe_c7` int DEFAULT '-1',
  `opd_pe_c8` int DEFAULT '-1',
  `opd_pe_c9` int DEFAULT '-1',
  `opd_pe_c10` int DEFAULT '-1',
  `opd_pe_c11` int DEFAULT '-1',
  `opd_pe_c12` int DEFAULT '-1',
  `opd_pe_c13` int DEFAULT '-1',
  `is_editing` tinyint DEFAULT '0',
  `doctor_name` varchar(100) DEFAULT NULL,
  `assistant_user_id_2` int DEFAULT '-1',
  `suggestion` longtext NOT NULL,
  `reportlab` longtext NOT NULL,
  `assistant_1` int DEFAULT NULL,
  `assistant_2` int DEFAULT NULL,
  `logged_in_user` int DEFAULT NULL,
  `opd_review_checked` int DEFAULT NULL,
  PRIMARY KEY (`opd_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `queue_uid` (`queue_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `opd_status` (`opd_status`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_opd_queue_status` (`queue_uid`,`opd_status`),
  KEY `idx_opd_branch_status` (`branch_id`,`opd_status`),
  KEY `idx_opd_pet_uid` (`pet_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=116250 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_add_cut_stock`
--

DROP TABLE IF EXISTS `opd_add_cut_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_add_cut_stock` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `item_uid` int NOT NULL,
  `related_item_id` int NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `opd_id` (`opd_id`),
  KEY `item_uid` (`item_uid`),
  KEY `related_item_id` (`related_item_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_differtial_diagnosis`
--

DROP TABLE IF EXISTS `opd_differtial_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_differtial_diagnosis` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1242 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_differtial_diagnosis_item`
--

DROP TABLE IF EXISTS `opd_differtial_diagnosis_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_differtial_diagnosis_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `differtial_id` int NOT NULL,
  `system_id` int NOT NULL,
  `disease_id` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_expense_info`
--

DROP TABLE IF EXISTS `opd_expense_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_expense_info` (
  `pet_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL DEFAULT '0',
  `expense_uid` int NOT NULL DEFAULT '0',
  `expense_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pet_uid`),
  KEY `opd_id` (`opd_id`),
  KEY `expense_uid` (`expense_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_eye`
--

DROP TABLE IF EXISTS `opd_eye`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_eye` (
  `eye_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `image` longtext NOT NULL,
  `cotton_ball_left` varchar(200) NOT NULL,
  `cotton_ball_right` varchar(200) NOT NULL,
  `dazzle_left` varchar(200) NOT NULL,
  `dazzle_right` varchar(200) NOT NULL,
  `direct_PLR_left` varchar(200) NOT NULL,
  `direct_PLR_right` varchar(200) NOT NULL,
  `indirect_PLR_left` varchar(200) NOT NULL,
  `indirect_PLR_right` varchar(200) NOT NULL,
  `light_reflex_left` varchar(200) NOT NULL,
  `light_reflex_right` varchar(200) NOT NULL,
  `menance_left` varchar(200) NOT NULL,
  `menance_right` varchar(200) NOT NULL,
  `pupil_size_left` varchar(200) NOT NULL,
  `pupil_size_right` varchar(200) NOT NULL,
  `response_left` varchar(200) NOT NULL,
  `response_right` varchar(200) NOT NULL,
  `turn_off_light_left` varchar(200) NOT NULL,
  `turn_off_light_right` varchar(200) NOT NULL,
  `fundic_exam_left` text NOT NULL,
  `fundic_exam_right` text NOT NULL,
  `exam_left` text NOT NULL,
  `exam_right` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`eye_uid`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_eye_cut_stock`
--

DROP TABLE IF EXISTS `opd_eye_cut_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_eye_cut_stock` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `contentleft` varchar(200) NOT NULL,
  `contentright` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `opd_id` (`opd_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3696 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_final_diagnosis`
--

DROP TABLE IF EXISTS `opd_final_diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_final_diagnosis` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `content` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1066 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_final_diagnosis_item`
--

DROP TABLE IF EXISTS `opd_final_diagnosis_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_final_diagnosis_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `final_id` int NOT NULL,
  `system_id` int NOT NULL,
  `disease_id` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_history`
--

DROP TABLE IF EXISTS `opd_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `content` longblob,
  `canvas` longtext,
  `word_tags` longtext,
  `word_results` longtext,
  `opd_id` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`history_id`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115974 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_history_tags`
--

DROP TABLE IF EXISTS `opd_history_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_history_tags` (
  `h_tag_id` int NOT NULL AUTO_INCREMENT,
  `h_tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `h_tag_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`h_tag_id`),
  FULLTEXT KEY `h_tag_name` (`h_tag_name`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_history_tags_user`
--

DROP TABLE IF EXISTS `opd_history_tags_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_history_tags_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_lab`
--

DROP TABLE IF EXISTS `opd_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_lab` (
  `lab_id` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `pet_uid` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `lab_type_id` int NOT NULL,
  `product` longtext NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `lab_status` int DEFAULT NULL,
  `is_idexx` int DEFAULT '0',
  `logged_in_user` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`lab_id`),
  KEY `opd_id` (`opd_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `lab_type_id` (`lab_type_id`),
  KEY `status` (`status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15844 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_modify_history`
--

DROP TABLE IF EXISTS `opd_modify_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_modify_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `doctor_id` int NOT NULL DEFAULT '-1',
  `modify_datetime` datetime NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_neuro`
--

DROP TABLE IF EXISTS `opd_neuro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_neuro` (
  `neuro_id` int NOT NULL AUTO_INCREMENT,
  `observation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `neuro_symptom` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `palpation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `postural` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `spinal` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cranial` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sensation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `opd_id` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`neuro_id`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=738 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_notifications`
--

DROP TABLE IF EXISTS `opd_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_notifications` (
  `noti_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `content` longblob,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`noti_uid`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29511 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_payment_item`
--

DROP TABLE IF EXISTS `opd_payment_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_payment_item` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `room_id` int DEFAULT '0',
  `opd_id` int NOT NULL DEFAULT '-1',
  `surgery_uid` int NOT NULL,
  `admit_id` int NOT NULL,
  `lab_opd_id` int DEFAULT '0',
  `lab_admit_id` int DEFAULT '0',
  `lab_surgery_id` int DEFAULT '0',
  `stock_uid` int NOT NULL DEFAULT '-1',
  `related_stock_info_id` int NOT NULL,
  `stock_type_id` int DEFAULT NULL,
  `stock_id` varchar(50) DEFAULT NULL,
  `payment_usefor` int DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT NULL,
  `payment_name` varchar(125) DEFAULT NULL,
  `payment_amount` float(10,2) DEFAULT NULL,
  `payment_amount_unit_id` int DEFAULT NULL,
  `payment_status` int DEFAULT NULL,
  `payment_total_net_price` float(10,2) DEFAULT NULL,
  `discount_percentage` int DEFAULT '0',
  `properties` varchar(75) DEFAULT NULL,
  `rxtx_type_id` int DEFAULT NULL,
  `rxtxform` int DEFAULT NULL,
  `squirt` varchar(255) DEFAULT NULL,
  `squirt_time` varchar(255) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `drug_number_use` varchar(255) DEFAULT NULL,
  `howto_use` varchar(60) DEFAULT NULL,
  `drug_mix` varchar(255) DEFAULT NULL,
  `drug_mix_number` varchar(255) DEFAULT NULL,
  `start_time_saline` varchar(255) DEFAULT NULL,
  `end_time_saline` varchar(255) DEFAULT NULL,
  `rate_saline` varchar(255) DEFAULT NULL,
  `rate_saline_number` varchar(255) DEFAULT NULL,
  `number_time_to_eat` varchar(25) DEFAULT NULL,
  `number_time_to_eat_unit` int DEFAULT NULL,
  `number_time_per_day` varchar(25) DEFAULT NULL,
  `number_day` varchar(35) DEFAULT NULL,
  `every_hour_per_eat` varchar(25) DEFAULT NULL,
  `when_to_eat` varchar(60) DEFAULT NULL,
  `eye_use_side` varchar(30) DEFAULT NULL,
  `eye_number_drop` varchar(20) DEFAULT NULL,
  `eye_use_every_hour` int DEFAULT NULL,
  `warning_list` varchar(60) DEFAULT NULL,
  `more_info_1` varchar(100) DEFAULT NULL,
  `more_info_2` varchar(100) DEFAULT NULL,
  `payment_item_add_datetime` datetime DEFAULT NULL,
  `payment_item_modify_datetime` datetime DEFAULT NULL,
  `pet_uid` int DEFAULT NULL,
  `payment_item_date` date DEFAULT NULL,
  `ml_price_scheme_id` int DEFAULT '-1',
  `discard_price_cal_flag` tinyint DEFAULT '0',
  `promotion_id` int DEFAULT '-1',
  `bill_uid` int DEFAULT '-1',
  `print_drug_label_flag` tinyint DEFAULT '0',
  `expense_uid` int DEFAULT '-1',
  `logged_user_id` int DEFAULT '-1',
  `discount_price` float(10,2) DEFAULT '0.00',
  `stock_price_per_unit` float(10,2) DEFAULT '0.00',
  `exclude_vat_flag` tinyint DEFAULT '0',
  `calculate_vat_flag` tinyint DEFAULT '0',
  `vat_percentage` float(10,2) DEFAULT '7.00',
  `vat` float(10,2) DEFAULT '0.00',
  `vatable` float(10,2) DEFAULT '0.00',
  `cost_per_unit` float(10,2) DEFAULT '0.00',
  `eye_use_type` varchar(10) DEFAULT NULL,
  `drug_label_mode` int DEFAULT '1',
  `where_lab` int DEFAULT '-1',
  `is_platform` varchar(255) DEFAULT '0',
  `requisition_uid` int DEFAULT '-1',
  `requisition_item_status` int DEFAULT '-1',
  `requisition_number_change` float DEFAULT '0',
  `vat_type_id` int DEFAULT '1',
  `route_injection_type_id` int DEFAULT '-1',
  `main_payment_id` int DEFAULT '-1',
  `requisition_number_request` float DEFAULT '0',
  `requisition_number_paid` float DEFAULT '0',
  `requisition_number_added` float DEFAULT '0',
  `requisition_number_returned_item` float DEFAULT '0',
  `stock_sale_item_unit_rate` float(10,2) DEFAULT '1.00',
  `stock_sale_item_unit` varchar(20) DEFAULT NULL,
  `stock_sale_item_warehouse` varchar(50) DEFAULT NULL,
  `stock_sale_item_location` varchar(50) DEFAULT NULL,
  `stock_warehouse_id` int DEFAULT '-1',
  `bill_sale_id` int DEFAULT '-1',
  `add_user_display_name` varchar(100) DEFAULT NULL,
  `latest_edit_user_display_name` varchar(100) DEFAULT NULL,
  `item_price_level` int DEFAULT '1',
  `delstock` int NOT NULL,
  `divide` text,
  `discount_money` int DEFAULT NULL,
  `timer_id` int DEFAULT '0',
  `delete_item_date_time` date DEFAULT NULL,
  `create_date_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  KEY `opd_id` (`opd_id`),
  KEY `surgery_uid` (`surgery_uid`),
  KEY `admit_id` (`admit_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `related_stock_info_id` (`related_stock_info_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `branch_id` (`branch_id`),
  KEY `room_id` (`room_id`),
  KEY `idx_opd_expense_uid_datetime` (`expense_uid`,`payment_item_add_datetime`),
  KEY `idx_opd_requisition` (`requisition_uid`),
  KEY `idx_opd_payment_opd_stock_related` (`opd_id`,`stock_uid`,`related_stock_info_id`),
  KEY `idx_opd_payment_expense_status` (`expense_uid`,`payment_status`),
  KEY `idx_opd_payment_stock_uid_date` (`stock_uid`,`payment_item_add_datetime`),
  KEY `idx_opi_requisition_status` (`requisition_uid`,`payment_status`)
) ENGINE=InnoDB AUTO_INCREMENT=989817 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_payment_item_old`
--

DROP TABLE IF EXISTS `opd_payment_item_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_payment_item_old` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `room_id` int DEFAULT '0',
  `opd_id` int NOT NULL DEFAULT '-1',
  `surgery_uid` int NOT NULL,
  `admit_id` int NOT NULL,
  `lab_opd_id` int DEFAULT '0',
  `lab_admit_id` int DEFAULT '0',
  `lab_surgery_id` int DEFAULT '0',
  `stock_uid` int NOT NULL DEFAULT '-1',
  `related_stock_info_id` int NOT NULL,
  `stock_type_id` int DEFAULT NULL,
  `stock_id` varchar(50) DEFAULT NULL,
  `payment_usefor` int DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT NULL,
  `payment_name` varchar(125) DEFAULT NULL,
  `payment_amount` float(10,2) DEFAULT NULL,
  `payment_amount_unit_id` int DEFAULT NULL,
  `payment_status` int DEFAULT NULL,
  `payment_total_net_price` float(10,2) DEFAULT NULL,
  `discount_percentage` int DEFAULT '0',
  `properties` varchar(75) DEFAULT NULL,
  `rxtx_type_id` int DEFAULT NULL,
  `rxtxform` int DEFAULT NULL,
  `squirt` varchar(255) DEFAULT NULL,
  `squirt_time` varchar(255) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `drug_number_use` varchar(255) DEFAULT NULL,
  `howto_use` varchar(60) DEFAULT NULL,
  `drug_mix` varchar(255) DEFAULT NULL,
  `drug_mix_number` varchar(255) DEFAULT NULL,
  `start_time_saline` varchar(255) DEFAULT NULL,
  `end_time_saline` varchar(255) DEFAULT NULL,
  `rate_saline` varchar(255) DEFAULT NULL,
  `rate_saline_number` varchar(255) DEFAULT NULL,
  `number_time_to_eat` varchar(25) DEFAULT NULL,
  `number_time_to_eat_unit` int DEFAULT NULL,
  `number_time_per_day` varchar(25) DEFAULT NULL,
  `number_day` varchar(35) DEFAULT NULL,
  `every_hour_per_eat` varchar(25) DEFAULT NULL,
  `when_to_eat` varchar(60) DEFAULT NULL,
  `eye_use_side` varchar(30) DEFAULT NULL,
  `eye_number_drop` varchar(20) DEFAULT NULL,
  `eye_use_every_hour` int DEFAULT NULL,
  `warning_list` varchar(60) DEFAULT NULL,
  `more_info_1` varchar(100) DEFAULT NULL,
  `more_info_2` varchar(100) DEFAULT NULL,
  `payment_item_add_datetime` datetime DEFAULT NULL,
  `payment_item_modify_datetime` datetime DEFAULT NULL,
  `pet_uid` int DEFAULT NULL,
  `payment_item_date` date DEFAULT NULL,
  `ml_price_scheme_id` int DEFAULT '-1',
  `discard_price_cal_flag` tinyint DEFAULT '0',
  `promotion_id` int DEFAULT '-1',
  `bill_uid` int DEFAULT '-1',
  `print_drug_label_flag` tinyint DEFAULT '0',
  `expense_uid` int DEFAULT '-1',
  `logged_user_id` int DEFAULT '-1',
  `discount_price` float(10,2) DEFAULT '0.00',
  `stock_price_per_unit` float(10,2) DEFAULT '0.00',
  `exclude_vat_flag` tinyint DEFAULT '0',
  `calculate_vat_flag` tinyint DEFAULT '0',
  `vat_percentage` float(10,2) DEFAULT '7.00',
  `vat` float(10,2) DEFAULT '0.00',
  `vatable` float(10,2) DEFAULT '0.00',
  `cost_per_unit` float(10,2) DEFAULT '0.00',
  `eye_use_type` varchar(10) DEFAULT NULL,
  `drug_label_mode` int DEFAULT '1',
  `where_lab` int DEFAULT '-1',
  `is_platform` varchar(255) DEFAULT '0',
  `requisition_uid` int DEFAULT '-1',
  `requisition_item_status` int DEFAULT '-1',
  `requisition_number_change` float DEFAULT '0',
  `vat_type_id` int DEFAULT '1',
  `route_injection_type_id` int DEFAULT '-1',
  `main_payment_id` int DEFAULT '-1',
  `requisition_number_request` float DEFAULT '0',
  `requisition_number_paid` float DEFAULT '0',
  `requisition_number_added` float DEFAULT '0',
  `requisition_number_returned_item` float DEFAULT '0',
  `stock_sale_item_unit_rate` float(10,2) DEFAULT '1.00',
  `stock_sale_item_unit` varchar(20) DEFAULT NULL,
  `stock_sale_item_warehouse` varchar(50) DEFAULT NULL,
  `stock_sale_item_location` varchar(50) DEFAULT NULL,
  `stock_warehouse_id` int DEFAULT '-1',
  `bill_sale_id` int DEFAULT '-1',
  `add_user_display_name` varchar(100) DEFAULT NULL,
  `latest_edit_user_display_name` varchar(100) DEFAULT NULL,
  `item_price_level` int DEFAULT '1',
  `delstock` int NOT NULL,
  `divide` text,
  `discount_money` int DEFAULT NULL,
  `timer_id` int DEFAULT '0',
  PRIMARY KEY (`payment_id`),
  KEY `opd_id` (`opd_id`),
  KEY `surgery_uid` (`surgery_uid`),
  KEY `admit_id` (`admit_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `related_stock_info_id` (`related_stock_info_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `branch_id` (`branch_id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=279315 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_payment_item_old1`
--

DROP TABLE IF EXISTS `opd_payment_item_old1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_payment_item_old1` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `room_id` int DEFAULT '0',
  `opd_id` int NOT NULL DEFAULT '-1',
  `surgery_uid` int NOT NULL,
  `admit_id` int NOT NULL,
  `lab_opd_id` int DEFAULT '0',
  `lab_admit_id` int DEFAULT '0',
  `lab_surgery_id` int DEFAULT '0',
  `stock_uid` int NOT NULL DEFAULT '-1',
  `related_stock_info_id` int NOT NULL,
  `stock_type_id` int DEFAULT NULL,
  `stock_id` varchar(50) DEFAULT NULL,
  `payment_usefor` int DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT NULL,
  `payment_name` varchar(125) DEFAULT NULL,
  `payment_amount` float(10,2) DEFAULT NULL,
  `payment_amount_unit_id` int DEFAULT NULL,
  `payment_status` int DEFAULT NULL,
  `payment_total_net_price` float(10,2) DEFAULT NULL,
  `discount_percentage` int DEFAULT '0',
  `properties` varchar(75) DEFAULT NULL,
  `rxtx_type_id` int DEFAULT NULL,
  `rxtxform` int DEFAULT NULL,
  `squirt` varchar(255) DEFAULT NULL,
  `squirt_time` varchar(255) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `drug_number_use` varchar(255) DEFAULT NULL,
  `howto_use` varchar(60) DEFAULT NULL,
  `drug_mix` varchar(255) DEFAULT NULL,
  `drug_mix_number` varchar(255) DEFAULT NULL,
  `start_time_saline` varchar(255) DEFAULT NULL,
  `end_time_saline` varchar(255) DEFAULT NULL,
  `rate_saline` varchar(255) DEFAULT NULL,
  `rate_saline_number` varchar(255) DEFAULT NULL,
  `number_time_to_eat` varchar(25) DEFAULT NULL,
  `number_time_to_eat_unit` int DEFAULT NULL,
  `number_time_per_day` varchar(25) DEFAULT NULL,
  `number_day` varchar(35) DEFAULT NULL,
  `every_hour_per_eat` varchar(25) DEFAULT NULL,
  `when_to_eat` varchar(60) DEFAULT NULL,
  `eye_use_side` varchar(30) DEFAULT NULL,
  `eye_number_drop` varchar(20) DEFAULT NULL,
  `eye_use_every_hour` int DEFAULT NULL,
  `warning_list` varchar(60) DEFAULT NULL,
  `more_info_1` varchar(100) DEFAULT NULL,
  `more_info_2` varchar(100) DEFAULT NULL,
  `payment_item_add_datetime` datetime DEFAULT NULL,
  `payment_item_modify_datetime` datetime DEFAULT NULL,
  `pet_uid` int DEFAULT NULL,
  `payment_item_date` date DEFAULT NULL,
  `ml_price_scheme_id` int DEFAULT '-1',
  `discard_price_cal_flag` tinyint DEFAULT '0',
  `promotion_id` int DEFAULT '-1',
  `bill_uid` int DEFAULT '-1',
  `print_drug_label_flag` tinyint DEFAULT '0',
  `expense_uid` int DEFAULT '-1',
  `logged_user_id` int DEFAULT '-1',
  `discount_price` float(10,2) DEFAULT '0.00',
  `stock_price_per_unit` float(10,2) DEFAULT '0.00',
  `exclude_vat_flag` tinyint DEFAULT '0',
  `calculate_vat_flag` tinyint DEFAULT '0',
  `vat_percentage` float(10,2) DEFAULT '7.00',
  `vat` float(10,2) DEFAULT '0.00',
  `vatable` float(10,2) DEFAULT '0.00',
  `cost_per_unit` float(10,2) DEFAULT '0.00',
  `eye_use_type` varchar(10) DEFAULT NULL,
  `drug_label_mode` int DEFAULT '1',
  `where_lab` int DEFAULT '-1',
  `is_platform` varchar(255) DEFAULT '0',
  `requisition_uid` int DEFAULT '-1',
  `requisition_item_status` int DEFAULT '-1',
  `requisition_number_change` float DEFAULT '0',
  `vat_type_id` int DEFAULT '1',
  `route_injection_type_id` int DEFAULT '-1',
  `main_payment_id` int DEFAULT '-1',
  `requisition_number_request` float DEFAULT '0',
  `requisition_number_paid` float DEFAULT '0',
  `requisition_number_added` float DEFAULT '0',
  `requisition_number_returned_item` float DEFAULT '0',
  `stock_sale_item_unit_rate` float(10,2) DEFAULT '1.00',
  `stock_sale_item_unit` varchar(20) DEFAULT NULL,
  `stock_sale_item_warehouse` varchar(50) DEFAULT NULL,
  `stock_sale_item_location` varchar(50) DEFAULT NULL,
  `stock_warehouse_id` int DEFAULT '-1',
  `bill_sale_id` int DEFAULT '-1',
  `add_user_display_name` varchar(100) DEFAULT NULL,
  `latest_edit_user_display_name` varchar(100) DEFAULT NULL,
  `item_price_level` int DEFAULT '1',
  `delstock` int NOT NULL,
  `divide` text,
  `discount_money` int DEFAULT NULL,
  `timer_id` int DEFAULT '0',
  PRIMARY KEY (`payment_id`),
  KEY `opd_id` (`opd_id`),
  KEY `surgery_uid` (`surgery_uid`),
  KEY `admit_id` (`admit_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `related_stock_info_id` (`related_stock_info_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `branch_id` (`branch_id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=295020 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_payment_item_tax`
--

DROP TABLE IF EXISTS `opd_payment_item_tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_payment_item_tax` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL DEFAULT '-1',
  `stock_uid` int NOT NULL DEFAULT '-1',
  `stock_type_id` int DEFAULT NULL,
  `stock_id` varchar(50) DEFAULT NULL,
  `payment_usefor` int DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT NULL,
  `payment_name` varchar(125) DEFAULT NULL,
  `payment_amount` float DEFAULT NULL,
  `payment_amount_unit_id` int DEFAULT NULL,
  `payment_status` int DEFAULT NULL,
  `payment_total_net_price` float DEFAULT NULL,
  `discount_percentage` int DEFAULT '0',
  `properties` varchar(75) DEFAULT NULL,
  `rxtx_type_id` int DEFAULT NULL,
  `howto_use` varchar(60) DEFAULT NULL,
  `number_time_to_eat` varchar(25) DEFAULT NULL,
  `number_time_to_eat_unit` int DEFAULT NULL,
  `number_time_per_day` varchar(25) DEFAULT NULL,
  `every_hour_per_eat` varchar(25) DEFAULT NULL,
  `when_to_eat` varchar(60) DEFAULT NULL,
  `eye_use_side` varchar(30) DEFAULT NULL,
  `eye_number_drop` varchar(20) DEFAULT NULL,
  `eye_use_every_hour` int DEFAULT NULL,
  `warning_list` varchar(60) DEFAULT NULL,
  `more_info_1` varchar(100) DEFAULT NULL,
  `more_info_2` varchar(100) DEFAULT NULL,
  `payment_item_add_datetime` datetime DEFAULT NULL,
  `payment_item_modify_datetime` datetime DEFAULT NULL,
  `pet_uid` int DEFAULT NULL,
  `payment_item_date` date DEFAULT NULL,
  `ml_price_scheme_id` int DEFAULT '-1',
  `discard_price_cal_flag` tinyint DEFAULT '0',
  `promotion_id` int DEFAULT '-1',
  `bill_uid` int DEFAULT '-1',
  `print_drug_label_flag` tinyint DEFAULT '0',
  `expense_uid` int DEFAULT '-1',
  `logged_user_id` int DEFAULT '-1',
  `discount_price` float DEFAULT '0',
  `stock_price_per_unit` float DEFAULT '0',
  `exclude_vat_flag` tinyint DEFAULT '0',
  `calculate_vat_flag` tinyint DEFAULT '0',
  `vat_percentage` float DEFAULT '7',
  `vat` float DEFAULT '0',
  `vatable` float DEFAULT '0',
  `cost_per_unit` float DEFAULT '0',
  `eye_use_type` varchar(10) DEFAULT NULL,
  `drug_label_mode` int DEFAULT '1',
  `where_lab` int DEFAULT '-1',
  `requisition_uid` int DEFAULT '-1',
  `requisition_item_status` int DEFAULT '-1',
  `requisition_number_change` float DEFAULT '0',
  `vat_type_id` int DEFAULT '1',
  `route_injection_type_id` int DEFAULT '-1',
  `main_payment_id` int DEFAULT '-1',
  `requisition_number_request` float DEFAULT '0',
  `requisition_number_paid` float DEFAULT '0',
  `requisition_number_added` float DEFAULT '0',
  `requisition_number_returned_item` float DEFAULT '0',
  `stock_sale_item_unit_rate` float DEFAULT '1',
  `stock_sale_item_unit` varchar(20) DEFAULT NULL,
  `stock_sale_item_warehouse` varchar(50) DEFAULT NULL,
  `stock_sale_item_location` varchar(50) DEFAULT NULL,
  `stock_warehouse_id` int DEFAULT '-1',
  `bill_sale_id` int DEFAULT '-1',
  `add_user_display_name` varchar(100) DEFAULT NULL,
  `latest_edit_user_display_name` varchar(100) DEFAULT NULL,
  `item_price_level` int DEFAULT '1',
  PRIMARY KEY (`payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_payment_status`
--

DROP TABLE IF EXISTS `opd_payment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_payment_status` (
  `payment_status_id` int NOT NULL AUTO_INCREMENT,
  `payment_status` varchar(15) NOT NULL,
  PRIMARY KEY (`payment_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_picture`
--

DROP TABLE IF EXISTS `opd_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_picture` (
  `opd_picture_id` int NOT NULL AUTO_INCREMENT,
  `opd_id` int DEFAULT NULL,
  `picture` mediumblob,
  `picture_path` varchar(260) DEFAULT NULL,
  `picture_album_id` int DEFAULT '-1',
  PRIMARY KEY (`opd_picture_id`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_prognosis`
--

DROP TABLE IF EXISTS `opd_prognosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_prognosis` (
  `prognosis_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `content` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prognosis_uid`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24906 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_skin`
--

DROP TABLE IF EXISTS `opd_skin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_skin` (
  `skin_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `image` longtext NOT NULL,
  `coat_brushing` text NOT NULL,
  `pinna_padal_reflex` text NOT NULL,
  `content` longtext NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`skin_uid`),
  KEY `opd_id` (`opd_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4772 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_skin_cut_stock`
--

DROP TABLE IF EXISTS `opd_skin_cut_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_skin_cut_stock` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `content` text NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `opd_id` (`opd_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4860 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_status`
--

DROP TABLE IF EXISTS `opd_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_treatment`
--

DROP TABLE IF EXISTS `opd_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_treatment` (
  `treatment_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `content` longblob,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`treatment_uid`),
  KEY `opd_id` (`opd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opd_vaccine`
--

DROP TABLE IF EXISTS `opd_vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opd_vaccine` (
  `vaccine_uid` int NOT NULL AUTO_INCREMENT,
  `opd_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `content` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`vaccine_uid`),
  KEY `opd_id` (`opd_id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=94835 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opendrawer`
--

DROP TABLE IF EXISTS `opendrawer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opendrawer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `opendrawer_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `petid` varchar(25) DEFAULT NULL,
  `petname` varchar(45) DEFAULT NULL,
  `pettype` varchar(64) DEFAULT NULL,
  `petsex` varchar(15) DEFAULT NULL,
  `petbreed` text,
  `petcolor` varchar(64) DEFAULT NULL,
  `petdefect` varchar(512) DEFAULT NULL,
  `petbirthday` varchar(64) DEFAULT NULL,
  `microship` varchar(45) DEFAULT NULL,
  `sprayedorneutereded` tinyint DEFAULT NULL,
  `petstatus` varchar(20) DEFAULT NULL,
  `petpicture` varchar(200) DEFAULT NULL,
  `cuid` int DEFAULT NULL,
  `pettypeothers` varchar(64) DEFAULT 'ไม่ระบุ',
  `petageday` int DEFAULT NULL,
  `petagemonth` int DEFAULT NULL,
  `petageyear` int DEFAULT NULL,
  `petnote` varchar(400) DEFAULT NULL,
  `pet_follow` text NOT NULL,
  `cid_reserved` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `petstatus` (`petstatus`),
  KEY `cuid` (`cuid`),
  KEY `idx_pet_cuid_status` (`cuid`,`petstatus`),
  KEY `idx_pet_uid_status` (`uid`,`petstatus`),
  KEY `idx_pet_cuid` (`cuid`),
  KEY `idx_pet_cuid_petstatus` (`cuid`,`petstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=30621 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_admit`
--

DROP TABLE IF EXISTS `pet_admit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_admit` (
  `pet_admit_id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL DEFAULT '-1',
  `cage_id` int DEFAULT '-1',
  PRIMARY KEY (`pet_admit_id`),
  KEY `pet_uid` (`pet_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_breeds`
--

DROP TABLE IF EXISTS `pet_breeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_breeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `breed_th` varchar(64) NOT NULL,
  `breed_en` varchar(64) DEFAULT NULL,
  `pet_type_id` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `pet_type_id` (`pet_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=550 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_deliver`
--

DROP TABLE IF EXISTS `pet_deliver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_deliver` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `expense_uid` int NOT NULL,
  `cuid` int NOT NULL,
  `deliver_history` text,
  `deliver_exam` text,
  `deliver_diagnosis` text,
  `deliver_treatment` text,
  `deliver_reason` text,
  `deliver_comment` text,
  `user_id` int NOT NULL,
  `pet_lab_data` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pet_temperature` varchar(100) DEFAULT NULL,
  `pet_weight` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=872 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_reference_lab`
--

DROP TABLE IF EXISTS `pet_reference_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_reference_lab` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `stock_uid` int NOT NULL,
  `pet_type_id` int NOT NULL DEFAULT '1',
  `pet_type_name` varchar(100) NOT NULL,
  `reference_value` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4369 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_registration`
--

DROP TABLE IF EXISTS `pet_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_registration` (
  `puid` int NOT NULL AUTO_INCREMENT,
  `registration_datetime` datetime NOT NULL,
  PRIMARY KEY (`puid`)
) ENGINE=InnoDB AUTO_INCREMENT=5547 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_status`
--

DROP TABLE IF EXISTS `pet_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pet_types`
--

DROP TABLE IF EXISTS `pet_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `petprofile_picture`
--

DROP TABLE IF EXISTS `petprofile_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petprofile_picture` (
  `pet_uid` int NOT NULL AUTO_INCREMENT,
  `picture` mediumblob,
  `picture_path` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`pet_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `picture_album`
--

DROP TABLE IF EXISTS `picture_album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `picture_album` (
  `id` int NOT NULL AUTO_INCREMENT,
  `picture_album_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `picture_scan_history`
--

DROP TABLE IF EXISTS `picture_scan_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `picture_scan_history` (
  `scan_id` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL DEFAULT '-1',
  `picture_datetime` datetime DEFAULT NULL,
  `scan_picture_path` varchar(1024) DEFAULT NULL,
  `scan_picture_add_datetime` datetime DEFAULT NULL,
  `scan_picture_modify_datetime` datetime DEFAULT NULL,
  `scan_type` int NOT NULL DEFAULT '-1',
  `scan_sub_type_1` int NOT NULL DEFAULT '-1',
  `scan_sub_type_2` int NOT NULL DEFAULT '-1',
  PRIMARY KEY (`scan_id`),
  KEY `pet_uid` (`pet_uid`),
  KEY `scan_type` (`scan_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `picture_scan_type`
--

DROP TABLE IF EXISTS `picture_scan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `picture_scan_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pnd_type`
--

DROP TABLE IF EXISTS `pnd_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pnd_type` (
  `pnd_type_id` int NOT NULL AUTO_INCREMENT,
  `pnd_type_name` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pnd_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `priority_list`
--

DROP TABLE IF EXISTS `priority_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `priority_list` (
  `priority_id` int NOT NULL AUTO_INCREMENT,
  `priority_name` varchar(25) NOT NULL,
  `priority_order` int NOT NULL,
  PRIMARY KEY (`priority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `province`
--

DROP TABLE IF EXISTS `province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `province` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_appointmet_come_for_list`
--

DROP TABLE IF EXISTS `queue_appointmet_come_for_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_appointmet_come_for_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `name_en` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_history`
--

DROP TABLE IF EXISTS `queue_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_history` (
  `queue_uid` int NOT NULL AUTO_INCREMENT,
  `queue_id` varchar(10) NOT NULL,
  `queue_type` char(1) DEFAULT 'W',
  `appointment_uid` int DEFAULT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `pet_uid` int NOT NULL,
  `room_id` int NOT NULL DEFAULT '1',
  `main_room_id` int NOT NULL,
  `queue_mode_id` int NOT NULL DEFAULT '1',
  `special_clinic_id` int NOT NULL DEFAULT '-1',
  `specific_doctor_id` int NOT NULL DEFAULT '-1',
  `specific_doctor_name` varchar(64) DEFAULT NULL,
  `come_for_list` varchar(256) DEFAULT NULL,
  `more_info` longblob,
  `queue_add_user_id` varchar(50) DEFAULT NULL,
  `queue_add_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `queue_modify_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `queue_history_status` int NOT NULL DEFAULT '2',
  `queue_priority_id` int NOT NULL DEFAULT '4',
  `pet_weight` varchar(20) DEFAULT '0',
  `pet_temperature` varchar(20) DEFAULT '0',
  `pet_bp` varchar(20) NOT NULL DEFAULT '0',
  `pet_hs` varchar(20) NOT NULL DEFAULT '0',
  `pet_ls` varchar(20) NOT NULL DEFAULT '0',
  `pet_crt` varchar(20) NOT NULL DEFAULT '0',
  `pet_hr` varchar(20) NOT NULL DEFAULT '0',
  `pet_rr` varchar(20) NOT NULL DEFAULT '0',
  `pet_mm` varchar(20) NOT NULL DEFAULT '0',
  `pet_bcs` varchar(20) NOT NULL DEFAULT '0',
  `hydration` text,
  `score` longblob,
  `comment` longblob,
  `content` longblob,
  `treatment` longblob,
  `canvas` longtext,
  `pe_canvas` longtext,
  PRIMARY KEY (`queue_uid`),
  KEY `pet_uid` (`pet_uid`),
  KEY `room_id` (`room_id`),
  KEY `main_room_id` (`main_room_id`),
  KEY `queue_history_status` (`queue_history_status`),
  KEY `idx_queue_history_branch_uid` (`branch_id`,`queue_uid`),
  KEY `idx_queue_history_branch_timestamp` (`branch_id`,`queue_add_timestamp`,`queue_history_status`),
  KEY `idx_queue_history_add_timestamp_branch` (`queue_add_timestamp`,`branch_id`),
  KEY `idx_queue_history_modify_timestamp` (`queue_modify_timestamp`),
  KEY `idx_queue_history_room_lookup` (`branch_id`,`room_id`,`queue_history_status`,`queue_modify_timestamp`),
  KEY `idx_queue_history_pet_type_timestamp` (`pet_uid`,`queue_type`,`queue_add_timestamp`),
  KEY `idx_queue_history_branch_status` (`branch_id`,`queue_history_status`),
  KEY `idx_qh_branch_status_room` (`branch_id`,`queue_history_status`,`room_id`),
  KEY `idx_qh_queue_uid` (`queue_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=128828 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_history_status`
--

DROP TABLE IF EXISTS `queue_history_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_history_status` (
  `id` int NOT NULL,
  `status_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_mode`
--

DROP TABLE IF EXISTS `queue_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_mode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `queue_mode_name` varchar(45) NOT NULL,
  `queue_mode_prefix` varchar(3) DEFAULT NULL,
  `queue_color` varchar(20) DEFAULT NULL,
  `queue_mode_en_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_symptom`
--

DROP TABLE IF EXISTS `queue_symptom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_symptom` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `symptom_name` varchar(200) NOT NULL,
  `symptom_status` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_symptom_log`
--

DROP TABLE IF EXISTS `queue_symptom_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_symptom_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `symptom_uid` int NOT NULL,
  `branch_id` int NOT NULL,
  `queue_uid` int NOT NULL DEFAULT '1',
  `room_id` int NOT NULL,
  `pet_id` varchar(100) NOT NULL,
  `pet_name` varchar(100) NOT NULL,
  `customer_id` varchar(100) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_queue_symptom_log_queue_uid` (`queue_uid`),
  KEY `idx_qsl_queue_uid` (`queue_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=440243 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receive_medicine`
--

DROP TABLE IF EXISTS `receive_medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receive_medicine` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `received_payment`
--

DROP TABLE IF EXISTS `received_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `received_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pay_name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `received_stock_bill_info`
--

DROP TABLE IF EXISTS `received_stock_bill_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `received_stock_bill_info` (
  `received_info_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `received_stock_bill_uid` int NOT NULL,
  `payment_date` date NOT NULL,
  `manufacturer_name` varchar(200) NOT NULL,
  `bil_paymen_number` varchar(200) NOT NULL,
  `total_amount` float(10,2) NOT NULL,
  `received_payment_id` int NOT NULL,
  `number_check` float(10,2) NOT NULL,
  `bank` int NOT NULL,
  `interest` float(10,2) NOT NULL,
  `discount` float(10,2) NOT NULL,
  `pay_actual` float(10,2) NOT NULL,
  `unpaid_debts` int NOT NULL,
  `bill_info_tax` float(10,2) NOT NULL,
  `logged_in_user` int NOT NULL,
  `modify_logged_in_user` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`received_info_uid`),
  KEY `received_stock_bill_uid` (`received_stock_bill_uid`),
  KEY `received_payment_id` (`received_payment_id`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1975 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `received_stock_bill_price_type`
--

DROP TABLE IF EXISTS `received_stock_bill_price_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `received_stock_bill_price_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `received_stock_bill_status`
--

DROP TABLE IF EXISTS `received_stock_bill_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `received_stock_bill_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `received_stock_bill_type`
--

DROP TABLE IF EXISTS `received_stock_bill_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `received_stock_bill_type` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(45) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `received_stock_bills`
--

DROP TABLE IF EXISTS `received_stock_bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `received_stock_bills` (
  `received_stock_bill_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `received_stock_bill_id` varchar(100) DEFAULT NULL,
  `lot_id` varchar(255) NOT NULL,
  `received_stock_date` date DEFAULT NULL,
  `vat_type` int NOT NULL DEFAULT '0',
  `other_reference` varchar(255) DEFAULT NULL,
  `manufacturer_id` int NOT NULL DEFAULT '-1',
  `sale_name` varchar(100) DEFAULT NULL,
  `sale_contact_number` varchar(100) DEFAULT NULL,
  `sale_email` varchar(128) DEFAULT NULL,
  `end_bill_discount_total` float NOT NULL DEFAULT '0',
  `sub_total` float NOT NULL DEFAULT '0',
  `vat` float NOT NULL DEFAULT '0',
  `net_total` float NOT NULL DEFAULT '0',
  `add_datetime` datetime DEFAULT NULL,
  `modify_datetime` datetime DEFAULT NULL,
  `end_bill_discount_percentage` float NOT NULL DEFAULT '0',
  `vatable` float DEFAULT '0',
  `received_stock_bill_type_id` int DEFAULT '-1',
  `vat_rate` float NOT NULL DEFAULT '7',
  `total_amount` float NOT NULL DEFAULT '0',
  `received_stock_bill_unique_id` varchar(45) DEFAULT NULL,
  `received_stock_bill_status_id` int DEFAULT '1',
  `other_reference_2` varchar(50) DEFAULT NULL,
  `other_reference_3` varchar(50) DEFAULT NULL,
  `shipment_cost_total` float DEFAULT '0',
  `logged_user_id` int DEFAULT '-1',
  `gateway_type_id` int NOT NULL,
  `check_payment_type_id` int NOT NULL,
  `other_info` text NOT NULL,
  PRIMARY KEY (`received_stock_bill_uid`),
  KEY `received_stock_bill_type_id` (`received_stock_bill_type_id`),
  KEY `received_stock_bill_status_id` (`received_stock_bill_status_id`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8858 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `related_stock`
--

DROP TABLE IF EXISTS `related_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `related_stock` (
  `related_stock_info_id` int NOT NULL AUTO_INCREMENT,
  `main_stock_uid` int NOT NULL DEFAULT '-1',
  `related_stock_uid` int NOT NULL DEFAULT '-1',
  `relate_stock_sale_item_id` int NOT NULL,
  `related_cutting_stock_amount` float NOT NULL DEFAULT '0',
  `related_cutting_stock_unit_id` int NOT NULL DEFAULT '-1',
  `related_cutting_stock_mode` int NOT NULL DEFAULT '1',
  `related_stock_no_cutting_stock` int DEFAULT '0',
  `related_ml_price_scheme_id` int NOT NULL DEFAULT '-1',
  `related_stock_rxtx_usefor` int NOT NULL DEFAULT '-1',
  `related_stock_where_lab` int NOT NULL DEFAULT '-1',
  `related_stock_print_drug_label_flag` tinyint NOT NULL DEFAULT '0',
  `add_related_stock_price_flag` tinyint NOT NULL DEFAULT '0',
  `related_stock_total_price` float NOT NULL DEFAULT '0',
  `related_stock_adjust_price_flag` tinyint NOT NULL DEFAULT '0',
  `related_drug_label_properties` varchar(75) DEFAULT NULL,
  `related_drug_label_rxtx_type_id` int NOT NULL DEFAULT '-1',
  `related_drug_label_howto_use` varchar(60) DEFAULT NULL,
  `related_drug_label_number_time_to_eat` varchar(25) DEFAULT NULL,
  `related_drug_label_number_time_to_eat_unit` int NOT NULL DEFAULT '-1',
  `related_drug_label_number_time_per_day` varchar(25) DEFAULT NULL,
  `related_drug_label_number_day` varchar(35) DEFAULT NULL,
  `related_drug_label_every_hour_per_eat` varchar(25) DEFAULT NULL,
  `related_drug_label_when_to_eat` varchar(60) DEFAULT NULL,
  `related_drug_label_eye_use_side` varchar(30) DEFAULT NULL,
  `related_drug_label_eye_number_drop` varchar(20) DEFAULT NULL,
  `related_drug_label_eye_use_every_hour` int DEFAULT NULL,
  `related_drug_label_warning_list` varchar(60) DEFAULT NULL,
  `related_drug_label_more_info_1` varchar(100) DEFAULT NULL,
  `related_drug_label_more_info_2` varchar(100) DEFAULT NULL,
  `related_drug_label_eye_use_type` varchar(10) DEFAULT NULL,
  `related_drug_label_laguage` int DEFAULT '1',
  `related_drug_label_rxtxform` int NOT NULL,
  `related_drug_label_squirt` varchar(255) NOT NULL,
  `related_drug_label_squirt_time` varchar(255) NOT NULL,
  `related_drug_label_route` varchar(255) NOT NULL,
  `related_drug_label_drug_mix` varchar(255) NOT NULL,
  `related_drug_label_drug_mix_number` varchar(255) NOT NULL,
  `related_drug_label_start_time_saline` varchar(255) NOT NULL,
  `related_drug_label_end_time_saline` varchar(255) NOT NULL,
  `related_drug_label_rate_saline` varchar(255) NOT NULL,
  `related_drug_label_rate_saline_number` varchar(255) NOT NULL,
  `related_drug_label_divide` text,
  PRIMARY KEY (`related_stock_info_id`),
  KEY `main_stock_uid` (`main_stock_uid`),
  KEY `related_stock_uid` (`related_stock_uid`),
  KEY `idx_related_stock_info_id` (`related_stock_info_id`),
  KEY `idx_related_stock_main_uid` (`main_stock_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2987 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_statement_setting`
--

DROP TABLE IF EXISTS `report_statement_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_statement_setting` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `setting_key` varchar(255) NOT NULL,
  `setting_value` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requisition`
--

DROP TABLE IF EXISTS `requisition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition` (
  `requisition_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `requisition_id` varchar(25) DEFAULT NULL,
  `requisition_type_id` int NOT NULL DEFAULT '-1',
  `requisition_warehouse_id` varchar(255) DEFAULT NULL,
  `request_for` varchar(255) DEFAULT NULL,
  `requisition_datetime` datetime DEFAULT NULL,
  `requisition_modify_datetime` datetime DEFAULT NULL,
  `requisition_status_id` int NOT NULL DEFAULT '1',
  `requested_user_id` int NOT NULL DEFAULT '-1',
  `expense_uid` int DEFAULT '-1',
  `to_sub_stock_uid` int DEFAULT '-1',
  `return_status_id` int NOT NULL DEFAULT '0',
  `requisition_reference` varchar(100) DEFAULT NULL,
  `requisition_verify_username_display` varchar(64) DEFAULT NULL,
  `requisition_user_request_name` varchar(50) DEFAULT NULL,
  `requisition_more_info` varchar(64) DEFAULT NULL,
  `requisition_header_info_save_status` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`requisition_uid`),
  KEY `requisition_type_id` (`requisition_type_id`),
  KEY `expense_uid` (`expense_uid`),
  KEY `requisition_status_id` (`requisition_status_id`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_req_branch_status` (`branch_id`,`requisition_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5729 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requisition_item_status`
--

DROP TABLE IF EXISTS `requisition_item_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition_item_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requisition_mode`
--

DROP TABLE IF EXISTS `requisition_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition_mode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mode` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requisition_status`
--

DROP TABLE IF EXISTS `requisition_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `requisition_type`
--

DROP TABLE IF EXISTS `requisition_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requisition_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  `mode` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reserved_accounts`
--

DROP TABLE IF EXISTS `reserved_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserved_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reserved_account_name` varchar(64) NOT NULL,
  `reserved_account_syn` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `return_report`
--

DROP TABLE IF EXISTS `return_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return_report` (
  `return_uid` int NOT NULL AUTO_INCREMENT,
  `return_id` varchar(45) DEFAULT NULL,
  `return_tax_id` varchar(45) DEFAULT NULL,
  `bill_uid_ref` int DEFAULT '-1',
  `discount_amount` float DEFAULT '0',
  `return_money_total_amount` float DEFAULT '0',
  `return_datetime` datetime DEFAULT NULL,
  `diff_amount` float DEFAULT '0',
  `return_status_id` int DEFAULT '1',
  PRIMARY KEY (`return_uid`),
  KEY `bill_uid_ref` (`bill_uid_ref`),
  KEY `return_status_id` (`return_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `return_status`
--

DROP TABLE IF EXISTS `return_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return_status` (
  `id` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `route_injection_type`
--

DROP TABLE IF EXISTS `route_injection_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route_injection_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `route_injection_type` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `run_number_vat`
--

DROP TABLE IF EXISTS `run_number_vat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `run_number_vat` (
  `number_id` int NOT NULL AUTO_INCREMENT,
  `book_number` varchar(255) NOT NULL,
  `run_number` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`number_id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rxtx`
--

DROP TABLE IF EXISTS `rxtx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rxtx` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int NOT NULL,
  `rxtxform` int NOT NULL DEFAULT '1',
  `squirt` varchar(255) NOT NULL,
  `squirt_time` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `properties` varchar(90) DEFAULT NULL,
  `rxtx_type_id` int DEFAULT NULL,
  `usefor` int DEFAULT NULL,
  `howto_use` varchar(110) DEFAULT NULL,
  `number_time_to_eat` varchar(25) DEFAULT '0',
  `number_time_to_eat_unit` int DEFAULT '-1',
  `number_time_per_day` varchar(35) DEFAULT NULL,
  `number_day` varchar(35) DEFAULT NULL,
  `every_hour_per_eat` varchar(25) DEFAULT NULL,
  `when_to_eat` varchar(60) DEFAULT NULL,
  `eye_use_side` varchar(30) DEFAULT NULL,
  `eye_number_drop` varchar(20) DEFAULT NULL,
  `eye_use_every_hour` int DEFAULT '0',
  `warning_list` varchar(60) DEFAULT NULL,
  `more_info_1` varchar(100) DEFAULT NULL,
  `more_info_2` varchar(100) DEFAULT NULL,
  `eye_use_type` varchar(10) DEFAULT NULL,
  `properties_en` varchar(75) DEFAULT NULL,
  `howto_use_en` varchar(60) DEFAULT NULL,
  `more_info_1_en` varchar(100) DEFAULT NULL,
  `more_info_2_en` varchar(100) DEFAULT NULL,
  `drug_mix` varchar(255) NOT NULL,
  `drug_mix_number` varchar(255) NOT NULL,
  `start_time_saline` varchar(255) NOT NULL,
  `end_time_saline` varchar(255) NOT NULL,
  `rate_saline` varchar(255) NOT NULL,
  `rate_saline_number` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `stock_uid` (`stock_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2380 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rxtx_unit`
--

DROP TABLE IF EXISTS `rxtx_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rxtx_unit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(20) DEFAULT NULL,
  `unit_name_en` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rxtx_usefor`
--

DROP TABLE IF EXISTS `rxtx_usefor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rxtx_usefor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usefor` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary` (
  `salary_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `salary_id` varchar(100) NOT NULL,
  `bank_id` int NOT NULL,
  `date_pay` date NOT NULL,
  `user_pay_id` int NOT NULL,
  `salary_status` int NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`salary_uid`),
  KEY `salary_id` (`salary_id`),
  KEY `salary_status` (`salary_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_info` (
  `version` varchar(20) NOT NULL,
  `hospital_name` varchar(45) NOT NULL,
  `binary_revision` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_history`
--

DROP TABLE IF EXISTS `sms_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `appointment_uid` int DEFAULT '-1',
  `sms_datetime` datetime DEFAULT NULL,
  `sms_number` varchar(45) DEFAULT NULL,
  `sms_message` varchar(201) DEFAULT NULL,
  `sms_status` int DEFAULT '1',
  `sms_history_datetime` datetime DEFAULT NULL,
  `sms_sender` varchar(10) DEFAULT NULL,
  `sms_schedule_datetime_flag` tinyint DEFAULT '0',
  `user_id` int DEFAULT '-1',
  `number_credit_used` int DEFAULT '0',
  `sbuysms_error_detail` varchar(100) DEFAULT NULL,
  `error_msg_display` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sms_status`
--

DROP TABLE IF EXISTS `sms_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sms_status` (
  `id` int NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `special_clinic`
--

DROP TABLE IF EXISTS `special_clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `special_clinic` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_name` varchar(45) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `clinic_name_en` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(50) NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `payment_asset` int DEFAULT '1',
  `stock_barcode` varchar(40) DEFAULT NULL,
  `stock_name` varchar(125) NOT NULL,
  `stock_number` int DEFAULT '0',
  `stock_number_alert` float(10,2) DEFAULT '0.00',
  `stock_number_rxtx_unit_id` int DEFAULT '-1',
  `stock_number_rxtx_main_unit_id` int NOT NULL,
  `stock_purchase_price` float DEFAULT '0',
  `stock_sale_price` float DEFAULT '0',
  `stock_other_info` varchar(512) DEFAULT NULL,
  `stock_type_id` int DEFAULT NULL,
  `stock_modify_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stock_category_id` int DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT '1',
  `ml_per_each_bottle` float DEFAULT '0',
  `all_ml_remaining` float DEFAULT '0',
  `ml_per_bottle_use` float DEFAULT '0',
  `ml_per_bottle_use_price` float DEFAULT '0',
  `stock_manufacturer` varchar(50) DEFAULT NULL,
  `stock_status` int DEFAULT '1',
  `stock_generic_name` varchar(1000) DEFAULT NULL,
  `stock_manufacturer_id` int DEFAULT '-1',
  `day_before_exp_alert` int DEFAULT '0',
  `ml_stock_calculation_prices_id` int DEFAULT '-1',
  `prices_promotion_id` int DEFAULT '-1',
  `exclude_vat_flag` tinyint DEFAULT '0',
  `stock_sub_category_id` int DEFAULT '-1',
  `is_controlled_substance_drug` tinyint DEFAULT '0',
  `drug_reg_no` varchar(45) DEFAULT NULL,
  `stock_sale_name` varchar(125) DEFAULT NULL,
  `stock_use_frequency_type` int NOT NULL DEFAULT '1',
  `stock_price_type` int NOT NULL DEFAULT '-1',
  `is_liquid` tinyint DEFAULT '0',
  `ml_remaining_alert` float DEFAULT '0',
  `sale_price_include_vat` tinyint DEFAULT '1',
  `stock_all_remaining` float NOT NULL DEFAULT '0',
  `stock_warehouse_id` int DEFAULT '-1',
  `stock_sale_warehouse_id` int DEFAULT '-1',
  `stock_sub_category_id_2` int DEFAULT '-1',
  `stock_sub_category_id_3` int DEFAULT '-1',
  `stock_sub_category_id_4` int DEFAULT '-1',
  `stock_sub_category_id_5` int DEFAULT '-1',
  `lock_status` tinyint DEFAULT '0',
  `use_per_month` int NOT NULL,
  `use_per_month_min` int NOT NULL,
  `use_per_day_average` int NOT NULL,
  `duration_day_in_warehouse` int NOT NULL,
  `duration_day_for_waiting` int NOT NULL,
  `safety_stock` int NOT NULL,
  `use_per_month_max` int NOT NULL,
  `recorder_point` int NOT NULL,
  `rxtx_type_id` int NOT NULL,
  `rxtx_usefor` int NOT NULL,
  `tag_drug` varchar(200) NOT NULL,
  `narcotic_drug` int NOT NULL,
  `ingredient_drug` int NOT NULL,
  `stock_add_datetime` varchar(200) NOT NULL,
  `stock_use_datetime` varchar(200) NOT NULL,
  `stock_carcass_price` float(10,2) NOT NULL,
  `stock_depreciate_price` float(10,2) NOT NULL,
  `stock_depreciate_garner` float(10,2) NOT NULL,
  `stock_depreciate_cal` float(10,2) NOT NULL,
  `stock_cal_depreciate_datetime` varchar(200) NOT NULL,
  `stock_depreciate_break` float(10,2) NOT NULL,
  `stock_rate_id` int NOT NULL,
  `stock_purchase_price_vatable` float(10,2) NOT NULL,
  `stock_purchase_price_vat` float(10,2) NOT NULL,
  `stock_no_cutting_stock` int DEFAULT '0',
  `stock_image` varchar(255) DEFAULT NULL,
  `stock_mark_buy` decimal(10,2) DEFAULT '0.00',
  `stock_mark_buy_total` decimal(10,2) DEFAULT '0.00',
  `bill_duration_day_in_warehouse` int DEFAULT '0',
  `bill_duration_day_for_waiting` int DEFAULT '0',
  `bill_safety_stock` int DEFAULT '0',
  `bill_use_per_month_max` decimal(10,2) DEFAULT '0.00',
  `bill_recorder_point` decimal(10,2) DEFAULT '0.00',
  `text_status_profit` varchar(255) DEFAULT '-',
  `profit_percent` int DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `stock_id` (`stock_id`),
  KEY `stock_type_id` (`stock_type_id`),
  KEY `stock_category_id` (`stock_category_id`),
  KEY `stock_status` (`stock_status`),
  KEY `stock_sub_category_id` (`stock_sub_category_id`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_stock_branch_status_category` (`branch_id`,`stock_status`,`stock_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19426 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_card`
--

DROP TABLE IF EXISTS `stock_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_card` (
  `card_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `stock_uid` int NOT NULL,
  `payment_id` int NOT NULL,
  `bill_id` varchar(200) NOT NULL,
  `manufacturer_id` int NOT NULL,
  `stock_purchase_price` float(10,2) NOT NULL,
  `total_net_price` float(10,2) NOT NULL,
  `add_date` varchar(200) NOT NULL,
  `expired_date` varchar(255) DEFAULT NULL,
  `stock_origin_qty` float(10,2) NOT NULL,
  `stock_received_qty` float(10,2) NOT NULL,
  `stock_use_qty` float(10,2) NOT NULL,
  `stock_adjust_qty` float(10,2) NOT NULL,
  `stock_qty` float(10,2) NOT NULL,
  `stock_card_type` int NOT NULL,
  `stock_card_status` int NOT NULL DEFAULT '1',
  `stock_card_log_warehouse` text,
  `user_id` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`card_uid`),
  KEY `stock_uid` (`stock_uid`),
  KEY `payment_id` (`payment_id`),
  KEY `bill_id` (`bill_id`),
  KEY `stock_card_status` (`stock_card_status`),
  KEY `stock_card_type` (`stock_card_type`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1238969 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_card_type`
--

DROP TABLE IF EXISTS `stock_card_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_card_type` (
  `card_type_id` int NOT NULL AUTO_INCREMENT,
  `card_type_name` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`card_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_category`
--

DROP TABLE IF EXISTS `stock_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(30) NOT NULL,
  `category_en` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_check`
--

DROP TABLE IF EXISTS `stock_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_check` (
  `check_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `check_id` varchar(100) NOT NULL,
  `check_warehouse_id` int NOT NULL,
  `check_user_id` int NOT NULL,
  `check_approve_id` int NOT NULL,
  `stock_category_id` int NOT NULL,
  `stock_sub_category_id` int NOT NULL,
  `check_add_datetime` date NOT NULL,
  `adjust_modify_datetime` datetime NOT NULL,
  `check_status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`check_uid`),
  KEY `stock_sub_category_id` (`stock_sub_category_id`),
  KEY `stock_category_id` (`stock_category_id`),
  KEY `check_approve_id` (`check_approve_id`),
  KEY `check_status` (`check_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4462 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_check_list`
--

DROP TABLE IF EXISTS `stock_check_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_check_list` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `check_uid` int NOT NULL,
  `stock_uid` int NOT NULL,
  `stock_name` varchar(200) NOT NULL,
  `stock_unit_id` int NOT NULL,
  `number_in_count` decimal(10,2) NOT NULL,
  `number_in_stock` decimal(10,2) NOT NULL,
  `number_total` decimal(10,2) NOT NULL,
  `number_balance` decimal(10,2) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `add_date` varchar(200) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `check_uid` (`check_uid`),
  KEY `stock_uid` (`stock_uid`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71648 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_check_status`
--

DROP TABLE IF EXISTS `stock_check_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_check_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_code`
--

DROP TABLE IF EXISTS `stock_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_code` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3864 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_info_view`
--

DROP TABLE IF EXISTS `stock_info_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_info_view` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(50) NOT NULL,
  `stock_name` varchar(125) NOT NULL,
  `price_unit_name` varchar(20) DEFAULT NULL,
  `barcode` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `stock_id` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_level`
--

DROP TABLE IF EXISTS `stock_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_level` (
  `int` int NOT NULL,
  `stock_level` varchar(45) NOT NULL,
  PRIMARY KEY (`int`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_payment_asset`
--

DROP TABLE IF EXISTS `stock_payment_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_payment_asset` (
  `payment_asset_id` int NOT NULL AUTO_INCREMENT,
  `payment_asset_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`payment_asset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_price_type`
--

DROP TABLE IF EXISTS `stock_price_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_price_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_rate`
--

DROP TABLE IF EXISTS `stock_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_rate` (
  `rate_id` int NOT NULL AUTO_INCREMENT,
  `rate_name` varchar(200) NOT NULL,
  `rate_cost` float(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_rxtx_type`
--

DROP TABLE IF EXISTS `stock_rxtx_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_rxtx_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  `type_en` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sale_item_info`
--

DROP TABLE IF EXISTS `stock_sale_item_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sale_item_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int DEFAULT '-1',
  `price_unit_id` int DEFAULT '-1',
  `price_unit_name` varchar(20) DEFAULT NULL,
  `price_unit_rate` float DEFAULT '0',
  `stock_sale_item_price` float DEFAULT '0',
  `barcode` varchar(40) DEFAULT NULL,
  `update_flag` tinyint DEFAULT '0',
  `warehouse` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `stock_sale_item_special_price` float DEFAULT '0',
  `sale_item_status` int NOT NULL DEFAULT '1',
  `stock_sale_item_price_2` float DEFAULT '0',
  `stock_sale_item_price_3` float DEFAULT '0',
  `stock_sale_item_price_4` float DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `sale_item_status` (`sale_item_status`),
  KEY `idx_stock_sale_item_stock_uid` (`stock_uid`,`sale_item_status`)
) ENGINE=InnoDB AUTO_INCREMENT=16021 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sale_item_status`
--

DROP TABLE IF EXISTS `stock_sale_item_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sale_item_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sell_asset`
--

DROP TABLE IF EXISTS `stock_sell_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sell_asset` (
  `sell_uid` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int NOT NULL,
  `stock_sell_datetime` varchar(200) NOT NULL,
  `stock_sell_price` float(10,2) NOT NULL,
  `stock_profit_price` float(10,2) NOT NULL,
  `exclude_vat_flag` int NOT NULL,
  `vatable` float(10,2) NOT NULL,
  `vat` float(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sell_uid`),
  KEY `stock_uid` (`stock_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_status`
--

DROP TABLE IF EXISTS `stock_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sub_category`
--

DROP TABLE IF EXISTS `stock_sub_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sub_category` (
  `stock_sub_category_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `stock_sub_category_name_th` varchar(100) DEFAULT NULL,
  `stock_sub_category_name_en` varchar(100) DEFAULT NULL,
  `stock_type_id` int NOT NULL,
  `stock_sub_category_status` int NOT NULL DEFAULT '1',
  `stock_sub_category_code` varchar(10) DEFAULT NULL,
  `icon_path` varchar(512) DEFAULT '_images/folder.png',
  `stock_sub_category_root_id` int DEFAULT '-1',
  `bill_info_th` varchar(45) DEFAULT NULL,
  `show_bill_info_flag` tinyint DEFAULT '0',
  `labs_type` int NOT NULL,
  PRIMARY KEY (`stock_sub_category_id`),
  KEY `stock_type_id` (`stock_type_id`),
  KEY `stock_sub_category_status` (`stock_sub_category_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sub_category_2`
--

DROP TABLE IF EXISTS `stock_sub_category_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sub_category_2` (
  `stock_sub_category_id` int NOT NULL AUTO_INCREMENT,
  `stock_sub_category_name_th` varchar(100) DEFAULT NULL,
  `stock_sub_category_name_en` varchar(100) DEFAULT NULL,
  `stock_sub_category_root_id` int NOT NULL DEFAULT '-1',
  `stock_sub_category_status` int NOT NULL DEFAULT '1',
  `stock_sub_category_code` varchar(10) DEFAULT NULL,
  `icon_path` varchar(512) DEFAULT '_images/folder.png',
  `stock_type_id` int DEFAULT '-1',
  PRIMARY KEY (`stock_sub_category_id`),
  KEY `stock_sub_category_status` (`stock_sub_category_status`),
  KEY `stock_type_id` (`stock_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sub_category_3`
--

DROP TABLE IF EXISTS `stock_sub_category_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sub_category_3` (
  `stock_sub_category_id` int NOT NULL AUTO_INCREMENT,
  `stock_sub_category_name_th` varchar(100) DEFAULT NULL,
  `stock_sub_category_name_en` varchar(100) DEFAULT NULL,
  `stock_sub_category_root_id` int NOT NULL DEFAULT '-1',
  `stock_sub_category_status` int NOT NULL DEFAULT '1',
  `stock_sub_category_code` varchar(10) DEFAULT NULL,
  `icon_path` varchar(512) DEFAULT '_images/folder.png',
  `stock_type_id` int DEFAULT '-1',
  PRIMARY KEY (`stock_sub_category_id`),
  KEY `stock_type_id` (`stock_type_id`),
  KEY `stock_sub_category_status` (`stock_sub_category_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sub_category_4`
--

DROP TABLE IF EXISTS `stock_sub_category_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sub_category_4` (
  `stock_sub_category_id` int NOT NULL AUTO_INCREMENT,
  `stock_sub_category_name_th` varchar(100) DEFAULT NULL,
  `stock_sub_category_name_en` varchar(100) DEFAULT NULL,
  `stock_sub_category_root_id` int NOT NULL DEFAULT '-1',
  `stock_sub_category_status` int NOT NULL DEFAULT '1',
  `stock_sub_category_code` varchar(10) DEFAULT NULL,
  `icon_path` varchar(512) DEFAULT '_images/folder.png',
  `stock_type_id` int DEFAULT '-1',
  PRIMARY KEY (`stock_sub_category_id`),
  KEY `stock_type_id` (`stock_type_id`),
  KEY `stock_sub_category_status` (`stock_sub_category_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sub_category_5`
--

DROP TABLE IF EXISTS `stock_sub_category_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sub_category_5` (
  `stock_sub_category_id` int NOT NULL AUTO_INCREMENT,
  `stock_sub_category_name_th` varchar(100) DEFAULT NULL,
  `stock_sub_category_name_en` varchar(100) DEFAULT NULL,
  `stock_sub_category_root_id` int NOT NULL DEFAULT '-1',
  `stock_sub_category_status` int NOT NULL DEFAULT '1',
  `stock_sub_category_code` varchar(10) DEFAULT NULL,
  `icon_path` varchar(512) DEFAULT '_images/folder.png',
  `stock_type_id` int DEFAULT '-1',
  PRIMARY KEY (`stock_sub_category_id`),
  KEY `stock_type_id` (`stock_type_id`),
  KEY `stock_sub_category_status` (`stock_sub_category_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_sub_category_status`
--

DROP TABLE IF EXISTS `stock_sub_category_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_sub_category_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_type`
--

DROP TABLE IF EXISTS `stock_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `typename` varchar(200) NOT NULL,
  `stock_category_id` int NOT NULL,
  `stock_unit_name` varchar(10) DEFAULT 'รายการ',
  `other_stock_main_category_id` int NOT NULL DEFAULT '-1',
  `typename_en` varchar(20) DEFAULT NULL,
  `stock_type_bill_th_1` varchar(45) DEFAULT NULL,
  `stock_type_bill_en_1` varchar(45) DEFAULT NULL,
  `stock_type_bill_th_2` varchar(45) DEFAULT NULL,
  `stock_type_bill_en_2` varchar(45) DEFAULT NULL,
  `stock_type_status` int NOT NULL DEFAULT '1',
  `stock_type_code` varchar(3) DEFAULT NULL,
  `icon_path` varchar(512) DEFAULT NULL,
  `is_short_label` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_category_id` (`stock_category_id`),
  KEY `stock_type_status` (`stock_type_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_type_status`
--

DROP TABLE IF EXISTS `stock_type_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_type_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_usage_summary`
--

DROP TABLE IF EXISTS `stock_usage_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_usage_summary` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int NOT NULL DEFAULT '-1',
  `payment_date` date DEFAULT NULL,
  `stock_id` varchar(50) DEFAULT NULL,
  `payment_name` varchar(125) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `payment_amount_unit_id` int DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT NULL,
  `total_cost` double DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `payment_total_net_price` double DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `stock_uid` (`stock_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_use_frequency_type`
--

DROP TABLE IF EXISTS `stock_use_frequency_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_use_frequency_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `typename` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_using`
--

DROP TABLE IF EXISTS `stock_using`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_using` (
  `using_uid` int NOT NULL AUTO_INCREMENT,
  `stock_uid` int NOT NULL,
  `using_header` text NOT NULL,
  `using_content` text NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`using_uid`),
  KEY `stock_uid` (`stock_uid`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_warehouse_info`
--

DROP TABLE IF EXISTS `stock_warehouse_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_warehouse_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `stock_uid` int DEFAULT NULL,
  `unit_name` varchar(20) DEFAULT NULL,
  `warehouse` varchar(60) DEFAULT NULL,
  `stock_qty` float(10,2) DEFAULT '0.00',
  `unit_id` int DEFAULT '-1',
  `update_flag` tinyint DEFAULT '0',
  `location` varchar(255) DEFAULT NULL,
  `warehouse_type_id` int DEFAULT '3',
  `warehouse_id` int DEFAULT '-1',
  `default_warehouse` tinyint DEFAULT '0',
  `all_ml_remaining` float(10,2) DEFAULT '0.00',
  `stock_warehouse_status` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `stock_uid` (`stock_uid`),
  KEY `stock_warehouse_status` (`stock_warehouse_status`),
  KEY `warehouse_id` (`warehouse_id`),
  KEY `warehouse_type_id` (`warehouse_type_id`),
  KEY `branch_id` (`branch_id`),
  KEY `idx_stock_warehouse_stock_uid` (`stock_uid`,`warehouse_type_id`,`stock_warehouse_status`)
) ENGINE=InnoDB AUTO_INCREMENT=32821 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_warehouse_status`
--

DROP TABLE IF EXISTS `stock_warehouse_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_warehouse_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockadjust_log`
--

DROP TABLE IF EXISTS `stockadjust_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stockadjust_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `stockadjust_id` varchar(200) NOT NULL,
  `branch_id` int NOT NULL,
  `user_id` int NOT NULL,
  `stock_uid` int NOT NULL DEFAULT '1',
  `stock_id_old` varchar(200) NOT NULL,
  `stock_id_new` varchar(200) NOT NULL,
  `stock_name_old` varchar(200) NOT NULL,
  `stock_name_new` varchar(200) NOT NULL,
  `everage_purchase_price_per_each_old` float(10,2) NOT NULL,
  `everage_purchase_price_per_each_new` float(10,2) NOT NULL,
  `stock_sale_item_price_old` float(10,2) NOT NULL,
  `stock_sale_item_price_new` float(10,2) NOT NULL,
  `username` varchar(200) NOT NULL,
  `status_name` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_opd`
--

DROP TABLE IF EXISTS `support_opd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_opd` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `stock_warehouse_id` int NOT NULL,
  `stock_sale_warehouse_id` int NOT NULL,
  `vaccine` int NOT NULL,
  `eye` int NOT NULL,
  `skin` int NOT NULL,
  `inhouse_lab` int NOT NULL,
  `out_lab` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `surgery`
--

DROP TABLE IF EXISTS `surgery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgery` (
  `surgery_uid` int NOT NULL AUTO_INCREMENT,
  `pet_uid` int NOT NULL,
  `queue_uid` int NOT NULL,
  `expense_uid` int NOT NULL,
  `branch_id` int NOT NULL DEFAULT '1',
  `disease` varchar(200) NOT NULL,
  `symptoms` text NOT NULL,
  `typesurgery` text NOT NULL,
  `pre_drug_1` varchar(200) NOT NULL,
  `pre_vol_1` varchar(20) NOT NULL,
  `pre_time_1` varchar(100) NOT NULL,
  `pre_drug_2` varchar(200) NOT NULL,
  `pre_vol_2` varchar(20) NOT NULL,
  `pre_time_2` varchar(100) NOT NULL,
  `ane_drug` varchar(200) NOT NULL,
  `ane_vol` varchar(20) NOT NULL,
  `ane_time` varchar(100) NOT NULL,
  `local_drug` varchar(200) NOT NULL,
  `local_vol` varchar(20) NOT NULL,
  `local_time` varchar(100) NOT NULL,
  `general_drug` varchar(200) NOT NULL,
  `general_vol` varchar(20) NOT NULL,
  `general_start` varchar(100) NOT NULL,
  `general_time` varchar(100) NOT NULL,
  `cri_drug` varchar(200) NOT NULL,
  `cri_vol` varchar(20) NOT NULL,
  `saline_1` varchar(200) NOT NULL,
  `saline_vol_1` varchar(20) NOT NULL,
  `saline_rate_1` varchar(20) NOT NULL,
  `saline_2` varchar(200) NOT NULL,
  `saline_vol_2` varchar(20) NOT NULL,
  `saline_rate_2` varchar(20) NOT NULL,
  `saline_total_2` varchar(20) NOT NULL,
  `asa` varchar(20) NOT NULL,
  `image` longtext NOT NULL,
  `technique` text NOT NULL,
  `note` text NOT NULL,
  `assistant_1` varchar(200) NOT NULL,
  `assistant_2` varchar(200) NOT NULL,
  `anesthesiologist` varchar(200) NOT NULL,
  `doctor_id` varchar(200) NOT NULL,
  `logged_in_user` int DEFAULT NULL,
  `surgery_modify_datetime` varchar(200) NOT NULL,
  `status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`surgery_uid`),
  KEY `pet_uid` (`pet_uid`),
  KEY `queue_uid` (`queue_uid`),
  KEY `expense_uid` (`expense_uid`),
  KEY `status` (`status`),
  KEY `idx_surgery_branch_status` (`branch_id`,`status`),
  KEY `idx_surgery_pet_uid` (`pet_uid`),
  KEY `idx_surgery_queue_uid` (`queue_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4419 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `surgery_add_cut_stock`
--

DROP TABLE IF EXISTS `surgery_add_cut_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgery_add_cut_stock` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `surgery_uid` int NOT NULL,
  `related_item_id` int NOT NULL,
  `item_uid` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `surgery_uid` (`surgery_uid`),
  KEY `related_item_id` (`related_item_id`),
  KEY `item_uid` (`item_uid`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `surgery_lab`
--

DROP TABLE IF EXISTS `surgery_lab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `surgery_lab` (
  `lab_id` int NOT NULL AUTO_INCREMENT,
  `surgery_uid` int NOT NULL,
  `pet_uid` int NOT NULL,
  `branch_id` int NOT NULL,
  `lab_type_id` int NOT NULL,
  `product` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `lab_status` int DEFAULT NULL,
  `is_idexx` int DEFAULT '0',
  `logged_in_user` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags_keyword`
--

DROP TABLE IF EXISTS `tags_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags_keyword` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(200) NOT NULL,
  `tag_status` int NOT NULL DEFAULT '1',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tag_id`),
  KEY `tag_status` (`tag_status`)
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_amphures`
--

DROP TABLE IF EXISTS `tbl_amphures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_amphures` (
  `amphur_id` int NOT NULL AUTO_INCREMENT,
  `amphur_code` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amphur_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amphur_name_eng` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `geo_id` int NOT NULL DEFAULT '0',
  `province_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`amphur_id`),
  KEY `amphur_code` (`amphur_code`),
  KEY `province_id` (`province_id`),
  KEY `geo_id` (`geo_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_districts`
--

DROP TABLE IF EXISTS `tbl_districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_districts` (
  `district_id` int NOT NULL AUTO_INCREMENT,
  `district_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `district_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `district_name_eng` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amphur_id` int NOT NULL DEFAULT '0',
  `province_id` int NOT NULL DEFAULT '0',
  `geo_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`district_id`),
  KEY `geo_id` (`geo_id`),
  KEY `province_id` (`province_id`),
  KEY `amphur_id` (`amphur_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8921 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='InnoDB free: 8192 kB';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_geography`
--

DROP TABLE IF EXISTS `tbl_geography`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_geography` (
  `geo_id` int NOT NULL AUTO_INCREMENT,
  `geo_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`geo_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='InnoDB free: 8192 kB';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_provinces`
--

DROP TABLE IF EXISTS `tbl_provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_provinces` (
  `province_id` int NOT NULL AUTO_INCREMENT,
  `province_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_name_eng` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `geo_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`province_id`),
  KEY `geo_id` (`geo_id`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_zipcodes`
--

DROP TABLE IF EXISTS `tbl_zipcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_zipcodes` (
  `zipcode_id` int NOT NULL AUTO_INCREMENT,
  `district_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `zipcode_name` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`zipcode_id`),
  KEY `district_code` (`district_code`)
) ENGINE=MyISAM AUTO_INCREMENT=7513 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timer_plan`
--

DROP TABLE IF EXISTS `timer_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timer_plan` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL,
  `plan_id` varchar(100) NOT NULL,
  `payment_id` int NOT NULL,
  `opd_id` int NOT NULL,
  `admit_id` int NOT NULL,
  `surgery_uid` int NOT NULL,
  `stock_uid` int NOT NULL,
  `timer_type` varchar(50) NOT NULL,
  `timer_start` varchar(50) NOT NULL,
  `timer_end` varchar(50) NOT NULL,
  `timer_time_end` varchar(50) DEFAULT NULL,
  `timer_cutting_every` int NOT NULL,
  `timer_cutting_every_unit` varchar(50) NOT NULL,
  `timer_cutting_stock` varchar(50) NOT NULL,
  `timer_in_minute` int NOT NULL,
  `timer_status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timer_plan_status`
--

DROP TABLE IF EXISTS `timer_plan_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timer_plan_status` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `status_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timesheet`
--

DROP TABLE IF EXISTS `timesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timesheet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '-1',
  `record_datetime` datetime NOT NULL,
  `timesheet_type` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timesheet_type`
--

DROP TABLE IF EXISTS `timesheet_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timesheet_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `total_bill_summary_report_per_day`
--

DROP TABLE IF EXISTS `total_bill_summary_report_per_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_bill_summary_report_per_day` (
  `date` date NOT NULL,
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `total_revenue_cash` double DEFAULT NULL,
  `total_revenue_credit_debit` double DEFAULT NULL,
  `total_revenue_others` double DEFAULT NULL,
  `total_expenses` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `total_bill_summary_report_per_day_no_cashier`
--

DROP TABLE IF EXISTS `total_bill_summary_report_per_day_no_cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_bill_summary_report_per_day_no_cashier` (
  `date` date DEFAULT NULL,
  `total_revenue_cash` double DEFAULT NULL,
  `total_revenue_credit_debit` double DEFAULT NULL,
  `total_revenue_others` double DEFAULT NULL,
  `other_revenues` double DEFAULT NULL,
  `total_all_revenue` double DEFAULT NULL,
  `total_all_expenses` double DEFAULT NULL,
  `net_revenue_total` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `total_bill_summary_report_per_day_with_cashier`
--

DROP TABLE IF EXISTS `total_bill_summary_report_per_day_with_cashier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_bill_summary_report_per_day_with_cashier` (
  `date` date DEFAULT NULL,
  `cashier_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `cashier_period_name` varchar(50) DEFAULT 'ไม่ระบุ',
  `total_revenue_cash` double DEFAULT NULL,
  `total_revenue_credit_debit` double DEFAULT NULL,
  `total_revenue_others` double DEFAULT NULL,
  `other_revenues` double DEFAULT NULL,
  `total_all_revenue` double DEFAULT NULL,
  `total_all_expenses` double DEFAULT NULL,
  `net_revenue_total` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `total_cutting_stock_remaining_by_warehouse`
--

DROP TABLE IF EXISTS `total_cutting_stock_remaining_by_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_cutting_stock_remaining_by_warehouse` (
  `warehouse_id` int NOT NULL DEFAULT '-1',
  `stock_uid` int DEFAULT '-1',
  `warehouse` varchar(60) DEFAULT NULL,
  `all_remaining` double DEFAULT NULL,
  `all_ml_remaining` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `total_stock_remaining`
--

DROP TABLE IF EXISTS `total_stock_remaining`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_stock_remaining` (
  `stock_uid` int NOT NULL DEFAULT '0',
  `stock_id` varchar(50) NOT NULL,
  `stock_category_id` int DEFAULT NULL,
  `stock_number_alert` int DEFAULT '0',
  `ml_remaining_alert` float DEFAULT '0',
  `cutting_stock_mode` int DEFAULT '1',
  `stock_number` double DEFAULT NULL,
  `all_ml_remaining` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transfer`
--

DROP TABLE IF EXISTS `transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer` (
  `transfer_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `transfer_id` varchar(20) NOT NULL,
  `user_id` int NOT NULL,
  `status` int NOT NULL,
  `transfer_add_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transfer_modify_timestamp` varchar(200) NOT NULL,
  PRIMARY KEY (`transfer_uid`),
  KEY `status` (`status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8775 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transfer_stock_info`
--

DROP TABLE IF EXISTS `transfer_stock_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfer_stock_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transfer_uid` int NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `stock_uid` int DEFAULT '-1',
  `from_stock_warehouse_info_id` int DEFAULT '-1',
  `from_warehouse` int NOT NULL,
  `to_stock_warehouse_info_id` int DEFAULT '-1',
  `to_warehouse` int NOT NULL,
  `transfer_amount` float DEFAULT '0',
  `transfer_unit_id` int DEFAULT '-1',
  `more_information` varchar(512) DEFAULT NULL,
  `logged_user_id` int DEFAULT '-1',
  `transfer_datetime` datetime DEFAULT NULL,
  `cutting_stock_mode` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `transfer_uid` (`transfer_uid`),
  KEY `status` (`status`),
  KEY `stock_uid` (`stock_uid`)
) ENGINE=InnoDB AUTO_INCREMENT=65415 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `type_salary`
--

DROP TABLE IF EXISTS `type_salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_salary` (
  `type_salary_id` int NOT NULL AUTO_INCREMENT,
  `type_salary_name` varchar(200) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`type_salary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `user_code` varchar(100) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `user_type` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `address` varchar(255) NOT NULL,
  `card_number` varchar(13) NOT NULL,
  `allow_to_login` int DEFAULT '0',
  `logged_in` int NOT NULL,
  `admin_is_vet` tinyint DEFAULT '0',
  `is_active` tinyint DEFAULT '0',
  `license` varchar(128) DEFAULT NULL,
  `stock_verification_flag` tinyint DEFAULT '0',
  `stock_permission_flag` tinyint DEFAULT '0',
  `allow_discount_permission` tinyint DEFAULT '1',
  `discount_percentage_limit` float DEFAULT '100',
  `allow_adjust_sale_price` tinyint DEFAULT '1',
  `permission_user` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quit_status` int NOT NULL DEFAULT '0',
  `quit_date` date DEFAULT NULL,
  `password_slip` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_type` (`user_type`),
  KEY `logged_in` (`logged_in`),
  KEY `allow_to_login` (`allow_to_login`),
  KEY `is_active` (`is_active`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_queue`
--

DROP TABLE IF EXISTS `user_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_queue` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `is_active` int NOT NULL DEFAULT '0',
  `room_id` int DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=76001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_salary`
--

DROP TABLE IF EXISTS `user_salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_salary` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `salary_uid` int NOT NULL,
  `salary_id` varchar(200) NOT NULL,
  `user_id` int NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `df_commission` decimal(10,2) NOT NULL,
  `overtime_pay` decimal(10,2) NOT NULL,
  `other_pay` decimal(10,2) NOT NULL,
  `total_pay` decimal(10,2) NOT NULL,
  `tax_cut` decimal(10,2) NOT NULL,
  `insure_cut` decimal(10,2) NOT NULL,
  `other_cut` decimal(10,2) NOT NULL,
  `total_cut` float(10,2) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`),
  KEY `salary_uid` (`salary_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_type`
--

DROP TABLE IF EXISTS `user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_type` (
  `user_type_id` int NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(30) NOT NULL,
  `is_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_withholding_taxes`
--

DROP TABLE IF EXISTS `user_withholding_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_withholding_taxes` (
  `withhold_taxes_uid` int NOT NULL AUTO_INCREMENT,
  `branch_id` int NOT NULL DEFAULT '1',
  `pk_salary_uid` int NOT NULL,
  `salary_uid` int NOT NULL,
  `tax_info` mediumtext,
  `cost_uid` int NOT NULL,
  `user_id` int NOT NULL,
  `manufacturer_id` int NOT NULL,
  `doc_number` varchar(255) NOT NULL,
  `withhold_taxes_type_id` int NOT NULL DEFAULT '1',
  `type_salary_id` int NOT NULL DEFAULT '1',
  `amount_paid` varchar(200) NOT NULL,
  `deduction_rate` varchar(200) NOT NULL,
  `tax_deductible` varchar(200) NOT NULL,
  `pnd_type_id` int NOT NULL DEFAULT '1',
  `social_security_fund` varchar(200) NOT NULL,
  `provident_fund` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`withhold_taxes_uid`),
  KEY `pk_salary_uid` (`pk_salary_uid`),
  KEY `salary_uid` (`salary_uid`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vat_type`
--

DROP TABLE IF EXISTS `vat_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vat_type` (
  `id` int NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ward_type`
--

DROP TABLE IF EXISTS `ward_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ward_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ward_type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warehouse` varchar(58) DEFAULT NULL,
  `warehouse_detail` varchar(255) DEFAULT NULL,
  `warehouse_type_id` int NOT NULL DEFAULT '1',
  `warehouse_location` varchar(255) DEFAULT NULL,
  `default_warehouse` tinyint NOT NULL DEFAULT '0',
  `warehouse_status` int NOT NULL DEFAULT '1',
  `branch_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `warehouse_type_id` (`warehouse_type_id`),
  KEY `warehouse_status` (`warehouse_status`),
  KEY `branch_id` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_status`
--

DROP TABLE IF EXISTS `warehouse_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_stock_remaining`
--

DROP TABLE IF EXISTS `warehouse_stock_remaining`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_stock_remaining` (
  `stock_uid` int NOT NULL AUTO_INCREMENT,
  `stock_id` varchar(50) NOT NULL,
  `stock_category_id` int DEFAULT NULL,
  `stock_number_alert` int DEFAULT '0',
  `ml_remaining_alert` float DEFAULT '0',
  `cutting_stock_mode` int DEFAULT '1',
  `warehouse_id` int DEFAULT '-1',
  `stock_number` float DEFAULT '0',
  `all_ml_remaining` float DEFAULT '0',
  PRIMARY KEY (`stock_uid`),
  KEY `stock_category_id` (`stock_category_id`),
  KEY `warehouse_id` (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse_type`
--

DROP TABLE IF EXISTS `warehouse_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warning_list`
--

DROP TABLE IF EXISTS `warning_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warning_list` (
  `warning_id` int NOT NULL AUTO_INCREMENT,
  `warning_type` int NOT NULL,
  `warning_detail` varchar(64) NOT NULL,
  `pet_uid` int NOT NULL,
  `warning_status` int NOT NULL DEFAULT '1',
  `add_datetime` datetime NOT NULL,
  PRIMARY KEY (`warning_id`),
  KEY `warning_type` (`warning_type`),
  KEY `pet_uid` (`pet_uid`),
  KEY `warning_status` (`warning_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1829 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warning_type`
--

DROP TABLE IF EXISTS `warning_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warning_type` (
  `type_uid` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(200) NOT NULL,
  `type_status` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`type_uid`),
  KEY `type_status` (`type_status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `withhold_taxes_type`
--

DROP TABLE IF EXISTS `withhold_taxes_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withhold_taxes_type` (
  `withhold_taxes_type_id` int NOT NULL AUTO_INCREMENT,
  `timestamp_name` varchar(200) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`withhold_taxes_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-07  0:00:18
