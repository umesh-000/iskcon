-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: iskcon
-- ------------------------------------------------------
-- Server version	8.0.39

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

--
-- Table structure for table `accounts_user`
--

DROP TABLE IF EXISTS `accounts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$870000$m0FPsJh1deHtep9cJAzMCm$CRUREkqRHQnEuPn+rvxl9cdLIdPmGqY/mDB3L4V28XY=','2024-11-27 11:13:28.926128',1,'umesh','','','admin@gmail.com',0,1,'2024-11-27 11:06:55.627221','admin'),(2,'pbkdf2_sha256$600000$q5FZjnfrceLdWNqkxXTcss$6Zu+k6/73Ebvw3bXu2PdUcRtaHG+bA4znDJeORxXPtM=','2024-12-09 07:58:01.437299',0,'ankushvyas','','','ghartaktech03@gmail.com',0,1,'2024-11-28 10:54:42.740325','admin'),(3,'pbkdf2_sha256$600000$ySJw3Lj5YH4hxOimIkEAsU$N5CtfVgN6AyHdy5m8d13ZIFZA+E9urxE3SIqAJ2P/fU=','2024-12-10 07:19:19.756682',0,'admin','','','admin@gmail.com',0,1,'2024-11-30 09:58:27.848289','admin'),(4,'pbkdf2_sha256$600000$hcBbHsLOevrrZtQaAh2k6A$WWUBsEvJGtF/3lJyiZV24YLgPYlyoFKRkaMrWJKmLFs=',NULL,0,'rodhu@gmail.com','Rinku','Mahawar','rodhu@gmail.com',0,1,'2024-12-09 11:02:00.968149','customer');
/*!40000 ALTER TABLE `accounts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_groups`
--

DROP TABLE IF EXISTS `accounts_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  KEY `accounts_user_groups_user_id_52b62117` (`user_id`),
  KEY `accounts_user_groups_group_id_bd11a704` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_groups`
--

LOCK TABLES `accounts_user_groups` WRITE;
/*!40000 ALTER TABLE `accounts_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_user_permissions`
--

DROP TABLE IF EXISTS `accounts_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  KEY `accounts_user_user_permissions_user_id_e4f0a161` (`user_id`),
  KEY `accounts_user_user_permissions_permission_id_113bb443` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_user_permissions`
--

LOCK TABLES `accounts_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `profile_image` varchar(100) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'',1),(2,'',2),(3,'',3);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add admins',5,'add_admins'),(18,'Can change admins',5,'change_admins'),(19,'Can delete admins',5,'delete_admins'),(20,'Can view admins',5,'view_admins'),(21,'Can add customer',6,'add_customer'),(22,'Can change customer',6,'change_customer'),(23,'Can delete customer',6,'delete_customer'),(24,'Can view customer',6,'view_customer'),(25,'Can add address book',7,'add_addressbook'),(26,'Can change address book',7,'change_addressbook'),(27,'Can delete address book',7,'delete_addressbook'),(28,'Can view address book',7,'view_addressbook'),(29,'Can add log entry',8,'add_logentry'),(30,'Can change log entry',8,'change_logentry'),(31,'Can delete log entry',8,'delete_logentry'),(32,'Can view log entry',8,'view_logentry'),(33,'Can add session',9,'add_session'),(34,'Can change session',9,'change_session'),(35,'Can delete session',9,'delete_session'),(36,'Can view session',9,'view_session'),(37,'Can add Blog',10,'add_blog'),(38,'Can change Blog',10,'change_blog'),(39,'Can delete Blog',10,'delete_blog'),(40,'Can view Blog',10,'view_blog'),(41,'Can add Book',11,'add_book'),(42,'Can change Book',11,'change_book'),(43,'Can delete Book',11,'delete_book'),(44,'Can view Book',11,'view_book'),(45,'Can add Event',12,'add_event'),(46,'Can change Event',12,'change_event'),(47,'Can delete Event',12,'delete_event'),(48,'Can view Event',12,'view_event'),(49,'Can add privacy policy',13,'add_privacypolicy'),(50,'Can change privacy policy',13,'change_privacypolicy'),(51,'Can delete privacy policy',13,'delete_privacypolicy'),(52,'Can view privacy policy',13,'view_privacypolicy'),(53,'Can add terms and conditions',14,'add_termsandconditions'),(54,'Can change terms and conditions',14,'change_termsandconditions'),(55,'Can delete terms and conditions',14,'delete_termsandconditions'),(56,'Can view terms and conditions',14,'view_termsandconditions'),(57,'Can add Notification',15,'add_notification'),(58,'Can change Notification',15,'change_notification'),(59,'Can delete Notification',15,'delete_notification'),(60,'Can view Notification',15,'view_notification');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `added_by_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blogs_added_by_id_861c71e6` (`added_by_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (34,'ffgdfdffg','fgdddfdfd','blogs/images/4642a8f387560c4eaa0ba769f88ed659.jpg','<p>gffffffffffffffffffffffffffffffffasaaaaaaaaaaaaaaaaa</p>',1,'2024-12-09 09:36:13.692507','2024-12-09 09:36:13.692507',3),(33,'test','testing','blogs/images/user-removebg-preview.png','<p>Description</p>',1,'2024-12-09 09:26:21.213899','2024-12-09 09:35:55.581548',3);
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author_name` varchar(255) NOT NULL,
  `cover_image` varchar(100) DEFAULT NULL,
  `status` int NOT NULL,
  `book_file` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (6,'jhjhjhjhjhjhjhg','fgfgfgfgfgfgfgfgfgfg','books/covers/user-removebg-preview.png',1,'books/files/download_opan8LB.pdf','2024-12-09 09:52:53.826787','2024-12-09 09:53:11.769508'),(5,'book','new book ','books/covers/58e266b8778fec12962e3f759675b029.jpeg',1,'books/files/TT_MCA_III_IV.pdf','2024-12-09 09:47:02.362341','2024-12-09 09:52:15.098336');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_address_book`
