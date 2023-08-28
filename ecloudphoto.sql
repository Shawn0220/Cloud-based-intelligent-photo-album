-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: ecloudphoto
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `album_admin`
--

DROP TABLE IF EXISTS `album_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `album_admin` (
  `userName` varchar(255) NOT NULL,
  `passWord` varchar(255) NOT NULL,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album_admin`
--

LOCK TABLES `album_admin` WRITE;
/*!40000 ALTER TABLE `album_admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `album_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audios`
--

DROP TABLE IF EXISTS `audios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `audioRoad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `audioName` varchar(255) NOT NULL,
  `uploadTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`userName`,`audioRoad`,`audioName`) USING BTREE,
  KEY `userName` (`userName`),
  CONSTRAINT `audios_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audios`
--

LOCK TABLES `audios` WRITE;
/*!40000 ALTER TABLE `audios` DISABLE KEYS */;
INSERT INTO `audios` VALUES (19,'admin','itsuwari - Eye Water.mp3','itsuwari - Eye Water.mp3','2021-08-06 19:16:09'),(20,'admin','Amedeo Tommasi - Magic Waltz.mp3','Amedeo Tommasi - Magic Waltz.mp3','2021-08-06 19:16:09'),(21,'admin','Mark Petrie - A New Day.mp3','Mark Petrie - A New Day.mp3','2021-08-06 19:16:09'),(22,'admin','October - Time To Love.mp3','October - Time To Love.mp3','2021-08-06 19:16:09'),(23,'admin','赵海洋 - 《瞬间的永恒》夜色钢琴曲.mp3','赵海洋 - 《瞬间的永恒》夜色钢琴曲.mp3','2021-08-06 19:16:10'),(24,'admin','灰澈 - 星茶会.mp3','灰澈 - 星茶会.mp3','2021-08-06 19:16:10'),(25,'admin','赵海洋 - 匆匆那年 (钢琴版).mp3','赵海洋 - 匆匆那年 (钢琴版).mp3','2021-08-06 19:16:10'),(26,'admin','36233152191231165165_remix239188137.mp3','36233152191231165165_remix239188137.mp3','2021-08-17 12:00:10'),(27,'lixiao','陈奕迅 - 倾城.mp3','陈奕迅 - 倾城.mp3','2021-08-19 19:39:21'),(28,'lixiao','陈尤利 - 独白.mp3','陈尤利 - 独白.mp3','2021-08-19 19:39:21'),(29,'lixiao','陈奕迅,蔡依林 - Fight as ONE.mp3','陈奕迅,蔡依林 - Fight as ONE.mp3','2021-08-19 19:39:21'),(30,'lixiao','陈尤利 - 每一个名字.mp3','陈尤利 - 每一个名字.mp3','2021-08-19 19:39:21'),(31,'lixiao','陈尤利 - 君は微光（你是微光）.mp3','陈尤利 - 君は微光（你是微光）.mp3','2021-08-19 19:39:21'),(32,'lixiao','陈尤利 - 木偶假说.mp3','陈尤利 - 木偶假说.mp3','2021-08-19 19:39:21'),(33,'admin','陈尤利 - 独白.mp3','陈尤利 - 独白.mp3','2021-08-19 19:42:42'),(34,'admin','陈奕迅,蔡依林 - Fight as ONE.mp3','陈奕迅,蔡依林 - Fight as ONE.mp3','2021-08-19 19:42:42'),(35,'admin','陈奕迅 - 倾城.mp3','陈奕迅 - 倾城.mp3','2021-08-19 19:42:42'),(36,'admin','陈尤利 - 木偶假说.mp3','陈尤利 - 木偶假说.mp3','2021-08-19 19:42:42'),(37,'admin','陈尤利 - 君は微光（你是微光）.mp3','陈尤利 - 君は微光（你是微光）.mp3','2021-08-19 19:42:42'),(38,'admin','陈尤利 - 每一个名字.mp3','陈尤利 - 每一个名字.mp3','2021-08-19 19:42:42');
/*!40000 ALTER TABLE `audios` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add admin',7,'add_admin'),(26,'Can change admin',7,'change_admin'),(27,'Can delete admin',7,'delete_admin'),(28,'Can view admin',7,'view_admin');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
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
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'album','admin'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-06-07 11:39:17.328395'),(2,'auth','0001_initial','2021-06-07 11:39:17.798756'),(3,'admin','0001_initial','2021-06-07 11:39:17.970408'),(4,'admin','0002_logentry_remove_auto_add','2021-06-07 11:39:17.977424'),(5,'admin','0003_logentry_add_action_flag_choices','2021-06-07 11:39:17.986412'),(6,'album','0001_initial','2021-06-07 11:39:18.011299'),(7,'contenttypes','0002_remove_content_type_name','2021-06-07 11:39:18.101474'),(8,'auth','0002_alter_permission_name_max_length','2021-06-07 11:39:18.159458'),(9,'auth','0003_alter_user_email_max_length','2021-06-07 11:39:18.187383'),(10,'auth','0004_alter_user_username_opts','2021-06-07 11:39:18.195362'),(11,'auth','0005_alter_user_last_login_null','2021-06-07 11:39:18.245230'),(12,'auth','0006_require_contenttypes_0002','2021-06-07 11:39:18.249218'),(13,'auth','0007_alter_validators_add_error_messages','2021-06-07 11:39:18.257197'),(14,'auth','0008_alter_user_username_max_length','2021-06-07 11:39:18.328008'),(15,'auth','0009_alter_user_last_name_max_length','2021-06-07 11:39:18.387848'),(16,'auth','0010_alter_group_name_max_length','2021-06-07 11:39:18.408792'),(17,'auth','0011_update_proxy_permissions','2021-06-07 11:39:18.418802'),(18,'auth','0012_alter_user_first_name_max_length','2021-06-07 11:39:18.475306'),(19,'sessions','0001_initial','2021-06-07 11:39:18.509184');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0ra71zj1f55ouhsm17dk0aog4aiu6rik','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mEML1:1s5JSkMnlOGj6JWhtoUzOssT60C--qyOZMBUWzptDmE','2021-08-27 01:50:23.831101'),('239tshfs5nmsjszygy0pmd7r1fim51w1','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mLOY5:TjUPgxVvL1kLYb5I74PxbpsnJIrnTk2hG8VA13icaIg','2021-09-15 11:36:57.021817'),('2pukwegjjrd4qyxdl22d2dnzgz09cnx6','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mKJJn:wmyfWt43YhmIHxxwDDh0WResmJyV_0zA2cqtBH0YIfc','2021-09-12 11:49:43.623500'),('3zejdir9vb4hqzqv0hmbqmaokezjwnpk','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mLKSN:k7HSvKvMxg_eKMl3eEr6DcbGV7IofZezLNEGTGHbD8Y','2021-09-15 07:14:47.922605'),('4s12ly9emr5cho892itjuqkif8i8guiz','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mCLwG:py-hQq2iVFrhW9Ba9inoM6lD5OdKRveT3k_o4AEQGwY','2021-08-21 13:00:32.281257'),('cmz986fwq6k0x7b8klshm823za1r1apn','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mFqDO:_hGt0v-2CE2prPLOO-qph2rzLOfIjlmFj81dgsdTAMM','2021-08-31 03:56:38.793120'),('dnlhxuldt3n7dij8swpwekjuk07t97i8','eyJ1c2VyaW5mbyI6ImxpeGlhbyJ9:1mGgNG:IZNHf6eL6UCDDon5LcIDPo0UH-4FdbvTKHC64VltVtU','2021-09-02 11:38:18.017041'),('es6rvizjme24hzzcvpxdzgbyw0uhct6p','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mHmO3:4xTN79WmnBvanvElmA0USXBblDtQaZe_mg6KIVcfeqI','2021-09-05 12:15:39.829175'),('fq3g4ok5rih9vb2r6hmho963m88cq6gr','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mJTZ2:DDxZyq6h0Arp-vlt4TT_7nHdsbyLONqlNeEmpDbBm3Q','2021-09-10 04:34:00.125215'),('gi3ttiummjp5qz9lg839v34dzlu6w2wz','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mJrg3:tiKbtCV7ClRlMpyucjchXHECZUKHa56MtdXcs-zZ6eY','2021-09-11 06:18:51.961918'),('htk3jnd8yqsp1akdt52rowi67vtcs8kc','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mGY1l:cwwXzzkY-6fHujuax9F0h40rhOoX1qRAGt1DjglnXL4','2021-09-02 02:43:33.863905'),('hzut208cx1n7tianivbspd9t1yq6goh4','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mDLv8:FgXb99TfKP4-WDOCHcIbzj1M-bKUdyh-tfVspXk4VD4','2021-08-24 07:11:30.130653'),('iagn501tvzj5c4744i0bd595r19pv1fl','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mEAMq:ux2vuqHAqK5qBVrsGhTNgE4NrZM8u2V0LuaIyAb3Zro','2021-08-26 13:03:28.060966'),('igcksoblbf61xoeefeqxpjlf1gm9ilo9','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mGaw7:vTqSUiS1OUX0s2iFuK_aSYKthqMRlA9UPhhf2184tTs','2021-09-02 05:49:55.772861'),('je7wc2m9hcrh0u9tzfg3w7hg3ba94kia','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mJqLm:9WbhWgAsRS3fnfMA5KSDbWG6ZRK6auLuS1lyj5ShoqE','2021-09-11 04:53:50.125465'),('lar4wyc6ao4ptmhr1r1t3l4qv6oxte7j','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mJrgh:vmjVS7oOmMl_1DGBYDZrVF-_huxXGKv1AGOg17cTU6Q','2021-09-11 06:19:31.948428'),('lu99tlhq02orekxecjr0dz098ajhtj2k','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mDeqg:mn6PtNblOYiQ2nqnYAoeqFenwCkaUTuoqzOPPZIyGZI','2021-08-25 03:24:10.895371'),('nfh1h7h7yf76a9gtqev8drgijvtd5zmb','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mEAhs:E8dFXV9yXhm0y-AeZYiecAMX2nYgJk4gYf2yOi95DPY','2021-08-26 13:25:12.773676'),('p6wkxndo223699xxydobxbuv67d0wlum','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mE9p4:VSLoiWGN8EDcm7lPT-53KJGafXmUhiT44tIsVk3jrSM','2021-08-26 12:28:34.257693'),('q4tal16kr34uydy23au3xq93p3x3am21','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mGgQt:Ba6nP_L0Xkw8gxwZzKEXaqaPsOIIrKVvler3yKOVZB0','2021-09-02 11:42:03.594460'),('qoe4tyo8db8t7kny6vegis35zbb9l14s','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mFSib:hHwmbHL1F49Cexg1K9CaKdgzPkUF9wcR--Jmh9w_ZBQ','2021-08-30 02:51:17.444434'),('qq4oye7ccaahfp6qzq5ppwefdm84j0nm','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mDp8s:RxlmA_rfUqQ2jqyW_mH1k7d-Ob0WNWPxUW5OtO3lpzg','2021-08-25 14:23:38.669402'),('r2sy93zks2dunaz60x89wuvh6p9bqfkt','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mDp9d:W-hO5guAmajmF-oL5gtX1uhoQ_smVqGCWan9N1ejLu0','2021-08-25 14:24:25.231235'),('sbnkcsuwy5bgftettpsva0juzp1woffb','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mGaw7:vTqSUiS1OUX0s2iFuK_aSYKthqMRlA9UPhhf2184tTs','2021-09-02 05:49:55.792809'),('sey3igu3bzwf6w4r1ikqgi36w292fsvi','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mIrCm:jeIZagYreNK_Ea5LHxE7GI_rwnPBTF22tSBp9QAOii4','2021-09-08 11:36:28.878367'),('tdxv9sht972fpvzo1efk8zftyutg5a4m','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mGZp7:C5Sv6pVV3k5oMT1DP_okKNzQgBXLGo2h-uwHpa2seIc','2021-09-02 04:38:37.422385'),('uggfx5k25dzbkkjlvvst22sfgdwaslma','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mElxn:m1nhhxAmbytp9CJ4sRRBRjrBaNwx2qyhrr72FyApGkg','2021-08-28 05:12:07.915312'),('wjgmifg8mk71nfm4rlfnddjwm8oa0wxa','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mGBJY:jRJbOVNVrSqnRtb9u_JDx2wYbwidV0CfVbsrOAY6m80','2021-09-01 02:28:24.305244'),('yz1afh097fckkaxb7vzicn7mi0ng49xa','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mE2yT:S2B8LtM0sUFIU17HIQvj5HY2H7JS-SuJFoNeHFPE1R0','2021-08-26 05:09:49.123582'),('zfbtnesl2w3rxtjeltw621nzlrns26od','eyJ1c2VyaW5mbyI6ImFkbWluIn0:1mHf51:jwvaBe_I9gOCb_D5B-NaT5cwKuqi1xaXBHI8tSlyOJ8','2021-09-05 04:27:31.797780');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faceidtoname`
--

DROP TABLE IF EXISTS `faceidtoname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faceidtoname` (
  `faceName` varchar(255) NOT NULL,
  `peopleName` varchar(255) NOT NULL,
  `userName` varchar(255) NOT NULL,
  PRIMARY KEY (`faceName`,`userName`) USING BTREE,
  KEY `f_userName` (`userName`),
  CONSTRAINT `f_userName` FOREIGN KEY (`userName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faceidtoname`
--

LOCK TABLES `faceidtoname` WRITE;
/*!40000 ALTER TABLE `faceidtoname` DISABLE KEYS */;
INSERT INTO `faceidtoname` VALUES ('124dd406-f4f0-11eb-9b83-8c1645ac402c','顾书宁','admin'),('124dd406-f4f0-11eb-9b83-8c1645ac402c','未命名','test'),('238a5de4-f4f0-11eb-a6f8-8c1645ac402c','未命名','admin'),('244274b6-f4f0-11eb-88a0-8c1645ac402c','未命名','admin'),('36aa8df6faa011eba3498c16','群众','admin'),('5a2d20060af411ecb4848c16','未命名','admin'),('5a3779280af411ec98ca8c16','未命名','admin'),('66a3d592fbf011eb82a18c16','未命名','admin'),('67238d06-d8ae-11eb-96d6-8c1645ac402c','未命名','admin'),('6c686e18-d8ae-11eb-972b-8c1645ac402c','未命名','admin'),('NoFace','未命名','admin'),('NoFace','未命名','lixiao'),('NoFace','未命名','test');
/*!40000 ALTER TABLE `faceidtoname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `img_deleted`
--

DROP TABLE IF EXISTS `img_deleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `img_deleted` (
  `id` int NOT NULL,
  `userName` varchar(255) NOT NULL,
  `imgRoad` varchar(255) NOT NULL,
  `Photo_time` datetime DEFAULT NULL,
  `upload_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL,
  `album` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`userName`,`imgRoad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_deleted`
--

LOCK TABLES `img_deleted` WRITE;
/*!40000 ALTER TABLE `img_deleted` DISABLE KEYS */;
/*!40000 ALTER TABLE `img_deleted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imgs`
--

DROP TABLE IF EXISTS `imgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `imgs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `imgRoad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Photo_time` datetime DEFAULT NULL,
  `upload_time` datetime NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `faceName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `album` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`userName`,`imgRoad`) USING BTREE,
  KEY `userName` (`userName`),
  KEY `category_name` (`faceName`),
  KEY `imgRoad` (`imgRoad`),
  KEY `id` (`id`),
  CONSTRAINT `faceName` FOREIGN KEY (`faceName`) REFERENCES `faceidtoname` (`faceName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userName` FOREIGN KEY (`userName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imgs`
--

LOCK TABLES `imgs` WRITE;
/*!40000 ALTER TABLE `imgs` DISABLE KEYS */;
INSERT INTO `imgs` VALUES (1966,'admin','a742769c-f5e6-11eb-88da-8c1645ac402cIMG_20210404_141542.jpg','2021-04-04 14:15:42','2021-08-05 20:14:25','南通市','124dd406-f4f0-11eb-9b83-8c1645ac402c','人'),(1968,'admin','2123f1a5-f5e7-11eb-9197-8c1645ac402cIMG_20201221_190127.jpg','2020-12-21 19:01:27','2021-08-05 20:17:47','常州市','NoFace','人'),(1971,'admin','eab91670-f65c-11eb-bf9f-00ffc4de3237IMG_20201217_073132.jpg','2020-12-17 07:31:33','2021-08-06 10:20:53','常州市','NoFace','绿色的'),(1972,'admin','eab8f0e4-f65c-11eb-b2d5-00ffc4de3237IMG_20201205_112951.jpg','2020-12-05 11:29:51','2021-08-06 10:20:53','常州市','NoFace','食物'),(1973,'admin','ea8db682-f65c-11eb-a0ce-00ffc4de3237IMG_20201202_091027_edit_544367065871101.jpg','2020-12-02 09:10:28','2021-08-06 10:20:53','常州市','NoFace','设计'),(1975,'admin','ea8e2b52-f65c-11eb-a180-8c1645ac402cIMG_20201130_120223.jpg','2020-11-30 12:02:23','2021-08-06 10:20:54','常州市','NoFace','材料特性'),(1977,'admin','ec9f991c-f65c-11eb-8f4c-00ffc4de3237IMG_20201219_114140.jpg','2020-12-19 11:41:40','2021-08-06 10:20:55','常州市','NoFace','食物'),(1979,'admin','ec9629b0-f65c-11eb-b3b2-00ffc4de3237IMG_20201219_075546.jpg','2020-12-19 07:55:46','2021-08-06 10:20:57','常州市','NoFace','碟'),(1980,'admin','ee01b698-f65c-11eb-817f-00ffc4de3237IMG_20210527_094520.jpg','2021-05-27 09:45:20','2021-08-06 10:20:58','常州市','NoFace','人'),(1981,'admin','edccac1c-f65c-11eb-a56b-00ffc4de3237IMG_20210526_145713.jpg','2021-05-26 14:57:14','2021-08-06 10:20:59','常州市','NoFace','文本'),(1982,'admin','ef3dac74-f65c-11eb-86f7-00ffc4de3237IMG_20210529_084627.jpg','2021-05-29 08:46:27','2021-08-06 10:20:59','常州市','NoFace','饮食'),(1984,'admin','eeef4dee-f65c-11eb-b8d2-00ffc4de3237IMG_20210528_235852.jpg','2021-05-28 23:58:52','2021-08-06 10:21:00','常州市','NoFace','设计'),(1985,'admin','ef8f1728-f65c-11eb-bd68-00ffc4de3237IMG_20210529_124609.jpg','2021-05-29 12:46:09','2021-08-06 10:21:02','常州市','NoFace','设计'),(1987,'admin','f1307398-f65c-11eb-a191-00ffc4de3237IMG_20210615_181908_edit_492622924941497.jpg','2021-06-15 18:19:08','2021-08-06 10:21:03','常州市','NoFace','纺织品'),(1988,'admin','f08897b0-f65c-11eb-a981-00ffc4de3237IMG_20210613_113912_edit_196608959054373.jpg','2021-06-13 11:39:13','2021-08-06 10:21:04','南通市','NoFace','饮食'),(1989,'admin','f06bfb86-f65c-11eb-93aa-00ffc4de3237IMG_20210612_194520_edit_165739132335125.jpg','2021-06-12 19:45:20','2021-08-06 10:21:05','南通市','NoFace','饮食'),(1990,'admin','f22db28a-f65c-11eb-8cfe-00ffc4de3237IMG_20210615_183805.jpg','2021-06-15 18:38:05','2021-08-06 10:21:05','常州市','NoFace','纺织品'),(1991,'admin','f2a23994-f65c-11eb-85f4-00ffc4de3237IMG_20210617_215510.jpg','2021-06-17 21:55:10','2021-08-06 10:21:05','常州市','NoFace','食物'),(1992,'admin','f2e40e9c-f65c-11eb-9e54-00ffc4de3237IMG_20210617_215521.jpg','2021-06-17 21:55:21','2021-08-06 10:21:06','常州市','NoFace','喝'),(1993,'admin','f3170e58-f65c-11eb-b480-00ffc4de3237IMG_20210617_215532.jpg','2021-06-17 21:55:32','2021-08-06 10:21:06','常州市','NoFace','饮食'),(1994,'admin','f05c27ee-f65c-11eb-9dc8-00ffc4de3237IMG_20210602_213549.jpg','2021-06-02 21:35:49','2021-08-06 10:21:07','常州市','124dd406-f4f0-11eb-9b83-8c1645ac402c','人'),(1995,'admin','f40e5d5c-f65c-11eb-8856-00ffc4de3237IMG_20210619_094630.jpg','2021-06-19 09:46:30','2021-08-06 10:21:08','常州市','NoFace','食物'),(1996,'admin','f3ace33a-f65c-11eb-be4c-00ffc4de3237IMG_20210618_153942.jpg','2021-06-18 15:39:43','2021-08-06 10:21:08','常州市','NoFace','食物'),(1997,'admin','f4609f62-f65c-11eb-9dc0-00ffc4de3237IMG_20210621_120554.jpg','2021-06-21 12:05:54','2021-08-06 10:21:08','常州市','NoFace','饮食'),(1998,'admin','f40e3662-f65c-11eb-baf0-00ffc4de3237IMG_20210618_154502_edit_435412808751267.jpg','2021-06-18 15:45:02','2021-08-06 10:21:08','常州市','NoFace','食物'),(1999,'admin','f5778362-f65c-11eb-8800-00ffc4de3237IMG_20210626_155050.jpg','2021-06-26 15:50:50','2021-08-06 10:21:10','常州市','NoFace','脊椎动物'),(2000,'admin','f5c51da6-f65c-11eb-b52c-00ffc4de3237IMG_20210627_122141.jpg','2021-06-27 12:21:42','2021-08-06 10:21:11','常州市','NoFace','设计'),(2001,'admin','f4e995cc-f65c-11eb-b9f4-00ffc4de3237IMG_20210626_115522.jpg','2021-06-26 11:55:23','2021-08-06 10:21:11','常州市','NoFace','食物'),(2002,'admin','f5f68062-f65c-11eb-bc56-00ffc4de3237IMG_20210628_222721_edit_163260012929775.jpg','2021-06-28 22:27:21','2021-08-06 10:21:12','常州市','NoFace','服装'),(2003,'admin','f46bbd24-f65c-11eb-a2ee-00ffc4de3237IMG_20210622_175525.jpg','2021-06-22 17:55:25','2021-08-06 10:21:12','常州市','NoFace','花'),(2004,'admin','f6f56790-f65c-11eb-99b2-00ffc4de3237IMG_20210701_080130.jpg','2021-07-01 08:01:30','2021-08-06 10:21:13','常州市','NoFace','人'),(2005,'admin','f57736ac-f65c-11eb-ae62-00ffc4de3237IMG_20210626_120133.jpg','2021-06-26 12:01:33','2021-08-06 10:21:13','常州市','NoFace','饮食'),(2006,'admin','f7673d7a-f65c-11eb-b4b4-00ffc4de3237IMG_20210701_202956.jpg','2021-07-01 20:29:56','2021-08-06 10:21:13','常州市','NoFace','电脑'),(2007,'admin','f7c26478-f65c-11eb-8465-00ffc4de3237IMG_20210702_083148.jpg','2021-07-02 08:31:48','2021-08-06 10:21:15','常州市','NoFace','材料特性'),(2008,'admin','f7dd2d22-f65c-11eb-8805-00ffc4de3237IMG_20210702_140324.jpg','2021-07-02 14:03:24','2021-08-06 10:21:15','常州市','NoFace','服装'),(2009,'admin','f8a5aa7a-f65c-11eb-b000-00ffc4de3237IMG_20210710_143934.jpg','2021-07-10 14:39:34','2021-08-06 10:21:16','南通市','NoFace','设计'),(2010,'admin','f7ffdf9e-f65c-11eb-bb86-00ffc4de3237IMG_20210702_203249_edit_310294960512547.jpg','2021-07-02 20:32:49','2021-08-06 10:21:16','常州市','NoFace','纺织品'),(2011,'admin','f9a701e2-f65c-11eb-a554-00ffc4de3237IMG_20210711_183914.jpg','2021-07-11 18:39:14','2021-08-06 10:21:17','南通市','NoFace','设计'),(2012,'admin','f892a498-f65c-11eb-a8ca-00ffc4de3237IMG_20210705_081001_edit_537775215263253.jpg','2021-07-05 08:10:02','2021-08-06 10:21:18','常州市','NoFace','植物'),(2013,'admin','fa1ef068-f65c-11eb-b9c9-00ffc4de3237IMG_20210713_074608_edit_538139630413198.jpg','2021-07-13 07:46:09','2021-08-06 10:21:19','南通市','NoFace','设计'),(2014,'admin','fa6db634-f65c-11eb-83e1-00ffc4de3237IMG_20210716_122709.jpg','2021-07-16 12:27:09','2021-08-06 10:21:19','南京市','NoFace','树'),(2015,'admin','f8e2b8a4-f65c-11eb-acd6-00ffc4de3237IMG_20210710_144024.jpg','2021-07-10 14:40:24','2021-08-06 10:21:19','南通市','NoFace','材料特性'),(2016,'admin','fb416fc2-f65c-11eb-b8da-00ffc4de3237IMG_20210716_124223.jpg','2021-07-16 12:42:23','2021-08-06 10:21:20','南京市','NoFace','人'),(2017,'admin','fa68d79a-f65c-11eb-8be6-00ffc4de3237IMG_20210716_111900.jpg','2021-07-16 11:19:00','2021-08-06 10:21:20','南京市','NoFace','饮食'),(2018,'admin','fc83876c-f65c-11eb-aa3a-00ffc4de3237IMG_20210716_155325.jpg','2021-07-16 15:53:25','2021-08-06 10:21:21','南京市','NoFace','墙'),(2019,'admin','fbfc2e68-f65c-11eb-92a9-00ffc4de3237IMG_20210716_130920.jpg','2021-07-16 13:09:21','2021-08-06 10:21:22','南京市','NoFace','脊椎动物'),(2020,'admin','fcf88162-f65c-11eb-8eeb-00ffc4de3237IMG_20210716_160548.jpg','2021-07-16 16:05:49','2021-08-06 10:21:23','南京市','NoFace','灯光'),(2021,'admin','fd0c97d2-f65c-11eb-af70-00ffc4de3237IMG_20210716_161415.jpg','2021-07-16 16:14:15','2021-08-06 10:21:23','南京市','NoFace','设计'),(2022,'admin','fc9139ba-f65c-11eb-b7e7-00ffc4de3237IMG_20210716_155413_edit_492828152863341.jpg','2021-07-16 15:54:13','2021-08-06 10:21:24','南京市','NoFace','视觉艺术'),(2023,'admin','fec5f9e8-f65c-11eb-8180-00ffc4de3237IMG_20210716_204254.jpg','2021-07-16 20:42:54','2021-08-06 10:21:26','南京市','NoFace','人'),(2024,'admin','fc3b7e4a-f65c-11eb-bde0-00ffc4de3237IMG_20210716_144418_edit_492879118112812.jpg','2021-07-16 14:44:18','2021-08-06 10:21:26','南京市','238a5de4-f4f0-11eb-a6f8-8c1645ac402c','人'),(2025,'admin','feb5b15e-f65c-11eb-94ca-00ffc4de3237IMG_20210716_200724.jpg','2021-07-16 20:07:25','2021-08-06 10:21:26','南京市','NoFace','鼓状物'),(2026,'admin','fdf20788-f65c-11eb-bd7b-00ffc4de3237IMG_20210716_192421.jpg','2021-07-16 19:24:21','2021-08-06 10:21:26','南京市','244274b6-f4f0-11eb-88a0-8c1645ac402c','界线'),(2027,'admin','0046d818-f65d-11eb-8e5c-00ffc4de3237IMG_20210717_085453.jpg','2021-07-17 08:54:53','2021-08-06 10:21:28','南京市','NoFace','食物'),(2028,'admin','003a0f98-f65d-11eb-90dd-00ffc4de3237IMG_20210717_085426.jpg','2021-07-17 08:54:27','2021-08-06 10:21:28','南京市','NoFace','食物'),(2029,'admin','009b9e36-f65d-11eb-8f21-00ffc4de3237IMG_20210717_152516.jpg','2021-07-17 15:25:16','2021-08-06 10:21:29','南京市','NoFace','饮食'),(2030,'admin','ff2ae01a-f65c-11eb-8d06-00ffc4de3237IMG_20210716_215215.jpg','2021-07-16 21:52:15','2021-08-06 10:21:29','南京市','NoFace','房间'),(2031,'admin','fdcb391c-f65c-11eb-b515-00ffc4de3237IMG_20210716_164800.jpg','2021-07-16 16:48:00','2021-08-06 10:21:30','南京市','NoFace','人'),(2032,'admin','009b7746-f65d-11eb-8e6b-00ffc4de3237IMG_20210717_151518.jpg','2021-07-17 15:15:18','2021-08-06 10:21:30','南京市','NoFace','材料特性'),(2033,'admin','01c7dc54-f65d-11eb-b45c-00ffc4de3237IMG_20210721_123349.jpg','2021-07-21 12:33:49','2021-08-06 10:21:31','南通市','NoFace','饮食'),(2034,'admin','01b5c04c-f65d-11eb-9024-00ffc4de3237IMG_20210717_161028.jpg','2021-07-17 16:10:29','2021-08-06 10:21:31','南京市','NoFace','建筑学'),(2035,'admin','0208b18a-f65d-11eb-bbb8-00ffc4de3237IMG_20210721_152445_edit_537922009368439.jpg','2021-07-21 15:24:45','2021-08-06 10:21:32','南通市','NoFace','服装'),(2036,'admin','02354838-f65d-11eb-ac7f-00ffc4de3237IMG_20210721_152741.jpg','2021-07-21 15:27:42','2021-08-06 10:21:32','南通市','NoFace','白色的'),(2037,'admin','02ab1834-f65d-11eb-b7d7-00ffc4de3237IMG_20210721_171907.jpg','2021-07-21 17:19:07','2021-08-06 10:21:32','南通市','NoFace','饮食'),(2038,'admin','030af7e2-f65d-11eb-9318-00ffc4de3237IMG_20210722_153539_edit_492058476485854.jpg','2021-07-22 15:35:39','2021-08-06 10:21:34','南通市','NoFace','食物'),(2039,'admin','03f95cae-f65d-11eb-89e1-00ffc4de3237IMG_20210723_113621.jpg','2021-07-23 11:36:21','2021-08-06 10:21:34','南通市','NoFace','天空'),(2040,'admin','032d0fee-f65d-11eb-8e9a-00ffc4de3237IMG_20210722_153657.jpg','2021-07-22 15:36:58','2021-08-06 10:21:34','南通市','NoFace','食物'),(2041,'admin','042d90dc-f65d-11eb-8a55-00ffc4de3237IMG_20210730_143707.jpg','2021-07-30 14:37:07','2021-08-06 10:21:34','南通市','NoFace','设计'),(2042,'admin','041f1bd0-f65d-11eb-95b0-00ffc4de3237IMG_20210730_122956.jpg','2021-07-30 12:29:56','2021-08-06 10:21:35','南通市','NoFace','饮食'),(2043,'admin','03902064-f65d-11eb-905f-00ffc4de3237IMG_20210723_113619.jpg','2021-07-23 11:36:19','2021-08-06 10:21:35','南通市','NoFace','天空'),(2045,'admin','050b9912-f65d-11eb-b91d-00ffc4de3237IMG_20210801_143233.jpg','2021-08-01 14:32:34','2021-08-06 10:21:38','南通市','NoFace','喝'),(2046,'admin','05cf9458-f65d-11eb-abf9-00ffc4de3237IMG_20210803_224736.jpg','2021-07-29 19:37:43','2021-08-06 10:21:38','南通市','NoFace','纺织品'),(2047,'admin','05882a0a-f65d-11eb-9aa4-00ffc4de3237IMG_20210803_223904.jpg','2021-08-03 22:39:04','2021-08-06 10:21:39','南通市','NoFace','白色的'),(2048,'admin','05c9f2e8-f65d-11eb-8a2a-00ffc4de3237IMG_20210803_223922.jpg','2021-08-03 22:39:22','2021-08-06 10:21:39','南通市','NoFace','电脑鼠标'),(2049,'admin','058801b4-f65d-11eb-89fb-00ffc4de3237IMG_20210803_223813.jpg','2021-08-03 22:38:13','2021-08-06 10:21:40','南通市','NoFace','蓝色的'),(2050,'admin','07e6c558-f65d-11eb-85bc-00ffc4de3237IMG_20210803_224913.jpg','2021-08-03 22:49:13','2021-08-06 10:21:40','南通市','NoFace','钢笔'),(2051,'admin','08353342-f65d-11eb-91f9-00ffc4de3237IMG_20210803_225135.jpg','2021-07-16 12:24:29','2021-08-06 10:21:41','南京市','NoFace','公共场所'),(2052,'admin','07060cae-f65d-11eb-b11d-00ffc4de3237IMG_20210803_224900.jpg','2021-08-03 22:49:01','2021-08-06 10:21:41','南通市','NoFace','材料特性'),(2053,'admin','08ab4f86-f65d-11eb-87e8-00ffc4de3237IMG_20210803_225330.jpg','2021-06-20 09:40:47','2021-08-06 10:21:42','常州市','NoFace','动物'),(2054,'admin','07aafba4-f65d-11eb-8659-00ffc4de3237IMG_20210803_224908.jpg','2021-08-03 22:49:08','2021-08-06 10:21:43','南通市','NoFace','材料特性'),(2055,'admin','0992b336-f65d-11eb-8a24-00ffc4de3237IMG_20210803_225512.jpg','2021-08-03 22:55:12','2021-08-06 10:21:43','南通市','NoFace','鞋类'),(2056,'admin','08186264-f65d-11eb-a61c-00ffc4de3237IMG_20210803_224924.jpg','2021-08-03 22:49:24','2021-08-06 10:21:44','南通市','NoFace','办公用品'),(2057,'admin','090e3a76-f65d-11eb-a15b-00ffc4de3237IMG_20210803_225458.jpg','2021-08-03 22:54:58','2021-08-06 10:21:44','南通市','NoFace','白色的'),(2058,'admin','09fe6514-f65d-11eb-bc7e-00ffc4de3237IMG_20210803_225548.jpg','2021-08-03 22:55:49','2021-08-06 10:21:44','南通市','NoFace','蓝色的'),(2059,'admin','0abbdca6-f65d-11eb-af4b-00ffc4de3237IMG_20210803_225601.jpg','2021-08-03 22:56:01','2021-08-06 10:21:46','南通市','NoFace','鞋类'),(2060,'admin','0992db86-f65d-11eb-a193-00ffc4de3237IMG_20210803_225512_1.jpg','2021-08-03 22:55:12','2021-08-06 10:21:46','南通市','NoFace','鞋类'),(2061,'admin','0add578a-f65d-11eb-9a54-00ffc4de3237IMG_20210803_225653.jpg','2021-08-03 22:56:53','2021-08-06 10:21:46','南通市','NoFace','白色的'),(2062,'admin','0b6d9d4c-f65d-11eb-b4d5-00ffc4de3237IMG_20210803_225820.jpg','2021-08-03 22:58:20','2021-08-06 10:21:47','南通市','NoFace','食物'),(2063,'admin','0b6d4f74-f65d-11eb-81df-00ffc4de3237IMG_20210803_225753.jpg','2021-08-03 22:57:53','2021-08-06 10:21:47','南通市','NoFace','食物'),(2064,'admin','0b090488-f65d-11eb-8a4f-00ffc4de3237IMG_20210803_225716.jpg','2021-08-03 22:57:17','2021-08-06 10:21:49','南通市','NoFace','蓝色的'),(2065,'admin','0cc83598-f65d-11eb-b240-00ffc4de3237IMG_20210803_230013.jpg','2021-08-03 23:00:13','2021-08-06 10:21:50','南通市','NoFace','时尚配饰'),(2066,'admin','0c2a6ad0-f65d-11eb-a235-00ffc4de3237IMG_20210803_225829_edit_538521486439181.jpg','2021-08-03 22:58:29','2021-08-06 10:21:50','南通市','NoFace','食物'),(2067,'admin','0ccb401c-f65d-11eb-976b-00ffc4de3237IMG_20210803_230052.jpg','2021-08-03 23:00:52','2021-08-06 10:21:51','南通市','NoFace','服装'),(2068,'admin','0c6a554a-f65d-11eb-ab1e-00ffc4de3237IMG_20210803_225929_edit_538580455107401.jpg','2021-08-03 22:59:29','2021-08-06 10:21:51','南通市','NoFace','时尚配饰'),(2069,'admin','0c6e4b90-f65d-11eb-890c-00ffc4de3237IMG_20210803_230004.jpg','2021-08-03 23:00:04','2021-08-06 10:21:51','南通市','NoFace','黄色的'),(2070,'admin','0e9faf6e-f65d-11eb-b005-00ffc4de3237IMG_20210803_230202.jpg','2021-08-03 23:02:02','2021-08-06 10:21:52','南通市','NoFace','工具'),(2071,'admin','0dea1476-f65d-11eb-9ffb-00ffc4de3237IMG_20210803_230124.jpg','2021-08-03 23:01:24','2021-08-06 10:21:53','南通市','NoFace','材料特性'),(2072,'admin','0f31ac30-f65d-11eb-b35f-00ffc4de3237IMG_20210803_230442.jpg','2021-08-03 23:04:42','2021-08-06 10:21:53','南通市','NoFace','设计'),(2073,'admin','0f151010-f65d-11eb-b4ca-00ffc4de3237IMG_20210803_230233.jpg','2021-08-03 23:02:33','2021-08-06 10:21:54','南通市','NoFace','白色的'),(2074,'admin','0f18de02-f65d-11eb-b7f3-00ffc4de3237IMG_20210803_230403.jpg','2021-08-03 23:04:03','2021-08-06 10:21:54','南通市','NoFace','文本'),(2075,'admin','0e9f887a-f65d-11eb-9a5e-00ffc4de3237IMG_20210803_230136.jpg','2021-08-03 23:01:36','2021-08-06 10:21:54','南通市','NoFace','材料特性'),(2076,'admin','0fe5eefa-f65d-11eb-a6af-00ffc4de3237IMG_20210803_230638.jpg','2021-08-03 23:06:38','2021-08-06 10:21:55','南通市','NoFace','纺织品'),(2077,'admin','1055a5b4-f65d-11eb-9bd3-00ffc4de3237IMG_20210803_230646.jpg','2021-08-03 23:06:46','2021-08-06 10:21:55','南通市','NoFace','纺织品'),(2078,'admin','10aaabd2-f65d-11eb-b690-00ffc4de3237IMG_20210804_095307.jpg','2021-08-04 09:53:07','2021-08-06 10:21:56','南通市','NoFace','材料特性'),(2079,'admin','1124dfc0-f65d-11eb-9669-00ffc4de3237IMG_20210804_095334.jpg','2021-08-04 09:53:34','2021-08-06 10:21:57','南通市','NoFace','材料特性'),(2080,'admin','114badba-f65d-11eb-95e0-00ffc4de3237IMG_20210804_095342.jpg','2021-08-04 09:53:42','2021-08-06 10:21:57','南通市','NoFace','材料特性'),(2081,'admin','116ed51a-f65d-11eb-8acf-00ffc4de3237IMG_20210804_095429.jpg','2021-08-04 09:54:29','2021-08-06 10:21:57','南通市','NoFace','材料特性'),(2084,'admin','11831288-f65d-11eb-b48b-00ffc4de3237IMG_20210804_095521_edit_544752723129376.jpg','2021-08-04 09:55:21','2021-08-06 10:21:59','南通市','NoFace','材料特性'),(2104,'test','0f72c14a-f77d-11eb-bbaa-8c1645ac402c.jpg','2021-08-04 10:01:21','2021-08-07 20:43:26','南通市','NoFace','绿色的'),(2105,'test','0f7999a4-f77d-11eb-855f-8c1645ac402c.jpg','2021-08-04 10:00:27','2021-08-07 20:43:26','南通市','NoFace','蓝色的'),(2106,'test','0f7b1f38-f77d-11eb-91f3-8c1645ac402c.jpg','2021-08-04 10:00:13','2021-08-07 20:43:26','南通市','NoFace','黄色的'),(2107,'TEST','5aa9da66-f77d-11eb-82e5-8c1645ac402c.jpg','2021-08-04 10:01:21','2021-08-07 20:45:32','南通市','NoFace','绿色的'),(2108,'TEST','5aab5ff6-f77d-11eb-8dc2-8c1645ac402c.jpg','2021-08-04 10:00:27','2021-08-07 20:45:32','南通市','NoFace','蓝色的'),(2109,'TEST','5ab483ca-f77d-11eb-b53e-8c1645ac402c.jpg','2021-08-04 10:00:13','2021-08-07 20:45:32','南通市','NoFace','黄色的'),(2110,'admin','19dba774-fa80-11eb-9ec4-00ff1ef14421.jpg','2020-06-11 20:10:50','2021-08-11 16:42:49','南通市','NoFace','建筑学'),(2111,'admin','19afaddc-fa80-11eb-894e-8c1645ac402c.jpg','2020-06-05 19:31:29','2021-08-11 16:42:49','南通市','NoFace','鸡蛋（食物）'),(2112,'admin','19dbce68-fa80-11eb-9794-00ff1ef14421.jpg','2020-07-09 15:50:16','2021-08-11 16:42:51','南通市','67238d06-d8ae-11eb-96d6-8c1645ac402c','人'),(2113,'admin','19ae9be4-fa80-11eb-961f-00ff1ef14421.jpg','2020-06-06 10:02:19','2021-08-11 16:42:53','南通市','6c686e18-d8ae-11eb-972b-8c1645ac402c','人'),(2114,'admin','3d513424-fa80-11eb-b4c7-00ff1ef14421.jpg','2020-07-10 19:36:42','2021-08-11 16:43:50','南通市','NoFace','饮食'),(2115,'admin','411ae1e5-fa80-11eb-ad64-00ff1ef14421.jpg','2020-08-10 21:38:04','2021-08-11 16:43:54','南通市','NoFace','文本'),(2116,'admin','40045be4-fa80-11eb-8d6d-00ff1ef14421.jpg','2020-07-12 10:50:24','2021-08-11 16:43:55','南通市','NoFace','喝'),(2117,'admin','411ae1e4-fa80-11eb-a3b7-00ff1ef14421.jpg','2020-08-16 11:25:10','2021-08-11 16:43:56','南通市','NoFace','紫色的'),(2121,'admin','34d0e61a-faa0-11eb-aecd-8c1645ac402c.jpg','2020-05-25 13:55:12','2021-08-11 20:32:37','南通市','NoFace','白天'),(2122,'admin','34feab62-faa0-11eb-841d-8c1645ac402c.jpg','2020-06-05 19:30:44','2021-08-11 20:32:37','南通市','NoFace','鸡蛋（食物）'),(2123,'admin','35025230-faa0-11eb-a81d-8c1645ac402c.jpg','2020-05-31 19:35:41','2021-08-11 20:32:38','南通市','NoFace','食物'),(2124,'admin','34cffc6e-faa0-11eb-9504-8c1645ac402c.jpg','2021-01-25 15:23:51','2021-08-11 20:32:39','南通市','36aa8df6faa011eba3498c16','人'),(2145,'lixiao','92fd7cde-00d1-11ec-9119-00ff1ef14421.jpg','2021-08-19 17:41:49','2021-08-19 17:41:49','其他','NoFace','字形'),(2146,'lixiao','92fd560c-00d1-11ec-9dbd-00ff1ef14421.jpg','2021-08-19 17:41:49','2021-08-19 17:41:49','其他','NoFace','绿色的'),(2147,'lixiao','92fedb8a-00d1-11ec-907b-8c1645ac402c.jpg','2021-08-19 17:41:49','2021-08-19 17:41:49','其他','NoFace','绿色的'),(2148,'lixiao','932d93b4-00d1-11ec-a796-00ff1ef14421.jpg','2021-08-19 17:41:49','2021-08-19 17:41:49','其他','NoFace','绿色的'),(2149,'lixiao','b4cfaf86-00d1-11ec-9f03-00ff1ef14421.jpg','2021-08-19 17:42:45','2021-08-19 17:42:45','其他','NoFace','字形'),(2150,'admin','d56d4ff4-0342-11ec-84e9-8c1645ac402c.jpg','2020-05-31 19:35:41','2021-08-22 20:16:55','南通市','NoFace','食物'),(2151,'admin','d56d28f8-0342-11ec-9724-8c1645ac402c.jpg','2020-05-25 13:55:12','2021-08-22 20:16:55','南通市','NoFace','白天'),(2152,'admin','d59b498c-0342-11ec-83ed-8c1645ac402c.jpg','2020-06-05 19:30:44','2021-08-22 20:16:57','南通市','NoFace','鸡蛋（食物）'),(2154,'admin','f3f06246-0342-11ec-b87e-8c1645ac402c.jpg','2020-05-25 13:55:12','2021-08-22 20:17:47','南通市','NoFace','白天'),(2158,'admin','d530d0a6-06e6-11ec-8222-8c1645ac402c.jpg','2020-06-11 20:10:50','2021-08-27 11:28:26','南通市','NoFace','测试'),(2159,'admin','d52f4b46-06e6-11ec-a4e6-8c1645ac402c.jpg','2020-07-10 19:36:42','2021-08-27 11:28:26','南通市','NoFace','测试'),(2160,'admin','d530f7a4-06e6-11ec-8fca-8c1645ac402c.jpg','2020-07-09 15:50:16','2021-08-27 11:28:35','南通市','66a3d592fbf011eb82a18c16','测试'),(2161,'admin','9de15a78-06e7-11ec-9e7a-8c1645ac402c.jpg','2020-06-05 19:30:44','2021-08-27 11:34:02','南通市','NoFace','饮食'),(2162,'admin','9e1002da-06e7-11ec-9064-8c1645ac402c.jpg','2020-06-05 19:31:29','2021-08-27 11:34:03','南通市','NoFace','饮食'),(2163,'test','72c2a9c0-06ef-11ec-be53-8c1645ac402c.jpg','2021-08-19 17:42:45','2021-08-27 12:30:03','其他','NoFace','字形'),(2164,'test','72c7d646-06ef-11ec-84c6-8c1645ac402c.jpg','2021-08-19 17:41:49','2021-08-27 12:30:03','其他','NoFace','字形'),(2165,'test','72cfe71a-06ef-11ec-ae70-8c1645ac402c.jpg','2021-08-19 17:41:49','2021-08-27 12:30:03','其他','NoFace','绿色的'),(2166,'test','a32254dc-06ef-11ec-97c5-8c1645ac402c.jpg','2021-08-04 09:55:21','2021-08-27 12:31:24','南通市','NoFace','材料特性'),(2167,'test','a366fbc6-06ef-11ec-97ef-8c1645ac402c.jpg','2021-08-04 09:54:29','2021-08-27 12:31:25','南通市','NoFace','材料特性'),(2168,'test','a3737662-06ef-11ec-bc8a-8c1645ac402c.jpg','2021-08-04 09:53:42','2021-08-27 12:31:25','南通市','NoFace','材料特性'),(2169,'admin','55653e24-0af4-11ec-a0ba-8c1645ac402c.jpg','2021-09-01 15:15:16','2021-09-01 15:15:16','常州市','5a2d20060af411ecb4848c16','人'),(2170,'admin','5565651c-0af4-11ec-8e41-8c1645ac402c.jpg','2021-09-01 15:15:17','2021-09-01 15:15:17','常州市','5a3779280af411ec98ca8c16','人'),(2171,'admin','65252202-0af4-11ec-9d2b-8c1645ac402c.jpg','2021-09-01 15:15:39','2021-09-01 15:15:39','常州市','5a2d20060af411ecb4848c16','人'),(2172,'admin','65260e80-0af4-11ec-ba22-8c1645ac402c.jpg','2021-09-01 15:15:41','2021-09-01 15:15:41','常州市','5a3779280af411ec98ca8c16','人');
/*!40000 ALTER TABLE `imgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sharephotos`
--

DROP TABLE IF EXISTS `sharephotos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sharephotos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fromUserName` varchar(255) DEFAULT NULL,
  `acceptUserName` varchar(255) DEFAULT NULL,
  `fromImgRoad` varchar(255) DEFAULT NULL,
  `acceptImgRoad` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ff_userName` (`fromUserName`),
  KEY `aa_userName` (`acceptUserName`),
  KEY `ff_imgRoad` (`fromImgRoad`),
  KEY `aa_imgRoad` (`acceptImgRoad`),
  CONSTRAINT `aa_imgRoad` FOREIGN KEY (`acceptImgRoad`) REFERENCES `imgs` (`imgRoad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aa_userName` FOREIGN KEY (`acceptUserName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ff_imgRoad` FOREIGN KEY (`fromImgRoad`) REFERENCES `imgs` (`imgRoad`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ff_userName` FOREIGN KEY (`fromUserName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sharephotos`
--

LOCK TABLES `sharephotos` WRITE;
/*!40000 ALTER TABLE `sharephotos` DISABLE KEYS */;
INSERT INTO `sharephotos` VALUES (16,'lixiao','test','b4cfaf86-00d1-11ec-9f03-00ff1ef14421.jpg','72c2a9c0-06ef-11ec-be53-8c1645ac402c.jpg'),(17,'lixiao','test','92fd7cde-00d1-11ec-9119-00ff1ef14421.jpg','72c7d646-06ef-11ec-84c6-8c1645ac402c.jpg'),(18,'lixiao','test','92fd560c-00d1-11ec-9dbd-00ff1ef14421.jpg','72cfe71a-06ef-11ec-ae70-8c1645ac402c.jpg'),(19,'admin','test','11831288-f65d-11eb-b48b-00ffc4de3237IMG_20210804_095521_edit_544752723129376.jpg','a32254dc-06ef-11ec-97c5-8c1645ac402c.jpg'),(20,'admin','test','116ed51a-f65d-11eb-8acf-00ffc4de3237IMG_20210804_095429.jpg','a366fbc6-06ef-11ec-97ef-8c1645ac402c.jpg'),(21,'admin','test','114badba-f65d-11eb-95e0-00ffc4de3237IMG_20210804_095342.jpg','a3737662-06ef-11ec-bc8a-8c1645ac402c.jpg');
/*!40000 ALTER TABLE `sharephotos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sharephotos_msg`
--

DROP TABLE IF EXISTS `sharephotos_msg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sharephotos_msg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fromUserName` varchar(255) DEFAULT NULL,
  `acceptUserName` varchar(255) DEFAULT NULL,
  `imgid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ff_userName` (`fromUserName`),
  KEY `aa_userName` (`acceptUserName`),
  KEY `sharephotos_msg_imgid` (`imgid`),
  CONSTRAINT `sharephotos_msg_ibfk_2` FOREIGN KEY (`acceptUserName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sharephotos_msg_ibfk_4` FOREIGN KEY (`fromUserName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sharephotos_msg_imgid` FOREIGN KEY (`imgid`) REFERENCES `imgs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sharephotos_msg`
--

LOCK TABLES `sharephotos_msg` WRITE;
/*!40000 ALTER TABLE `sharephotos_msg` DISABLE KEYS */;
/*!40000 ALTER TABLE `sharephotos_msg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userName` varchar(255) NOT NULL,
  `passWord` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  PRIMARY KEY (`userName`,`phone`) USING BTREE,
  KEY `userName` (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('admin','123456','18115679537'),('lixiao','123456','15150649924'),('test','123456','15861860233');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `videos`
--

DROP TABLE IF EXISTS `videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `viedoRoad` varchar(255) NOT NULL,
  `makeTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`userName`,`viedoRoad`) USING BTREE,
  KEY `userName` (`userName`),
  CONSTRAINT `videos_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `users` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos`
--

LOCK TABLES `videos` WRITE;
/*!40000 ALTER TABLE `videos` DISABLE KEYS */;
INSERT INTO `videos` VALUES (39,'admin','a53c85b6-f6a7-11eb-8577-8c1645ac402c94a20622-d68e-11eb-88b9-7440bb7a7562.mp4','2021-08-06 19:15:45'),(40,'admin','a55dab5c-f6a7-11eb-b49a-8c1645ac402c622c6ac0-d67a-11eb-b8ef-7440bb7a756216f48310-d64a-11eb-95c3-7440bb7a7562.mp4','2021-08-06 19:15:45'),(41,'admin','a56373d8-f6a7-11eb-8240-8c1645ac402ca6f432b8-d707-11eb-8181-7440bb7a7562965E94E487753EDC1864EE723B0D6128.mp4','2021-08-06 19:15:45'),(42,'admin','a56cfbae-f6a7-11eb-928d-8c1645ac402ca6f432b9-d707-11eb-a07f-7440bb7a756299C154CC5B34D6057FD04B2A1C0BA605.mp4','2021-08-06 19:15:46'),(43,'admin','a571dad2-f6a7-11eb-b437-8c1645ac402ca6fa2690-d707-11eb-912c-7440bb7a756282F42E0484B8A71E07D1494C449C6A58.mp4','2021-08-06 19:15:46'),(44,'admin','a57706e2-f6a7-11eb-89c7-8c1645ac402ca6fe6958-d707-11eb-b557-7440bb7a756253C95BEBA0D52AE85A0CA04A67CCA0DB.mp4','2021-08-06 19:15:46'),(45,'admin','a577f0ae-f6a7-11eb-a22d-8c1645ac402ca6fede38-d707-11eb-ba0c-7440bb7a7562DA62D6B79AD615D110F7ABC82C721933.mp4','2021-08-06 19:15:46'),(46,'admin','a581ae38-f6a7-11eb-99d8-8c1645ac402ca706054a-d707-11eb-b078-7440bb7a756294926581C64A72AAC041F16E77DEC47F.mp4','2021-08-06 19:15:46'),(48,'admin','b1194a5c-fbe5-11eb-ba56-8c1645ac402c.mp4','2021-08-13 11:22:31'),(51,'admin','1864d5ae-ff10-11eb-8a3d-8c1645ac402c.mp4','2021-08-17 12:03:36'),(52,'admin','330fc28c-06dd-11ec-9322-8c1645ac402c.mp4','2021-08-27 10:19:26');
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

-- Dump completed on 2021-09-01 21:10:56
