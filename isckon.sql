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
-- Table structure for table `about_us`
--

DROP TABLE IF EXISTS `about_us`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about_us` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about_us`
--

LOCK TABLES `about_us` WRITE;
/*!40000 ALTER TABLE `about_us` DISABLE KEYS */;
INSERT INTO `about_us` VALUES (1,'7ii','<p>iiii</p>',1,'2024-12-13 10:09:49.097416','2024-12-14 11:48:12.247366');
/*!40000 ALTER TABLE `about_us` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
INSERT INTO `accounts_user` VALUES (1,'pbkdf2_sha256$600000$VPQFuhTFQLdNfR5jD0YXB2$FbeLq//PT2APvHstwr6uHQdNy0mMJ/oU8Ce+vpASIHA=','2024-12-16 09:48:38.462184',0,'admin','','','admin@gmail.com',0,1,'2024-12-11 07:15:32.702346','admin'),(4,'pbkdf2_sha256$600000$qRu0gWj1aa8UIBJ5ZaZcGj$vlOYlLGTrodyTibzRmtGztOGdfUGhvAUbkZhnDh2nnA=',NULL,0,'umesh@gmail.com','umesh','prajapati','umesh@gmail.com',0,1,'2024-12-14 11:40:57.831692','customer'),(6,'pbkdf2_sha256$600000$DsmXIwlXYfgLqOUk10lOF2$zPMl7LN2ejvIpl0limxeRpwHQaMB+rBluLQXSPE3+OY=',NULL,0,'ansh@gmail.com','Jolene','Reid','ansh@gmail.com',0,1,'2024-12-16 09:57:23.597259','customer');
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'',1);
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio_tracks`
--

DROP TABLE IF EXISTS `audio_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio_tracks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `artist` varchar(255) DEFAULT NULL,
  `duration` bigint DEFAULT NULL,
  `thumbnail` varchar(100) DEFAULT NULL,
  `track_file` varchar(100) NOT NULL,
  `status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `uploaded_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `audio_tracks_uploaded_by_id_8a9cb075` (`uploaded_by_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio_tracks`
--

LOCK TABLES `audio_tracks` WRITE;
/*!40000 ALTER TABLE `audio_tracks` DISABLE KEYS */;
/*!40000 ALTER TABLE `audio_tracks` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add customer',5,'add_customer'),(18,'Can change customer',5,'change_customer'),(19,'Can delete customer',5,'delete_customer'),(20,'Can view customer',5,'view_customer'),(21,'Can add admins',6,'add_admins'),(22,'Can change admins',6,'change_admins'),(23,'Can delete admins',6,'delete_admins'),(24,'Can view admins',6,'view_admins'),(25,'Can add address book',7,'add_addressbook'),(26,'Can change address book',7,'change_addressbook'),(27,'Can delete address book',7,'delete_addressbook'),(28,'Can view address book',7,'view_addressbook'),(29,'Can add Book',8,'add_book'),(30,'Can change Book',8,'change_book'),(31,'Can delete Book',8,'delete_book'),(32,'Can view Book',8,'view_book'),(33,'Can add Event',9,'add_event'),(34,'Can change Event',9,'change_event'),(35,'Can delete Event',9,'delete_event'),(36,'Can view Event',9,'view_event'),(37,'Can add Notification',10,'add_notification'),(38,'Can change Notification',10,'change_notification'),(39,'Can delete Notification',10,'delete_notification'),(40,'Can view Notification',10,'view_notification'),(41,'Can add privacy policy',11,'add_privacypolicy'),(42,'Can change privacy policy',11,'change_privacypolicy'),(43,'Can delete privacy policy',11,'delete_privacypolicy'),(44,'Can view privacy policy',11,'view_privacypolicy'),(45,'Can add terms and conditions',12,'add_termsandconditions'),(46,'Can change terms and conditions',12,'change_termsandconditions'),(47,'Can delete terms and conditions',12,'delete_termsandconditions'),(48,'Can view terms and conditions',12,'view_termsandconditions'),(49,'Can add Blog',13,'add_blog'),(50,'Can change Blog',13,'change_blog'),(51,'Can delete Blog',13,'delete_blog'),(52,'Can view Blog',13,'view_blog'),(53,'Can add Video',14,'add_video'),(54,'Can change Video',14,'change_video'),(55,'Can delete Video',14,'delete_video'),(56,'Can view Video',14,'view_video'),(57,'Can add log entry',15,'add_logentry'),(58,'Can change log entry',15,'change_logentry'),(59,'Can delete log entry',15,'delete_logentry'),(60,'Can view log entry',15,'view_logentry'),(61,'Can add session',16,'add_session'),(62,'Can change session',16,'change_session'),(63,'Can delete session',16,'delete_session'),(64,'Can view session',16,'view_session'),(65,'Can add Audio Track',17,'add_audio'),(66,'Can change Audio Track',17,'change_audio'),(67,'Can delete Audio Track',17,'delete_audio'),(68,'Can view Audio Track',17,'view_audio'),(69,'Can add about us',18,'add_aboutus'),(70,'Can change about us',18,'change_aboutus'),(71,'Can delete about us',18,'delete_aboutus'),(72,'Can view about us',18,'view_aboutus');
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
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
  `gender` varchar(10) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `status` int NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (5,'customers/profiles/4642a8f387560c4eaa0ba769f88ed659.jpg','9874520150','male','1983-10-09',1,'2024-12-16 09:57:24.750721','2024-12-16 09:57:24.750721',6),(3,'','9993324010','male','1999-07-20',1,'2024-12-14 11:40:57.832678','2024-12-14 11:40:57.832678',4);
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
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'auth','permission'),(2,'auth','group'),(3,'contenttypes','contenttype'),(4,'accounts','user'),(5,'accounts','customer'),(6,'accounts','admins'),(7,'accounts','addressbook'),(8,'myadmin','book'),(9,'myadmin','event'),(10,'myadmin','notification'),(11,'myadmin','privacypolicy'),(12,'myadmin','termsandconditions'),(13,'myadmin','blog'),(14,'myadmin','video'),(15,'admin','logentry'),(16,'sessions','session'),(17,'myadmin','audio'),(18,'myadmin','aboutus');
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
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-11 07:13:52.676062'),(2,'contenttypes','0002_remove_content_type_name','2024-12-11 07:13:52.738547'),(3,'auth','0001_initial','2024-12-11 07:13:53.004110'),(4,'auth','0002_alter_permission_name_max_length','2024-12-11 07:13:53.035353'),(5,'auth','0003_alter_user_email_max_length','2024-12-11 07:13:53.035353'),(6,'auth','0004_alter_user_username_opts','2024-12-11 07:13:53.050974'),(7,'auth','0005_alter_user_last_login_null','2024-12-11 07:13:53.050974'),(8,'auth','0006_require_contenttypes_0002','2024-12-11 07:13:53.050974'),(9,'auth','0007_alter_validators_add_error_messages','2024-12-11 07:13:53.066604'),(10,'auth','0008_alter_user_username_max_length','2024-12-11 07:13:53.066604'),(11,'auth','0009_alter_user_last_name_max_length','2024-12-11 07:13:53.082216'),(12,'auth','0010_alter_group_name_max_length','2024-12-11 07:13:53.113475'),(13,'auth','0011_update_proxy_permissions','2024-12-11 07:13:53.129083'),(14,'auth','0012_alter_user_first_name_max_length','2024-12-11 07:13:53.129083'),(15,'accounts','0001_initial','2024-12-11 07:13:53.644586'),(16,'myadmin','0001_initial','2024-12-11 07:14:05.298097'),(17,'admin','0001_initial','2024-12-11 07:14:27.917781'),(18,'admin','0002_logentry_remove_auto_add','2024-12-11 07:14:27.933404'),(19,'admin','0003_logentry_add_action_flag_choices','2024-12-11 07:14:27.933404'),(20,'sessions','0001_initial','2024-12-11 07:14:27.995888'),(21,'myadmin','0002_audio','2024-12-11 10:31:11.395835'),(22,'myadmin','0003_remove_audio_track_url','2024-12-12 05:55:39.654545'),(23,'myadmin','0004_aboutus','2024-12-13 10:08:56.478291');
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
INSERT INTO `django_session` VALUES ('mokt06mexa4d7f712u5tchsahkpkjidn','.eJxVjssOgjAURP-la0K4l1Jalu79hub2JfXRGgqJxvjvCmGh2zkzk_NimpZ51Evxk46ODQxY9ZsZshefVuDOlE65tjnNUzT1Wql3Wupjdv562Lt_ByOV8buWigKC8I0I4LGTgcBxxBYklx0XoTcWeo8ouFGSuOoxSKGMtaAQWrFZFV9KzEn7xz1OTzY0FSN3i2kTh_cHlw9CDw:1tLGwe:hw_iog09QrCbzwj03QmBJOL77S8U1ukdz44vvOmHcyE','2024-12-11 08:15:40.901016'),('kxur12svyfvgb1cw0zlz8o8chfkzckja','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tLIp2:80zVVzpTBVFY2wLHYTKRueVyBVz-VuuPbFBgVA2D-Qs','2024-12-11 10:15:56.927255'),('6fmt6ryj4hws1lt6dq9ti7kmt9vuwrq4','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tLJu3:kMiL6sUUZ4FK9US25UuzHoROXClIPMvOsyJcigKxNnA','2024-12-11 11:25:11.849902'),('1zc8s6k47tk650w8cpz5t3fuy5rluyp6','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tLbdO:JFEUN6xxXUk74ZyUJxJ_7kW0ju5bL3d6gqNlpom5ocY','2024-12-12 06:21:10.021279'),('unsyztggzy9szh8rd4lmu7wcuexrn73c','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tLcZl:NKp1RYDRnodqaykDE00foQuf5rg4vWPQD6IVT8UgBU0','2024-12-12 07:21:29.593854'),('5p55morgl7yfgh7dc4ns0ge58s8fmpdj','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tLfGj:jgq1XJiQ0ZaWmmZwaJMe1H6BKBtwNOSaQ-UaYKAOOk8','2024-12-12 10:14:01.983329'),('trlq2ep4v8omcyzzm7jxsj5oh48fd517','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tM2ac:g3yhsWmCCdBrB1NdoSfK7bMA4nVioooAhiOe5ghRvgY','2024-12-13 11:08:06.763071'),('jyfbgb929qdlt7csrtszl8qnq89xf5nv','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tMMhC:KTybOm1VlaQJ5vWvJuu4zd6wn_9ilvPasxcTbwBhOvc','2024-12-14 08:36:14.280043'),('ba33oblwnjx3c463ywsyt5mbkegm92yw','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tMO96:NSr200yH8fJMi5Ywb0XFo5lvwEh-cQnSVKQHFVj-mjk','2024-12-14 10:09:08.012552'),('weg01k5ky3d39f5xbmgfvqmarptbau40','.eJxVjssOgjAURP-la0K4l1Jalu79hub2JfXRGgqJxvjvCmGh2zkzk_NimpZ51Evxk46ODQxY9ZsZshefVuDOlE65tjnNUzT1Wql3Wupjdv562Lt_ByOV8buWigKC8I0I4LGTgcBxxBYklx0XoTcWeo8ouFGSuOoxSKGMtaAQWrFZFV9KzEn7xz1OTzY0FSN3i2kTh_cHlw9CDw:1tMPDK:wiG7-kbfIVrWTOOXLZST_jPZxOcqJovG-taey5H4ptM','2024-12-14 11:17:34.893986'),('q2lgt8dxfei6f7vefewl58smmk415oki','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tMQQL:JeqXvsFPDWH0dvooAjOfPfa0iUpYfiK90aOyPodFeYE','2024-12-14 12:35:05.685416'),('j8nffxjo7tt1d9n809rgb17aql7rzruj','.eJxVjssOwiAQRf-FdUOAQhm7dO83kAFGiw9oSptojP9u2nSh23tOTu6bOVzmwS2VJpci65lize_mMdworyBeMV8KDyXPU_J8VfhOKz-VSPfj7v4FBqzDmiWNiPEMUgiQ1HZovEUvtDVGGQ0dkZWClDcClD2Y4IFih0ChhaDlFq1UayrZ0XNM04v1omEYHylvx9XnC9MLQxc:1tMRP7:ah2tJiqgsDhfjQSn4J6qCdOGPatPSSzM4B8vcRb5r3s','2024-12-14 13:37:53.628493'),('1zlbnh9w0qmbtjzqx40ppgh1rvgenyfp','.eJxVjssOgjAURP-la0K4l1Jalu79hub2JfXRGgqJxvjvCmGh2zkzk_NimpZ51Evxk46ODQxY9ZsZshefVuDOlE65tjnNUzT1Wql3Wupjdv562Lt_ByOV8buWigKC8I0I4LGTgcBxxBYklx0XoTcWeo8ouFGSuOoxSKGMtaAQWrFZFV9KzEn7xz1OTzY0FSN3i2kTh_cHlw9CDw:1tN48K:-8AYxfdk3it7FlZ2vh7Eq97qIWVfV_n_g5mFpluaIKc','2024-12-16 06:59:08.125719'),('nvu6i0xhj7487n5g76sja554nzgnnbvt','.eJxVjssOgjAURP-la0K4l1Jalu79hub2JfXRGgqJxvjvCmGh2zkzk_NimpZ51Evxk46ODQxY9ZsZshefVuDOlE65tjnNUzT1Wql3Wupjdv562Lt_ByOV8buWigKC8I0I4LGTgcBxxBYklx0XoTcWeo8ouFGSuOoxSKGMtaAQWrFZFV9KzEn7xz1OTzY0FSN3i2kTh_cHlw9CDw:1tN4xy:TJqTQB6hPVsiMtlUcQ_pqt7VL72ZJPldoJ5RpIt8bN4','2024-12-16 07:52:30.040769'),('fxdp7xsnfubjajzjrc53vnkp1qyrtjej','.eJxVjssOgjAURP-la0K4l1Jalu79hub2JfXRGgqJxvjvCmGh2zkzk_NimpZ51Evxk46ODQxY9ZsZshefVuDOlE65tjnNUzT1Wql3Wupjdv562Lt_ByOV8buWigKC8I0I4LGTgcBxxBYklx0XoTcWeo8ouFGSuOoxSKGMtaAQWrFZFV9KzEn7xz1OTzY0FSN3i2kTh_cHlw9CDw:1tN5xx:Yf7ncU3I9HppLaOfJE0cn2Py4ZUDEr67BAItHWPqp1w','2024-12-16 08:56:33.304424'),('sqms4iw51dohn3m89j894stlab5lvglc','.eJxVjssOgjAURP-la0K4l1Jalu79hub2JfXRGgqJxvjvCmGh2zkzk_NimpZ51Evxk46ODQxY9ZsZshefVuDOlE65tjnNUzT1Wql3Wupjdv562Lt_ByOV8buWigKC8I0I4LGTgcBxxBYklx0XoTcWeo8ouFGSuOoxSKGMtaAQWrFZFV9KzEn7xz1OTzY0FSN3i2kTh_cHlw9CDw:1tN7iQ:VhvfzJwoP4N-SIQqZ2UafDWwpAgrTM7CYM7ZTjiePbA','2024-12-16 10:48:38.466947');
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
  `image` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `venue` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myadmin_event`
--

LOCK TABLES `myadmin_event` WRITE;
/*!40000 ALTER TABLE `myadmin_event` DISABLE KEYS */;
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privacy_policies`
--

LOCK TABLES `privacy_policies` WRITE;
/*!40000 ALTER TABLE `privacy_policies` DISABLE KEYS */;
INSERT INTO `privacy_policies` VALUES (1,'o9ol','<p>o9ool</p>',1,'2024-12-13 10:10:58.983659','2024-12-13 10:11:05.953806');
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms_and_conditions`
--

LOCK TABLES `terms_and_conditions` WRITE;
/*!40000 ALTER TABLE `terms_and_conditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `terms_and_conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) DEFAULT NULL,
  `description` longtext,
  `thumbnail` varchar(100) DEFAULT NULL,
  `video_file` varchar(100) NOT NULL,
  `video_url` varchar(200) DEFAULT NULL,
  `status` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `uploaded_by_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `videos_uploaded_by_id_348c6695` (`uploaded_by_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `videos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-16 16:28:24
