-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: math_formulas
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `category`
--

CREATE DATABASE math_formulas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

use math_formulas;

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  `category_icon` mediumblob,
  `grade_id` int(11) NOT NULL,
  `division_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk0_category` (`division_id`),
  KEY `fk1_category_idx` (`grade_id`),
  KEY `fk2_category_idx` (`version_id`),
  CONSTRAINT `fk0_category` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `fk1_category` FOREIGN KEY (`grade_id`) REFERENCES `grade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk2_category` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `division`
--

DROP TABLE IF EXISTS `division`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `division` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `division_name` varchar(20) NOT NULL,
  `version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk0_division_idx` (`version_id`),
  CONSTRAINT `fk0_division` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `error_feedback`
--

DROP TABLE IF EXISTS `error_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `error_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `lesson_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk0_error_feedback_idx` (`lesson_id`),
  CONSTRAINT `fk0_error_feedback` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `example`
--

DROP TABLE IF EXISTS `example`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `example` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk0_example_idx` (`lesson_id`),
  KEY `fk1_example_idx` (`version_id`),
  CONSTRAINT `fk0_example` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`),
  CONSTRAINT `fk1_example` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exercises`
--

DROP TABLE IF EXISTS `exercises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exercises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` longtext NOT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `math_form_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk0_exercises_idx` (`math_form_id`),
  KEY `fk1_exercises_idx` (`version_id`),
  CONSTRAINT `fk0_exercises` FOREIGN KEY (`math_form_id`) REFERENCES `mathform` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_exercises` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `grade_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lesson`
--

DROP TABLE IF EXISTS `lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lesson` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lesson_title` varchar(100) NOT NULL,
  `lesson_content` longtext NOT NULL,
  `category_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk0_formula` (`category_id`),
  KEY `fk1_formula_idx` (`version_id`),
  CONSTRAINT `fk0_formula` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk1_formula` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mathform`
--

DROP TABLE IF EXISTS `mathform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mathform` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mathform_title` varchar(255) NOT NULL,
  `mathform_content` longtext NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk0_math_form_idx` (`lesson_id`),
  KEY `fk1_math_form_idx` (`version_id`),
  CONSTRAINT `fk0_math_form` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_math_form` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `category_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk0_question` (`category_id`),
  KEY `fk1_question_idx` (`version_id`),
  CONSTRAINT `fk0_question` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk1_question` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_choices`
--

DROP TABLE IF EXISTS `question_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `is_correct` bit(1) NOT NULL,
  `question_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk0_question_choices` (`question_id`),
  KEY `fk1_question_choices_idx` (`version_id`),
  CONSTRAINT `fk0_question_choices` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `fk1_question_choices` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question_level`
--

DROP TABLE IF EXISTS `question_level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(20) NOT NULL,
  `question_id` int(11) NOT NULL,
  `version_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk0_question_level_idx` (`question_id`),
  KEY `fk1_question_level_idx` (`version_id`),
  CONSTRAINT `fk0_question_level` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk1_question_level` FOREIGN KEY (`version_id`) REFERENCES `version` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `role_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk0_user_roles_idx` (`username`),
  CONSTRAINT `fk0_user_roles` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `enabled` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `id` int(11) NOT NULL,
  `database_version` int(11) NOT NULL,
  `version_name` varchar(45) DEFAULT NULL,
  `is_current` bit(1) NOT NULL,
  `released_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `database_version_UNIQUE` (`database_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-11 19:05:41