--

DROP TABLE IF EXISTS `customer_address_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_address_book` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(15) DEFAULT NULL,
  `address_type` varchar(10) DEFAULT NULL,
  `address_line_1` varchar(255) NOT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `customer_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_address_book_customer_id_address_type_f7a887bb_uniq` (`customer_id`,`address_type`,`is_default`),
  KEY `customer_address_book_customer_id_062e3114` (`customer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_address_book`
--

LOCK TABLES `customer_address_book` WRITE;
/*!40000 ALTER TABLE `customer_address_book` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_address_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `profile_image` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `status` int NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'','9157672461',0,'2024-12-09 11:02:00.982327','2024-12-09 11:02:00.982327',4,'1990-01-01','male');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'auth','permission'),(2,'auth','group'),(3,'contenttypes','contenttype'),(4,'accounts','user'),(5,'accounts','admins'),(6,'accounts','customer'),(7,'accounts','addressbook'),(8,'admin','logentry'),(9,'sessions','session'),(10,'myadmin','blog'),(11,'myadmin','book'),(12,'myadmin','event'),(13,'myadmin','privacypolicy'),(14,'myadmin','termsandconditions'),(15,'myadmin','notification');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-11-27 10:59:14.844257'),(2,'contenttypes','0002_remove_content_type_name','2024-11-27 10:59:14.914067'),(3,'auth','0001_initial','2024-11-27 10:59:15.249018'),(4,'auth','0002_alter_permission_name_max_length','2024-11-27 10:59:15.283922'),(5,'auth','0003_alter_user_email_max_length','2024-11-27 10:59:15.289906'),(6,'auth','0004_alter_user_username_opts','2024-11-27 10:59:15.293894'),(7,'auth','0005_alter_user_last_login_null','2024-11-27 10:59:15.314839'),(8,'auth','0006_require_contenttypes_0002','2024-11-27 10:59:15.315836'),(9,'auth','0007_alter_validators_add_error_messages','2024-11-27 10:59:15.319825'),(10,'auth','0008_alter_user_username_max_length','2024-11-27 10:59:15.323814'),(11,'auth','0009_alter_user_last_name_max_length','2024-11-27 10:59:15.328801'),(12,'auth','0010_alter_group_name_max_length','2024-11-27 10:59:15.361713'),(13,'auth','0011_update_proxy_permissions','2024-11-27 10:59:15.369696'),(14,'auth','0012_alter_user_first_name_max_length','2024-11-27 10:59:15.373681'),(15,'accounts','0001_initial','2024-11-27 10:59:15.922642'),(16,'admin','0001_initial','2024-11-27 10:59:22.271018'),(17,'admin','0002_logentry_remove_auto_add','2024-11-27 10:59:22.295951'),(18,'admin','0003_logentry_add_action_flag_choices','2024-11-27 10:59:22.303928'),(19,'sessions','0001_initial','2024-11-27 10:59:22.346822'),(20,'myadmin','0001_initial','2024-11-28 11:26:24.302374'),(21,'myadmin','0002_book','2024-12-04 06:30:29.543565'),(22,'myadmin','0003_event','2024-12-05 07:25:37.399392'),(23,'myadmin','0004_alter_event_options_remove_event_date_time_and_more','2024-12-05 07:51:32.554067'),(24,'myadmin','0005_alter_event_created_at_alter_event_description_and_more','2024-12-07 10:45:50.241253'),(25,'myadmin','0006_alter_event_table','2024-12-09 07:11:47.864156'),(26,'accounts','0002_customer_dob_customer_gender','2024-12-09 10:51:27.494970'),(27,'myadmin','0007_privacypolicy_termsandconditions','2024-12-09 12:00:13.647514'),(28,'myadmin','0008_notification','2024-12-10 05:34:57.502442');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('fdnk16boa3u3oqib0l46m2sfb8bwvmsr','.eJxVjs0OwiAQhN-Fc0MoBKQ9evcZyLK7WPyhprSJxvjuWtODXueb-TJPEWCZh7BUnkIm0YtWNL9ZBDxzWQGdoBxHiWOZpxzlWpEbrfIwEl_2W_dPMEAdPuvUaYiRUekWDTlSBnyMlHZJea2s6jpEZyxaRSa6lBg8QSKLxjkG7Vdp5VrzWALfb3l6iF41Auiay_d4-3oDLHdEYg:1tGFz6:IKGeXsjpC0KOtlodfI23SgyqnrxwzOCnXnQYToWBCmk','2024-11-27 12:13:28.927125'),('d85h3njc8m9k7k8zvz7j9fscese3wv52','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGco4:6DoKhg3vJp6hndqpr1IwP9lzVRoF3YSVrZHRSdcRjvY','2024-11-28 12:35:36.647305'),('zper903gdqphym4um5xnpap6bvcv95k1','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGeVS:a4Y6dZPNolwvUD3Yv4J1SKgKql1HRj58k8daVbj8Ml8','2024-11-28 14:24:30.939898'),('8m1k8t3teddl536blp7s1sotx1qa745d','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGtMF:PyB_4vKuxHrZ4I6Fubtv_GL87iSKa-9WhFg5CtkHeRc','2024-11-29 06:15:59.360671'),('jmabx59e3z6k0lik5bbdnwj0ltw0jqho','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGuJC:aw5pXIKW5xr8sWQDQdELLZrNls492u1aaIqsB9OxgDM','2024-11-29 07:16:54.628646'),('c7ql3tlqyog2s6klu2a1ncygwllns8nu','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGvKe:wKZ73E1wmsHA46ft4GaxrXuA2bcWNf1rkF3RH29rP7E','2024-11-29 08:22:28.339104'),('6p6yopfg09u58lg9qd3xda6aahmq8b4l','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGxwb:DyR70tNlbGAA494DNjIYKTlEeAkW0CAIDpg3nrTLBMw','2024-11-29 11:09:49.088707'),('pgsxoj9qjk0dkfqub3b3ipagixrzgfyy','.eJxVjssOwiAUBf-FdUOAUqBduvcbyAUuFh9gSptojP9uMF3o9sxkcl7EwrbOdqu42BTIRATpfjcH_oK5gXCGfCrUl7wuydGm0J1WeiwBr4fd_QvMUOeWHaLhPDKFJsIQJVc-ChTKReO04T0TGg03Y9QSBNNiQMak8T1wVMzxsUUr1ppKtvi4p-VJJtYRCLeUv8fF-wOul0Jg:1tGyu8:X-_vppOy9V8O6MUTq1pXB6k2rILCiOehn5i_LMYqdRM','2024-11-29 12:11:20.748433'),('ijae3c58hcfba7u63x1wzez2p054xxur','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tHKFG:sACI6iArI3Z2rfILFZgx-2j5sm1Yh8aqPbQKF7AqFWc','2024-11-30 10:58:34.657535'),('jk7qfghq7shd0oq3tj75v01w8kl4gi4g','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tINeb:fMyjyDD5X58WDHZZyKiAmmwIZjk55DgsrEPk4XtPf2w','2024-12-03 08:49:05.897702'),('z0f31cr1cvt6owy8zsdcs54fxd62uqve','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tIP3p:kYuCXeNxweZ2OL_h98k-YA4Bcr-EhMsShYwEzbVjekE','2024-12-03 10:19:13.719716'),('gcj86guqtvv5nmc53wg7o2s2gwsydmr1','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tIj0s:hn7urxIka_ivFw3QOCG3JkFrBd3qH3FJfUm43qbIJ6M','2024-12-04 07:37:30.089046'),('hrk63bqe49uudcymdogmk9gj9lp31d8s','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tIk0x:HjfRggHC1Qjur4PgFZgKSOgcLmbtGC-uT74MZol6S5A','2024-12-04 08:41:39.490027'),('t8boe6c5k89x4hd8cigzo42vxwj06rp5','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tIl9X:O2hTXXXRO6Z15J6N_e3oA452VB7eeO-jFbTLJeMrASk','2024-12-04 09:54:35.476362'),('7e90smmzls8gf77v3nrjv41770ph1qv1','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tImEo:k0cG8j72j5JVXcsM303UfcY5Lqvb6XNQAGAxsyfnKmY','2024-12-04 11:04:06.683150'),('x1ui8a802m9rc7pj6idmvrwpxy77ncl0','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJ3hh:tyUn4WNYns37hAqKsMKJHqHd2S2tf3PQydY6qcqPqj8','2024-12-05 05:43:05.673676'),('cv9n4xs43wx4zs7pkgebbul6ule2206x','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJ6JQ:q9pri6J_XCSm6nT6L_mKojjkOMiLfS2G6GCGh69CGrE','2024-12-05 08:30:12.913556'),('mvmlsrcwk8ol5jl5vc4ubpmy5n4l375q','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJ63p:LazdBacQ2zOEey8r-TLYP0trZYy5iAualYBAeA0z5NY','2024-12-05 08:14:05.742958'),('8n8fjf45mn2r1iaqhykpp14cmncqpk31','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJ7G4:KYXALLrWaqOmgeH0LVh2Q0Y-ANPepY19m_Y7WzJeBsY','2024-12-05 09:30:48.850684'),('yi1ldvtg1w0znzir35bm6ndolmfjm753','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJ8NU:MYrC83dqTzXTtVzR0sIbsXVlZQ_25vXI7twFL4t4lk8','2024-12-05 10:42:32.273866'),('3kbnt86gb8qbikfdpd0k6ncei1efy9hx','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJV3X:lhpABnkj1RTTCptVyJJqgROITMsFa4qQR8AE64hzLU8','2024-12-06 10:55:27.630457'),('fagoarz8ggrwi32b80pm0wszipvu9mli','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJW25:DRbb7TkK8uwQkJbjOl7fWWN2nATy9eCdqJSDk2TA5Ew','2024-12-06 11:58:01.860705'),('r1kuya3bnapnd58s056fmspofhp6vjha','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJqOU:-_rLmuDIh20UhM7NA_NgR_J0E3wIB0zBeQvV0PWaXuI','2024-12-07 09:42:30.886434'),('fwdaqv2l23visdp7349yne6gz481iu1t','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJsf4:F4AaJbde2lVpzaR1TjQxFvlsbtPVZlIZupNlz4oNfas','2024-12-07 12:07:46.664253'),('czz75kkspcjlcop9imb54xk1j3o0mrwf','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tJu9L:keh3WxB54PnsIa3_uwkfU6Furs79cgWK7sfbi-aMhZE','2024-12-07 13:43:07.232438'),('0054sh3cekth9pkq3ip87w0h5w2rx9uy','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tJv9J:nWMfhgbP0CTVgvyW2XUZk4TbDuflkuVSu_RNUgMqjoI','2024-12-07 14:47:09.206891'),('g2yo4s2e2irlzkba0539ewfv73wuuntz','.eJxVjssOwiAURP-FdUPgIpS6dO83ELjcWnyAKW2iMf67tulCt3NmJufFnJ-nwc2VRpci2zNgzW8WPF4oLyCefT4VjiVPYwp8qfCNVn4ska6Hrft3MPg6fNfUewiqQ6vJBAgSwBqxg17b1mhSaAMZlEZLLxWi72IUFmMETdoo2a5WlWpNJTt63NP4ZPsWhGiYj7eUV3d4fwChd0O0:1tKWIu:rT02V7hnGnuhKTSSu7vza-f2c89Vx5u_ZAG-9Smm0E4','2024-12-09 07:27:32.445857'),('opohz8wyr0y5rh4razrgvdnv7zo2ir0k','.eJxVjs0OwiAQhN-Fc9OURSj16N1nILC7tfgDprSJxvju2qYHvc43M_lewvl5GtxceHSRxF6AqH6z4PHCaQF09umUa8xpGmOol0q90VIfM_H1sHX_DgZfhu-aew9BdWg1mwBBAljT7KDXtjWaFdrABqXR0kuF6DuixiIRaNZGyXa1KlxKzMnx4x7Hp9g3lfB0i2kVh_cH3CFDGw:1tKYeX:lYaAU_LrFLaHOWREgoWgep9jQy7GjtIOarLGXM-mmuw','2024-12-09 08:58:01.441472'),('kjrgz3ll2d59wcglp9wdd5aw1qlbmbpz','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tKZwe:jhv-p1fydY-67WBcyuC__n7s7UV7JY8SDpFaRmOrBpc','2024-12-09 10:20:48.616910'),('o2bzb3zahd7f6hxq0anj0rkg4s8aiphe','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tKcDe:MaSROECAeKmelP7alNa4mSyS3lniNkXoYR64tq_Aqo4','2024-12-09 12:46:30.635777'),('efxhy5y2isfrums3gk3va27psl2wbdpy','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tKdCd:R1n_Rh1PUM6b8s0_jMfPBewR5LZUSnuewlAy8Z-j4vk','2024-12-09 13:49:31.292957'),('r3xl6utr0yyfa2yt57mo2uwys5wchmk8','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tKsLH:bV6zMnUfg4Az7te1_D6VVoMkpDt9x2UKiaR31FVdeVw','2024-12-10 05:59:27.382890'),('6v87j0j4xoyu9bxh8x2sitqdkt8c5b9c','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tKtIU:ATSpPYf-793e-lXXejLEdJD0xGCzAdkWi1dD1kyV6uY','2024-12-10 07:00:38.605737'),('ulkgwh23xjwohkzipgd8h73hutukp6k6','.eJxVjssOwiAURP-FdUNKoSBduvcbyIV7sfgAU9pEY_x3relCt3NmTubJHCzz6JZKk0vIBiZZ85t5CGfKK8AT5GPhoeR5Sp6vFb7Ryg8F6bLfun-CEer4WUMnTasURWtRQAfBopfkiaLYCR2NUL4H9DsyUZOybYfKBOxBEXnUoFdppVpTyY7utzQ92NA2DPCa8ve4fL0BJ01Edg:1tKuWd:YEteVv9XKseORaTql-6QxsKRPoR6MG-R3bnnhsv55yU','2024-12-10 08:19:19.770431');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myadmin_event`
--

DROP TABLE IF EXISTS `myadmin_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `myadmin_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `venue` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myadmin_event`
--

LOCK TABLES `myadmin_event` WRITE;
/*!40000 ALTER TABLE `myadmin_event` DISABLE KEYS */;
INSERT INTO `myadmin_event` VALUES (20,'gthyh','<p>gdef</p>','hhjj',1,'2024-12-09 06:03:47.456311','2024-12-09 07:22:39.274366','events/pandit4poojan_WUP5hrn.webp'),(22,'event testing','<p>event</p>','event ',1,'2024-12-09 09:58:53.145229','2024-12-09 10:04:26.983522','events/worker-avatar-icon-orange-worker.png');
/*!40000 ALTER TABLE `myadmin_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `message` longtext,
  `target_audience` varchar(20) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privacy_policies`
--

DROP TABLE IF EXISTS `privacy_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `privacy_policies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_policies`
--

LOCK TABLES `privacy_policies` WRITE;
/*!40000 ALTER TABLE `privacy_policies` DISABLE KEYS */;
INSERT INTO `privacy_policies` VALUES (1,'Privacy Policy','<h3>Privacy Policy for Ringtone Shuffle</h3><p><strong>Effective Date: [Insert Date]</strong></p><p>At <strong>Ringtone Shuffle</strong>, we value your privacy and are committed to protecting your personal information. This Privacy Policy outlines the types of information we collect, how we use it, and the steps we take to safeguard your data. By using our app, you agree to the collection and use of your information in accordance with this policy.</p><h4>1. Information We Collect</h4><p>When you use the <strong>Ringtone Shuffle</strong> app, we may collect the following types of information:</p><ul><li><strong>Personal Information</strong>: We may ask you to provide personal information such as your name, email address, and phone number when you register or communicate with us.</li><li><strong>Usage Data</strong>: We automatically collect information about how you interact with our app, including your device type, operating system, IP address, and usage patterns. This helps us improve the app experience.</li><li><strong>App Permissions</strong>: Our app may request permission to access features like storage and media on your device. You can control these permissions in your device settings.</li></ul><h4>2. How We Use Your Information</h4><p>We use the information we collect to:</p><ul><li>Provide and improve the app’s functionality, features, and performance.</li><li>Personalize your experience by offering ringtone recommendations based on your preferences.</li><li>Communicate with you regarding updates, features, or customer support.</li><li>Ensure the security of the app and protect against unauthorized access.</li></ul><h4>3. Data Retention</h4><p>We retain your data only as long as necessary to fulfill the purposes outlined in this Privacy Policy. If you choose to delete your account, we will remove your personal data from our servers within a reasonable period, unless required by law to retain it.</p><h4>4. Data Sharing and Disclosure</h4><p>We do not sell, rent, or trade your personal information to third parties. However, we may share your data with trusted third-party service providers to assist in the operation of the app, such as hosting services or analytics platforms. These service providers are bound by confidentiality agreements and may only use your data to provide services to <strong>Ringtone Shuffle</strong>.</p><p>We may also disclose your data if required by law or in response to legal requests (e.g., a court order, government inquiry).</p><h4>5. Security</h4><p>We take the security of your personal information seriously. We use industry-standard encryption to protect your data both in transit and at rest. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee the absolute security of your information.</p><h4>6. Your Rights and Choices</h4><ul><li><strong>Access and Update</strong>: You have the right to access, correct, or delete your personal data. You can do so by contacting us directly at support@ringtoneshuffle.com.</li><li><strong>Opt-Out of Communications</strong>: You can opt out of marketing emails by following the unsubscribe instructions included in the emails or adjusting your preferences in the app settings.</li><li><strong>App Permissions</strong>: You can manage permissions granted to the app through your device settings, including access to storage, microphone, and other media features.</li></ul><h4>7. Children’s Privacy</h4><p>The <strong>Ringtone Shuffle</strong> app is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13, we will take steps to delete that information as soon as possible.</p><h4>8. Changes to This Privacy Policy</h4><p>We may update our Privacy Policy from time to time to reflect changes in our practices, technologies, or legal requirements. When we make changes, we will update the \"Effective Date\" at the top of this page. We encourage you to review this Privacy Policy periodically to stay informed about how we are protecting your information.</p><h4>9. Contact Us</h4><p>If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:</p><p><strong>Ringtone Shuffle Support Team</strong><br>Email: support@ringtoneshuffle.com<br>Website: <a href=\"http://www.ringtoneshuffle.com\">www.ringtoneshuffle.com</a></p>',1,'2024-12-09 12:27:52.656836','2024-12-09 12:51:11.470613');
/*!40000 ALTER TABLE `privacy_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms_and_conditions`
--

DROP TABLE IF EXISTS `terms_and_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terms_and_conditions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms_and_conditions`
--

LOCK TABLES `terms_and_conditions` WRITE;
/*!40000 ALTER TABLE `terms_and_conditions` DISABLE KEYS */;
INSERT INTO `terms_and_conditions` VALUES (1,'Terms And Conditions','<h3>Terms and Conditions for Ringtone Shuffle</h3><p><strong>Effective Date: [Insert Date]</strong></p><p>Welcome to <strong>Ringtone Shuffle</strong>! These Terms and Conditions govern your use of the <strong>Ringtone Shuffle</strong> app and services. By accessing or using the app, you agree to comply with these terms. If you do not agree with any part of these terms, please do not use the app.</p><h4>1. Acceptance of Terms</h4><p>By using the <strong>Ringtone Shuffle</strong> app, you agree to be bound by these Terms and Conditions and any other policies referenced in this document. If you do not agree to these terms, you should not use the app.</p><h4>2. Changes to the Terms</h4><p>We reserve the right to update or modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting on this page, with an updated “Effective Date” at the top of the page. You are encouraged to review these terms periodically to stay informed of any changes.</p><h4>3. User Registration</h4><p>To access certain features of the <strong>Ringtone Shuffle</strong> app, you may be required to register for an account. You agree to provide accurate, current, and complete information during the registration process and to update this information as necessary.</p><ul><li><strong>Account Security</strong>: You are responsible for maintaining the confidentiality of your account login information and for all activities that occur under your account.</li><li><strong>Account Termination</strong>: We reserve the right to suspend or terminate your account if we believe you have violated any of these terms or engaged in any unlawful or inappropriate conduct.</li></ul><h4>4. Use of the App</h4><p>You agree to use the <strong>Ringtone Shuffle</strong> app in accordance with all applicable laws and regulations. You may not use the app for any unlawful or prohibited purposes, including but not limited to:</p><ul><li>Engaging in fraudulent activity</li><li>Using the app to distribute malicious content or viruses</li><li>Violating the rights of others, including their intellectual property rights</li></ul><h4>5. Content Ownership</h4><p>All content available through the <strong>Ringtone Shuffle</strong> app, including but not limited to text, images, videos, logos, and ringtones, is the property of <strong>Ringtone Shuffle</strong> or its licensors. You may not copy, modify, distribute, or create derivative works of any content without prior written consent.</p><h4>6. License to Use the App</h4><p>Subject to these Terms and Conditions, <strong>Ringtone Shuffle</strong> grants you a limited, non-exclusive, non-transferable license to access and use the app for personal, non-commercial purposes. This license does not permit you to:</p><ul><li>Reproduce, sell, or exploit any part of the app for commercial purposes</li><li>Reverse engineer or decompile the app</li></ul><h4>7. Payment and Subscriptions</h4><p>Certain features of the <strong>Ringtone Shuffle</strong> app may require payment. If you subscribe to any paid services, you agree to the payment terms provided at the time of purchase, including recurring billing if applicable. All payments are processed through secure payment gateways.</p><ul><li><strong>Refunds</strong>: Payments are non-refundable, except where required by law.</li></ul><h4>8. Data Collection and Privacy</h4><p>Your use of the app may involve the collection and processing of personal information as described in our <a href=\"#\">Privacy Policy</a>. By using the app, you consent to the collection and use of your information in accordance with our Privacy Policy.</p><h4>9. Disclaimers and Limitation of Liability</h4><p><strong>Ringtone Shuffle</strong> provides the app and services “as is” and does not make any representations or warranties regarding the app\'s functionality, availability, or security. We are not responsible for any damages, losses, or liabilities arising from your use of the app.</p><ul><li><strong>Limitation of Liability</strong>: In no event shall <strong>Ringtone Shuffle</strong> be liable for any indirect, incidental, or consequential damages arising from your use of the app, even if we have been advised of the possibility of such damages.</li></ul><h4>10. Indemnification</h4><p>You agree to indemnify, defend, and hold harmless <strong>Ringtone Shuffle</strong>, its affiliates, and its employees from any claims, damages, losses, liabilities, or expenses (including legal fees) arising from your use of the app, violation of these Terms and Conditions, or infringement of any rights of third parties.</p><h4>11. Termination</h4><p>We may suspend or terminate your access to the <strong>Ringtone Shuffle</strong> app at any time, with or without cause, without notice. Upon termination, you must immediately cease using the app and delete any copies of the app from your devices.</p><h4>12. Governing Law</h4><p>These Terms and Conditions shall be governed by and construed in accordance with the laws of the jurisdiction in which <strong>Ringtone Shuffle</strong> operates, without regard to its conflict of law principles.</p><h4>13. Contact Us</h4><p>If you have any questions or concerns about these Terms and Conditions, please contact us at:</p><p><strong>Ringtone Shuffle Support Team</strong><br>Email: support@ringtoneshuffle.com<br>Website: <a href=\"http://www.ringtoneshuffle.com\">www.ringtoneshuffle.com</a></p>',1,'2024-12-09 12:45:33.586715','2024-12-09 12:50:54.475556');
/*!40000 ALTER TABLE `terms_and_conditions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-10 13:01:35
