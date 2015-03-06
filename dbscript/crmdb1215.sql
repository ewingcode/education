-- MySQL dump 10.13  Distrib 5.1.30, for Win32 (ia32)
--
-- Host: 127.0.0.1    Database: crmdb
-- ------------------------------------------------------
-- Server version	5.1.30-community

CREATE DATABASE crmdb;
USE crmdb;
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
-- Table structure for table `course_period`
--

DROP TABLE IF EXISTS `course_period`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_period` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `start_time` varchar(50) NOT NULL,
  `end_time` varchar(50) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `course_period`
--

LOCK TABLES `course_period` WRITE;
/*!40000 ALTER TABLE `course_period` DISABLE KEYS */;
INSERT INTO `course_period` VALUES (1,'0800','1000','2012-07-24 14:37:30'),(2,'1030','1230','2012-07-24 14:37:30'),(3,'1400','1600','2012-07-24 14:37:30'),(4,'1630','1830','2012-07-24 14:37:30');
/*!40000 ALTER TABLE `course_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_exchange`
--

DROP TABLE IF EXISTS `customer_exchange`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_exchange` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `cust_status` char(1) NOT NULL COMMENT '客户当前状态',
  `source_type` char(1) NOT NULL COMMENT '咨询量来源',
  `is_book` char(1) NOT NULL COMMENT '是否预约',
  `user_id` int(10) NOT NULL,
  `content` varchar(1000) NOT NULL COMMENT '交流内容',
  `customer_attach_id` varchar(1000) DEFAULT NULL COMMENT '交流录音记录',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `book_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '预约时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='回访客户交流表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_exchange`
--

LOCK TABLES `customer_exchange` WRITE;
/*!40000 ALTER TABLE `customer_exchange` DISABLE KEYS */;
INSERT INTO `customer_exchange` VALUES (4,2,'0','0','1',18,'阿瑟大大',NULL,'2012-10-08 14:43:52','2012-10-20 04:56:59','2012-10-26 16:00:00'),(5,2,'0','1','0',18,'12121',NULL,'2012-10-20 05:07:06','2012-10-20 05:07:06','2012-10-20 05:07:06'),(6,2,'1','1','1',18,'212121',NULL,'2012-10-20 05:07:26','2012-11-06 15:24:07','2012-11-06 16:00:00'),(7,3,'1','1','0',18,'1213dd',NULL,'2012-10-20 05:08:21','2012-10-20 05:08:21','2012-10-20 05:08:21'),(8,2,'1','1','1',18,'9849848',NULL,'2012-12-06 14:13:02','2012-12-06 14:13:02','2012-12-12 16:00:00');
/*!40000 ALTER TABLE `customer_exchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `customer_exchange_view`
--

DROP TABLE IF EXISTS `customer_exchange_view`;
/*!50001 DROP VIEW IF EXISTS `customer_exchange_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `customer_exchange_view` (
  `id` int(10),
  `customer_id` int(10),
  `cust_status` char(1),
  `source_type` char(1),
  `is_book` char(1),
  `user_id` int(10),
  `content` varchar(1000),
  `customer_attach_id` varchar(1000),
  `create_time` timestamp,
  `last_update` timestamp,
  `book_time` timestamp,
  `name` varchar(50),
  `sex` char(1),
  `school` varchar(200),
  `classes` varchar(50),
  `brithday` varchar(10),
  `age` varchar(3),
  `student_type` varchar(1),
  `resident_type` varchar(1),
  `parent_name` varchar(20),
  `phone` varchar(50),
  `addr` varchar(200)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `customer_info`
--

DROP TABLE IF EXISTS `customer_info`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `customer_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `school` varchar(200) DEFAULT NULL COMMENT '学校',
  `classes` varchar(50) DEFAULT NULL COMMENT '班级',
  `brithday` varchar(10) DEFAULT NULL COMMENT '生日',
  `age` varchar(3) DEFAULT NULL COMMENT '年龄',
  `student_type` varchar(1) DEFAULT NULL COMMENT '学生类型',
  `resident_type` varchar(1) DEFAULT NULL COMMENT '户口类型',
  `parent_name` varchar(20) DEFAULT NULL COMMENT '家长名称',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `addr` varchar(200) DEFAULT NULL COMMENT '家庭住址',
  `iseff` char(1) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `email` varchar(45) DEFAULT NULL,
  `class` varchar(50) DEFAULT NULL COMMENT '班级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='客户信息表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `customer_info`
--

LOCK TABLES `customer_info` WRITE;
/*!40000 ALTER TABLE `customer_info` DISABLE KEYS */;
INSERT INTO `customer_info` VALUES (2,'tanson lin','0','guangzhou 17 ','初中','1998-08-27','14','1','2','老林','2121312','1','0','2012-08-22 12:40:32','2012-08-22 12:40:32','22@163.com',NULL),(3,'林','0',NULL,NULL,'2008-10-01','4','0','0',NULL,NULL,NULL,NULL,'2012-10-08 14:29:37','2012-10-08 14:29:37',NULL,NULL);
/*!40000 ALTER TABLE `customer_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_task`
--

DROP TABLE IF EXISTS `flow_task`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `flow_task` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `process_name` varchar(200) NOT NULL DEFAULT '' COMMENT '流程名称',
  `task_name` varchar(200) NOT NULL DEFAULT '' COMMENT '任务名称',
  `assign_type` char(1) DEFAULT NULL COMMENT '指派类型,0:用户,1:角色,2:部门',
  `assigner` varchar(20) DEFAULT NULL COMMENT '被指派',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `busi_page_name` varchar(50) DEFAULT NULL COMMENT '业务页面对应 follow_busi_page的name字段',
  `type` char(1) CHARACTER SET ucs2 NOT NULL DEFAULT '' COMMENT '0:开始 1:执行中 2:结束',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='流程定义任务权限列表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `flow_task`
--

LOCK TABLES `flow_task` WRITE;
/*!40000 ALTER TABLE `flow_task` DISABLE KEYS */;
INSERT INTO `flow_task` VALUES (1,'orderProcess','签约','1','1','2012-10-22 12:22:17','2012-04-29 03:25:19','/page/contract/follow/saler_confirm.jsp','0'),(2,'orderProcess','销售主管审批','1','2','2012-10-22 12:22:17','2012-04-29 03:25:19','/page/contract/follow/market_confirm.jsp','1'),(3,'orderProcess','教务部处理','1','3','2012-10-22 12:22:17','2012-04-29 03:25:19','/page/contract/follow/eduadmin_dispatch.jsp','1'),(4,'orderProcess','待班主任确认','1','4','2012-10-22 12:22:17','2012-04-29 03:25:19','/page/contract/follow/mainteacher_confirm.jsp','1'),(5,'orderProcess','班主任处理中','1','4','2012-10-22 12:22:17','2012-04-29 03:25:19','/page/contract/follow/mainteacher_handle.jsp','1'),(6,'orderProcess','教务部审批','1','3','2012-10-22 12:22:17','2012-04-29 03:25:19','/page/contract/follow/eduadmin_confirm.jsp','1'),(7,'orderProcess','审批通过','','','2012-11-14 13:00:31','2012-04-29 03:25:19','/page/contract/follow/order_detail.jsp','2'),(8,'orderProcess','结束',NULL,NULL,'2012-10-30 13:02:16','2012-04-29 03:25:19',NULL,''),(9,'orderLastProcess','续签','1','3','2012-11-27 14:19:05','2012-07-08 01:46:02','/page/contract/last/last.jsp','0'),(10,'orderLastProcess','审批通过',NULL,'','2012-11-27 14:19:05','2012-10-29 14:01:35',NULL,'2'),(11,'orderLastProcess','结束',NULL,NULL,'2012-10-29 14:01:35','2012-10-29 14:01:35',NULL,'');
/*!40000 ALTER TABLE `flow_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_task_transition`
--

DROP TABLE IF EXISTS `flow_task_transition`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `flow_task_transition` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `task_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL COMMENT '转移动作名称',
  `to` varchar(50) DEFAULT NULL COMMENT '转向的任务名称',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `need_arrange` char(1) NOT NULL DEFAULT '0' COMMENT '是否需要安排下一步处理人 0:不 1:需要',
  `to_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='流程任务转变列表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `flow_task_transition`
--

LOCK TABLES `flow_task_transition` WRITE;
/*!40000 ALTER TABLE `flow_task_transition` DISABLE KEYS */;
INSERT INTO `flow_task_transition` VALUES (1,1,'待审批','销售主管审批','2012-04-17 12:40:59','2012-11-30 16:00:00','0',2),(2,2,'通过','教务部处理','2012-04-17 12:40:59','2012-11-30 16:00:00','0',3),(3,2,'不通过','签约','2012-04-17 12:40:59','2012-11-30 16:00:00','0',1),(4,3,'分配任务','待班主任确认','2012-04-17 12:40:59','2012-11-30 16:00:00','1',4),(5,4,'确认','班主任处理中','2012-04-17 12:40:59','2012-11-30 16:00:00','2',5),(6,4,'拒绝','教务部处理','2012-04-17 12:40:59','2012-11-30 16:00:00','0',3),(7,5,'待审批','教务部审批','2012-04-17 12:40:59','2012-11-30 16:00:00','0',6),(8,6,'通过','审批通过','2012-04-17 12:40:59','2012-11-30 16:00:00','0',7),(9,6,'不通过','班主任处理中','2012-04-17 12:40:59','2012-11-30 16:00:00','0',5),(10,7,'判断授课时间','结束','2012-04-17 12:40:59','2012-04-17 12:40:59','2',0),(11,9,'继单','审批通过','2012-04-17 12:40:59','2012-04-17 12:40:59','0',10),(12,10,'判断授课时间','结束','2012-04-17 12:40:59','2012-04-17 12:40:59','0',0);
/*!40000 ALTER TABLE `flow_task_transition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_deployment`
--

DROP TABLE IF EXISTS `jbpm4_deployment`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_deployment` (
  `DBID_` bigint(20) NOT NULL,
  `NAME_` longtext,
  `TIMESTAMP_` bigint(20) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_deployment`
--

LOCK TABLES `jbpm4_deployment` WRITE;
/*!40000 ALTER TABLE `jbpm4_deployment` DISABLE KEYS */;
INSERT INTO `jbpm4_deployment` VALUES (1,NULL,0,'active');
/*!40000 ALTER TABLE `jbpm4_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_deployprop`
--

DROP TABLE IF EXISTS `jbpm4_deployprop`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_deployprop` (
  `DBID_` bigint(20) NOT NULL,
  `DEPLOYMENT_` bigint(20) DEFAULT NULL,
  `OBJNAME_` varchar(255) DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `STRINGVAL_` varchar(255) DEFAULT NULL,
  `LONGVAL_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_DEPLPROP_DEPL` (`DEPLOYMENT_`),
  CONSTRAINT `FK_DEPLPROP_DEPL` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_deployprop`
--

LOCK TABLES `jbpm4_deployprop` WRITE;
/*!40000 ALTER TABLE `jbpm4_deployprop` DISABLE KEYS */;
INSERT INTO `jbpm4_deployprop` VALUES (3,1,'orderProcess','langid','jpdl-4.4',NULL),(4,1,'orderProcess','pdid','orderProcess-1',NULL),(5,1,'orderProcess','pdkey','orderProcess',NULL),(6,1,'orderProcess','pdversion',NULL,1);
/*!40000 ALTER TABLE `jbpm4_deployprop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_execution`
--

DROP TABLE IF EXISTS `jbpm4_execution`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_execution` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ACTIVITYNAME_` varchar(255) DEFAULT NULL,
  `PROCDEFID_` varchar(255) DEFAULT NULL,
  `HASVARS_` bit(1) DEFAULT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `SUSPHISTSTATE_` varchar(255) DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `HISACTINST_` bigint(20) DEFAULT NULL,
  `PARENT_` bigint(20) DEFAULT NULL,
  `INSTANCE_` bigint(20) DEFAULT NULL,
  `SUPEREXEC_` bigint(20) DEFAULT NULL,
  `SUBPROCINST_` bigint(20) DEFAULT NULL,
  `PARENT_IDX_` int(11) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  UNIQUE KEY `ID_` (`ID_`),
  KEY `IDX_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  KEY `IDX_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `IDX_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `IDX_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_PARENT` (`PARENT_`),
  KEY `FK_EXEC_SUBPI` (`SUBPROCINST_`),
  KEY `FK_EXEC_INSTANCE` (`INSTANCE_`),
  KEY `FK_EXEC_SUPEREXEC` (`SUPEREXEC_`),
  CONSTRAINT `FK_EXEC_INSTANCE` FOREIGN KEY (`INSTANCE_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUBPI` FOREIGN KEY (`SUBPROCINST_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_EXEC_SUPEREXEC` FOREIGN KEY (`SUPEREXEC_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_execution`
--

LOCK TABLES `jbpm4_execution` WRITE;
/*!40000 ALTER TABLE `jbpm4_execution` DISABLE KEYS */;
INSERT INTO `jbpm4_execution` VALUES (10001,'pvm',9,'授课中','orderProcess-1','',NULL,'109','orderProcess.109','active-root',NULL,0,10020,NULL,10001,NULL,NULL,NULL),(20001,'pvm',9,'授课中','orderProcess-1','',NULL,'110','orderProcess.110','active-root',NULL,0,70006,NULL,20001,NULL,NULL,NULL),(30001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'75','orderProcess.75','active-root',NULL,0,30006,NULL,30001,NULL,NULL,NULL),(40001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'76','orderProcess.76','active-root',NULL,0,40006,NULL,40001,NULL,NULL,NULL),(50001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'77','orderProcess.77','active-root',NULL,0,50006,NULL,50001,NULL,NULL,NULL),(50005,'pvm',7,'授课中','orderProcess-1','',NULL,'114','orderProcess.114','active-root',NULL,0,50020,NULL,50005,NULL,NULL,NULL),(50007,'pvm',3,'教务部处理','orderProcess-1','',NULL,'78','orderProcess.78','active-root',NULL,0,60002,NULL,50007,NULL,NULL,NULL),(70001,'pvm',3,'教务部处理','orderProcess-1','',NULL,'79','orderProcess.79','active-root',NULL,0,80002,NULL,70001,NULL,NULL,NULL),(80003,'pvm',10,'教务部审批','orderProcess-1','',NULL,'80','orderProcess.80','active-root',NULL,0,80024,NULL,80003,NULL,NULL,NULL),(90001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'86','orderProcess.86','active-root',NULL,0,90014,NULL,90001,NULL,NULL,NULL),(100001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'96','orderProcess.96','active-root',NULL,0,100006,NULL,100001,NULL,NULL,NULL),(100005,'pvm',1,'签约','orderProcess-1','',NULL,'119','orderProcess.119','active-root',NULL,0,100008,NULL,100005,NULL,NULL,NULL),(110001,'pvm',1,'签约','orderProcess-1','',NULL,'120','orderProcess.120','active-root',NULL,0,110004,NULL,110001,NULL,NULL,NULL),(120001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'121','orderProcess.121','active-root',NULL,0,120006,NULL,120001,NULL,NULL,NULL),(130001,'pvm',3,'教务部处理','orderProcess-1','',NULL,'1','orderProcess.1','active-root',NULL,0,130008,NULL,130001,NULL,NULL,NULL),(140001,'pvm',5,'班主任处理中','orderProcess-1','',NULL,'2','orderProcess.2','active-root',NULL,0,140012,NULL,140001,NULL,NULL,NULL),(150001,'pvm',1,'签约','orderProcess-1','',NULL,'3','orderProcess.3','active-root',NULL,0,150004,NULL,150001,NULL,NULL,NULL),(150005,'pvm',1,'签约','orderProcess-1','',NULL,'4','orderProcess.4','active-root',NULL,0,150008,NULL,150005,NULL,NULL,NULL),(160001,'pvm',1,'签约','orderProcess-1','',NULL,'103','orderProcess.103','active-root',NULL,0,160004,NULL,160001,NULL,NULL,NULL),(160005,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'6','orderProcess.6','active-root',NULL,0,160010,NULL,160005,NULL,NULL,NULL),(170001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'7','orderProcess.7','active-root',NULL,0,170006,NULL,170001,NULL,NULL,NULL),(170007,'pvm',1,'签约','orderProcess-1','',NULL,'8','orderProcess.8','active-root',NULL,0,170010,NULL,170007,NULL,NULL,NULL),(180001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'105','orderProcess.105','active-root',NULL,0,180006,NULL,180001,NULL,NULL,NULL),(180005,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'10','orderProcess.10','active-root',NULL,0,180010,NULL,180005,NULL,NULL,NULL),(190001,'pvm',1,'签约','orderProcess-1','',NULL,'106','orderProcess.106','active-root',NULL,0,190004,NULL,190001,NULL,NULL,NULL),(190005,'pvm',5,'班主任处理中','orderProcess-1','',NULL,'12','orderProcess.12','active-root',NULL,0,200006,NULL,190005,NULL,NULL,NULL),(200001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'107','orderProcess.107','active-root',NULL,0,220002,NULL,200001,NULL,NULL,NULL),(210001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'13','orderProcess.13','active-root',NULL,0,210014,NULL,210001,NULL,NULL,NULL),(230001,'pvm',7,'待授课老师确认','orderProcess-1','',NULL,'108','orderProcess.108','active-root',NULL,0,230016,NULL,230001,NULL,NULL,NULL),(230005,'pvm',7,'授课中','orderProcess-1','',NULL,'16','orderProcess.16','active-root',NULL,0,230020,NULL,230005,NULL,NULL,NULL),(240001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'17','orderProcess.17','active-root',NULL,0,240006,NULL,240001,NULL,NULL,NULL),(250001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'18','orderProcess.18','active-root',NULL,0,270006,NULL,250001,NULL,NULL,NULL),(280001,'pvm',7,'授课中','orderProcess-1','',NULL,'19','orderProcess.19','active-root',NULL,0,300002,NULL,280001,NULL,NULL,NULL),(310001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'27','orderProcess.27','active-root',NULL,0,310006,NULL,310001,NULL,NULL,NULL),(320001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'28','orderProcess.28','active-root',NULL,0,320006,NULL,320001,NULL,NULL,NULL),(320007,'pvm',7,'授课中','orderProcess-1','',NULL,'29','orderProcess.29','active-root',NULL,0,320022,NULL,320007,NULL,NULL,NULL),(320023,'pvm',4,'待班主任确认','orderProcess-1','',NULL,'30','orderProcess.30','active-root',NULL,0,320032,NULL,320023,NULL,NULL,NULL),(330001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'31','orderProcess.31','active-root',NULL,0,330006,NULL,330001,NULL,NULL,NULL),(340001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'32','orderProcess.32','active-root',NULL,0,340006,NULL,340001,NULL,NULL,NULL),(340007,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'33','orderProcess.33','active-root',NULL,0,340012,NULL,340007,NULL,NULL,NULL),(350001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'34','orderProcess.34','active-root',NULL,0,350006,NULL,350001,NULL,NULL,NULL),(360001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'35','orderProcess.35','active-root',NULL,0,360006,NULL,360001,NULL,NULL,NULL),(370001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'36','orderProcess.36','active-root',NULL,0,370006,NULL,370001,NULL,NULL,NULL),(380001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'37','orderProcess.37','active-root',NULL,0,380006,NULL,380001,NULL,NULL,NULL),(390001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'38','orderProcess.38','active-root',NULL,0,390006,NULL,390001,NULL,NULL,NULL),(400001,'pvm',3,'教务部处理','orderProcess-1','',NULL,'39','orderProcess.39','active-root',NULL,0,400008,NULL,400001,NULL,NULL,NULL),(410001,'pvm',4,'待班主任确认','orderProcess-1','',NULL,'40','orderProcess.40','active-root',NULL,0,420002,NULL,410001,NULL,NULL,NULL),(430001,'pvm',4,'待班主任确认','orderProcess-1','',NULL,'41','orderProcess.41','active-root',NULL,0,430010,NULL,430001,NULL,NULL,NULL),(440001,'pvm',3,'签约','orderProcess-1','',NULL,'42','orderProcess.42','active-root',NULL,0,440008,NULL,440001,NULL,NULL,NULL),(470001,'pvm',3,'签约','orderProcess-1','',NULL,'45','orderProcess.45','active-root',NULL,0,470008,NULL,470001,NULL,NULL,NULL),(480001,'pvm',3,'签约','orderProcess-1','',NULL,'46','orderProcess.46','active-root',NULL,0,480008,NULL,480001,NULL,NULL,NULL),(490001,'pvm',3,'签约','orderProcess-1','',NULL,'47','orderProcess.47','active-root',NULL,0,490008,NULL,490001,NULL,NULL,NULL),(490009,'pvm',3,'签约','orderProcess-1','',NULL,'48','orderProcess.48','active-root',NULL,0,490016,NULL,490009,NULL,NULL,NULL),(490017,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'49','orderProcess.49','active-root',NULL,0,490022,NULL,490017,NULL,NULL,NULL),(500001,'pvm',4,'销售主管审批','orderProcess-1','',NULL,'50','orderProcess.50','active-root',NULL,0,510006,NULL,500001,NULL,NULL,NULL),(520001,'pvm',1,'签约','orderProcess-1','',NULL,'51','orderProcess.51','active-root',NULL,0,520004,NULL,520001,NULL,NULL,NULL),(530001,'pvm',8,'销售主管审批','orderProcess-1','',NULL,'52','orderProcess.52','active-root',NULL,0,560002,NULL,530001,NULL,NULL,NULL),(560003,'pvm',4,'销售主管审批','orderProcess-1','',NULL,'53','orderProcess.53','active-root',NULL,0,570004,NULL,560003,NULL,NULL,NULL),(570005,'pvm',4,'销售主管审批','orderProcess-1','',NULL,'54','orderProcess.54','active-root',NULL,0,570014,NULL,570005,NULL,NULL,NULL),(580001,'pvm',3,'签约','orderProcess-1','',NULL,'55','orderProcess.55','active-root',NULL,0,590002,NULL,580001,NULL,NULL,NULL),(600001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'56','orderProcess.56','active-root',NULL,0,600006,NULL,600001,NULL,NULL,NULL),(600007,'pvm',3,'签约','orderProcess-1','',NULL,'57','orderProcess.57','active-root',NULL,0,600014,NULL,600007,NULL,NULL,NULL),(630001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'60','orderProcess.60','active-root',NULL,0,630006,NULL,630001,NULL,NULL,NULL),(640001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'61','orderProcess.61','active-root',NULL,0,640006,NULL,640001,NULL,NULL,NULL),(650005,'pvm',3,'教务部处理','orderProcess-1','',NULL,'64','orderProcess.64','active-root',NULL,0,670002,NULL,650005,NULL,NULL,NULL),(660001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'65','orderProcess.65','active-root',NULL,0,660006,NULL,660001,NULL,NULL,NULL),(680001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'66','orderProcess.66','active-root',NULL,0,680006,NULL,680001,NULL,NULL,NULL),(690001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'67','orderProcess.67','active-root',NULL,0,690006,NULL,690001,NULL,NULL,NULL),(690007,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'68','orderProcess.68','active-root',NULL,0,690012,NULL,690007,NULL,NULL,NULL),(700001,'pvm',9,'授课中','orderProcess-1','',NULL,'69','orderProcess.69','active-root',NULL,0,700020,NULL,700001,NULL,NULL,NULL),(700021,'pvm',5,'班主任处理中','orderProcess-1','',NULL,'70','orderProcess.70','active-root',NULL,0,700032,NULL,700021,NULL,NULL,NULL),(700033,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'71','orderProcess.71','active-root',NULL,0,700038,NULL,700033,NULL,NULL,NULL),(710001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'72','orderProcess.72','active-root',NULL,0,710006,NULL,710001,NULL,NULL,NULL),(720001,'pvm',7,'授课中','orderProcess-1','',NULL,'73','orderProcess.73','active-root',NULL,0,720016,NULL,720001,NULL,NULL,NULL),(720017,'pvm',3,'教务部处理','orderProcess-1','',NULL,'74','orderProcess.74','active-root',NULL,0,720024,NULL,720017,NULL,NULL,NULL);
/*!40000 ALTER TABLE `jbpm4_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_hist_actinst`
--

DROP TABLE IF EXISTS `jbpm4_hist_actinst`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_hist_actinst` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `HPROCI_` bigint(20) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `EXECUTION_` varchar(255) DEFAULT NULL,
  `ACTIVITY_NAME_` varchar(255) DEFAULT NULL,
  `START_` datetime DEFAULT NULL,
  `END_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TRANSITION_` varchar(255) DEFAULT NULL,
  `NEXTIDX_` int(11) DEFAULT NULL,
  `HTASK_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HACTI_HPROCI` (`HPROCI_`),
  KEY `FK_HTI_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HACTI_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HTI_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_hist_actinst`
--

LOCK TABLES `jbpm4_hist_actinst` WRITE;
/*!40000 ALTER TABLE `jbpm4_hist_actinst` DISABLE KEYS */;
INSERT INTO `jbpm4_hist_actinst` VALUES (10004,'task',1,10001,'task','orderProcess.109','签约','2012-07-08 09:39:20','2012-07-08 09:39:21',1273,'待审批',1,10003),(10006,'task',1,10001,'task','orderProcess.109','销售主管审批','2012-07-08 09:39:21','2012-07-08 09:40:14',53258,'通过',1,10005),(10008,'task',1,10001,'task','orderProcess.109','教务部处理','2012-07-08 09:40:14','2012-07-08 09:44:32',258271,'分配任务',1,10007),(10010,'task',1,10001,'task','orderProcess.109','待班主任确认','2012-07-08 09:44:32','2012-07-08 09:49:32',300106,'确认',1,10009),(10012,'task',1,10001,'task','orderProcess.109','班主任处理中','2012-07-08 09:49:32','2012-07-08 09:58:16',524408,'待审批',1,10011),(10014,'task',1,10001,'task','orderProcess.109','教务部审批','2012-07-08 09:58:16','2012-07-08 10:30:30',1934422,'不通过',1,10013),(10016,'task',1,10001,'task','orderProcess.109','班主任处理中','2012-07-08 10:30:30','2012-07-08 13:30:04',10774434,'待审批',1,10015),(10018,'task',1,10001,'task','orderProcess.109','教务部审批','2012-07-08 13:30:04','2012-07-08 13:58:52',1728723,'通过',1,10017),(10020,'task',0,10001,'task','orderProcess.109','授课中','2012-07-08 13:58:52',NULL,0,NULL,1,10019),(20004,'task',1,20001,'task','orderProcess.110','签约','2012-07-08 14:54:32','2012-07-08 14:54:33',1562,'待审批',1,20003),(20006,'task',1,20001,'task','orderProcess.110','销售主管审批','2012-07-08 14:54:33','2012-07-08 14:58:52',259432,'不通过',1,20005),(20008,'task',1,20001,'task','orderProcess.110','签约','2012-07-08 14:58:52','2012-07-08 14:59:32',40531,'待审批',1,20007),(20010,'task',1,20001,'task','orderProcess.110','销售主管审批','2012-07-08 14:59:32','2012-07-08 23:38:01',31109089,'通过',1,20009),(50008,'task',1,50005,'task','orderProcess.114','签约','2012-07-08 15:33:35','2012-07-08 15:34:57',82152,'待审批',1,50007),(50010,'task',1,50005,'task','orderProcess.114','销售主管审批','2012-07-08 15:34:57','2012-07-08 15:35:45',48578,'通过',1,50009),(50012,'task',1,50005,'task','orderProcess.114','教务部处理','2012-07-08 15:35:45','2012-07-08 15:36:15',30222,'分配任务',1,50011),(50014,'task',1,50005,'task','orderProcess.114','待班主任确认','2012-07-08 15:36:15','2012-07-08 15:36:39',24108,'确认',1,50013),(50016,'task',1,50005,'task','orderProcess.114','班主任处理中','2012-07-08 15:36:39','2012-07-08 15:37:12',33401,'待审批',1,50015),(50018,'task',1,50005,'task','orderProcess.114','教务部审批','2012-07-08 15:37:12','2012-07-08 15:37:48',36373,'通过',1,50017),(50020,'task',0,50005,'task','orderProcess.114','授课中','2012-07-08 15:37:48',NULL,0,NULL,1,50019),(60002,'task',1,20001,'task','orderProcess.110','教务部处理','2012-07-08 23:38:01','2012-07-09 00:30:33',3152192,'分配任务',1,60001),(60004,'task',1,20001,'task','orderProcess.110','待班主任确认','2012-07-09 00:30:33','2012-07-09 20:46:24',72951122,'确认',1,60003),(70002,'task',1,20001,'task','orderProcess.110','班主任处理中','2012-07-09 20:46:24','2012-07-09 20:46:50',26049,'待审批',1,70001),(70004,'task',1,20001,'task','orderProcess.110','教务部审批','2012-07-09 20:46:50','2012-07-09 20:47:10',20179,'通过',1,70003),(70006,'task',0,20001,'task','orderProcess.110','授课中','2012-07-09 20:47:10',NULL,0,NULL,1,70005),(100008,'task',0,100005,'task','orderProcess.119','签约','2012-07-09 23:04:33',NULL,0,NULL,1,100007),(110004,'task',0,110001,'task','orderProcess.120','签约','2012-07-09 23:06:37',NULL,0,NULL,1,110003),(120004,'task',1,120001,'task','orderProcess.121','签约','2012-07-09 23:10:26','2012-07-09 23:10:30',4722,'待审批',1,120003),(120006,'task',0,120001,'task','orderProcess.121','销售主管审批','2012-07-09 23:10:30',NULL,0,NULL,1,120005),(130004,'task',1,130001,'task','orderProcess.1','签约','2012-07-10 20:07:20','2012-07-10 20:07:21',1330,'待审批',1,130003),(130006,'task',1,130001,'task','orderProcess.1','销售主管审批','2012-07-10 20:07:21','2012-07-10 20:07:59',38504,'通过',1,130005),(130008,'task',0,130001,'task','orderProcess.1','教务部处理','2012-07-10 20:07:59',NULL,0,NULL,1,130007),(140004,'task',1,140001,'task','orderProcess.2','签约','2012-07-10 20:10:27','2012-07-10 20:10:27',883,'待审批',1,140003),(140006,'task',1,140001,'task','orderProcess.2','销售主管审批','2012-07-10 20:10:27','2012-07-10 20:14:35',248878,'通过',1,140005),(140008,'task',1,140001,'task','orderProcess.2','教务部处理','2012-07-10 20:14:35','2012-07-10 20:15:09',34080,'分配任务',1,140007),(140010,'task',1,140001,'task','orderProcess.2','待班主任确认','2012-07-10 20:15:09','2012-07-10 20:15:38',29594,'确认',1,140009),(140012,'task',0,140001,'task','orderProcess.2','班主任处理中','2012-07-10 20:15:38',NULL,0,NULL,1,140011),(150004,'task',0,150001,'task','orderProcess.3','签约','2012-07-10 21:07:29',NULL,0,NULL,1,150003),(150008,'task',0,150005,'task','orderProcess.4','签约','2012-07-10 21:10:45',NULL,0,NULL,1,150007),(160008,'task',1,160005,'task','orderProcess.6','签约','2012-07-10 21:12:53','2012-07-10 21:13:11',18180,'待审批',1,160007),(160010,'task',0,160005,'task','orderProcess.6','销售主管审批','2012-07-10 21:13:11',NULL,0,NULL,1,160009),(170004,'task',1,170001,'task','orderProcess.7','签约','2012-07-10 21:22:20','2012-07-10 21:22:22',2220,'待审批',1,170003),(170006,'task',0,170001,'task','orderProcess.7','销售主管审批','2012-07-10 21:22:22',NULL,0,NULL,1,170005),(170010,'task',0,170007,'task','orderProcess.8','签约','2012-07-10 21:24:15',NULL,0,NULL,1,170009),(180008,'task',1,180005,'task','orderProcess.10','签约','2012-07-10 21:29:59','2012-07-10 21:30:00',1768,'待审批',1,180007),(180010,'task',0,180005,'task','orderProcess.10','销售主管审批','2012-07-10 21:30:00',NULL,0,NULL,1,180009),(190008,'task',1,190005,'task','orderProcess.12','签约','2012-07-10 21:37:30','2012-07-10 21:37:31',1511,'待审批',1,190007),(190010,'task',1,190005,'task','orderProcess.12','销售主管审批','2012-07-10 21:37:31','2012-07-10 21:43:28',357199,'通过',1,190009),(200002,'task',1,190005,'task','orderProcess.12','教务部处理','2012-07-10 21:43:30','2012-07-10 22:06:07',1357565,'分配任务',1,200001),(200004,'task',1,190005,'task','orderProcess.12','待班主任确认','2012-07-10 22:06:07','2012-07-10 22:09:14',187069,'确认',1,200003),(200006,'task',0,190005,'task','orderProcess.12','班主任处理中','2012-07-10 22:09:14',NULL,0,NULL,1,200005),(210004,'task',1,210001,'task','orderProcess.13','签约','2012-07-10 22:13:11','2012-07-10 22:13:12',1262,'待审批',1,210003),(210006,'task',1,210001,'task','orderProcess.13','销售主管审批','2012-07-10 22:13:12','2012-07-10 22:13:36',24367,'通过',1,210005),(210008,'task',1,210001,'task','orderProcess.13','教务部处理','2012-07-10 22:13:36','2012-07-10 22:14:06',30845,'分配任务',1,210007),(210010,'task',1,210001,'task','orderProcess.13','待班主任确认','2012-07-10 22:14:06','2012-07-10 22:14:26',20352,'确认',1,210009),(210012,'task',1,210001,'task','orderProcess.13','班主任处理中','2012-07-10 22:14:26','2012-07-10 22:15:21',55236,'待审批',1,210011),(210014,'task',0,210001,'task','orderProcess.13','教务部审批','2012-07-10 22:15:21',NULL,0,NULL,1,210013),(230008,'task',1,230005,'task','orderProcess.16','签约','2012-07-10 22:28:49','2012-07-10 22:28:50',1878,'待审批',1,230007),(230010,'task',1,230005,'task','orderProcess.16','销售主管审批','2012-07-10 22:28:50','2012-07-10 22:29:53',63457,'通过',1,230009),(230012,'task',1,230005,'task','orderProcess.16','教务部处理','2012-07-10 22:29:53','2012-07-10 22:30:39',46133,'分配任务',1,230011),(230014,'task',1,230005,'task','orderProcess.16','待班主任确认','2012-07-10 22:30:39','2012-07-10 22:31:06',27886,'确认',1,230013),(230016,'task',1,230005,'task','orderProcess.16','班主任处理中','2012-07-10 22:31:06','2012-07-10 22:31:51',45679,'待审批',1,230015),(230018,'task',1,230005,'task','orderProcess.16','教务部审批','2012-07-10 22:31:51','2012-07-10 22:32:12',21379,'通过',1,230017),(230020,'task',0,230005,'task','orderProcess.16','授课中','2012-07-10 22:32:12',NULL,0,NULL,1,230019),(240004,'task',1,240001,'task','orderProcess.17','签约','2012-07-11 22:35:01','2012-07-11 22:35:02',1325,'待审批',1,240003),(240006,'task',0,240001,'task','orderProcess.17','销售主管审批','2012-07-11 22:35:02',NULL,0,NULL,1,240005),(250004,'task',1,250001,'task','orderProcess.18','签约','2012-07-11 22:59:28','2012-07-11 22:59:29',1435,'待审批',1,250003),(250006,'task',1,250001,'task','orderProcess.18','销售主管审批','2012-07-11 22:59:29','2012-07-11 23:33:24',2035464,'通过',1,250005),(260002,'task',1,250001,'task','orderProcess.18','教务部处理','2012-07-11 23:33:25','2012-07-11 23:40:03',398528,'分配任务',1,260001),(270002,'task',1,250001,'task','orderProcess.18','待班主任确认','2012-07-11 23:40:04','2012-07-11 23:41:50',106237,'确认',1,270001),(270004,'task',1,250001,'task','orderProcess.18','班主任处理中','2012-07-11 23:41:50','2012-07-11 23:45:02',192958,'待审批',1,270003),(270006,'task',0,250001,'task','orderProcess.18','教务部审批','2012-07-11 23:45:02',NULL,0,NULL,1,270005),(280004,'task',1,280001,'task','orderProcess.19','签约','2012-07-22 20:40:29','2012-07-22 20:40:29',788,'待审批',1,280003),(280006,'task',1,280001,'task','orderProcess.19','销售主管审批','2012-07-22 20:40:29','2012-07-22 20:43:51',202952,'通过',1,280005),(280008,'task',1,280001,'task','orderProcess.19','教务部处理','2012-07-22 20:43:51','2012-07-22 20:44:09',18829,'分配任务',1,280007),(280010,'task',1,280001,'task','orderProcess.19','待班主任确认','2012-07-22 20:44:09','2012-07-22 20:44:22',13755,'确认',1,280009),(280012,'task',1,280001,'task','orderProcess.19','班主任处理中','2012-07-22 20:44:22','2012-07-22 20:44:41',19596,'待审批',1,280011),(280014,'task',1,280001,'task','orderProcess.19','教务部审批','2012-07-22 20:44:41','2012-07-22 20:52:13',452677,'通过',1,280013),(300002,'task',0,280001,'task','orderProcess.19','授课中','2012-07-22 20:52:15',NULL,0,NULL,1,300001),(310004,'task',1,310001,'task','orderProcess.27','签约','2012-08-15 23:39:58','2012-08-15 23:39:59',1558,'待审批',1,310003),(310006,'task',0,310001,'task','orderProcess.27','销售主管审批','2012-08-15 23:39:59',NULL,0,NULL,1,310005),(320004,'task',1,320001,'task','orderProcess.28','签约','2012-08-15 23:55:08','2012-08-15 23:55:09',1285,'待审批',1,320003),(320006,'task',0,320001,'task','orderProcess.28','销售主管审批','2012-08-15 23:55:09',NULL,0,NULL,1,320005),(320010,'task',1,320007,'task','orderProcess.29','签约','2012-08-16 00:05:31','2012-08-16 00:05:31',964,'待审批',1,320009),(320012,'task',1,320007,'task','orderProcess.29','销售主管审批','2012-08-16 00:05:31','2012-08-16 00:09:58',267189,'通过',1,320011),(320014,'task',1,320007,'task','orderProcess.29','教务部处理','2012-08-16 00:09:58','2012-08-16 00:18:07',489163,'分配任务',1,320013),(320016,'task',1,320007,'task','orderProcess.29','待班主任确认','2012-08-16 00:18:07','2012-08-16 00:18:17',10162,'确认',1,320015),(320018,'task',1,320007,'task','orderProcess.29','班主任处理中','2012-08-16 00:18:17','2012-08-16 00:18:42',25249,'待审批',1,320017),(320020,'task',1,320007,'task','orderProcess.29','教务部审批','2012-08-16 00:18:42','2012-08-16 00:18:55',13642,'通过',1,320019),(320022,'task',0,320007,'task','orderProcess.29','授课中','2012-08-16 00:18:55',NULL,0,NULL,1,320021),(320026,'task',1,320023,'task','orderProcess.30','签约','2012-08-16 00:29:35','2012-08-16 00:29:35',679,'待审批',1,320025),(320028,'task',1,320023,'task','orderProcess.30','销售主管审批','2012-08-16 00:29:35','2012-08-16 00:29:56',21313,'通过',1,320027),(320030,'task',1,320023,'task','orderProcess.30','教务部处理','2012-08-16 00:29:56','2012-08-16 00:30:55',59949,'分配任务',1,320029),(320032,'task',0,320023,'task','orderProcess.30','待班主任确认','2012-08-16 00:30:55',NULL,0,NULL,1,320031),(330004,'task',1,330001,'task','orderProcess.31','签约','2012-08-16 20:07:46','2012-08-16 20:07:47',1062,'待审批',1,330003),(330006,'task',0,330001,'task','orderProcess.31','销售主管审批','2012-08-16 20:07:47',NULL,0,NULL,1,330005),(340004,'task',1,340001,'task','orderProcess.32','签约','2012-08-16 20:14:21','2012-08-16 20:14:21',943,'待审批',1,340003),(340006,'task',0,340001,'task','orderProcess.32','销售主管审批','2012-08-16 20:14:21',NULL,0,NULL,1,340005),(340010,'task',1,340007,'task','orderProcess.33','签约','2012-08-16 20:17:16','2012-08-16 20:17:17',1344,'待审批',1,340009),(340012,'task',0,340007,'task','orderProcess.33','销售主管审批','2012-08-16 20:17:17',NULL,0,NULL,1,340011),(350004,'task',1,350001,'task','orderProcess.34','签约','2012-08-16 20:21:38','2012-08-16 20:21:39',1283,'待审批',1,350003),(350006,'task',0,350001,'task','orderProcess.34','销售主管审批','2012-08-16 20:21:39',NULL,0,NULL,1,350005),(360004,'task',1,360001,'task','orderProcess.35','签约','2012-08-16 23:22:53','2012-08-16 23:22:54',1413,'待审批',1,360003),(360006,'task',0,360001,'task','orderProcess.35','销售主管审批','2012-08-16 23:22:54',NULL,0,NULL,1,360005),(370004,'task',1,370001,'task','orderProcess.36','签约','2012-08-17 00:44:47','2012-08-17 00:44:48',1145,'待审批',1,370003),(370006,'task',0,370001,'task','orderProcess.36','销售主管审批','2012-08-17 00:44:48',NULL,0,NULL,1,370005),(380004,'task',1,380001,'task','orderProcess.37','签约','2012-08-17 00:47:24','2012-08-17 00:48:35',71220,'待审批',1,380003),(380006,'task',0,380001,'task','orderProcess.37','销售主管审批','2012-08-17 00:48:35',NULL,0,NULL,1,380005),(390004,'task',1,390001,'task','orderProcess.38','签约','2012-08-17 00:57:00','2012-08-17 00:57:20',20660,'待审批',1,390003),(390006,'task',0,390001,'task','orderProcess.38','销售主管审批','2012-08-17 00:57:20',NULL,0,NULL,1,390005),(400004,'task',1,400001,'task','orderProcess.39','签约','2012-08-17 01:08:54','2012-08-17 01:08:55',1485,'待审批',1,400003),(400006,'task',1,400001,'task','orderProcess.39','销售主管审批','2012-08-17 01:08:55','2012-08-17 01:10:36',101897,'通过',1,400005),(400008,'task',0,400001,'task','orderProcess.39','教务部处理','2012-08-17 01:10:36',NULL,0,NULL,1,400007),(410004,'task',1,410001,'task','orderProcess.40','签约','2012-08-17 23:00:08','2012-08-17 23:00:08',748,'待审批',1,410003),(410006,'task',1,410001,'task','orderProcess.40','销售主管审批','2012-08-17 23:00:08','2012-08-17 23:07:05',417372,'通过',1,410005),(410008,'task',1,410001,'task','orderProcess.40','教务部处理','2012-08-17 23:07:05','2012-08-17 23:25:51',1126408,'分配任务',1,410007),(420002,'task',0,410001,'task','orderProcess.40','待班主任确认','2012-08-17 23:25:51',NULL,0,NULL,1,420001),(430004,'task',1,430001,'task','orderProcess.41','签约','2012-08-17 23:29:34','2012-08-17 23:29:53',19060,'待审批',1,430003),(430006,'task',1,430001,'task','orderProcess.41','销售主管审批','2012-08-17 23:29:53','2012-08-17 23:31:07',74834,'通过',1,430005),(430008,'task',1,430001,'task','orderProcess.41','教务部处理','2012-08-17 23:31:07','2012-08-17 23:31:47',40825,'分配任务',1,430007),(430010,'task',0,430001,'task','orderProcess.41','待班主任确认','2012-08-17 23:31:47',NULL,0,NULL,1,430009),(440004,'task',1,440001,'task','orderProcess.42','签约','2012-08-18 00:49:12','2012-08-18 00:49:13',1447,'待审批',1,440003),(440006,'task',1,440001,'task','orderProcess.42','销售主管审批','2012-08-18 00:49:13','2012-08-18 00:52:54',221571,'不通过',1,440005),(440008,'task',0,440001,'task','orderProcess.42','签约','2012-08-18 00:52:54',NULL,0,NULL,1,440007),(470004,'task',1,470001,'task','orderProcess.45','签约','2012-08-18 01:02:39','2012-08-18 01:02:39',883,'待审批',1,470003),(470006,'task',1,470001,'task','orderProcess.45','销售主管审批','2012-08-18 01:02:39','2012-08-18 01:03:27',48632,'不通过',1,470005),(470008,'task',0,470001,'task','orderProcess.45','签约','2012-08-18 01:03:27',NULL,0,NULL,1,470007),(480004,'task',1,480001,'task','orderProcess.46','签约','2012-08-18 01:10:33','2012-08-18 01:10:33',651,'待审批',1,480003),(480006,'task',1,480001,'task','orderProcess.46','销售主管审批','2012-08-18 01:10:33','2012-08-18 01:11:33',60725,'不通过',1,480005),(480008,'task',0,480001,'task','orderProcess.46','签约','2012-08-18 01:11:33',NULL,0,NULL,1,480007),(490004,'task',1,490001,'task','orderProcess.47','签约','2012-08-18 01:15:10','2012-08-18 01:15:10',935,'待审批',1,490003),(490006,'task',1,490001,'task','orderProcess.47','销售主管审批','2012-08-18 01:15:10','2012-08-18 01:16:24',74562,'不通过',1,490005),(490008,'task',0,490001,'task','orderProcess.47','签约','2012-08-18 01:16:24',NULL,0,NULL,1,490007),(490012,'task',1,490009,'task','orderProcess.48','签约','2012-08-18 01:18:35','2012-08-18 01:18:35',541,'待审批',1,490011),(490014,'task',1,490009,'task','orderProcess.48','销售主管审批','2012-08-18 01:18:35','2012-08-18 01:19:14',39361,'不通过',1,490013),(490016,'task',0,490009,'task','orderProcess.48','签约','2012-08-18 01:19:14',NULL,0,NULL,1,490015),(490020,'task',1,490017,'task','orderProcess.49','签约','2012-08-18 01:20:19','2012-08-18 01:20:23',4094,'待审批',1,490019),(490022,'task',0,490017,'task','orderProcess.49','销售主管审批','2012-08-18 01:20:23',NULL,0,NULL,1,490021),(500004,'task',1,500001,'task','orderProcess.50','签约','2012-08-18 01:26:40','2012-08-18 01:26:43',3146,'待审批',1,500003),(500006,'task',1,500001,'task','orderProcess.50','销售主管审批','2012-08-18 01:26:43','2012-08-18 01:30:50',247499,'不通过',1,500005),(510004,'task',1,500001,'task','orderProcess.50','签约','2012-08-18 01:30:50','2012-08-18 01:32:25',95978,'待审批',1,510003),(510006,'task',0,500001,'task','orderProcess.50','销售主管审批','2012-08-18 01:32:25',NULL,0,NULL,1,510005),(520004,'task',0,520001,'task','orderProcess.51','签约','2012-08-18 18:20:22',NULL,0,NULL,1,520003),(530004,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:21:46','2012-08-18 18:21:47',1376,'待审批',1,530003),(530006,'task',1,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:21:47','2012-08-18 18:37:46',959820,'不通过',1,530005),(540002,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:37:47','2012-08-18 18:39:11',84496,'待审批',1,540001),(540004,'task',1,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:39:11','2012-08-18 18:40:44',93099,'不通过',1,540003),(540006,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:40:44','2012-08-18 18:41:38',54041,'待审批',1,540005),(540008,'task',1,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:41:38','2012-08-18 18:45:22',224472,'不通过',1,540007),(550002,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:45:23','2012-08-18 18:51:01',338117,'待审批',1,550001),(560002,'task',0,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:51:01',NULL,0,NULL,1,560001),(560006,'task',1,560003,'task','orderProcess.53','签约','2012-08-18 19:24:21','2012-08-18 19:24:22',1551,'待审批',1,560005),(560008,'task',1,560003,'task','orderProcess.53','销售主管审批','2012-08-18 19:24:22','2012-08-18 19:30:53',391699,'不通过',1,560007),(570002,'task',1,560003,'task','orderProcess.53','签约','2012-08-18 19:30:55','2012-08-18 19:32:12',77178,'待审批',1,570001),(570004,'task',0,560003,'task','orderProcess.53','销售主管审批','2012-08-18 19:32:12',NULL,0,NULL,1,570003),(570008,'task',1,570005,'task','orderProcess.54','签约','2012-08-18 19:33:38','2012-08-18 19:33:49',11353,'待审批',1,570007),(570010,'task',1,570005,'task','orderProcess.54','销售主管审批','2012-08-18 19:33:49','2012-08-18 19:34:30',41978,'不通过',1,570009),(570012,'task',1,570005,'task','orderProcess.54','签约','2012-08-18 19:34:30','2012-08-18 19:35:25',55239,'待审批',1,570011),(570014,'task',0,570005,'task','orderProcess.54','销售主管审批','2012-08-18 19:35:25',NULL,0,NULL,1,570013),(580004,'task',1,580001,'task','orderProcess.55','签约','2012-08-18 19:39:48','2012-08-18 19:39:57',9347,'待审批',1,580003),(580006,'task',1,580001,'task','orderProcess.55','销售主管审批','2012-08-18 19:39:57','2012-08-18 19:41:53',116009,'不通过',1,580005),(590002,'task',0,580001,'task','orderProcess.55','签约','2012-08-18 19:41:53',NULL,0,NULL,1,590001),(600004,'task',1,600001,'task','orderProcess.56','签约','2012-08-18 19:44:43','2012-08-18 19:44:44',1831,'待审批',1,600003),(600006,'task',0,600001,'task','orderProcess.56','销售主管审批','2012-08-18 19:44:44',NULL,0,NULL,1,600005),(600010,'task',1,600007,'task','orderProcess.57','签约','2012-08-18 19:45:31','2012-08-18 19:45:31',906,'待审批',1,600009),(600012,'task',1,600007,'task','orderProcess.57','销售主管审批','2012-08-18 19:45:31','2012-08-18 19:46:08',37653,'不通过',1,600011),(600014,'task',0,600007,'task','orderProcess.57','签约','2012-08-18 19:46:08',NULL,0,NULL,1,600013),(610004,'task',1,610001,'task','orderProcess.58','签约','2012-08-18 19:48:34','2012-08-18 19:48:34',825,'待审批',1,610003),(610006,'task',1,610001,'task','orderProcess.58','销售主管审批','2012-08-18 19:48:34','2012-08-18 19:49:01',27344,'不通过',1,610005),(610008,'task',1,610001,'task','orderProcess.58','签约','2012-08-18 19:49:01','2012-08-18 19:50:02',61056,'待审批',1,610007),(610010,'task',1,610001,'task','orderProcess.58','销售主管审批','2012-08-18 19:50:02','2012-08-18 19:51:59',117502,'通过',1,610009),(610012,'task',1,610001,'task','orderProcess.58','教务部处理','2012-08-18 19:51:59','2012-08-18 20:44:50',3171495,'分配任务',1,610011),(610014,'task',1,610001,'task','orderProcess.58','待班主任确认','2012-08-18 20:44:50','2012-08-18 20:46:09',79816,'确认',1,610013),(610016,'task',1,610001,'task','orderProcess.58','班主任处理中','2012-08-18 20:46:09','2012-08-18 20:49:05',176929,'待审批',1,610015),(610018,'task',1,610001,'task','orderProcess.58','教务部审批','2012-08-18 20:49:05','2012-08-18 20:50:30',85323,'不通过',1,610017),(610020,'task',1,610001,'task','orderProcess.58','班主任处理中','2012-08-18 20:50:30','2012-08-18 20:52:06',96436,'待审批',1,610019),(610022,'task',1,610001,'task','orderProcess.58','教务部审批','2012-08-18 20:52:06','2012-08-18 20:53:22',76123,'通过',1,610021),(610024,'task',1,610001,'task','orderProcess.58','授课中','2012-08-18 20:53:22','2012-08-18 22:13:18',4796213,'判断授课时间',1,610023),(620004,'task',1,620001,'task','orderProcess.59','签约','2012-08-18 22:41:04','2012-08-18 22:41:04',881,'待审批',1,620003),(620006,'task',1,620001,'task','orderProcess.59','销售主管审批','2012-08-18 22:41:04','2012-08-18 22:41:35',31005,'通过',1,620005),(620008,'task',1,620001,'task','orderProcess.59','教务部处理','2012-08-18 22:41:35','2012-08-18 22:42:17',42816,'分配任务',1,620007),(620010,'task',1,620001,'task','orderProcess.59','待班主任确认','2012-08-18 22:42:17','2012-08-18 22:43:14',57361,'确认',1,620009),(620012,'task',1,620001,'task','orderProcess.59','班主任处理中','2012-08-18 22:43:14','2012-08-18 22:44:26',72524,'待审批',1,620011),(620014,'task',1,620001,'task','orderProcess.59','教务部审批','2012-08-18 22:44:26','2012-08-18 22:45:20',54973,'通过',1,620013),(620016,'task',1,620001,'task','orderProcess.59','授课中','2012-08-18 22:45:20','2012-08-18 22:50:00',280089,'判断授课时间',1,620015),(630004,'task',1,630001,'task','orderProcess.60','签约','2012-08-19 08:17:33','2012-08-19 08:17:43',10591,'待审批',1,630003),(630006,'task',0,630001,'task','orderProcess.60','销售主管审批','2012-08-19 08:17:43',NULL,0,NULL,1,630005),(640004,'task',1,640001,'task','orderProcess.61','签约','2012-08-19 09:04:54','2012-08-19 09:04:55',1104,'待审批',1,640003),(640006,'task',0,640001,'task','orderProcess.61','销售主管审批','2012-08-19 09:04:55',NULL,0,NULL,1,640005),(640010,'task',1,640007,'task','orderProcess.62','签约','2012-08-19 11:02:03','2012-08-19 11:02:03',423,'待审批',1,640009),(640012,'task',1,640007,'task','orderProcess.62','销售主管审批','2012-08-19 11:02:03','2012-08-19 11:04:18',135225,'不通过',1,640011),(640014,'task',1,640007,'task','orderProcess.62','签约','2012-08-19 11:04:18','2012-08-19 11:05:40',82937,'待审批',1,640013),(640016,'task',1,640007,'task','orderProcess.62','销售主管审批','2012-08-19 11:05:40','2012-08-19 11:07:10',90982,'通过',1,640015),(640018,'task',1,640007,'task','orderProcess.62','教务部处理','2012-08-19 11:07:10','2012-08-19 11:21:40',870113,'分配任务',1,640017),(640020,'task',1,640007,'task','orderProcess.62','待班主任确认','2012-08-19 11:21:40','2012-08-19 11:23:38',118552,'确认',1,640019),(640022,'task',1,640007,'task','orderProcess.62','班主任处理中','2012-08-19 11:23:38','2012-08-19 11:27:27',229244,'待审批',1,640021),(640024,'task',1,640007,'task','orderProcess.62','教务部审批','2012-08-19 11:27:27','2012-08-19 11:28:24',57251,'通过',1,640023),(640026,'task',1,640007,'task','orderProcess.62','授课中','2012-08-19 11:28:24','2012-08-19 11:30:00',96122,'判断授课时间',1,640025),(650008,'task',1,650005,'task','orderProcess.64','签约','2012-08-26 16:59:34','2012-08-26 16:59:34',803,'待审批',1,650007),(650010,'task',1,650005,'task','orderProcess.64','销售主管审批','2012-08-26 16:59:34','2012-08-27 20:54:46',100512808,'通过',1,650009),(660004,'task',1,660001,'task','orderProcess.65','签约','2012-08-27 20:45:18','2012-08-27 20:45:18',724,'待审批',1,660003),(660006,'task',0,660001,'task','orderProcess.65','销售主管审批','2012-08-27 20:45:18',NULL,0,NULL,1,660005),(670002,'task',0,650005,'task','orderProcess.64','教务部处理','2012-08-27 20:54:47',NULL,0,NULL,1,670001),(680004,'task',1,680001,'task','orderProcess.66','签约','2012-09-11 22:36:55','2012-09-11 22:36:56',1066,'待审批',1,680003),(680006,'task',0,680001,'task','orderProcess.66','销售主管审批','2012-09-11 22:36:56',NULL,0,NULL,1,680005),(690004,'task',1,690001,'task','orderProcess.67','签约','2012-10-10 21:03:05','2012-10-10 21:03:06',1057,'待审批',1,690003),(690006,'task',0,690001,'task','orderProcess.67','销售主管审批','2012-10-10 21:03:06',NULL,0,NULL,1,690005),(690010,'task',1,690007,'task','orderProcess.68','签约','2012-10-10 21:12:36','2012-10-10 21:12:36',841,'待审批',1,690009),(690012,'task',0,690007,'task','orderProcess.68','销售主管审批','2012-10-10 21:12:36',NULL,0,NULL,1,690011),(700004,'task',1,700001,'task','orderProcess.69','签约','2012-10-10 21:19:29','2012-10-10 21:19:31',2423,'待审批',1,700003),(700006,'task',1,700001,'task','orderProcess.69','销售主管审批','2012-10-10 21:19:31','2012-10-10 21:25:37',366294,'通过',1,700005),(700008,'task',1,700001,'task','orderProcess.69','教务部处理','2012-10-10 21:25:37','2012-10-10 21:26:04',27487,'分配任务',1,700007),(700010,'task',1,700001,'task','orderProcess.69','待班主任确认','2012-10-10 21:26:04','2012-10-10 21:26:56',52422,'确认',1,700009),(700012,'task',1,700001,'task','orderProcess.69','班主任处理中','2012-10-10 21:26:56','2012-10-10 21:35:18',502000,'待审批',1,700011),(700014,'task',1,700001,'task','orderProcess.69','教务部审批','2012-10-10 21:35:18','2012-10-10 21:35:47',29473,'不通过',1,700013),(700016,'task',1,700001,'task','orderProcess.69','班主任处理中','2012-10-10 21:35:47','2012-10-10 21:37:09',82093,'待审批',1,700015),(700018,'task',1,700001,'task','orderProcess.69','教务部审批','2012-10-10 21:37:09','2012-10-10 21:37:28',19552,'通过',1,700017),(700020,'task',0,700001,'task','orderProcess.69','授课中','2012-10-10 21:37:28',NULL,0,NULL,1,700019),(700024,'task',1,700021,'task','orderProcess.70','签约','2012-10-10 21:49:43','2012-10-10 21:49:44',1845,'待审批',1,700023),(700026,'task',1,700021,'task','orderProcess.70','销售主管审批','2012-10-10 21:49:44','2012-10-10 21:50:51',67434,'通过',1,700025),(700028,'task',1,700021,'task','orderProcess.70','教务部处理','2012-10-10 21:50:51','2012-10-10 21:51:10',19936,'分配任务',1,700027),(700030,'task',1,700021,'task','orderProcess.70','待班主任确认','2012-10-10 21:51:10','2012-10-10 21:54:49',219999,'确认',1,700029),(700032,'task',0,700021,'task','orderProcess.70','班主任处理中','2012-10-10 21:54:50',NULL,0,NULL,1,700031),(700036,'task',1,700033,'task','orderProcess.71','签约','2012-10-10 22:26:29','2012-10-10 22:26:30',1382,'待审批',1,700035),(700038,'task',0,700033,'task','orderProcess.71','销售主管审批','2012-10-10 22:26:30',NULL,0,NULL,1,700037),(710004,'task',1,710001,'task','orderProcess.72','签约','2012-10-16 22:59:05','2012-10-16 22:59:05',891,'待审批',1,710003),(710006,'task',0,710001,'task','orderProcess.72','销售主管审批','2012-10-16 22:59:05',NULL,0,NULL,1,710005),(720004,'task',1,720001,'task','orderProcess.73','签约','2012-10-18 22:00:50','2012-10-18 22:00:59',9177,'待审批',1,720003),(720006,'task',1,720001,'task','orderProcess.73','销售主管审批','2012-10-18 22:00:59','2012-10-18 22:01:40',41041,'通过',1,720005),(720008,'task',1,720001,'task','orderProcess.73','教务部处理','2012-10-18 22:01:40','2012-10-18 22:02:42',62981,'分配任务',1,720007),(720010,'task',1,720001,'task','orderProcess.73','待班主任确认','2012-10-18 22:02:43','2012-10-18 22:03:31',48150,'确认',1,720009),(720012,'task',1,720001,'task','orderProcess.73','班主任处理中','2012-10-18 22:03:31','2012-10-18 22:04:13',42149,'待审批',1,720011),(720014,'task',1,720001,'task','orderProcess.73','教务部审批','2012-10-18 22:04:13','2012-10-18 22:04:37',24000,'通过',1,720013),(720016,'task',0,720001,'task','orderProcess.73','授课中','2012-10-18 22:04:37',NULL,0,NULL,1,720015),(720020,'task',1,720017,'task','orderProcess.74','签约','2012-10-18 22:08:35','2012-10-18 22:08:36',1533,'待审批',1,720019),(720022,'task',1,720017,'task','orderProcess.74','销售主管审批','2012-10-18 22:08:36','2012-10-18 22:09:30',54543,'通过',1,720021),(720024,'task',0,720017,'task','orderProcess.74','教务部处理','2012-10-18 22:09:30',NULL,0,NULL,1,720023);
/*!40000 ALTER TABLE `jbpm4_hist_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_hist_detail`
--

DROP TABLE IF EXISTS `jbpm4_hist_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_hist_detail` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USERID_` varchar(255) DEFAULT NULL,
  `TIME_` datetime DEFAULT NULL,
  `HPROCI_` bigint(20) DEFAULT NULL,
  `HPROCIIDX_` int(11) DEFAULT NULL,
  `HACTI_` bigint(20) DEFAULT NULL,
  `HACTIIDX_` int(11) DEFAULT NULL,
  `HTASK_` bigint(20) DEFAULT NULL,
  `HTASKIDX_` int(11) DEFAULT NULL,
  `HVAR_` bigint(20) DEFAULT NULL,
  `HVARIDX_` int(11) DEFAULT NULL,
  `MESSAGE_` longtext,
  `OLD_STR_` varchar(255) DEFAULT NULL,
  `NEW_STR_` varchar(255) DEFAULT NULL,
  `OLD_INT_` int(11) DEFAULT NULL,
  `NEW_INT_` int(11) DEFAULT NULL,
  `OLD_TIME_` datetime DEFAULT NULL,
  `NEW_TIME_` datetime DEFAULT NULL,
  `PARENT_` bigint(20) DEFAULT NULL,
  `PARENT_IDX_` int(11) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HDETAIL_HVAR` (`HVAR_`),
  KEY `FK_HDETAIL_HPROCI` (`HPROCI_`),
  KEY `FK_HDETAIL_HTASK` (`HTASK_`),
  KEY `FK_HDETAIL_HACTI` (`HACTI_`),
  CONSTRAINT `FK_HDETAIL_HACTI` FOREIGN KEY (`HACTI_`) REFERENCES `jbpm4_hist_actinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`),
  CONSTRAINT `FK_HDETAIL_HVAR` FOREIGN KEY (`HVAR_`) REFERENCES `jbpm4_hist_var` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_hist_detail`
--

LOCK TABLES `jbpm4_hist_detail` WRITE;
/*!40000 ALTER TABLE `jbpm4_hist_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_hist_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_hist_procinst`
--

DROP TABLE IF EXISTS `jbpm4_hist_procinst`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_hist_procinst` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `PROCDEFID_` varchar(255) DEFAULT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `START_` datetime DEFAULT NULL,
  `END_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `ENDACTIVITY_` varchar(255) DEFAULT NULL,
  `NEXTIDX_` int(11) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_hist_procinst`
--

LOCK TABLES `jbpm4_hist_procinst` WRITE;
/*!40000 ALTER TABLE `jbpm4_hist_procinst` DISABLE KEYS */;
INSERT INTO `jbpm4_hist_procinst` VALUES (10001,0,'orderProcess.109','orderProcess-1','109','2012-07-08 09:39:20',NULL,NULL,'active',NULL,1),(20001,0,'orderProcess.110','orderProcess-1','110','2012-07-08 14:54:32',NULL,NULL,'active',NULL,1),(50005,0,'orderProcess.114','orderProcess-1','114','2012-07-08 15:33:35',NULL,NULL,'active',NULL,1),(100005,0,'orderProcess.119','orderProcess-1','119','2012-07-09 23:04:33',NULL,NULL,'active',NULL,1),(110001,0,'orderProcess.120','orderProcess-1','120','2012-07-09 23:06:37',NULL,NULL,'active',NULL,1),(120001,0,'orderProcess.121','orderProcess-1','121','2012-07-09 23:10:26',NULL,NULL,'active',NULL,1),(130001,0,'orderProcess.1','orderProcess-1','1','2012-07-10 20:07:20',NULL,NULL,'active',NULL,1),(140001,0,'orderProcess.2','orderProcess-1','2','2012-07-10 20:10:27',NULL,NULL,'active',NULL,1),(150001,0,'orderProcess.3','orderProcess-1','3','2012-07-10 21:07:29',NULL,NULL,'active',NULL,1),(150005,0,'orderProcess.4','orderProcess-1','4','2012-07-10 21:10:45',NULL,NULL,'active',NULL,1),(160005,0,'orderProcess.6','orderProcess-1','6','2012-07-10 21:12:53',NULL,NULL,'active',NULL,1),(170001,0,'orderProcess.7','orderProcess-1','7','2012-07-10 21:22:20',NULL,NULL,'active',NULL,1),(170007,0,'orderProcess.8','orderProcess-1','8','2012-07-10 21:24:15',NULL,NULL,'active',NULL,1),(180005,0,'orderProcess.10','orderProcess-1','10','2012-07-10 21:29:59',NULL,NULL,'active',NULL,1),(190005,0,'orderProcess.12','orderProcess-1','12','2012-07-10 21:37:30',NULL,NULL,'active',NULL,1),(210001,0,'orderProcess.13','orderProcess-1','13','2012-07-10 22:13:11',NULL,NULL,'active',NULL,1),(230005,0,'orderProcess.16','orderProcess-1','16','2012-07-10 22:28:49',NULL,NULL,'active',NULL,1),(240001,0,'orderProcess.17','orderProcess-1','17','2012-07-11 22:35:01',NULL,NULL,'active',NULL,1),(250001,0,'orderProcess.18','orderProcess-1','18','2012-07-11 22:59:28',NULL,NULL,'active',NULL,1),(280001,0,'orderProcess.19','orderProcess-1','19','2012-07-22 20:40:29',NULL,NULL,'active',NULL,1),(310001,0,'orderProcess.27','orderProcess-1','27','2012-08-15 23:39:58',NULL,NULL,'active',NULL,1),(320001,0,'orderProcess.28','orderProcess-1','28','2012-08-15 23:55:08',NULL,NULL,'active',NULL,1),(320007,0,'orderProcess.29','orderProcess-1','29','2012-08-16 00:05:31',NULL,NULL,'active',NULL,1),(320023,0,'orderProcess.30','orderProcess-1','30','2012-08-16 00:29:35',NULL,NULL,'active',NULL,1),(330001,0,'orderProcess.31','orderProcess-1','31','2012-08-16 20:07:46',NULL,NULL,'active',NULL,1),(340001,0,'orderProcess.32','orderProcess-1','32','2012-08-16 20:14:21',NULL,NULL,'active',NULL,1),(340007,0,'orderProcess.33','orderProcess-1','33','2012-08-16 20:17:16',NULL,NULL,'active',NULL,1),(350001,0,'orderProcess.34','orderProcess-1','34','2012-08-16 20:21:38',NULL,NULL,'active',NULL,1),(360001,0,'orderProcess.35','orderProcess-1','35','2012-08-16 23:22:53',NULL,NULL,'active',NULL,1),(370001,0,'orderProcess.36','orderProcess-1','36','2012-08-17 00:44:47',NULL,NULL,'active',NULL,1),(380001,0,'orderProcess.37','orderProcess-1','37','2012-08-17 00:47:24',NULL,NULL,'active',NULL,1),(390001,0,'orderProcess.38','orderProcess-1','38','2012-08-17 00:57:00',NULL,NULL,'active',NULL,1),(400001,0,'orderProcess.39','orderProcess-1','39','2012-08-17 01:08:54',NULL,NULL,'active',NULL,1),(410001,0,'orderProcess.40','orderProcess-1','40','2012-08-17 23:00:08',NULL,NULL,'active',NULL,1),(430001,0,'orderProcess.41','orderProcess-1','41','2012-08-17 23:29:34',NULL,NULL,'active',NULL,1),(440001,0,'orderProcess.42','orderProcess-1','42','2012-08-18 00:49:12',NULL,NULL,'active',NULL,1),(470001,0,'orderProcess.45','orderProcess-1','45','2012-08-18 01:02:39',NULL,NULL,'active',NULL,1),(480001,0,'orderProcess.46','orderProcess-1','46','2012-08-18 01:10:33',NULL,NULL,'active',NULL,1),(490001,0,'orderProcess.47','orderProcess-1','47','2012-08-18 01:15:10',NULL,NULL,'active',NULL,1),(490009,0,'orderProcess.48','orderProcess-1','48','2012-08-18 01:18:35',NULL,NULL,'active',NULL,1),(490017,0,'orderProcess.49','orderProcess-1','49','2012-08-18 01:20:19',NULL,NULL,'active',NULL,1),(500001,0,'orderProcess.50','orderProcess-1','50','2012-08-18 01:26:40',NULL,NULL,'active',NULL,1),(520001,0,'orderProcess.51','orderProcess-1','51','2012-08-18 18:20:22',NULL,NULL,'active',NULL,1),(530001,0,'orderProcess.52','orderProcess-1','52','2012-08-18 18:21:46',NULL,NULL,'active',NULL,1),(560003,0,'orderProcess.53','orderProcess-1','53','2012-08-18 19:24:21',NULL,NULL,'active',NULL,1),(570005,0,'orderProcess.54','orderProcess-1','54','2012-08-18 19:33:38',NULL,NULL,'active',NULL,1),(580001,0,'orderProcess.55','orderProcess-1','55','2012-08-18 19:39:48',NULL,NULL,'active',NULL,1),(600001,0,'orderProcess.56','orderProcess-1','56','2012-08-18 19:44:43',NULL,NULL,'active',NULL,1),(600007,0,'orderProcess.57','orderProcess-1','57','2012-08-18 19:45:31',NULL,NULL,'active',NULL,1),(610001,1,'orderProcess.58','orderProcess-1','58','2012-08-18 19:48:34','2012-08-18 22:13:20',8686439,'ended','结束',1),(620001,1,'orderProcess.59','orderProcess-1','59','2012-08-18 22:41:04','2012-08-18 22:50:00',536157,'ended','结束',1),(630001,0,'orderProcess.60','orderProcess-1','60','2012-08-19 08:17:33',NULL,NULL,'active',NULL,1),(640001,0,'orderProcess.61','orderProcess-1','61','2012-08-19 09:04:54',NULL,NULL,'active',NULL,1),(640007,1,'orderProcess.62','orderProcess-1','62','2012-08-19 11:02:03','2012-08-19 11:30:00',1677136,'ended','结束',1),(650005,0,'orderProcess.64','orderProcess-1','64','2012-08-26 16:59:34',NULL,NULL,'active',NULL,1),(660001,0,'orderProcess.65','orderProcess-1','65','2012-08-27 20:45:18',NULL,NULL,'active',NULL,1),(680001,0,'orderProcess.66','orderProcess-1','66','2012-09-11 22:36:55',NULL,NULL,'active',NULL,1),(690001,0,'orderProcess.67','orderProcess-1','67','2012-10-10 21:03:05',NULL,NULL,'active',NULL,1),(690007,0,'orderProcess.68','orderProcess-1','68','2012-10-10 21:12:36',NULL,NULL,'active',NULL,1),(700001,0,'orderProcess.69','orderProcess-1','69','2012-10-10 21:19:29',NULL,NULL,'active',NULL,1),(700021,0,'orderProcess.70','orderProcess-1','70','2012-10-10 21:49:43',NULL,NULL,'active',NULL,1),(700033,0,'orderProcess.71','orderProcess-1','71','2012-10-10 22:26:29',NULL,NULL,'active',NULL,1),(710001,0,'orderProcess.72','orderProcess-1','72','2012-10-16 22:59:05',NULL,NULL,'active',NULL,1),(720001,0,'orderProcess.73','orderProcess-1','73','2012-10-18 22:00:50',NULL,NULL,'active',NULL,1),(720017,0,'orderProcess.74','orderProcess-1','74','2012-10-18 22:08:35',NULL,NULL,'active',NULL,1);
/*!40000 ALTER TABLE `jbpm4_hist_procinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_hist_task`
--

DROP TABLE IF EXISTS `jbpm4_hist_task`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_hist_task` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `EXECUTION_` varchar(255) DEFAULT NULL,
  `OUTCOME_` varchar(255) DEFAULT NULL,
  `ASSIGNEE_` varchar(255) DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `CREATE_` datetime DEFAULT NULL,
  `END_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `NEXTIDX_` int(11) DEFAULT NULL,
  `SUPERTASK_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HSUPERT_SUB` (`SUPERTASK_`),
  CONSTRAINT `FK_HSUPERT_SUB` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_hist_task`
--

LOCK TABLES `jbpm4_hist_task` WRITE;
/*!40000 ALTER TABLE `jbpm4_hist_task` DISABLE KEYS */;
INSERT INTO `jbpm4_hist_task` VALUES (10003,1,'orderProcess.109','待审批','17',0,'completed','2012-07-08 09:39:20','2012-07-08 09:39:21',1286,1,NULL),(10005,1,'orderProcess.109','通过','2',0,'completed','2012-07-08 09:39:21','2012-07-08 09:40:14',53264,1,NULL),(10007,1,'orderProcess.109','分配任务','3',0,'completed','2012-07-08 09:40:14','2012-07-08 09:44:32',258279,1,NULL),(10009,1,'orderProcess.109','确认','11',0,'completed','2012-07-08 09:44:32','2012-07-08 09:49:32',300113,1,NULL),(10011,1,'orderProcess.109','待审批','5',0,'completed','2012-07-08 09:49:32','2012-07-08 09:58:16',524422,1,NULL),(10013,1,'orderProcess.109','不通过','5',0,'completed','2012-07-08 09:58:16','2012-07-08 10:30:30',1934432,1,NULL),(10015,1,'orderProcess.109','待审批','4',0,'completed','2012-07-08 10:30:30','2012-07-08 13:30:04',10774441,1,NULL),(10017,1,'orderProcess.109','通过','5',0,'completed','2012-07-08 13:30:04','2012-07-08 13:58:52',1728736,1,NULL),(10019,0,'orderProcess.109',NULL,'4',0,NULL,'2012-07-08 13:58:52',NULL,0,1,NULL),(20003,1,'orderProcess.110','待审批','17',0,'completed','2012-07-08 14:54:32','2012-07-08 14:54:33',1579,1,NULL),(20005,1,'orderProcess.110','不通过','2',0,'completed','2012-07-08 14:54:33','2012-07-08 14:58:52',259442,1,NULL),(20007,1,'orderProcess.110','待审批','3',0,'completed','2012-07-08 14:58:52','2012-07-08 14:59:32',40538,1,NULL),(20009,1,'orderProcess.110','通过','2',0,'completed','2012-07-08 14:59:32','2012-07-08 23:38:01',31109101,1,NULL),(50007,1,'orderProcess.114','待审批','17',0,'completed','2012-07-08 15:33:35','2012-07-08 15:34:57',82165,1,NULL),(50009,1,'orderProcess.114','通过','2',0,'completed','2012-07-08 15:34:57','2012-07-08 15:35:45',48591,1,NULL),(50011,1,'orderProcess.114','分配任务','3',0,'completed','2012-07-08 15:35:45','2012-07-08 15:36:15',30232,1,NULL),(50013,1,'orderProcess.114','确认','11',0,'completed','2012-07-08 15:36:15','2012-07-08 15:36:39',24119,1,NULL),(50015,1,'orderProcess.114','待审批','5',0,'completed','2012-07-08 15:36:39','2012-07-08 15:37:12',33410,1,NULL),(50017,1,'orderProcess.114','通过','5',0,'completed','2012-07-08 15:37:12','2012-07-08 15:37:48',36381,1,NULL),(50019,0,'orderProcess.114',NULL,'4',0,NULL,'2012-07-08 15:37:48',NULL,0,1,NULL),(60001,1,'orderProcess.110','分配任务','3',0,'completed','2012-07-08 23:38:01','2012-07-09 00:30:33',3152198,1,NULL),(60003,1,'orderProcess.110','确认','11',0,'completed','2012-07-09 00:30:33','2012-07-09 20:46:24',72951184,1,NULL),(70001,1,'orderProcess.110','待审批','5',0,'completed','2012-07-09 20:46:24','2012-07-09 20:46:50',26049,1,NULL),(70003,1,'orderProcess.110','通过','5',0,'completed','2012-07-09 20:46:50','2012-07-09 20:47:10',20179,1,NULL),(70005,0,'orderProcess.110',NULL,'4',0,NULL,'2012-07-09 20:47:10',NULL,0,1,NULL),(100007,0,'orderProcess.119',NULL,'17',0,NULL,'2012-07-09 23:04:33',NULL,0,1,NULL),(110003,0,'orderProcess.120',NULL,'17',0,NULL,'2012-07-09 23:06:37',NULL,0,1,NULL),(120003,1,'orderProcess.121','待审批','17',0,'completed','2012-07-09 23:10:26','2012-07-09 23:10:30',4732,1,NULL),(120005,0,'orderProcess.121',NULL,'1',0,NULL,'2012-07-09 23:10:30',NULL,0,1,NULL),(130003,1,'orderProcess.1','待审批','17',0,'completed','2012-07-10 20:07:20','2012-07-10 20:07:21',1342,1,NULL),(130005,1,'orderProcess.1','通过','1',0,'completed','2012-07-10 20:07:21','2012-07-10 20:07:59',38512,1,NULL),(130007,0,'orderProcess.1',NULL,'2',0,NULL,'2012-07-10 20:07:59',NULL,0,1,NULL),(140003,1,'orderProcess.2','待审批','17',0,'completed','2012-07-10 20:10:27','2012-07-10 20:10:27',896,1,NULL),(140005,1,'orderProcess.2','通过','1',0,'completed','2012-07-10 20:10:27','2012-07-10 20:14:35',248884,1,NULL),(140007,1,'orderProcess.2','分配任务','2',0,'completed','2012-07-10 20:14:35','2012-07-10 20:15:09',34085,1,NULL),(140009,1,'orderProcess.2','确认','10',0,'completed','2012-07-10 20:15:09','2012-07-10 20:15:38',29600,1,NULL),(140011,0,'orderProcess.2',NULL,'4',0,NULL,'2012-07-10 20:15:38',NULL,0,1,NULL),(150003,0,'orderProcess.3',NULL,'17',0,NULL,'2012-07-10 21:07:29',NULL,0,1,NULL),(150007,0,'orderProcess.4',NULL,'17',0,NULL,'2012-07-10 21:10:45',NULL,0,1,NULL),(160007,1,'orderProcess.6','待审批','17',0,'completed','2012-07-10 21:12:53','2012-07-10 21:13:11',18212,1,NULL),(160009,0,'orderProcess.6',NULL,'0',0,NULL,'2012-07-10 21:13:11',NULL,0,1,NULL),(170003,1,'orderProcess.7','待审批','17',0,'completed','2012-07-10 21:22:20','2012-07-10 21:22:22',2231,1,NULL),(170005,0,'orderProcess.7',NULL,'0',0,NULL,'2012-07-10 21:22:22',NULL,0,1,NULL),(170009,0,'orderProcess.8',NULL,'17',0,NULL,'2012-07-10 21:24:15',NULL,0,1,NULL),(180007,1,'orderProcess.10','待审批','17',0,'completed','2012-07-10 21:29:59','2012-07-10 21:30:00',1779,1,NULL),(180009,0,'orderProcess.10',NULL,'0',0,NULL,'2012-07-10 21:30:00',NULL,0,1,NULL),(190007,1,'orderProcess.12','待审批','17',0,'completed','2012-07-10 21:37:30','2012-07-10 21:37:31',1523,1,NULL),(190009,1,'orderProcess.12','通过','0',0,'completed','2012-07-10 21:37:31','2012-07-10 21:43:28',357213,1,NULL),(200001,1,'orderProcess.12','分配任务','0',0,'completed','2012-07-10 21:43:30','2012-07-10 22:06:07',1357587,1,NULL),(200003,1,'orderProcess.12','确认','10',0,'completed','2012-07-10 22:06:07','2012-07-10 22:09:14',187075,1,NULL),(200005,0,'orderProcess.12',NULL,'0',0,NULL,'2012-07-10 22:09:14',NULL,0,1,NULL),(210003,1,'orderProcess.13','待审批','17',0,'completed','2012-07-10 22:13:11','2012-07-10 22:13:12',1276,1,NULL),(210005,1,'orderProcess.13','通过','0',0,'completed','2012-07-10 22:13:12','2012-07-10 22:13:36',24376,1,NULL),(210007,1,'orderProcess.13','分配任务','0',0,'completed','2012-07-10 22:13:36','2012-07-10 22:14:06',30853,1,NULL),(210009,1,'orderProcess.13','确认','10',0,'completed','2012-07-10 22:14:06','2012-07-10 22:14:26',20361,1,NULL),(210011,1,'orderProcess.13','待审批','0',0,'completed','2012-07-10 22:14:26','2012-07-10 22:15:21',55243,1,NULL),(210013,0,'orderProcess.13',NULL,'0',0,NULL,'2012-07-10 22:15:21',NULL,0,1,NULL),(230007,1,'orderProcess.16','待审批','17',0,'completed','2012-07-10 22:28:49','2012-07-10 22:28:50',1891,1,NULL),(230009,1,'orderProcess.16','通过','0',0,'completed','2012-07-10 22:28:50','2012-07-10 22:29:53',63462,1,NULL),(230011,1,'orderProcess.16','分配任务','0',0,'completed','2012-07-10 22:29:53','2012-07-10 22:30:39',46142,1,NULL),(230013,1,'orderProcess.16','确认','10',0,'completed','2012-07-10 22:30:39','2012-07-10 22:31:06',27897,1,NULL),(230015,1,'orderProcess.16','待审批','0',0,'completed','2012-07-10 22:31:06','2012-07-10 22:31:51',45685,1,NULL),(230017,1,'orderProcess.16','通过','0',0,'completed','2012-07-10 22:31:51','2012-07-10 22:32:12',21384,1,NULL),(230019,0,'orderProcess.16',NULL,'0',0,NULL,'2012-07-10 22:32:12',NULL,0,1,NULL),(240003,1,'orderProcess.17','待审批','17',0,'completed','2012-07-11 22:35:01','2012-07-11 22:35:02',1336,1,NULL),(240005,0,'orderProcess.17',NULL,'0',0,NULL,'2012-07-11 22:35:02',NULL,0,1,NULL),(250003,1,'orderProcess.18','待审批','3',0,'completed','2012-07-11 22:59:28','2012-07-11 22:59:29',1448,1,NULL),(250005,1,'orderProcess.18','通过','0',0,'completed','2012-07-11 22:59:29','2012-07-11 23:33:24',2035475,1,NULL),(260001,1,'orderProcess.18','分配任务','0',0,'completed','2012-07-11 23:33:26','2012-07-11 23:40:03',397541,1,NULL),(270001,1,'orderProcess.18','确认','14',0,'completed','2012-07-11 23:40:04','2012-07-11 23:41:50',106245,1,NULL),(270003,1,'orderProcess.18','待审批','0',0,'completed','2012-07-11 23:41:50','2012-07-11 23:45:02',192965,1,NULL),(270005,0,'orderProcess.18',NULL,'0',0,NULL,'2012-07-11 23:45:03',NULL,0,1,NULL),(280003,1,'orderProcess.19','待审批','14',0,'completed','2012-07-22 20:40:29','2012-07-22 20:40:29',801,1,NULL),(280005,1,'orderProcess.19','通过','0',0,'completed','2012-07-22 20:40:29','2012-07-22 20:43:51',202956,1,NULL),(280007,1,'orderProcess.19','分配任务','0',0,'completed','2012-07-22 20:43:51','2012-07-22 20:44:09',18835,1,NULL),(280009,1,'orderProcess.19','确认','15',0,'completed','2012-07-22 20:44:09','2012-07-22 20:44:22',13762,1,NULL),(280011,1,'orderProcess.19','待审批','0',0,'completed','2012-07-22 20:44:22','2012-07-22 20:44:41',19603,1,NULL),(280013,1,'orderProcess.19','通过','0',0,'completed','2012-07-22 20:44:41','2012-07-22 20:52:13',452688,1,NULL),(300001,0,'orderProcess.19',NULL,'0',0,NULL,'2012-07-22 20:52:15',NULL,0,1,NULL),(310003,1,'orderProcess.27','待审批','14',0,'completed','2012-08-15 23:39:58','2012-08-15 23:39:59',1564,1,NULL),(310005,0,'orderProcess.27',NULL,'0',0,NULL,'2012-08-15 23:39:59',NULL,0,1,NULL),(320003,1,'orderProcess.28','待审批','14',0,'completed','2012-08-15 23:55:08','2012-08-15 23:55:09',1290,1,NULL),(320005,0,'orderProcess.28',NULL,'0',0,NULL,'2012-08-15 23:55:09',NULL,0,1,NULL),(320009,1,'orderProcess.29','待审批','14',0,'completed','2012-08-16 00:05:31','2012-08-16 00:05:31',966,1,NULL),(320011,1,'orderProcess.29','通过','0',0,'completed','2012-08-16 00:05:31','2012-08-16 00:09:58',267191,1,NULL),(320013,1,'orderProcess.29','分配任务','0',0,'completed','2012-08-16 00:09:58','2012-08-16 00:18:07',489165,1,NULL),(320015,1,'orderProcess.29','确认','14',0,'completed','2012-08-16 00:18:07','2012-08-16 00:18:17',10163,1,NULL),(320017,1,'orderProcess.29','待审批','0',0,'completed','2012-08-16 00:18:17','2012-08-16 00:18:42',25251,1,NULL),(320019,1,'orderProcess.29','通过','0',0,'completed','2012-08-16 00:18:42','2012-08-16 00:18:55',13644,1,NULL),(320021,0,'orderProcess.29',NULL,'0',0,NULL,'2012-08-16 00:18:55',NULL,0,1,NULL),(320025,1,'orderProcess.30','待审批','14',0,'completed','2012-08-16 00:29:35','2012-08-16 00:29:35',682,1,NULL),(320027,1,'orderProcess.30','通过','0',0,'completed','2012-08-16 00:29:35','2012-08-16 00:29:56',21315,1,NULL),(320029,1,'orderProcess.30','分配任务','0',0,'completed','2012-08-16 00:29:56','2012-08-16 00:30:55',59951,1,NULL),(320031,0,'orderProcess.30',NULL,'15',0,NULL,'2012-08-16 00:30:55',NULL,0,1,NULL),(330003,1,'orderProcess.31','待审批','14',0,'completed','2012-08-16 20:07:46','2012-08-16 20:07:47',1067,1,NULL),(330005,0,'orderProcess.31',NULL,'0',0,NULL,'2012-08-16 20:07:47',NULL,0,1,NULL),(340003,1,'orderProcess.32','待审批','14',0,'completed','2012-08-16 20:14:21','2012-08-16 20:14:21',949,1,NULL),(340005,0,'orderProcess.32',NULL,'0',0,NULL,'2012-08-16 20:14:21',NULL,0,1,NULL),(340009,1,'orderProcess.33','待审批','14',0,'completed','2012-08-16 20:17:16','2012-08-16 20:17:17',1347,1,NULL),(340011,0,'orderProcess.33',NULL,'0',0,NULL,'2012-08-16 20:17:17',NULL,0,1,NULL),(350003,1,'orderProcess.34','待审批','14',0,'completed','2012-08-16 20:21:38','2012-08-16 20:21:39',1288,1,NULL),(350005,0,'orderProcess.34',NULL,'0',0,NULL,'2012-08-16 20:21:39',NULL,0,1,NULL),(360003,1,'orderProcess.35','待审批','10',0,'completed','2012-08-16 23:22:53','2012-08-16 23:22:54',1417,1,NULL),(360005,0,'orderProcess.35',NULL,'0',0,NULL,'2012-08-16 23:22:54',NULL,0,1,NULL),(370003,1,'orderProcess.36','待审批','10',0,'completed','2012-08-17 00:44:47','2012-08-17 00:44:48',1149,1,NULL),(370005,0,'orderProcess.36',NULL,'0',0,NULL,'2012-08-17 00:44:48',NULL,0,1,NULL),(380003,1,'orderProcess.37','待审批','10',0,'completed','2012-08-17 00:47:24','2012-08-17 00:48:35',71225,1,NULL),(380005,0,'orderProcess.37',NULL,'0',0,NULL,'2012-08-17 00:48:35',NULL,0,1,NULL),(390003,1,'orderProcess.38','待审批','10',0,'completed','2012-08-17 00:57:00','2012-08-17 00:57:20',20667,1,NULL),(390005,0,'orderProcess.38',NULL,'0',0,NULL,'2012-08-17 00:57:20',NULL,0,1,NULL),(400003,1,'orderProcess.39','待审批','10',0,'completed','2012-08-17 01:08:54','2012-08-17 01:08:55',1490,1,NULL),(400005,1,'orderProcess.39','通过','0',0,'completed','2012-08-17 01:08:55','2012-08-17 01:10:36',101899,1,NULL),(400007,0,'orderProcess.39',NULL,'0',0,NULL,'2012-08-17 01:10:36',NULL,0,1,NULL),(410003,1,'orderProcess.40','待审批','10',0,'completed','2012-08-17 23:00:08','2012-08-17 23:00:08',754,1,NULL),(410005,1,'orderProcess.40','通过','0',0,'completed','2012-08-17 23:00:08','2012-08-17 23:07:05',417374,1,NULL),(410007,1,'orderProcess.40','分配任务','0',0,'completed','2012-08-17 23:07:05','2012-08-17 23:25:51',1126413,1,NULL),(420001,0,'orderProcess.40',NULL,'16',0,NULL,'2012-08-17 23:25:51',NULL,0,1,NULL),(430003,1,'orderProcess.41','待审批','10',0,'completed','2012-08-17 23:29:34','2012-08-17 23:29:53',19066,1,NULL),(430005,1,'orderProcess.41','通过','0',0,'completed','2012-08-17 23:29:53','2012-08-17 23:31:07',74835,1,NULL),(430007,1,'orderProcess.41','分配任务','0',0,'completed','2012-08-17 23:31:07','2012-08-17 23:31:47',40827,1,NULL),(430009,0,'orderProcess.41',NULL,'16',0,NULL,'2012-08-17 23:31:47',NULL,0,1,NULL),(440003,1,'orderProcess.42','待审批','10',0,'completed','2012-08-18 00:49:12','2012-08-18 00:49:13',1454,1,NULL),(440005,1,'orderProcess.42','不通过','0',0,'completed','2012-08-18 00:49:13','2012-08-18 00:52:54',221573,1,NULL),(440007,0,'orderProcess.42',NULL,'0',0,NULL,'2012-08-18 00:52:54',NULL,0,1,NULL),(470003,1,'orderProcess.45','待审批','10',0,'completed','2012-08-18 01:02:39','2012-08-18 01:02:39',888,1,NULL),(470005,1,'orderProcess.45','不通过','0',0,'completed','2012-08-18 01:02:39','2012-08-18 01:03:27',48634,1,NULL),(470007,0,'orderProcess.45',NULL,'0',0,NULL,'2012-08-18 01:03:27',NULL,0,1,NULL),(480003,1,'orderProcess.46','待审批','10',0,'completed','2012-08-18 01:10:33','2012-08-18 01:10:33',656,1,NULL),(480005,1,'orderProcess.46','不通过','0',0,'completed','2012-08-18 01:10:33','2012-08-18 01:11:33',60727,1,NULL),(480007,0,'orderProcess.46',NULL,'0',0,NULL,'2012-08-18 01:11:33',NULL,0,1,NULL),(490003,1,'orderProcess.47','待审批','10',0,'completed','2012-08-18 01:15:10','2012-08-18 01:15:10',940,1,NULL),(490005,1,'orderProcess.47','不通过','0',0,'completed','2012-08-18 01:15:10','2012-08-18 01:16:24',74564,1,NULL),(490007,0,'orderProcess.47',NULL,'0',0,NULL,'2012-08-18 01:16:24',NULL,0,1,NULL),(490011,1,'orderProcess.48','待审批','10',0,'completed','2012-08-18 01:18:35','2012-08-18 01:18:35',542,1,NULL),(490013,1,'orderProcess.48','不通过','0',0,'completed','2012-08-18 01:18:35','2012-08-18 01:19:14',39364,1,NULL),(490015,0,'orderProcess.48',NULL,'0',0,NULL,'2012-08-18 01:19:14',NULL,0,1,NULL),(490019,1,'orderProcess.49','待审批','10',0,'completed','2012-08-18 01:20:19','2012-08-18 01:20:23',4096,1,NULL),(490021,0,'orderProcess.49',NULL,'0',0,NULL,'2012-08-18 01:20:23',NULL,0,1,NULL),(500003,1,'orderProcess.50','待审批','10',0,'completed','2012-08-18 01:26:40','2012-08-18 01:26:43',3154,1,NULL),(500005,1,'orderProcess.50','不通过','0',0,'completed','2012-08-18 01:26:43','2012-08-18 01:30:50',247504,1,NULL),(510003,1,'orderProcess.50','待审批','0',0,'completed','2012-08-18 01:30:50','2012-08-18 01:32:25',95981,1,NULL),(510005,0,'orderProcess.50',NULL,'0',0,NULL,'2012-08-18 01:32:25',NULL,0,1,NULL),(520003,0,'orderProcess.51',NULL,'10',0,NULL,'2012-08-18 18:20:22',NULL,0,1,NULL),(530003,1,'orderProcess.52','待审批','10',0,'completed','2012-08-18 18:21:46','2012-08-18 18:21:47',1381,1,NULL),(530005,1,'orderProcess.52','不通过','0',0,'completed','2012-08-18 18:21:47','2012-08-18 18:37:46',959824,1,NULL),(540001,1,'orderProcess.52','待审批','0',0,'completed','2012-08-18 18:37:47','2012-08-18 18:39:11',84501,1,NULL),(540003,1,'orderProcess.52','不通过','0',0,'completed','2012-08-18 18:39:11','2012-08-18 18:40:44',93102,1,NULL),(540005,1,'orderProcess.52','待审批','0',0,'completed','2012-08-18 18:40:44','2012-08-18 18:41:38',54043,1,NULL),(540007,1,'orderProcess.52','不通过','0',0,'completed','2012-08-18 18:41:38','2012-08-18 18:45:22',224477,1,NULL),(550001,1,'orderProcess.52','待审批','0',0,'completed','2012-08-18 18:45:23','2012-08-18 18:51:01',338121,1,NULL),(560001,0,'orderProcess.52',NULL,'0',0,NULL,'2012-08-18 18:51:01',NULL,0,1,NULL),(560005,1,'orderProcess.53','待审批','10',0,'completed','2012-08-18 19:24:21','2012-08-18 19:24:22',1553,1,NULL),(560007,1,'orderProcess.53','不通过','0',0,'completed','2012-08-18 19:24:22','2012-08-18 19:30:53',391704,1,NULL),(570001,1,'orderProcess.53','待审批','0',0,'completed','2012-08-18 19:30:55','2012-08-18 19:32:12',77181,1,NULL),(570003,0,'orderProcess.53',NULL,'0',0,NULL,'2012-08-18 19:32:12',NULL,0,1,NULL),(570007,1,'orderProcess.54','待审批','10',0,'completed','2012-08-18 19:33:38','2012-08-18 19:33:49',11356,1,NULL),(570009,1,'orderProcess.54','不通过','0',0,'completed','2012-08-18 19:33:49','2012-08-18 19:34:30',41980,1,NULL),(570011,1,'orderProcess.54','待审批','0',0,'completed','2012-08-18 19:34:30','2012-08-18 19:35:25',55245,1,NULL),(570013,0,'orderProcess.54',NULL,'0',0,NULL,'2012-08-18 19:35:25',NULL,0,1,NULL),(580003,1,'orderProcess.55','待审批','10',0,'completed','2012-08-18 19:39:48','2012-08-18 19:39:57',9354,1,NULL),(580005,1,'orderProcess.55','不通过','0',0,'completed','2012-08-18 19:39:57','2012-08-18 19:41:53',116014,1,NULL),(590001,0,'orderProcess.55',NULL,'0',0,NULL,'2012-08-18 19:41:53',NULL,0,1,NULL),(600003,1,'orderProcess.56','待审批','10',0,'completed','2012-08-18 19:44:43','2012-08-18 19:44:44',1836,1,NULL),(600005,0,'orderProcess.56',NULL,'0',0,NULL,'2012-08-18 19:44:44',NULL,0,1,NULL),(600009,1,'orderProcess.57','待审批','10',0,'completed','2012-08-18 19:45:31','2012-08-18 19:45:31',908,1,NULL),(600011,1,'orderProcess.57','不通过','0',0,'completed','2012-08-18 19:45:31','2012-08-18 19:46:08',37656,1,NULL),(600013,0,'orderProcess.57',NULL,'0',0,NULL,'2012-08-18 19:46:08',NULL,0,1,NULL),(610003,1,'orderProcess.58','待审批','10',0,'completed','2012-08-18 19:48:34','2012-08-18 19:48:34',830,1,NULL),(610005,1,'orderProcess.58','不通过','0',0,'completed','2012-08-18 19:48:34','2012-08-18 19:49:01',27347,1,NULL),(610007,1,'orderProcess.58','待审批','0',0,'completed','2012-08-18 19:49:01','2012-08-18 19:50:02',61058,1,NULL),(610009,1,'orderProcess.58','通过','0',0,'completed','2012-08-18 19:50:02','2012-08-18 19:51:59',117504,1,NULL),(610011,1,'orderProcess.58','分配任务','0',0,'completed','2012-08-18 19:51:59','2012-08-18 20:44:50',3171551,1,NULL),(610013,1,'orderProcess.58','确认','16',0,'completed','2012-08-18 20:44:50','2012-08-18 20:46:09',79818,1,NULL),(610015,1,'orderProcess.58','待审批','0',0,'completed','2012-08-18 20:46:09','2012-08-18 20:49:05',176932,1,NULL),(610017,1,'orderProcess.58','不通过','0',0,'completed','2012-08-18 20:49:05','2012-08-18 20:50:30',85325,1,NULL),(610019,1,'orderProcess.58','待审批','0',0,'completed','2012-08-18 20:50:30','2012-08-18 20:52:06',96438,1,NULL),(610021,1,'orderProcess.58','通过','0',0,'completed','2012-08-18 20:52:06','2012-08-18 20:53:22',76126,1,NULL),(610023,1,'orderProcess.58','判断授课时间','0',0,'completed','2012-08-18 20:53:22','2012-08-18 22:13:18',4796238,1,NULL),(620003,1,'orderProcess.59','待审批','10',0,'completed','2012-08-18 22:41:04','2012-08-18 22:41:04',886,1,NULL),(620005,1,'orderProcess.59','通过','0',0,'completed','2012-08-18 22:41:04','2012-08-18 22:41:35',31008,1,NULL),(620007,1,'orderProcess.59','分配任务','0',0,'completed','2012-08-18 22:41:35','2012-08-18 22:42:17',42818,1,NULL),(620009,1,'orderProcess.59','确认','17',0,'completed','2012-08-18 22:42:17','2012-08-18 22:43:14',57363,1,NULL),(620011,1,'orderProcess.59','待审批','0',0,'completed','2012-08-18 22:43:14','2012-08-18 22:44:26',72525,1,NULL),(620013,1,'orderProcess.59','通过','0',0,'completed','2012-08-18 22:44:26','2012-08-18 22:45:20',54975,1,NULL),(620015,1,'orderProcess.59','判断授课时间','0',0,'completed','2012-08-18 22:45:20','2012-08-18 22:50:00',280091,1,NULL),(630003,1,'orderProcess.60','待审批','10',0,'completed','2012-08-19 08:17:33','2012-08-19 08:17:43',10591,1,NULL),(630005,0,'orderProcess.60',NULL,'0',0,NULL,'2012-08-19 08:17:43',NULL,0,1,NULL),(640003,1,'orderProcess.61','待审批','10',0,'completed','2012-08-19 09:04:54','2012-08-19 09:04:55',1120,1,NULL),(640005,0,'orderProcess.61',NULL,'0',0,NULL,'2012-08-19 09:04:55',NULL,0,1,NULL),(640009,1,'orderProcess.62','待审批','10',0,'completed','2012-08-19 11:02:03','2012-08-19 11:02:03',425,1,NULL),(640011,1,'orderProcess.62','不通过','0',0,'completed','2012-08-19 11:02:03','2012-08-19 11:04:18',135228,1,NULL),(640013,1,'orderProcess.62','待审批','0',0,'completed','2012-08-19 11:04:18','2012-08-19 11:05:40',82939,1,NULL),(640015,1,'orderProcess.62','通过','0',0,'completed','2012-08-19 11:05:40','2012-08-19 11:07:10',90984,1,NULL),(640017,1,'orderProcess.62','分配任务','0',0,'completed','2012-08-19 11:07:10','2012-08-19 11:21:40',870114,1,NULL),(640019,1,'orderProcess.62','确认','16',0,'completed','2012-08-19 11:21:40','2012-08-19 11:23:38',118555,1,NULL),(640021,1,'orderProcess.62','待审批','0',0,'completed','2012-08-19 11:23:38','2012-08-19 11:27:27',229246,1,NULL),(640023,1,'orderProcess.62','通过','0',0,'completed','2012-08-19 11:27:27','2012-08-19 11:28:24',57254,1,NULL),(640025,1,'orderProcess.62','判断授课时间','0',0,'completed','2012-08-19 11:28:24','2012-08-19 11:30:00',96124,1,NULL),(650007,1,'orderProcess.64','待审批','10',0,'completed','2012-08-26 16:59:34','2012-08-26 16:59:34',809,1,NULL),(650009,1,'orderProcess.64','通过','0',0,'completed','2012-08-26 16:59:34','2012-08-27 20:54:46',100512816,1,NULL),(660003,1,'orderProcess.65','待审批','10',0,'completed','2012-08-27 20:45:18','2012-08-27 20:45:18',729,1,NULL),(660005,0,'orderProcess.65',NULL,'0',0,NULL,'2012-08-27 20:45:18',NULL,0,1,NULL),(670001,0,'orderProcess.64',NULL,'0',0,NULL,'2012-08-27 20:54:47',NULL,0,1,NULL),(680003,1,'orderProcess.66','待审批','18',0,'completed','2012-09-11 22:36:55','2012-09-11 22:36:56',1072,1,NULL),(680005,0,'orderProcess.66',NULL,'0',0,NULL,'2012-09-11 22:36:56',NULL,0,1,NULL),(690003,1,'orderProcess.67','待审批','18',0,'completed','2012-10-10 21:03:05','2012-10-10 21:03:06',1071,1,NULL),(690005,0,'orderProcess.67',NULL,'0',0,NULL,'2012-10-10 21:03:06',NULL,0,1,NULL),(690009,1,'orderProcess.68','待审批','18',0,'completed','2012-10-10 21:12:36','2012-10-10 21:12:36',850,1,NULL),(690011,0,'orderProcess.68',NULL,'0',0,NULL,'2012-10-10 21:12:36',NULL,0,1,NULL),(700003,1,'orderProcess.69','待审批','18',0,'completed','2012-10-10 21:19:29','2012-10-10 21:19:31',2435,1,NULL),(700005,1,'orderProcess.69','通过','0',0,'completed','2012-10-10 21:19:31','2012-10-10 21:25:37',366309,1,NULL),(700007,1,'orderProcess.69','分配任务','0',0,'completed','2012-10-10 21:25:37','2012-10-10 21:26:04',27500,1,NULL),(700009,1,'orderProcess.69','确认','17',0,'completed','2012-10-10 21:26:04','2012-10-10 21:26:56',52443,1,NULL),(700011,1,'orderProcess.69','待审批','0',0,'completed','2012-10-10 21:26:56','2012-10-10 21:35:18',502005,1,NULL),(700013,1,'orderProcess.69','不通过','0',0,'completed','2012-10-10 21:35:18','2012-10-10 21:35:47',29480,1,NULL),(700015,1,'orderProcess.69','待审批','0',0,'completed','2012-10-10 21:35:47','2012-10-10 21:37:09',82103,1,NULL),(700017,1,'orderProcess.69','通过','0',0,'completed','2012-10-10 21:37:09','2012-10-10 21:37:28',19560,1,NULL),(700019,0,'orderProcess.69',NULL,'0',0,NULL,'2012-10-10 21:37:28',NULL,0,1,NULL),(700023,1,'orderProcess.70','待审批','18',0,'completed','2012-10-10 21:49:43','2012-10-10 21:49:44',1856,1,NULL),(700025,1,'orderProcess.70','通过','0',0,'completed','2012-10-10 21:49:44','2012-10-10 21:50:51',67443,1,NULL),(700027,1,'orderProcess.70','分配任务','0',0,'completed','2012-10-10 21:50:51','2012-10-10 21:51:10',19942,1,NULL),(700029,1,'orderProcess.70','确认','16',0,'completed','2012-10-10 21:51:10','2012-10-10 21:54:50',220006,1,NULL),(700031,0,'orderProcess.70',NULL,'0',0,NULL,'2012-10-10 21:54:50',NULL,0,1,NULL),(700035,1,'orderProcess.71','待审批','10',0,'completed','2012-10-10 22:26:29','2012-10-10 22:26:30',1389,1,NULL),(700037,0,'orderProcess.71',NULL,'0',0,NULL,'2012-10-10 22:26:30',NULL,0,1,NULL),(710003,1,'orderProcess.72','待审批','18',0,'completed','2012-10-16 22:59:05','2012-10-16 22:59:05',891,1,NULL),(710005,0,'orderProcess.72',NULL,'0',0,NULL,'2012-10-16 22:59:05',NULL,0,1,NULL),(720003,1,'orderProcess.73','待审批','18',0,'completed','2012-10-18 22:00:50','2012-10-18 22:00:59',9224,1,NULL),(720005,1,'orderProcess.73','通过','0',0,'completed','2012-10-18 22:00:59','2012-10-18 22:01:40',41057,1,NULL),(720007,1,'orderProcess.73','分配任务','0',0,'completed','2012-10-18 22:01:40','2012-10-18 22:02:42',62997,1,NULL),(720009,1,'orderProcess.73','确认','17',0,'completed','2012-10-18 22:02:43','2012-10-18 22:03:31',48166,1,NULL),(720011,1,'orderProcess.73','待审批','0',0,'completed','2012-10-18 22:03:31','2012-10-18 22:04:13',42165,1,NULL),(720013,1,'orderProcess.73','通过','0',0,'completed','2012-10-18 22:04:13','2012-10-18 22:04:37',24000,1,NULL),(720015,0,'orderProcess.73',NULL,'0',0,NULL,'2012-10-18 22:04:37',NULL,0,1,NULL),(720019,1,'orderProcess.74','待审批','18',0,'completed','2012-10-18 22:08:35','2012-10-18 22:08:36',1548,1,NULL),(720021,1,'orderProcess.74','通过','0',0,'completed','2012-10-18 22:08:36','2012-10-18 22:09:30',54543,1,NULL),(720023,0,'orderProcess.74',NULL,'0',0,NULL,'2012-10-18 22:09:30',NULL,0,1,NULL);
/*!40000 ALTER TABLE `jbpm4_hist_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_hist_var`
--

DROP TABLE IF EXISTS `jbpm4_hist_var`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_hist_var` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `PROCINSTID_` varchar(255) DEFAULT NULL,
  `EXECUTIONID_` varchar(255) DEFAULT NULL,
  `VARNAME_` varchar(255) DEFAULT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  `HPROCI_` bigint(20) DEFAULT NULL,
  `HTASK_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_HVAR_HPROCI` (`HPROCI_`),
  KEY `FK_HVAR_HTASK` (`HTASK_`),
  CONSTRAINT `FK_HVAR_HPROCI` FOREIGN KEY (`HPROCI_`) REFERENCES `jbpm4_hist_procinst` (`DBID_`),
  CONSTRAINT `FK_HVAR_HTASK` FOREIGN KEY (`HTASK_`) REFERENCES `jbpm4_hist_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_hist_var`
--

LOCK TABLES `jbpm4_hist_var` WRITE;
/*!40000 ALTER TABLE `jbpm4_hist_var` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_hist_var` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_id_group`
--

DROP TABLE IF EXISTS `jbpm4_id_group`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_id_group` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `PARENT_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_GROUP_PARENT` (`PARENT_`),
  CONSTRAINT `FK_GROUP_PARENT` FOREIGN KEY (`PARENT_`) REFERENCES `jbpm4_id_group` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_id_group`
--

LOCK TABLES `jbpm4_id_group` WRITE;
/*!40000 ALTER TABLE `jbpm4_id_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_id_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_id_membership`
--

DROP TABLE IF EXISTS `jbpm4_id_membership`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_id_membership` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `USER_` bigint(20) DEFAULT NULL,
  `GROUP_` bigint(20) DEFAULT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_MEM_GROUP` (`GROUP_`),
  KEY `FK_MEM_USER` (`USER_`),
  CONSTRAINT `FK_MEM_GROUP` FOREIGN KEY (`GROUP_`) REFERENCES `jbpm4_id_group` (`DBID_`),
  CONSTRAINT `FK_MEM_USER` FOREIGN KEY (`USER_`) REFERENCES `jbpm4_id_user` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_id_membership`
--

LOCK TABLES `jbpm4_id_membership` WRITE;
/*!40000 ALTER TABLE `jbpm4_id_membership` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_id_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_id_user`
--

DROP TABLE IF EXISTS `jbpm4_id_user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_id_user` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `ID_` varchar(255) DEFAULT NULL,
  `PASSWORD_` varchar(255) DEFAULT NULL,
  `GIVENNAME_` varchar(255) DEFAULT NULL,
  `FAMILYNAME_` varchar(255) DEFAULT NULL,
  `BUSINESSEMAIL_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_id_user`
--

LOCK TABLES `jbpm4_id_user` WRITE;
/*!40000 ALTER TABLE `jbpm4_id_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_id_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_job`
--

DROP TABLE IF EXISTS `jbpm4_job`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_job` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `DUEDATE_` datetime DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  `ISEXCLUSIVE_` bit(1) DEFAULT NULL,
  `LOCKOWNER_` varchar(255) DEFAULT NULL,
  `LOCKEXPTIME_` datetime DEFAULT NULL,
  `EXCEPTION_` longtext,
  `RETRIES_` int(11) DEFAULT NULL,
  `PROCESSINSTANCE_` bigint(20) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  `CFG_` bigint(20) DEFAULT NULL,
  `SIGNAL_` varchar(255) DEFAULT NULL,
  `EVENT_` varchar(255) DEFAULT NULL,
  `REPEAT_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_JOB_CFG` (`CFG_`),
  CONSTRAINT `FK_JOB_CFG` FOREIGN KEY (`CFG_`) REFERENCES `jbpm4_lob` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_job`
--

LOCK TABLES `jbpm4_job` WRITE;
/*!40000 ALTER TABLE `jbpm4_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_lob`
--

DROP TABLE IF EXISTS `jbpm4_lob`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_lob` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `BLOB_VALUE_` longblob,
  `DEPLOYMENT_` bigint(20) DEFAULT NULL,
  `NAME_` longtext,
  PRIMARY KEY (`DBID_`),
  KEY `FK_LOB_DEPLOYMENT` (`DEPLOYMENT_`),
  CONSTRAINT `FK_LOB_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_`) REFERENCES `jbpm4_deployment` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_lob`
--

LOCK TABLES `jbpm4_lob` WRITE;
/*!40000 ALTER TABLE `jbpm4_lob` DISABLE KEYS */;
INSERT INTO `jbpm4_lob` VALUES (2,0,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n\r\n<process key=\"orderProcess\" name=\"orderProcess\" xmlns=\"http://jbpm.org/4.4/jpdl\">\r\n	<start g=\"-2,55,45,23\" name=\"开始\">\r\n		<transition g=\"-19,-19\" name=\"新签单\" to=\"签约\" />\r\n	</start>\r\n	<task assignee=\"#{userid}\" g=\"113,56,89,40\" name=\"签约\">\r\n		<transition g=\"-37,-14\" name=\"待审批\" to=\"销售主管审批\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"107,135,96,40\" name=\"销售主管审批\">\r\n		<transition g=\"156,189:-33,-14\" name=\"通过\" to=\"教务部处理\" />\r\n		<transition g=\"244,142;247,105;248,79;223,77:-18,7\" name=\"不通过\"\r\n			to=\"签约\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"110,214,89,40\" name=\"教务部处理\">\r\n		<transition name=\"分配任务\" to=\"待班主任确认\" g=\"-22,-13\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"279,216,100,40\" name=\"待班主任确认\">\r\n		<transition g=\"-12,-12\" name=\"确认\" to=\"班主任处理中\" />\r\n		<transition g=\"330,166;251,166:-23,-19\" name=\"拒绝\" to=\"教务部处理\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"274,308,112,40\" name=\"班主任处理中\">\r\n		<transition g=\"-28,-15\" name=\"待审批\" to=\"教务部审批\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"100,386,89,40\" name=\"教务部审批\">\r\n		<transition g=\"145,328:-18,9\" name=\"不通过\" to=\"班主任处理中\" />\r\n		<transition name=\"通过\" to=\"授课中\" g=\"-11,-13\" />\r\n	</task> \r\n	<task assignee=\"#{userid}\" g=\"295,549,89,40\" name=\"授课中\">\r\n		<transition g=\"4,-11\" name=\"判断授课时间\" to=\"结束\" />\r\n	</task>\r\n	<end g=\"318,653,28,23\" name=\"结束\" />\r\n</process>',1,'com/core/jbpm/jpdl/order.jpdl.xml');
/*!40000 ALTER TABLE `jbpm4_lob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_participation`
--

DROP TABLE IF EXISTS `jbpm4_participation`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_participation` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `GROUPID_` varchar(255) DEFAULT NULL,
  `USERID_` varchar(255) DEFAULT NULL,
  `TYPE_` varchar(255) DEFAULT NULL,
  `TASK_` bigint(20) DEFAULT NULL,
  `SWIMLANE_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_PART_SWIMLANE` (`SWIMLANE_`),
  KEY `FK_PART_TASK` (`TASK_`),
  CONSTRAINT `FK_PART_SWIMLANE` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`),
  CONSTRAINT `FK_PART_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_participation`
--

LOCK TABLES `jbpm4_participation` WRITE;
/*!40000 ALTER TABLE `jbpm4_participation` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_participation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_property`
--

DROP TABLE IF EXISTS `jbpm4_property`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_property`
--

LOCK TABLES `jbpm4_property` WRITE;
/*!40000 ALTER TABLE `jbpm4_property` DISABLE KEYS */;
INSERT INTO `jbpm4_property` VALUES ('next.dbid',73,'730001');
/*!40000 ALTER TABLE `jbpm4_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_swimlane`
--

DROP TABLE IF EXISTS `jbpm4_swimlane`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_swimlane` (
  `DBID_` bigint(20) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `ASSIGNEE_` varchar(255) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_SWIMLANE_EXEC` (`EXECUTION_`),
  CONSTRAINT `FK_SWIMLANE_EXEC` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_swimlane`
--

LOCK TABLES `jbpm4_swimlane` WRITE;
/*!40000 ALTER TABLE `jbpm4_swimlane` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbpm4_swimlane` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_task`
--

DROP TABLE IF EXISTS `jbpm4_task`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_task` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` char(1) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `NAME_` varchar(255) DEFAULT NULL,
  `DESCR_` longtext,
  `STATE_` varchar(255) DEFAULT NULL,
  `SUSPHISTSTATE_` varchar(255) DEFAULT NULL,
  `ASSIGNEE_` varchar(255) DEFAULT NULL,
  `FORM_` varchar(255) DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_` datetime DEFAULT NULL,
  `DUEDATE_` datetime DEFAULT NULL,
  `PROGRESS_` int(11) DEFAULT NULL,
  `SIGNALLING_` bit(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(255) DEFAULT NULL,
  `ACTIVITY_NAME_` varchar(255) DEFAULT NULL,
  `HASVARS_` bit(1) DEFAULT NULL,
  `SUPERTASK_` bigint(20) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  `PROCINST_` bigint(20) DEFAULT NULL,
  `SWIMLANE_` bigint(20) DEFAULT NULL,
  `TASKDEFNAME_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_TASK_SWIML` (`SWIMLANE_`),
  KEY `FK_TASK_SUPERTASK` (`SUPERTASK_`),
  CONSTRAINT `FK_TASK_SUPERTASK` FOREIGN KEY (`SUPERTASK_`) REFERENCES `jbpm4_task` (`DBID_`),
  CONSTRAINT `FK_TASK_SWIML` FOREIGN KEY (`SWIMLANE_`) REFERENCES `jbpm4_swimlane` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_task`
--

LOCK TABLES `jbpm4_task` WRITE;
/*!40000 ALTER TABLE `jbpm4_task` DISABLE KEYS */;
INSERT INTO `jbpm4_task` VALUES (10019,'T',1,'授课中',NULL,'open',NULL,'4',NULL,0,'2012-07-08 13:58:52',NULL,NULL,'','orderProcess.109','授课中','\0',NULL,10001,10001,NULL,'授课中'),(50019,'T',1,'授课中',NULL,'open',NULL,'4',NULL,0,'2012-07-08 15:37:48',NULL,NULL,'','orderProcess.114','授课中','\0',NULL,50005,50005,NULL,'授课中'),(70005,'T',1,'授课中',NULL,'open',NULL,'4',NULL,0,'2012-07-09 20:47:10',NULL,NULL,'','orderProcess.110','授课中','\0',NULL,20001,20001,NULL,'授课中'),(100007,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-09 23:04:33',NULL,NULL,'','orderProcess.119','签约','\0',NULL,100005,100005,NULL,'签约'),(110003,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-09 23:06:37',NULL,NULL,'','orderProcess.120','签约','\0',NULL,110001,110001,NULL,'签约'),(120005,'T',1,'销售主管审批',NULL,'open',NULL,'1',NULL,0,'2012-07-09 23:10:30',NULL,NULL,'','orderProcess.121','销售主管审批','\0',NULL,120001,120001,NULL,'销售主管审批'),(130007,'T',1,'教务部处理',NULL,'open',NULL,'2',NULL,0,'2012-07-10 20:07:59',NULL,NULL,'','orderProcess.1','教务部处理','\0',NULL,130001,130001,NULL,'教务部处理'),(140011,'T',1,'班主任处理中',NULL,'open',NULL,'4',NULL,0,'2012-07-10 20:15:38',NULL,NULL,'','orderProcess.2','班主任处理中','\0',NULL,140001,140001,NULL,'班主任处理中'),(150003,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-10 21:07:29',NULL,NULL,'','orderProcess.3','签约','\0',NULL,150001,150001,NULL,'签约'),(150007,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-10 21:10:45',NULL,NULL,'','orderProcess.4','签约','\0',NULL,150005,150005,NULL,'签约'),(160009,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 21:13:11',NULL,NULL,'','orderProcess.6','销售主管审批','\0',NULL,160005,160005,NULL,'销售主管审批'),(170005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 21:22:22',NULL,NULL,'','orderProcess.7','销售主管审批','\0',NULL,170001,170001,NULL,'销售主管审批'),(170009,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-10 21:24:15',NULL,NULL,'','orderProcess.8','签约','\0',NULL,170007,170007,NULL,'签约'),(180009,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 21:30:00',NULL,NULL,'','orderProcess.10','销售主管审批','\0',NULL,180005,180005,NULL,'销售主管审批'),(200005,'T',1,'班主任处理中',NULL,'open',NULL,'0',NULL,0,'2012-07-10 22:09:14',NULL,NULL,'','orderProcess.12','班主任处理中','\0',NULL,190005,190005,NULL,'班主任处理中'),(210013,'T',1,'教务部审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 22:15:21',NULL,NULL,'','orderProcess.13','教务部审批','\0',NULL,210001,210001,NULL,'教务部审批'),(230019,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-07-10 22:32:12',NULL,NULL,'','orderProcess.16','授课中','\0',NULL,230005,230005,NULL,'授课中'),(240005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-11 22:35:02',NULL,NULL,'','orderProcess.17','销售主管审批','\0',NULL,240001,240001,NULL,'销售主管审批'),(270005,'T',1,'教务部审批',NULL,'open',NULL,'0',NULL,0,'2012-07-11 23:45:02',NULL,NULL,'','orderProcess.18','教务部审批','\0',NULL,250001,250001,NULL,'教务部审批'),(300001,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-07-22 20:52:15',NULL,NULL,'','orderProcess.19','授课中','\0',NULL,280001,280001,NULL,'授课中'),(310005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-15 23:39:59',NULL,NULL,'','orderProcess.27','销售主管审批','\0',NULL,310001,310001,NULL,'销售主管审批'),(320005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-15 23:55:09',NULL,NULL,'','orderProcess.28','销售主管审批','\0',NULL,320001,320001,NULL,'销售主管审批'),(320021,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-08-16 00:18:55',NULL,NULL,'','orderProcess.29','授课中','\0',NULL,320007,320007,NULL,'授课中'),(320031,'T',1,'待班主任确认',NULL,'open',NULL,'15',NULL,0,'2012-08-16 00:30:55',NULL,NULL,'','orderProcess.30','待班主任确认','\0',NULL,320023,320023,NULL,'待班主任确认'),(330005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:07:47',NULL,NULL,'','orderProcess.31','销售主管审批','\0',NULL,330001,330001,NULL,'销售主管审批'),(340005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:14:21',NULL,NULL,'','orderProcess.32','销售主管审批','\0',NULL,340001,340001,NULL,'销售主管审批'),(340011,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:17:17',NULL,NULL,'','orderProcess.33','销售主管审批','\0',NULL,340007,340007,NULL,'销售主管审批'),(350005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:21:39',NULL,NULL,'','orderProcess.34','销售主管审批','\0',NULL,350001,350001,NULL,'销售主管审批'),(360005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 23:22:54',NULL,NULL,'','orderProcess.35','销售主管审批','\0',NULL,360001,360001,NULL,'销售主管审批'),(370005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-17 00:44:48',NULL,NULL,'','orderProcess.36','销售主管审批','\0',NULL,370001,370001,NULL,'销售主管审批'),(380005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-17 00:48:35',NULL,NULL,'','orderProcess.37','销售主管审批','\0',NULL,380001,380001,NULL,'销售主管审批'),(390005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-17 00:57:20',NULL,NULL,'','orderProcess.38','销售主管审批','\0',NULL,390001,390001,NULL,'销售主管审批'),(400007,'T',1,'教务部处理',NULL,'open',NULL,'0',NULL,0,'2012-08-17 01:10:36',NULL,NULL,'','orderProcess.39','教务部处理','\0',NULL,400001,400001,NULL,'教务部处理'),(420001,'T',1,'待班主任确认',NULL,'open',NULL,'16',NULL,0,'2012-08-17 23:25:51',NULL,NULL,'','orderProcess.40','待班主任确认','\0',NULL,410001,410001,NULL,'待班主任确认'),(430009,'T',1,'待班主任确认',NULL,'open',NULL,'16',NULL,0,'2012-08-17 23:31:47',NULL,NULL,'','orderProcess.41','待班主任确认','\0',NULL,430001,430001,NULL,'待班主任确认'),(440007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 00:52:54',NULL,NULL,'','orderProcess.42','签约','\0',NULL,440001,440001,NULL,'签约'),(470007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:03:27',NULL,NULL,'','orderProcess.45','签约','\0',NULL,470001,470001,NULL,'签约'),(480007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:11:33',NULL,NULL,'','orderProcess.46','签约','\0',NULL,480001,480001,NULL,'签约'),(490007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:16:24',NULL,NULL,'','orderProcess.47','签约','\0',NULL,490001,490001,NULL,'签约'),(490015,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:19:14',NULL,NULL,'','orderProcess.48','签约','\0',NULL,490009,490009,NULL,'签约'),(490021,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:20:23',NULL,NULL,'','orderProcess.49','销售主管审批','\0',NULL,490017,490017,NULL,'销售主管审批'),(510005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:32:25',NULL,NULL,'','orderProcess.50','销售主管审批','\0',NULL,500001,500001,NULL,'销售主管审批'),(520003,'T',1,'签约',NULL,'open',NULL,'10',NULL,0,'2012-08-18 18:20:22',NULL,NULL,'','orderProcess.51','签约','\0',NULL,520001,520001,NULL,'签约'),(560001,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 18:51:01',NULL,NULL,'','orderProcess.52','销售主管审批','\0',NULL,530001,530001,NULL,'销售主管审批'),(570003,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:32:12',NULL,NULL,'','orderProcess.53','销售主管审批','\0',NULL,560003,560003,NULL,'销售主管审批'),(570013,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:35:25',NULL,NULL,'','orderProcess.54','销售主管审批','\0',NULL,570005,570005,NULL,'销售主管审批'),(590001,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:41:53',NULL,NULL,'','orderProcess.55','签约','\0',NULL,580001,580001,NULL,'签约'),(600005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:44:44',NULL,NULL,'','orderProcess.56','销售主管审批','\0',NULL,600001,600001,NULL,'销售主管审批'),(600013,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:46:08',NULL,NULL,'','orderProcess.57','签约','\0',NULL,600007,600007,NULL,'签约'),(630005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-19 08:17:43',NULL,NULL,'','orderProcess.60','销售主管审批','\0',NULL,630001,630001,NULL,'销售主管审批'),(640005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-19 09:04:55',NULL,NULL,'','orderProcess.61','销售主管审批','\0',NULL,640001,640001,NULL,'销售主管审批'),(660005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-27 20:45:18',NULL,NULL,'','orderProcess.65','销售主管审批','\0',NULL,660001,660001,NULL,'销售主管审批'),(670001,'T',1,'教务部处理',NULL,'open',NULL,'0',NULL,0,'2012-08-27 20:54:47',NULL,NULL,'','orderProcess.64','教务部处理','\0',NULL,650005,650005,NULL,'教务部处理'),(680005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-09-11 22:36:56',NULL,NULL,'','orderProcess.66','销售主管审批','\0',NULL,680001,680001,NULL,'销售主管审批'),(690005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:03:06',NULL,NULL,'','orderProcess.67','销售主管审批','\0',NULL,690001,690001,NULL,'销售主管审批'),(690011,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:12:36',NULL,NULL,'','orderProcess.68','销售主管审批','\0',NULL,690007,690007,NULL,'销售主管审批'),(700019,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:37:28',NULL,NULL,'','orderProcess.69','授课中','\0',NULL,700001,700001,NULL,'授课中'),(700031,'T',1,'班主任处理中',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:54:50',NULL,NULL,'','orderProcess.70','班主任处理中','\0',NULL,700021,700021,NULL,'班主任处理中'),(700037,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-10 22:26:30',NULL,NULL,'','orderProcess.71','销售主管审批','\0',NULL,700033,700033,NULL,'销售主管审批'),(710005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-16 22:59:05',NULL,NULL,'','orderProcess.72','销售主管审批','\0',NULL,710001,710001,NULL,'销售主管审批'),(720015,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-10-18 22:04:37',NULL,NULL,'','orderProcess.73','授课中','\0',NULL,720001,720001,NULL,'授课中'),(720023,'T',1,'教务部处理',NULL,'open',NULL,'0',NULL,0,'2012-10-18 22:09:30',NULL,NULL,'','orderProcess.74','教务部处理','\0',NULL,720017,720017,NULL,'教务部处理');
/*!40000 ALTER TABLE `jbpm4_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jbpm4_variable`
--

DROP TABLE IF EXISTS `jbpm4_variable`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `jbpm4_variable` (
  `DBID_` bigint(20) NOT NULL,
  `CLASS_` varchar(255) NOT NULL,
  `DBVERSION_` int(11) NOT NULL,
  `KEY_` varchar(255) DEFAULT NULL,
  `CONVERTER_` varchar(255) DEFAULT NULL,
  `HIST_` bit(1) DEFAULT NULL,
  `EXECUTION_` bigint(20) DEFAULT NULL,
  `TASK_` bigint(20) DEFAULT NULL,
  `LOB_` bigint(20) DEFAULT NULL,
  `DATE_VALUE_` datetime DEFAULT NULL,
  `DOUBLE_VALUE_` double DEFAULT NULL,
  `CLASSNAME_` varchar(255) DEFAULT NULL,
  `LONG_VALUE_` bigint(20) DEFAULT NULL,
  `STRING_VALUE_` varchar(255) DEFAULT NULL,
  `TEXT_VALUE_` longtext,
  `EXESYS_` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`DBID_`),
  KEY `FK_VAR_EXESYS` (`EXESYS_`),
  KEY `FK_VAR_LOB` (`LOB_`),
  KEY `FK_VAR_TASK` (`TASK_`),
  KEY `FK_VAR_EXECUTION` (`EXECUTION_`),
  CONSTRAINT `FK_VAR_EXECUTION` FOREIGN KEY (`EXECUTION_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_EXESYS` FOREIGN KEY (`EXESYS_`) REFERENCES `jbpm4_execution` (`DBID_`),
  CONSTRAINT `FK_VAR_LOB` FOREIGN KEY (`LOB_`) REFERENCES `jbpm4_lob` (`DBID_`),
  CONSTRAINT `FK_VAR_TASK` FOREIGN KEY (`TASK_`) REFERENCES `jbpm4_task` (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `jbpm4_variable`
--

LOCK TABLES `jbpm4_variable` WRITE;
/*!40000 ALTER TABLE `jbpm4_variable` DISABLE KEYS */;
INSERT INTO `jbpm4_variable` VALUES (10002,'string',7,'userid',NULL,'\0',10001,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(20002,'string',7,'userid',NULL,'\0',20001,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(50006,'string',5,'userid',NULL,'\0',50005,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(100006,'string',0,'userid',NULL,'\0',100005,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(110002,'string',0,'userid',NULL,'\0',110001,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(120002,'string',1,'userid',NULL,'\0',120001,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL),(130002,'string',2,'userid',NULL,'\0',130001,NULL,NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL),(140002,'string',4,'userid',NULL,'\0',140001,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(150002,'string',0,'userid',NULL,'\0',150001,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(150006,'string',0,'userid',NULL,'\0',150005,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(160006,'string',1,'userid',NULL,'\0',160005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(170002,'string',1,'userid',NULL,'\0',170001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(170008,'string',0,'userid',NULL,'\0',170007,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(180006,'string',1,'userid',NULL,'\0',180005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(190006,'string',3,'userid',NULL,'\0',190005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(210002,'string',3,'userid',NULL,'\0',210001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(230006,'string',3,'userid',NULL,'\0',230005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(240002,'string',1,'userid',NULL,'\0',240001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(250002,'string',3,'userid',NULL,'\0',250001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(280002,'string',3,'userid',NULL,'\0',280001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(310002,'string',1,'userid',NULL,'\0',310001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(320002,'string',1,'userid',NULL,'\0',320001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(320008,'string',3,'userid',NULL,'\0',320007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(320024,'string',2,'userid',NULL,'\0',320023,NULL,NULL,NULL,NULL,NULL,NULL,'15',NULL,NULL),(330002,'string',1,'userid',NULL,'\0',330001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(340002,'string',1,'userid',NULL,'\0',340001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(340008,'string',1,'userid',NULL,'\0',340007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(350002,'string',1,'userid',NULL,'\0',350001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(360002,'string',1,'userid',NULL,'\0',360001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(370002,'string',1,'userid',NULL,'\0',370001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(380002,'string',1,'userid',NULL,'\0',380001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(390002,'string',1,'userid',NULL,'\0',390001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(400002,'string',1,'userid',NULL,'\0',400001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(410002,'string',2,'userid',NULL,'\0',410001,NULL,NULL,NULL,NULL,NULL,NULL,'16',NULL,NULL),(430002,'string',2,'userid',NULL,'\0',430001,NULL,NULL,NULL,NULL,NULL,NULL,'16',NULL,NULL),(440002,'string',1,'userid',NULL,'\0',440001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(470002,'string',1,'userid',NULL,'\0',470001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(480002,'string',1,'userid',NULL,'\0',480001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(490002,'string',1,'userid',NULL,'\0',490001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(490010,'string',1,'userid',NULL,'\0',490009,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(490018,'string',1,'userid',NULL,'\0',490017,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(500002,'string',1,'userid',NULL,'\0',500001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(520002,'string',0,'userid',NULL,'\0',520001,NULL,NULL,NULL,NULL,NULL,NULL,'10',NULL,NULL),(530002,'string',1,'userid',NULL,'\0',530001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(560004,'string',1,'userid',NULL,'\0',560003,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(570006,'string',1,'userid',NULL,'\0',570005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(580002,'string',1,'userid',NULL,'\0',580001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(600002,'string',1,'userid',NULL,'\0',600001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(600008,'string',1,'userid',NULL,'\0',600007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(630002,'string',1,'userid',NULL,'\0',630001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(640002,'string',1,'userid',NULL,'\0',640001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(650006,'string',1,'userid',NULL,'\0',650005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(660002,'string',1,'userid',NULL,'\0',660001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(680002,'string',1,'userid',NULL,'\0',680001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(690002,'string',1,'userid',NULL,'\0',690001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(690008,'string',1,'userid',NULL,'\0',690007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(700002,'string',3,'userid',NULL,'\0',700001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(700022,'string',3,'userid',NULL,'\0',700021,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(700034,'string',1,'userid',NULL,'\0',700033,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(710002,'string',1,'userid',NULL,'\0',710001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(720002,'string',3,'userid',NULL,'\0',720001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(720018,'string',1,'userid',NULL,'\0',720017,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL);
/*!40000 ALTER TABLE `jbpm4_variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `notice` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) NOT NULL COMMENT '发送者id',
  `receiver_id` int(10) NOT NULL COMMENT '接收者id ',
  `status` char(1) NOT NULL COMMENT '通知状态 0: 未读, 1:已读 ',
  `content` varchar(2000) NOT NULL COMMENT '交流内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8 COMMENT='公告表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (193,18,14,'0','222222','2012-11-10 15:50:05','2012-11-10 15:50:05'),(194,18,15,'0','222222','2012-11-10 15:50:05','2012-11-10 15:50:05'),(195,18,16,'0','222222','2012-11-10 15:50:05','2012-11-10 15:50:05'),(196,18,17,'0','222222','2012-11-10 15:50:05','2012-11-10 15:50:05'),(197,18,18,'1','222222','2012-11-10 15:50:05','2012-11-10 15:50:28'),(198,18,19,'0','222222','2012-11-10 15:50:05','2012-11-10 15:50:05'),(199,18,20,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(200,18,21,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(201,18,22,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(202,18,5,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(203,18,7,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(204,18,10,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(205,18,13,'0','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(206,18,5,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:08:47','2012-11-10 16:08:47'),(207,18,7,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:08:47','2012-11-10 16:08:47'),(208,18,14,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:02','2012-11-10 16:13:02'),(209,18,15,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:02','2012-11-10 16:13:02'),(210,18,17,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:21','2012-11-10 16:13:21'),(211,18,17,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:36','2012-11-10 16:13:36'),(212,18,14,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:14:08','2012-11-10 16:14:08'),(213,18,15,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:14:08','2012-11-10 16:14:08'),(214,18,5,'0','你有1条新的未办签单信息，请查看签单编号【112】','2012-11-14 13:54:59','2012-11-14 13:54:59'),(215,18,7,'0','你有1条新的未办签单信息，请查看签单编号【112】','2012-11-14 13:54:59','2012-11-14 13:54:59'),(216,18,5,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:05:10','2012-11-14 14:05:10'),(217,18,7,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:05:10','2012-11-14 14:05:10'),(218,18,14,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:31:23','2012-11-14 14:31:23'),(219,18,15,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:31:23','2012-11-14 14:31:23'),(220,18,16,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:31:46','2012-11-14 14:31:46'),(221,18,16,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:32:03','2012-11-14 14:32:03'),(222,18,14,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:32:29','2012-11-14 14:32:29'),(223,18,15,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:32:29','2012-11-14 14:32:29'),(224,18,5,'0','你有1条新的未办签单信息，请查看签单编号【116】','2012-11-19 13:11:20','2012-11-19 13:11:20'),(225,18,7,'0','你有1条新的未办签单信息，请查看签单编号【116】','2012-11-19 13:11:20','2012-11-19 13:11:20'),(226,18,5,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-19 13:18:09','2012-11-19 13:18:09'),(227,18,7,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-19 13:18:09','2012-11-19 13:18:09'),(228,18,5,'0','你有1条新的未办签单信息，请查看签单编号【118】','2012-11-19 13:24:57','2012-11-19 13:24:57'),(229,18,7,'0','你有1条新的未办签单信息，请查看签单编号【118】','2012-11-19 13:24:57','2012-11-19 13:24:57'),(230,18,5,'0','你有1条新的未办签单信息，请查看签单编号【120】','2012-11-19 14:11:30','2012-11-19 14:11:30'),(231,18,7,'0','你有1条新的未办签单信息，请查看签单编号【120】','2012-11-19 14:11:30','2012-11-19 14:11:30'),(232,18,5,'0','你有1条新的未办签单信息，请查看签单编号【121】','2012-11-19 14:13:35','2012-11-19 14:13:35'),(233,18,7,'0','你有1条新的未办签单信息，请查看签单编号【121】','2012-11-19 14:13:35','2012-11-19 14:13:35'),(234,18,5,'0','你有1条新的未办签单信息，请查看签单编号【123】','2012-11-19 14:29:44','2012-11-19 14:29:44'),(235,18,7,'0','你有1条新的未办签单信息，请查看签单编号【123】','2012-11-19 14:29:44','2012-11-19 14:29:44'),(236,18,5,'0','你有1条新的未办签单信息，请查看签单编号【125】','2012-11-21 14:12:55','2012-11-21 14:12:55'),(237,18,7,'0','你有1条新的未办签单信息，请查看签单编号【125】','2012-11-21 14:12:55','2012-11-21 14:12:55'),(238,18,5,'0','你有1条新的未办签单信息，请查看签单编号【126】','2012-11-21 14:33:15','2012-11-21 14:33:15'),(239,18,7,'0','你有1条新的未办签单信息，请查看签单编号【126】','2012-11-21 14:33:15','2012-11-21 14:33:15'),(240,18,5,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:37:25','2012-11-21 14:37:25'),(241,18,7,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:37:25','2012-11-21 14:37:25'),(242,18,14,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:43:09','2012-11-21 14:43:09'),(243,18,15,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:43:09','2012-11-21 14:43:09'),(244,18,16,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:43:41','2012-11-21 14:43:41'),(245,18,16,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:44:03','2012-11-21 14:44:03'),(246,18,14,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:44:37','2012-11-21 14:44:37'),(247,18,15,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:44:37','2012-11-21 14:44:37'),(248,18,15,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 15:04:07','2012-11-27 15:04:07'),(249,18,15,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 15:16:29','2012-11-27 15:16:29'),(250,18,15,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 15:16:42','2012-11-27 15:16:42'),(251,18,5,'0','你有1条新的未办签单信息，请查看签单编号【128】','2012-12-01 15:16:11','2012-12-01 15:16:11'),(252,18,7,'0','你有1条新的未办签单信息，请查看签单编号【128】','2012-12-01 15:16:11','2012-12-01 15:16:11'),(253,18,5,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:33:58','2012-12-03 13:33:58'),(254,18,7,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:33:58','2012-12-03 13:33:58'),(255,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:37:57','2012-12-03 13:37:57'),(256,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:39:40','2012-12-03 13:39:40'),(257,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:40:38','2012-12-03 13:40:38'),(258,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:51:32','2012-12-03 13:51:32'),(259,18,5,'0','你有1条新的未办签单信息，请查看签单编号【130】','2012-12-03 14:40:21','2012-12-03 14:40:21'),(260,18,7,'0','你有1条新的未办签单信息，请查看签单编号【130】','2012-12-03 14:40:21','2012-12-03 14:40:21'),(261,18,5,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:26:39','2012-12-04 14:26:39'),(262,18,7,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:26:39','2012-12-04 14:26:39'),(263,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:29:28','2012-12-04 14:29:28'),(264,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:33:03','2012-12-04 14:33:03'),(265,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:33:32','2012-12-04 14:33:32'),(266,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:34:36','2012-12-04 14:34:36'),(267,18,5,'0','你有1条新的未办签单信息，请查看签单编号【5】','2012-12-10 14:36:56','2012-12-10 14:36:56'),(268,18,7,'0','你有1条新的未办签单信息，请查看签单编号【5】','2012-12-10 14:36:56','2012-12-10 14:36:56');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice_his`
--

DROP TABLE IF EXISTS `notice_his`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `notice_his` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) NOT NULL COMMENT '发送者id',
  `receiver_type` char(1) NOT NULL COMMENT '接收者类型 0:个人 1:角色 2:部门 3:全部人',
  `receiver_id` varchar(500) NOT NULL COMMENT '接收者id,多个以，分隔',
  `content` varchar(2000) NOT NULL COMMENT '交流内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8 COMMENT='公告表历史表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `notice_his`
--

LOCK TABLES `notice_his` WRITE;
/*!40000 ALTER TABLE `notice_his` DISABLE KEYS */;
INSERT INTO `notice_his` VALUES (116,18,'0','14,15,16,17,18,19,20,21,22,5,7,10,13','222222','2012-11-10 15:50:06','2012-11-10 15:50:06'),(117,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:08:47','2012-11-10 16:08:47'),(118,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:02','2012-11-10 16:13:02'),(119,18,'0','17','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:21','2012-11-10 16:13:21'),(120,18,'0','17','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:13:36','2012-11-10 16:13:36'),(121,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-10 16:14:08','2012-11-10 16:14:08'),(122,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【112】','2012-11-14 13:54:59','2012-11-14 13:54:59'),(123,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:05:10','2012-11-14 14:05:10'),(124,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:31:23','2012-11-14 14:31:23'),(125,18,'0','16','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:31:46','2012-11-14 14:31:46'),(126,18,'0','16','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:32:03','2012-11-14 14:32:03'),(127,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 14:32:29','2012-11-14 14:32:29'),(128,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【116】','2012-11-19 13:11:20','2012-11-19 13:11:20'),(129,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-19 13:18:09','2012-11-19 13:18:09'),(130,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【118】','2012-11-19 13:24:57','2012-11-19 13:24:57'),(131,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【120】','2012-11-19 14:11:30','2012-11-19 14:11:30'),(132,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【121】','2012-11-19 14:13:35','2012-11-19 14:13:35'),(133,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【123】','2012-11-19 14:29:44','2012-11-19 14:29:44'),(134,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【125】','2012-11-21 14:12:55','2012-11-21 14:12:55'),(135,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【126】','2012-11-21 14:33:15','2012-11-21 14:33:15'),(136,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:37:25','2012-11-21 14:37:25'),(137,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:43:09','2012-11-21 14:43:09'),(138,18,'0','16','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:43:41','2012-11-21 14:43:41'),(139,18,'0','16','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:44:03','2012-11-21 14:44:03'),(140,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 14:44:37','2012-11-21 14:44:37'),(141,18,'1','15','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 15:04:07','2012-11-27 15:04:07'),(142,18,'0','15','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 15:16:29','2012-11-27 15:16:29'),(143,18,'0','15','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 15:16:42','2012-11-27 15:16:42'),(144,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【128】','2012-12-01 15:16:11','2012-12-01 15:16:11'),(145,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:33:58','2012-12-03 13:33:58'),(146,18,'1','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:37:57','2012-12-03 13:37:57'),(147,18,'0','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:39:40','2012-12-03 13:39:40'),(148,18,'0','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:40:38','2012-12-03 13:40:38'),(149,18,'1','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 13:51:32','2012-12-03 13:51:32'),(150,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【130】','2012-12-03 14:40:21','2012-12-03 14:40:21'),(151,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:26:39','2012-12-04 14:26:39'),(152,18,'1','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:29:28','2012-12-04 14:29:28'),(153,18,'0','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:33:03','2012-12-04 14:33:03'),(154,18,'0','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:33:32','2012-12-04 14:33:32'),(155,18,'1','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 14:34:36','2012-12-04 14:34:36'),(156,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【5】','2012-12-10 14:36:56','2012-12-10 14:36:56');
/*!40000 ALTER TABLE `notice_his` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_attach`
--

DROP TABLE IF EXISTS `order_attach`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_attach` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL,
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '附件名称',
  `type` char(2) DEFAULT NULL COMMENT '0:交谈录音,1:评价,2:签约,3:模拟考试',
  `path` varchar(500) NOT NULL DEFAULT '' COMMENT '附件路径',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` char(1) NOT NULL DEFAULT '' COMMENT '0:未审批 1:通过 2:不通过',
  `commet` varchar(500) DEFAULT NULL COMMENT '审批语',
  `swfpath` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='签单附件表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_attach`
--

LOCK TABLES `order_attach` WRITE;
/*!40000 ALTER TABLE `order_attach` DISABLE KEYS */;
INSERT INTO `order_attach` VALUES (1,1,'测评报告模版.doc','4','fileupload/s1/o1/f4/测评报告模版1354631194883.doc','2012-12-04 14:26:34','2012-12-04 14:28:34','1',NULL,'fileupload/s1/o1/f4/1354631195213_swf.swf'),(2,1,'学生情况登记表.doc','2','fileupload/s1/o1/f2/学生情况登记表1354631195073.doc','2012-12-04 14:26:35','2012-12-04 14:28:34','1',NULL,'fileupload/s1/o1/f2/1354631222699_swf.swf'),(3,1,'学生情况登记表.doc','3','fileupload/s1/o1/f3/学生情况登记表1354631195229.doc','2012-12-04 14:26:35','2012-12-04 14:28:34','1',NULL,'fileupload/s1/o1/f3/1354631227155_swf.swf'),(4,1,'学初期辅导方案模版.doc','1','fileupload/s1/o1/f1/学初期辅导方案模版1354631195576.doc','2012-12-04 14:26:36','2012-12-04 14:28:34','1',NULL,'fileupload/s1/o1/f1/1354631231027_swf.swf'),(5,1,'学生情况登记表.doc','5','fileupload/s1/o1/f5/学生情况登记表1354631666000.doc','2012-12-04 14:34:26','2012-12-04 14:35:51','1',NULL,'fileupload/s1/o1/f5/1354631666131_swf.swf'),(6,4,'测评报告模版.doc','4','fileupload/s1/o1/f4/测评报告模版1354631194883.doc','2012-12-04 15:15:30','2012-12-04 15:15:30','1','','fileupload/s1/o1/f4/1354631195213_swf.swf'),(7,4,'学生情况登记表.doc','2','fileupload/s1/o1/f2/学生情况登记表1354631195073.doc','2012-12-04 15:15:30','2012-12-04 15:15:30','1','','fileupload/s1/o1/f2/1354631222699_swf.swf'),(8,4,'学生情况登记表.doc','3','fileupload/s1/o1/f3/学生情况登记表1354631195229.doc','2012-12-04 15:15:30','2012-12-04 15:15:30','1','','fileupload/s1/o1/f3/1354631227155_swf.swf'),(9,4,'学初期辅导方案模版.doc','1','fileupload/s1/o1/f1/学初期辅导方案模版1354631195576.doc','2012-12-04 15:15:30','2012-12-04 15:15:30','1','','fileupload/s1/o1/f1/1354631231027_swf.swf'),(10,4,'学生情况登记表.doc','5','fileupload/s1/o1/f5/学生情况登记表1354631666000.doc','2012-12-04 15:15:30','2012-12-04 15:15:30','1','','fileupload/s1/o1/f5/1354631666131_swf.swf'),(11,5,'学生情况登记表.doc','3','fileupload/s6/o5/f3/学生情况登记表1355150215151.doc','2012-12-10 14:36:55','2012-12-10 14:37:16','0',NULL,'fileupload/s6/o5/f3/1355150215322_swf.swf'),(12,5,'刘俊：部分电子文档.rar','4','fileupload/s6/o5/f4/刘俊：部分电子文档1355150215279.rar','2012-12-10 14:36:55','2012-12-10 14:36:55','0',NULL,NULL),(13,5,'学生情况登记表.doc','2','fileupload/s6/o5/f2/学生情况登记表1355150215441.doc','2012-12-10 14:36:55','2012-12-10 14:37:20','0',NULL,'fileupload/s6/o5/f2/1355150236735_swf.swf'),(14,5,'新建 Microsoft Word 文档.doc','1','fileupload/s6/o5/f1/新建 Microsoft Word 文档1355150215531.doc','2012-12-10 14:36:55','2012-12-10 14:37:22','0',NULL,'fileupload/s6/o5/f1/1355150240182_swf.swf');
/*!40000 ALTER TABLE `order_attach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_course`
--

DROP TABLE IF EXISTS `order_course`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_course` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `course_type` char(1) NOT NULL DEFAULT '0' COMMENT '课程类型',
  `charger_id` int(10) unsigned DEFAULT NULL COMMENT '负责人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT '0' COMMENT '0:未确认 1:确认 2:拒绝',
  `order_attach_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='签单课程负责人记录表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_course`
--

LOCK TABLES `order_course` WRITE;
/*!40000 ALTER TABLE `order_course` DISABLE KEYS */;
INSERT INTO `order_course` VALUES (1,1,'9',19,'2012-12-04 14:26:36','2012-12-04 14:35:51','1',0),(2,1,'2',21,'2012-12-04 14:26:36','2012-12-04 14:35:51','1',0),(3,1,'6',23,'2012-12-04 14:26:36','2012-12-04 14:35:51','1',0),(8,4,'2',21,'2012-12-04 15:15:30','2012-12-04 15:15:30','1',0),(9,4,'6',23,'2012-12-04 15:15:30','2012-12-04 15:15:30','1',0),(10,4,'9',19,'2012-12-04 15:15:30','2012-12-04 15:15:30','1',0),(11,5,'1',NULL,'2012-12-10 14:36:55','2012-12-10 14:36:55','0',0),(12,5,'2',NULL,'2012-12-10 14:36:55','2012-12-10 14:36:55','0',0);
/*!40000 ALTER TABLE `order_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_course_evaluation`
--

DROP TABLE IF EXISTS `order_course_evaluation`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_course_evaluation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `student_id` int(10) unsigned DEFAULT '0',
  `course_type` char(1) NOT NULL DEFAULT '0' COMMENT '课程类型',
  `charger_id` int(10) unsigned DEFAULT NULL COMMENT '负责人',
  `content` varchar(500) DEFAULT NULL COMMENT '评价',
  `order_attach_id` int(10) unsigned DEFAULT '0' COMMENT '附件',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) unsigned DEFAULT NULL,
  `course_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='课程后评价';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_course_evaluation`
--

LOCK TABLES `order_course_evaluation` WRITE;
/*!40000 ALTER TABLE `order_course_evaluation` DISABLE KEYS */;
INSERT INTO `order_course_evaluation` VALUES (1,1,1,'2',21,'不错一般',0,'2012-12-04 15:20:20','2012-12-04 15:27:19',18,'2012-12-03 16:00:00'),(2,1,1,'2',21,'有待提高',0,'2012-12-05 13:25:27','2012-12-05 14:05:39',18,'2012-12-02 16:00:00');
/*!40000 ALTER TABLE `order_course_evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_course_hour`
--

DROP TABLE IF EXISTS `order_course_hour`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_course_hour` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT '0',
  `cost_hour` int(10) unsigned DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) unsigned DEFAULT NULL,
  `teach_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='课时管理';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_course_hour`
--

LOCK TABLES `order_course_hour` WRITE;
/*!40000 ALTER TABLE `order_course_hour` DISABLE KEYS */;
INSERT INTO `order_course_hour` VALUES (1,1,1,10,'2012-12-05 13:24:20','2012-12-05 14:09:47',NULL,'2012-12-12 16:00:00'),(3,1,1,66,'2012-12-05 14:10:56','2012-12-05 14:10:56',NULL,'2012-12-05 16:00:00');
/*!40000 ALTER TABLE `order_course_hour` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_course_log`
--

DROP TABLE IF EXISTS `order_course_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_course_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `course_type` varchar(1) NOT NULL COMMENT '课程类型',
  `charger_id` int(11) DEFAULT NULL COMMENT '负责人',
  `create_time` datetime DEFAULT NULL,
  `status` varchar(1) NOT NULL COMMENT '0:未确认 1:确认 2:拒绝',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_course_log`
--

LOCK TABLES `order_course_log` WRITE;
/*!40000 ALTER TABLE `order_course_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_course_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_course_schedule`
--

DROP TABLE IF EXISTS `order_course_schedule`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_course_schedule` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `student_id` int(10) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `course_period_id` int(10) NOT NULL,
  `course_type` char(2) NOT NULL COMMENT '课程类型 对应system_param的order_course',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '0:进行中 1:已经结束',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_course_schedule`
--

LOCK TABLES `order_course_schedule` WRITE;
/*!40000 ALTER TABLE `order_course_schedule` DISABLE KEYS */;
INSERT INTO `order_course_schedule` VALUES (1,18,5,5,'2012-07-07','2012-08-08',1,'1','0','2012-07-27 14:33:37'),(2,18,5,5,'2012-10-07','2012-12-08',2,'2','0','2012-07-27 14:33:37');
/*!40000 ALTER TABLE `order_course_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_course_score`
--

DROP TABLE IF EXISTS `order_course_score`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_course_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `course_type` char(1) NOT NULL DEFAULT '0' COMMENT '课程类型',
  `charger_id` int(10) unsigned DEFAULT NULL COMMENT '负责人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `student_id` int(10) unsigned DEFAULT NULL,
  `score` int(5) unsigned DEFAULT NULL COMMENT '分数',
  `exam_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='签单课程负责人日志记录表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_course_score`
--

LOCK TABLES `order_course_score` WRITE;
/*!40000 ALTER TABLE `order_course_score` DISABLE KEYS */;
INSERT INTO `order_course_score` VALUES (4,1,'6',23,'2012-12-05 13:37:45',1,99,'2012-12-02 16:00:00','2012-12-05 13:55:50',18);
/*!40000 ALTER TABLE `order_course_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_exchange`
--

DROP TABLE IF EXISTS `order_exchange`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_exchange` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `content` varchar(1000) NOT NULL COMMENT '交流内容',
  `order_attach_id` int(10) unsigned DEFAULT NULL COMMENT '交流录音记录',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `student_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='签单客户交流表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_exchange`
--

LOCK TABLES `order_exchange` WRITE;
/*!40000 ALTER TABLE `order_exchange` DISABLE KEYS */;
INSERT INTO `order_exchange` VALUES (1,1,18,'潇洒大',NULL,'2012-12-06 13:10:42','2012-12-06 13:10:42',NULL),(2,4,18,'大大的',NULL,'2012-12-06 13:22:32','2012-12-06 13:22:32',NULL);
/*!40000 ALTER TABLE `order_exchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned NOT NULL DEFAULT '0',
  `order_type` char(2) DEFAULT NULL COMMENT '签单类型',
  `status` char(20) DEFAULT NULL COMMENT '签单审批状态',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `des` varchar(250) DEFAULT NULL,
  `order_no` varchar(100) DEFAULT NULL COMMENT '签单编号',
  `flow_ins_id` varchar(20) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `grade` varchar(10) DEFAULT NULL COMMENT '年级',
  `course_hour` int(10) unsigned DEFAULT NULL COMMENT '课时总数',
  `run_status` char(1) NOT NULL DEFAULT '0' COMMENT '签单执行状态 0:审批 1:教学中 2:结束',
  `parent_order_id` int(10) unsigned DEFAULT NULL,
  `cur_operator` int(10) unsigned DEFAULT NULL,
  `is_last` char(1) NOT NULL DEFAULT '0' COMMENT '是否被续签',
  `cost_course_hour` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='签单表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` VALUES (1,1,'0','审批通过','2012-12-04 15:15:29','2012-12-05 14:10:57',NULL,NULL,NULL,'2012-12-04 16:00:00','2012-12-24 16:00:00','2',55,'3',NULL,18,'1',55),(4,1,'1','审批通过','2012-12-04 15:15:29','2012-12-05 14:10:57',NULL,NULL,NULL,'2012-12-04 16:00:00','2012-12-24 16:00:00','2',55,'2',1,18,'0',21),(5,6,'0','销售主管审批','2012-12-10 14:36:54','2012-12-10 14:36:56',NULL,NULL,NULL,'2012-12-11 16:00:00','2012-12-18 16:00:00','2',22,'0',NULL,18,'0',NULL);
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `order_info_daily`
--

DROP TABLE IF EXISTS `order_info_daily`;
/*!50001 DROP VIEW IF EXISTS `order_info_daily`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `order_info_daily` (
  `create_date` varchar(10),
  `total` bigint(21)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `order_info_monthly`
--

DROP TABLE IF EXISTS `order_info_monthly`;
/*!50001 DROP VIEW IF EXISTS `order_info_monthly`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `order_info_monthly` (
  `month` varchar(7),
  `total` bigint(21)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `order_rel_his`
--

DROP TABLE IF EXISTS `order_rel_his`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_rel_his` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `task_name` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `chargerType` char(2) DEFAULT NULL COMMENT '参与的角色 1:销售 2: 销售主管 3:教务部主管 4:班主任 5:授课老师',
  `operator` int(10) DEFAULT NULL COMMENT '操作员',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='签单参与者历史表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_rel_his`
--

LOCK TABLES `order_rel_his` WRITE;
/*!40000 ALTER TABLE `order_rel_his` DISABLE KEYS */;
INSERT INTO `order_rel_his` VALUES (1,1,'签约','1',18,'2012-12-04 14:26:38','2012-12-04 14:26:38',1),(2,1,'销售主管审批','2',18,'2012-12-04 14:28:35','2012-12-04 14:28:35',2),(3,1,'教务部处理','3',18,'2012-12-04 14:32:58','2012-12-04 14:32:58',3),(4,1,'待班主任确认','4',18,'2012-12-04 14:33:26','2012-12-04 14:33:26',4),(5,1,'班主任处理中','4',18,'2012-12-04 14:34:26','2012-12-04 14:34:26',5),(6,1,'教务部审批','3',18,'2012-12-04 14:35:52','2012-12-04 14:35:52',6),(9,4,'续签','3',18,'2012-12-04 15:15:30','2012-12-04 15:15:30',9),(10,5,'签约','1',18,'2012-12-10 14:36:56','2012-12-10 14:36:56',1);
/*!40000 ALTER TABLE `order_rel_his` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_role`
--

DROP TABLE IF EXISTS `order_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `charger` int(10) NOT NULL COMMENT '1:销售 2: 销售主管 3:教务部主管 4:班主任 5:授课老师',
  `role_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='签单负责人配置';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_role`
--

LOCK TABLES `order_role` WRITE;
/*!40000 ALTER TABLE `order_role` DISABLE KEYS */;
INSERT INTO `order_role` VALUES (1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6);
/*!40000 ALTER TABLE `order_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_trace`
--

DROP TABLE IF EXISTS `order_trace`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_trace` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) NOT NULL,
  `task_name` varchar(50) DEFAULT NULL COMMENT '任务名称',
  `role_id` int(10) unsigned DEFAULT NULL COMMENT '安排的角色',
  `user_id` int(10) DEFAULT '0' COMMENT '安排的人员',
  `operator` int(10) unsigned DEFAULT '0' COMMENT '最后的操作员',
  `oper` char(1) DEFAULT NULL COMMENT '操作类型 0:前进，1:回退',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `oper_sort` int(3) unsigned DEFAULT NULL COMMENT '处理步骤的编号',
  `task_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='签单流程跟踪表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_trace`
--

LOCK TABLES `order_trace` WRITE;
/*!40000 ALTER TABLE `order_trace` DISABLE KEYS */;
INSERT INTO `order_trace` VALUES (1,1,'签约',1,NULL,18,'0','2012-12-04 14:26:36','2012-12-04 14:26:38',NULL,1),(2,1,'销售主管审批',2,NULL,18,'0','2012-12-04 14:26:39','2012-12-04 14:28:35',NULL,2),(3,1,'教务部处理',3,NULL,18,'0','2012-12-04 14:29:28','2012-12-04 14:32:58',NULL,3),(4,1,'待班主任确认',NULL,15,18,'0','2012-12-04 14:33:03','2012-12-04 14:33:26',NULL,4),(5,1,'班主任处理中',NULL,15,18,'0','2012-12-04 14:33:32','2012-12-04 14:34:26',NULL,5),(6,1,'教务部审批',3,NULL,18,'0','2012-12-04 14:34:36','2012-12-04 14:35:52',NULL,6),(7,1,'审批通过',NULL,NULL,NULL,NULL,'2012-12-04 14:36:26','2012-12-04 14:36:26',NULL,7),(12,4,'续签',3,NULL,18,'0','2012-12-04 15:15:29','2012-12-04 15:15:30',NULL,9),(13,4,'审批通过',NULL,NULL,NULL,NULL,'2012-12-04 15:15:30','2012-12-04 15:15:30',NULL,10),(14,5,'签约',1,NULL,18,'0','2012-12-10 14:36:55','2012-12-10 14:36:56',NULL,1),(15,5,'销售主管审批',2,NULL,NULL,NULL,'2012-12-10 14:36:56','2012-12-10 14:36:56',NULL,2);
/*!40000 ALTER TABLE `order_trace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_trace_detail`
--

DROP TABLE IF EXISTS `order_trace_detail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `order_trace_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_attach_id` int(11) NOT NULL,
  `status` varchar(1) DEFAULT NULL COMMENT '0:待审批,1:通过,2:不通过',
  `commet` text NOT NULL COMMENT '留言',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `order_trace_detail`
--

LOCK TABLES `order_trace_detail` WRITE;
/*!40000 ALTER TABLE `order_trace_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_trace_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_info`
--

DROP TABLE IF EXISTS `student_info`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `student_info` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '学生名称',
  `grade` varchar(10) DEFAULT NULL COMMENT '年级',
  `school` varchar(100) DEFAULT NULL COMMENT '学校',
  `age` varchar(3) DEFAULT NULL COMMENT '年龄',
  `brithday` varchar(10) DEFAULT NULL COMMENT '生日',
  `sex` char(1) DEFAULT NULL COMMENT '性别',
  `homephone` varchar(20) DEFAULT NULL COMMENT '家庭电话',
  `phone` varchar(20) DEFAULT NULL COMMENT '电话',
  `addr` varchar(200) DEFAULT NULL COMMENT '家庭住址',
  `father_name` varchar(20) DEFAULT NULL COMMENT '父亲姓名',
  `father_phone` varchar(20) DEFAULT NULL COMMENT '父亲电话',
  `father_unit` varchar(20) DEFAULT NULL COMMENT '父亲单位',
  `father_position` varchar(10) DEFAULT NULL COMMENT '父亲职务',
  `mother_name` varchar(20) DEFAULT NULL COMMENT '母亲姓名',
  `mother_phone` varchar(20) DEFAULT NULL COMMENT '母亲电话',
  `mother_unit` varchar(20) DEFAULT NULL COMMENT '母亲单位',
  `mother_position` varchar(10) DEFAULT NULL COMMENT '母亲职务',
  `interest` varchar(30) DEFAULT NULL COMMENT '兴趣',
  `last_exam_date` date DEFAULT NULL COMMENT '最近的测验时间',
  `score_yuwen` varchar(3) DEFAULT NULL COMMENT '语文成绩',
  `score_shuxue` varchar(3) DEFAULT NULL COMMENT '数学成绩',
  `score_yingwen` varchar(3) DEFAULT NULL COMMENT '英文成绩',
  `score_zhengzhi` varchar(3) DEFAULT NULL COMMENT '政治成绩',
  `score_wuli` varchar(3) DEFAULT NULL COMMENT '物理成绩',
  `score_huaxue` varchar(3) DEFAULT NULL COMMENT '化学成绩',
  `score_lishi` varchar(3) DEFAULT NULL COMMENT '历史成绩',
  `score_shengwu` varchar(3) DEFAULT NULL COMMENT '地理成绩',
  `selfevaluation` varchar(500) DEFAULT NULL COMMENT '自我评价',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `liketeacherstyle` varchar(200) DEFAULT NULL COMMENT '喜欢的老师类型',
  `likecoursestyle` varchar(200) DEFAULT NULL COMMENT '喜欢的课程类型',
  `livehabit` varchar(200) DEFAULT NULL COMMENT '生活习惯',
  `score_dili` varchar(10) DEFAULT NULL COMMENT '地理成绩',
  `self_assessment` text COMMENT '自我评价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='学生信息表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `student_info`
--

LOCK TABLES `student_info` WRITE;
/*!40000 ALTER TABLE `student_info` DISABLE KEYS */;
INSERT INTO `student_info` VALUES (1,'林小朋友','1','广州市第十七中','29','1983-12-14','0','2121',NULL,'赤岗','林','11','在家','煮饭','罗','22','在家2','吃饭','11','2012-10-18','11','22','33','55','22','44','66','22','33','2012-08-22 14:29:34','2012-10-20 06:21:08','44','55','22',NULL,NULL),(2,'111','1111',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-23 13:21:27','2012-06-23 13:21:27',NULL,NULL,NULL,NULL,NULL),(3,'2222333','1',NULL,'0','2012-12-10','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-24 06:07:43','2012-12-10 14:39:41',NULL,NULL,NULL,NULL,NULL),(4,'萝莉亲','2',NULL,'0','2012-07-03','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-07-08 00:59:17','2012-07-08 00:59:17',NULL,NULL,NULL,NULL,NULL),(5,'王小朋友','1',NULL,'23','1989-07-04','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-16 15:19:59','2012-12-10 14:41:20',NULL,NULL,NULL,NULL,NULL),(6,'qqq','2',NULL,'29','1983-05-26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-15 15:52:02','2012-08-15 15:52:02',NULL,NULL,NULL,NULL,NULL),(7,'黄飞','3','121221','29','1983-08-07','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-19 03:29:41','2012-08-19 03:29:41',NULL,NULL,NULL,NULL,NULL),(8,'嘿嘿嘿','4',NULL,'13','1999-11-05','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-11-10 16:15:02','2012-11-10 16:15:02',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `student_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_department`
--

DROP TABLE IF EXISTS `sys_department`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_department` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `des` varchar(250) DEFAULT NULL,
  `parentid` int(10) DEFAULT NULL COMMENT '上一层的部门构架',
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_department`
--

LOCK TABLES `sys_department` WRITE;
/*!40000 ALTER TABLE `sys_department` DISABLE KEYS */;
INSERT INTO `sys_department` VALUES (1,'教务部',NULL,0,'0','2012-08-14 14:10:09','2012-04-16 12:40:02'),(2,'销售部',NULL,0,'0','2012-08-14 14:10:10','2012-04-16 12:40:13'),(4,'科技部',NULL,NULL,'0','2012-08-16 14:35:32','2012-08-16 14:35:32');
/*!40000 ALTER TABLE `sys_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log_trace`
--

DROP TABLE IF EXISTS `sys_log_trace`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_log_trace` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `module_name` varchar(200) NOT NULL DEFAULT '' COMMENT '模块名称',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COMMENT='系统跟踪表';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_log_trace`
--

LOCK TABLES `sys_log_trace` WRITE;
/*!40000 ALTER TABLE `sys_log_trace` DISABLE KEYS */;
INSERT INTO `sys_log_trace` VALUES (1,18,'已处理任务','2012-12-10 12:28:43'),(2,18,'登陆','2012-12-10 12:38:47'),(3,18,'学生信息交流','2012-12-10 12:39:02'),(4,18,'已处理任务','2012-12-10 12:39:06'),(5,18,'登陆','2012-12-10 12:43:09'),(6,18,'学生信息交流','2012-12-10 12:44:05'),(7,18,'学生信息交流','2012-12-10 12:44:14'),(8,18,'登陆','2012-12-10 13:05:55'),(9,18,'已处理任务','2012-12-10 13:06:06'),(10,18,'登陆','2012-12-10 13:18:46'),(11,18,'权限管理','2012-12-10 13:19:56'),(12,18,'登陆','2012-12-10 13:20:23'),(13,18,'系统访问日志','2012-12-10 13:20:27'),(14,18,'系统访问日志','2012-12-10 13:21:04'),(15,18,'系统访问日志','2012-12-10 13:21:20'),(16,18,'登陆','2012-12-10 13:21:31'),(17,18,'系统访问日志','2012-12-10 13:21:38'),(18,18,'权限管理','2012-12-10 13:22:03'),(19,18,'权限管理','2012-12-10 13:22:12'),(20,18,'系统用户','2012-12-10 13:22:18'),(21,18,'全部消息历史','2012-12-10 13:22:21'),(22,18,'发送消息','2012-12-10 13:22:21'),(23,18,'已发消息','2012-12-10 13:22:22'),(24,18,'收件箱','2012-12-10 13:22:23'),(25,18,'发送消息','2012-12-10 13:29:55'),(26,18,'已发消息','2012-12-10 13:29:56'),(27,18,'发送消息','2012-12-10 13:29:58'),(28,18,'已发消息','2012-12-10 13:30:00'),(29,18,'发送消息','2012-12-10 13:30:02'),(30,18,'已发消息','2012-12-10 13:30:03'),(31,18,'发送消息','2012-12-10 13:30:05'),(32,18,'已发消息','2012-12-10 13:30:06'),(33,18,'发送消息','2012-12-10 13:30:09'),(34,18,'已发消息','2012-12-10 13:30:10'),(35,18,'发送消息','2012-12-10 13:30:17'),(36,18,'已发消息','2012-12-10 13:30:18'),(37,18,'发送消息','2012-12-10 13:30:21'),(38,18,'已发消息','2012-12-10 13:30:22'),(39,18,'发送消息','2012-12-10 13:30:25'),(40,18,'已发消息','2012-12-10 13:30:26'),(41,18,'发送消息','2012-12-10 13:30:28'),(42,18,'已发消息','2012-12-10 13:30:29'),(43,18,'发送消息','2012-12-10 13:30:31'),(44,18,'已发消息','2012-12-10 13:30:33'),(45,18,'发送消息','2012-12-10 13:30:35'),(46,18,'已发消息','2012-12-10 13:30:36'),(47,18,'发送消息','2012-12-10 13:30:49'),(48,18,'已发消息','2012-12-10 13:30:50'),(49,18,'发送消息','2012-12-10 13:30:54'),(50,18,'已发消息','2012-12-10 13:30:55'),(51,18,'发送消息','2012-12-10 13:30:57'),(52,18,'已发消息','2012-12-10 13:30:58'),(53,18,'已发消息','2012-12-10 13:31:05'),(54,18,'发送消息','2012-12-10 13:31:06'),(55,18,'已发消息','2012-12-10 13:31:08'),(56,18,'发送消息','2012-12-10 13:31:09'),(57,18,'已发消息','2012-12-10 13:31:13'),(58,18,'系统访问日志','2012-12-10 13:36:35'),(59,18,'系统访问日志','2012-12-10 13:36:58'),(60,18,'课程分数管理','2012-12-10 13:49:04'),(61,18,'课程评价管理','2012-12-10 13:49:05'),(62,18,'未处理任务','2012-12-10 14:11:38'),(63,18,'已处理任务','2012-12-10 14:11:59'),(64,18,'学生信息交流','2012-12-10 14:12:48'),(65,18,'全部消息历史','2012-12-10 14:13:10'),(66,18,'发送消息','2012-12-10 14:13:28'),(67,18,'已发消息','2012-12-10 14:13:30'),(68,18,'收件箱','2012-12-10 14:13:54'),(69,18,'客户管理','2012-12-10 14:14:00'),(70,18,'来电交流管理','2012-12-10 14:14:12'),(71,18,'来电交流管理','2012-12-10 14:14:20'),(72,18,'续单管理','2012-12-10 14:18:52'),(73,18,'续单管理','2012-12-10 14:22:57'),(74,18,'续单管理','2012-12-10 14:23:50'),(75,18,'续单管理','2012-12-10 14:24:32'),(76,18,'签单信息查询','2012-12-10 14:28:28'),(77,18,'签单信息查询','2012-12-10 14:28:49'),(78,18,'学生信息管理','2012-12-10 14:29:09'),(79,18,'学生信息管理','2012-12-10 14:30:36'),(80,18,'学生信息管理','2012-12-10 14:31:13'),(81,18,'权限管理','2012-12-10 14:34:59'),(82,18,'登陆','2012-12-10 14:36:10'),(83,18,'新签单登记','2012-12-10 14:36:20'),(84,18,'签单日统计','2012-12-10 14:37:08'),(85,18,'登陆','2012-12-10 14:37:30'),(86,18,'学生信息管理','2012-12-10 14:37:55'),(87,18,'学生信息管理','2012-12-10 14:37:59'),(88,18,'学生信息管理','2012-12-10 14:38:10'),(89,18,'学生信息管理','2012-12-10 14:39:31'),(90,18,'学生信息管理','2012-12-10 14:39:32'),(91,18,'学生信息管理','2012-12-10 14:40:59'),(92,18,'登陆','2012-12-10 14:42:04'),(93,18,'登陆','2012-12-10 14:46:12'),(94,18,'登陆','2012-12-10 14:46:54'),(95,18,'登陆','2012-12-10 14:49:54'),(96,18,'登陆','2012-12-10 14:50:38'),(97,18,'登陆','2012-12-10 14:51:50'),(98,18,'登陆','2012-12-10 14:52:52'),(99,18,'登陆','2012-12-10 14:58:19'),(100,18,'登陆','2012-12-10 14:59:10'),(101,18,'登陆','2012-12-10 14:59:38'),(102,18,'登陆','2012-12-12 13:37:58'),(103,18,'课程评价管理','2012-12-12 13:39:01'),(104,18,'课时管理','2012-12-12 13:40:23'),(105,18,'课程分数管理','2012-12-12 13:40:36'),(106,18,'课程分数管理','2012-12-12 13:44:54'),(107,18,'课程评价管理','2012-12-12 13:45:00'),(108,18,'课程评价管理','2012-12-12 13:47:03'),(109,18,'课程评价管理','2012-12-12 13:49:14'),(110,18,'课程评价管理','2012-12-12 13:49:26'),(111,18,'登陆','2012-12-12 13:49:35'),(112,18,'课程评价管理','2012-12-12 13:49:44'),(113,18,'课程评价管理','2012-12-12 13:52:37'),(114,18,'课程评价管理','2012-12-12 13:56:41'),(115,18,'课程分数管理','2012-12-12 13:57:40'),(116,18,'课程分数管理','2012-12-12 13:59:44'),(117,18,'课程分数管理','2012-12-12 14:00:12'),(118,18,'课时管理','2012-12-12 14:01:00'),(119,18,'课时管理','2012-12-12 14:02:56'),(120,18,'登陆','2012-12-12 14:03:55'),(121,18,'已处理任务','2012-12-12 14:17:18'),(122,18,'登陆','2012-12-12 14:18:23'),(123,18,'登陆','2012-12-12 14:20:13'),(124,18,'登陆','2012-12-12 14:21:19'),(125,18,'登陆','2012-12-12 14:25:33'),(126,18,'登陆','2012-12-12 14:26:06'),(127,18,'登陆','2012-12-12 14:26:37'),(128,18,'登陆','2012-12-12 14:27:12'),(129,18,'登陆','2012-12-12 14:28:31'),(130,18,'登陆','2012-12-12 14:29:17'),(131,18,'登陆','2012-12-12 14:29:38'),(132,18,'登陆','2012-12-12 14:30:14'),(133,18,'登陆','2012-12-12 14:30:42'),(134,18,'登陆','2012-12-12 14:33:44'),(135,18,'收件箱','2012-12-12 14:35:25'),(136,18,'登陆','2012-12-12 14:40:43'),(137,18,'登陆','2012-12-12 14:42:15'),(138,18,'登陆','2012-12-12 14:42:46'),(139,18,'登陆','2012-12-12 14:43:49'),(140,18,'收件箱','2012-12-12 14:45:19');
/*!40000 ALTER TABLE `sys_log_trace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_menu` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `level` char(1) NOT NULL,
  `parentid` int(10) NOT NULL,
  `iseff` char(1) NOT NULL DEFAULT '0' COMMENT '0:有效,1:无效',
  `isleaf` char(1) NOT NULL COMMENT '是否也是 0:不是, 1:是',
  `des` varchar(100) DEFAULT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `icon` varchar(100) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统设置',NULL,'1',0,'0','0',NULL,'2012-08-10 12:58:37','2012-04-14 16:17:59',NULL,0),(2,'学生管理','','1',0,'0','0','','2012-03-19 12:52:03','2012-02-25 04:35:48','',2),(4,'登陆','/frame/main/main.jsp','1',0,'1','1',NULL,'2012-12-10 12:33:13','2012-11-28 15:26:15',NULL,NULL),(5,'静态参数','','2',1,'0','0','','2012-02-25 04:35:48','2012-02-25 04:35:48','',2),(6,'权限管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-04-15 06:26:15','2012-04-15 06:26:15',NULL,3),(10,'系统用户','/page/system/user/user.jsp','2',1,'0','1',NULL,'2012-03-19 13:35:10','2012-03-02 17:18:21',NULL,NULL),(12,'学生信息管理','/page/student/infomrg/infomrg.jsp','2',2,'0','1',NULL,'2012-03-26 15:01:44','2012-03-06 11:47:18',NULL,NULL),(15,'教师管理',NULL,'1',0,'0','0',NULL,'2012-07-23 14:17:48','2012-04-14 16:18:32',NULL,2),(16,'签单管理',NULL,'1',0,'0','0',NULL,'2012-06-15 16:31:44','2012-04-14 16:18:17',NULL,1),(17,'新签单登记','/page/contract/register/register.jsp','2',16,'0','1',NULL,'2012-06-15 16:31:44','2012-03-06 11:47:18',NULL,NULL),(18,'签单流程管理','/page/contract/mrg/info.jsp','2',16,'0','1',NULL,'2012-06-25 12:21:42','2012-03-06 11:47:18',NULL,NULL),(23,'学生沟通记录','/page/student/exchange/infomrg.jsp','2',2,'0','1',NULL,'2012-07-22 14:24:36','2012-03-06 11:47:18',NULL,NULL),(37,'角色管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-03-06 11:47:18','2012-03-06 11:47:18',NULL,NULL),(38,'菜单管理','/page/system/menu/menu.jsp','2',1,'0','1',NULL,'2012-03-06 11:47:18','2012-03-06 11:47:18',NULL,NULL),(39,'部门管理','/page/system/department/dep.jsp','2',1,'0','1',NULL,'2012-04-16 12:37:51','2012-04-16 12:37:51',NULL,4),(40,'test',NULL,'2',1,'0','0',NULL,'2012-11-25 11:08:05','2012-04-17 14:30:26',NULL,5),(41,'文件操作','/demo/file/form.jsp','3',40,'0','1',NULL,'2012-04-17 14:31:12','2012-04-17 14:31:12',NULL,0),(42,'学生信息登记','/page/student/register/register.jsp','3',2,'0','1',NULL,'2012-04-17 14:31:12','2012-04-17 14:31:12',NULL,NULL),(43,'签单信息查询','/page/contract/info/info.jsp','3',16,'0','1',NULL,'2012-04-17 14:31:12','2012-04-17 14:31:12',NULL,NULL),(44,'个人信息管理','','1',0,'0','0',NULL,'2012-07-11 12:00:56','2012-04-17 14:31:12',NULL,NULL),(45,'未处理任务','/page/personal/task/info.jsp','2',44,'0','1',NULL,'2012-04-17 14:31:12','2012-04-17 14:31:12',NULL,NULL),(46,'已处理任务','/page/personal/taskhis/info.jsp','2',44,'0','1',NULL,'2012-07-11 12:01:21','2012-04-17 14:31:12',NULL,NULL),(47,'学生信息交流','/page/personal/exchange/info.jsp','2',44,'0','1',NULL,'2012-07-11 12:01:21','2012-07-11 12:01:21',NULL,NULL),(48,'教师信息管理','/page/teacher/info/info.jsp','2',15,'0','1',NULL,'2012-08-02 12:40:49','2012-07-11 12:01:21',NULL,NULL),(51,'统计查询',NULL,'1',0,'0','0',NULL,'2012-07-11 12:01:21','2012-07-11 12:01:21',NULL,NULL),(52,'签单统计',NULL,'2',51,'0','0',NULL,'2012-07-11 12:01:21','2012-07-11 12:01:21',NULL,NULL),(53,'签单日统计','/jasperreports/query/OrderCountDaily.jsp','3',52,'0','1',NULL,'2012-07-11 12:01:21','2012-07-11 12:01:21',NULL,NULL),(54,'消息管理',NULL,'1',0,'0','0',NULL,'2012-07-11 12:01:21','2012-07-11 12:01:21',NULL,NULL),(55,'全部消息历史','/page/notice/allhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 14:20:00','2012-07-11 12:01:21',NULL,NULL),(56,'发送消息','/page/notice/edit/edit.jsp','2',54,'0','1',NULL,'2012-12-06 14:20:00','2012-08-12 14:41:53',NULL,NULL),(57,'已发消息','/page/notice/personalhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 14:20:00','2012-08-12 14:41:53',NULL,NULL),(58,'收件箱','/page/notice/personalhis/noreadinfo.jsp','2',54,'0','1',NULL,'2012-12-06 14:20:00','2012-08-16 15:32:07',NULL,NULL),(59,'市场管理',NULL,'1',0,'0','0',NULL,'2012-08-16 15:45:07','2012-08-16 15:32:07',NULL,NULL),(60,'客户管理','/page/market/customer/info/info.jsp','2',59,'0','1',NULL,'2012-12-06 14:20:00','2012-08-16 15:45:07',NULL,NULL),(61,'来电交流管理','/page/market/customer/exchange/info.jsp','2',59,'0','1',NULL,'2012-12-06 14:20:00','2012-08-16 15:45:07',NULL,NULL),(62,'课程管理',NULL,'1',0,'0','0',NULL,'2012-08-16 15:45:07','2012-08-16 15:45:07',NULL,NULL),(63,'课程分数管理','/page/course/score/info.jsp','2',62,'0','1',NULL,'2012-08-16 15:45:07','2012-08-16 15:45:07',NULL,NULL),(64,'课程评价管理','/page/course/evaluation/info.jsp','2',62,'0','1',NULL,'2012-08-16 15:45:07','2012-08-16 15:45:07',NULL,NULL),(65,'课时管理','/page/course/hour/info.jsp','2',62,'0','1',NULL,'2012-09-12 14:02:37','2012-08-16 15:45:07',NULL,NULL),(66,'授课老师关联学生','/page/teacher/refstudent/info.jsp','2',15,'0','1',NULL,'2012-12-06 14:23:00','2012-09-12 14:02:37',NULL,NULL),(67,'续单管理','/page/contract/last/info.jsp','2',16,'0','1',NULL,'2012-10-25 14:00:34','2012-09-12 14:02:37',NULL,NULL),(68,'我的学生','/page/teacher/refstudent/info.jsp?isLoginOper=true','2',15,'0','1',NULL,'2012-10-25 14:00:34','2012-10-25 14:00:34',NULL,NULL),(69,'教师信息查询','/page/teacher/info/info.jsp?isOnlyQuery=true','2',15,'0','1',NULL,'2012-11-12 14:31:59','2012-10-25 14:00:34',NULL,NULL),(70,'角色树','/page/system/role/roletree.jsp','2',40,'0','1',NULL,'2012-11-12 14:31:59','2012-11-12 14:31:59',NULL,NULL),(71,'签单月统计','/jasperreports/query/OrderCountMonthly.jsp','3',52,'0','1',NULL,'2012-11-28 15:28:26','2012-11-12 14:31:59',NULL,NULL),(72,'饼图','/demo/chart/chart.jsp','3',40,'0','1',NULL,'2012-11-28 15:26:15','2012-11-28 15:26:15',NULL,NULL),(73,'来电交流查询','/page/market/customer/exchange/info.jsp?isOnlyQuery=true','2',59,'0','1',NULL,'2012-11-28 15:26:15','2012-11-28 15:26:15',NULL,NULL),(74,'系统访问日志','/page/system/trace/trace.jsp','2',1,'0','1',NULL,'2012-11-28 15:26:15','2012-11-28 15:26:15',NULL,NULL),(75,'学生信息查询','/page/student/infomrg/infomrg.jsp?isOnlyQuery=true','2',2,'0','1',NULL,'2012-12-10 14:34:48','2012-11-28 15:26:15',NULL,NULL);
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_param`
--

DROP TABLE IF EXISTS `sys_param`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_param` (
  `param_code` varchar(50) NOT NULL,
  `param_name` varchar(50) NOT NULL,
  `param_value` varchar(50) DEFAULT NULL,
  `root_code` varchar(50) DEFAULT NULL,
  `des` varchar(250) DEFAULT NULL,
  `seq` varchar(10) DEFAULT NULL,
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`param_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_param`
--

LOCK TABLES `sys_param` WRITE;
/*!40000 ALTER TABLE `sys_param` DISABLE KEYS */;
INSERT INTO `sys_param` VALUES ('ACCEPT','确认','0','TASK_OPER',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('APPLY_STATUS','审批结果',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ATTACH_TYPE_A','初期辅导方案','1','ATTACH_TYPE',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ATTACH_TYPE_B','华实模拟协议','2','ATTACH_TYPE',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ATTACH_TYPE_C','全方位测评报告','3','ATTACH_TYPE',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ATTACH_TYPE_D','教学安排表','4','ATTACH_TYPE',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ATTACH_TYPE_F','教学方案','5','ATTACH_TYPE',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('CONTRACT_STATUS','签单状态',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_DILI','地理','9','ORDER_COURSE',NULL,'9','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_HUAXUE','化学','5','ORDER_COURSE',NULL,'5','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_LISHI','历史','8','ORDER_COURSE',NULL,'8','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_SHENGWU','生物','7','ORDER_COURSE',NULL,'7','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_SHUXUE','数学','2','ORDER_COURSE',NULL,'2','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_WULI','物理','4','ORDER_COURSE',NULL,'4','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_YINGWEN','英文','3','ORDER_COURSE',NULL,'3','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_YUWEN','语文','1','ORDER_COURSE',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('COURSE_ZHENGZHI','政治','6','ORDER_COURSE',NULL,'6','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('CUSTOMER_STATUS','客户当前状态',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('CUSTOMER_STATUS_A','去电','0','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('CUSTOMER_STATUS_B','未上门','1','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('CUSTOMER_STATUS_C','已上门','2','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('EDUADMIN_CONFIRM','教务部审批','5','CONTRACT_STATUS',NULL,'5','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('EDUADMIN_DISPATCH','教务部分配班主任','2','CONTRACT_STATUS',NULL,'2','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('EFFECTIVE','有效','0','ISEFF',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('GRADE','年级',NULL,NULL,NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('HIGH_FIVE','高中二年级','11','GRADE',NULL,'11','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('HIGH_FOUR','高中一年级','10','GRADE',NULL,'10','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('HIGH_ONE','初中一年级','7','GRADE',NULL,'7','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('HIGH_SIX','高中三年级','12','GRADE',NULL,'12','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('HIGH_THREE','初中三年级','9','GRADE',NULL,'9','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('HIGH_TWO','初中二年级','8','GRADE',NULL,'8','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('INEFFECTIVE','无效','1','ISEFF',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ISEFF','是否有效',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('JUNIOR_FIVE',' 小学五年级','5','GRADE',NULL,'5','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('JUNIOR_FOUR',' 小学四年级','4','GRADE',NULL,'4','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('JUNIOR_ONE',' 小学一年级','1','GRADE',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('JUNIOR_SIX',' 小学六年级','6','GRADE',NULL,'6','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('JUNIOR_THREE',' 小学三年级','3','GRADE',NULL,'3','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('JUNIOR_TWO',' 小学二年级','2','GRADE',NULL,'2','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('LAERNING','授课中','7','CONTRACT_STATUS',NULL,'7','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('MAINTEACHER_CONFIRM','待班主任确认','3','CONTRACT_STATUS',NULL,'3','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('MAINTEACHER_HANDLE','班主任处理中','4','CONTRACT_STATUS',NULL,'4','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('MAN','男','0','SEXTYPE',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('MARKETEXECUTIVE_HANDLE','销售主管审批','1','CONTRACT_STATUS',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('NEW','新签单','0','CONTRACT_STATUS',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('NO','否','0','YESORNO',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('NOTICER_DEPARTMENT','部门','2','NOTICER_TYPE',NULL,'2','0','2012-08-12 14:28:19','2012-08-12 14:28:19'),('NOTICER_PERSONAL','个人','0','NOTICER_TYPE',NULL,'0','0','2012-08-12 14:28:19','2012-08-12 14:28:19'),('NOTICER_TYPE','消息者类型',NULL,NULL,NULL,NULL,'0','2012-08-12 14:28:19','0000-00-00 00:00:00'),('NOTICE_NOREAD','未读','0','NOTICE_STATUS',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('NOTICE_READ','已读','1','NOTICE_STATUS',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('NOTICE_STATUS','公告状态',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('NOTPASS','不通过','2','APPLY_STATUS',NULL,'2','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ORDER_COURSE','签单课程',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ORDER_RUN_STATUS_A','审批中','0','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ORDER_RUN_STATUS_B','未开始','1','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ORDER_RUN_STATUS_C','授课中','2','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('ORDER_RUN_STATUS_D','结束','3','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('OVER','结束','8','CONTRACT_STATUS',NULL,'8','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('PASS','通过','1','APPLY_STATUS',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('POSITION','职位',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('REJECT','拒绝','1','TASK_OPER',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('RESIDENT_TYPE','户口类型',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('RESIDENT_TYPE_A','非农业户口','0','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('RESIDENT_TYPE_B','农业户口','1','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('RESIDENT_TYPE_C','居民户口','2','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('SELLER','销售','0','POSITION',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('SEXTYPE','性别',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('STUDENT_TYPE','学生类型',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('STUDENT_TYPE_A','普通借读生','0','STUDENT_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('STUDENT_TYPE_B','正式生','1','STUDENT_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('TEACHER','教师','1','POSITION',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('TEACHER_CONFIRM','待授课老师确认','6','CONTRACT_STATUS',NULL,'6','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('VISIT_SOURCE_TYPE','访问来源',NULL,NULL,NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('VISIT_SOURCE_TYPE_A','来电','0','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('VISIT_SOURCE_TYPE_B','短信','1','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('VISIT_SOURCE_TYPE_C','老资料回访','2','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('WAIT','待审批','0','APPLY_STATUS',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('WOMAN','女','1','SEXTYPE',NULL,'1','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('YES','是','1','YESORNO',NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21'),('YESORNO','是与否',NULL,NULL,NULL,'0','0','2012-03-13 12:50:21','2012-03-13 12:50:21');
/*!40000 ALTER TABLE `sys_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_right_rel`
--

DROP TABLE IF EXISTS `sys_right_rel`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_right_rel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL COMMENT '关系类型 0:用户 1：角色 2：部门',
  `rel_id` varchar(250) DEFAULT NULL COMMENT '关联对象',
  `menu_id` int(10) unsigned DEFAULT NULL COMMENT '菜单ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1045 DEFAULT CHARSET=utf8 COMMENT='权限菜单关联';
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_right_rel`
--

LOCK TABLES `sys_right_rel` WRITE;
/*!40000 ALTER TABLE `sys_right_rel` DISABLE KEYS */;
INSERT INTO `sys_right_rel` VALUES (20,'0','17',40,'2012-08-14 13:46:12','2012-08-14 13:46:12'),(21,'0','17',41,'2012-08-14 13:46:12','2012-08-14 13:46:12'),(166,'1','4',2,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(167,'1','4',12,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(168,'1','4',23,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(169,'1','4',15,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(170,'1','4',48,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(171,'1','4',16,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(172,'1','4',43,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(173,'1','4',44,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(174,'1','4',45,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(175,'1','4',46,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(176,'1','4',47,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(177,'1','4',51,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(178,'1','4',52,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(179,'1','4',53,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(180,'1','4',54,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(181,'1','4',56,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(182,'1','4',57,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(183,'1','4',58,'2012-08-16 15:46:35','2012-08-16 15:46:35'),(262,'1','2',2,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(263,'1','2',12,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(264,'1','2',23,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(265,'1','2',42,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(266,'1','2',15,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(267,'1','2',48,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(268,'1','2',16,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(269,'1','2',17,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(270,'1','2',43,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(271,'1','2',44,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(272,'1','2',45,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(273,'1','2',46,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(274,'1','2',47,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(275,'1','2',54,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(276,'1','2',56,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(277,'1','2',57,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(278,'1','2',58,'2012-08-18 12:17:27','2012-08-18 12:17:27'),(279,'1','3',2,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(280,'1','3',12,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(281,'1','3',23,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(282,'1','3',15,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(283,'1','3',48,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(284,'1','3',16,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(285,'1','3',43,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(286,'1','3',44,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(287,'1','3',45,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(288,'1','3',46,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(289,'1','3',47,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(290,'1','3',51,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(291,'1','3',52,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(292,'1','3',53,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(293,'1','3',54,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(294,'1','3',56,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(295,'1','3',57,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(296,'1','3',58,'2012-08-18 12:17:36','2012-08-18 12:17:36'),(406,'1','5',2,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(407,'1','5',12,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(408,'1','5',23,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(409,'1','5',42,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(410,'1','5',15,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(411,'1','5',48,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(412,'1','5',16,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(413,'1','5',43,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(414,'1','5',44,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(415,'1','5',45,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(416,'1','5',46,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(417,'1','5',47,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(418,'1','5',51,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(419,'1','5',52,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(420,'1','5',53,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(421,'1','5',54,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(422,'1','5',56,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(423,'1','5',57,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(424,'1','5',58,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(425,'1','5',62,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(426,'1','5',63,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(427,'1','5',64,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(428,'1','5',65,'2012-09-12 14:04:10','2012-09-12 14:04:10'),(524,'1','6',2,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(525,'1','6',12,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(526,'1','6',23,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(527,'1','6',15,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(528,'1','6',68,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(529,'1','6',44,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(530,'1','6',45,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(531,'1','6',46,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(532,'1','6',47,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(533,'1','6',54,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(534,'1','6',56,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(535,'1','6',57,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(536,'1','6',58,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(537,'1','6',62,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(538,'1','6',63,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(539,'1','6',64,'2012-11-08 12:34:38','2012-11-08 12:34:38'),(540,'1','5',2,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(541,'1','5',12,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(542,'1','5',23,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(543,'1','5',42,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(544,'1','5',15,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(545,'1','5',48,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(546,'1','5',68,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(547,'1','5',16,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(548,'1','5',43,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(549,'1','5',67,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(550,'1','5',44,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(551,'1','5',45,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(552,'1','5',46,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(553,'1','5',47,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(554,'1','5',51,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(555,'1','5',52,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(556,'1','5',53,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(557,'1','5',54,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(558,'1','5',56,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(559,'1','5',57,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(560,'1','5',58,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(561,'1','5',62,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(562,'1','5',63,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(563,'1','5',64,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(564,'1','5',65,'2012-11-10 16:34:17','2012-11-10 16:34:17'),(565,'1','4',2,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(566,'1','4',12,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(567,'1','4',23,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(568,'1','4',15,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(569,'1','4',48,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(570,'1','4',68,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(571,'1','4',16,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(572,'1','4',43,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(573,'1','4',67,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(574,'1','4',44,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(575,'1','4',45,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(576,'1','4',46,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(577,'1','4',47,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(578,'1','4',51,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(579,'1','4',52,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(580,'1','4',53,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(581,'1','4',54,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(582,'1','4',56,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(583,'1','4',57,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(584,'1','4',58,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(585,'1','4',62,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(586,'1','4',63,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(587,'1','4',64,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(588,'1','4',65,'2012-11-10 16:34:42','2012-11-10 16:34:42'),(589,'1','2',2,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(590,'1','2',12,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(591,'1','2',23,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(592,'1','2',42,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(593,'1','2',15,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(594,'1','2',48,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(595,'1','2',16,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(596,'1','2',17,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(597,'1','2',43,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(598,'1','2',44,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(599,'1','2',45,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(600,'1','2',46,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(601,'1','2',47,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(602,'1','2',54,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(603,'1','2',56,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(604,'1','2',57,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(605,'1','2',58,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(606,'1','2',59,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(607,'1','2',60,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(608,'1','2',61,'2012-11-10 16:35:22','2012-11-10 16:35:22'),(609,'1','2',2,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(610,'1','2',12,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(611,'1','2',23,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(612,'1','2',42,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(613,'1','2',16,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(614,'1','2',17,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(615,'1','2',43,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(616,'1','2',44,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(617,'1','2',45,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(618,'1','2',46,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(619,'1','2',47,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(620,'1','2',54,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(621,'1','2',56,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(622,'1','2',57,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(623,'1','2',58,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(624,'1','2',59,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(625,'1','2',60,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(626,'1','2',61,'2012-11-10 16:35:27','2012-11-10 16:35:27'),(669,'1','2',2,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(670,'1','2',12,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(671,'1','2',23,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(672,'1','2',42,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(673,'1','2',15,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(674,'1','2',66,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(675,'1','2',69,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(676,'1','2',16,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(677,'1','2',17,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(678,'1','2',43,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(679,'1','2',44,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(680,'1','2',45,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(681,'1','2',46,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(682,'1','2',47,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(683,'1','2',54,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(684,'1','2',56,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(685,'1','2',57,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(686,'1','2',58,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(687,'1','2',59,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(688,'1','2',60,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(689,'1','2',61,'2012-11-12 14:47:23','2012-11-12 14:47:23'),(690,'1','2',2,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(691,'1','2',12,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(692,'1','2',23,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(693,'1','2',42,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(694,'1','2',15,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(695,'1','2',66,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(696,'1','2',68,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(697,'1','2',69,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(698,'1','2',16,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(699,'1','2',17,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(700,'1','2',43,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(701,'1','2',44,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(702,'1','2',45,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(703,'1','2',46,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(704,'1','2',47,'2012-11-12 14:47:28','2012-11-12 14:47:28'),(705,'1','2',54,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(706,'1','2',56,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(707,'1','2',57,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(708,'1','2',58,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(709,'1','2',59,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(710,'1','2',60,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(711,'1','2',61,'2012-11-12 14:47:29','2012-11-12 14:47:29'),(712,'1','2',2,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(713,'1','2',12,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(714,'1','2',23,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(715,'1','2',42,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(716,'1','2',15,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(717,'1','2',66,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(718,'1','2',69,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(719,'1','2',16,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(720,'1','2',17,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(721,'1','2',43,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(722,'1','2',44,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(723,'1','2',45,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(724,'1','2',46,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(725,'1','2',47,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(726,'1','2',54,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(727,'1','2',56,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(728,'1','2',57,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(729,'1','2',58,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(730,'1','2',59,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(731,'1','2',60,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(732,'1','2',61,'2012-11-12 14:47:34','2012-11-12 14:47:34'),(733,'1','3',2,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(734,'1','3',12,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(735,'1','3',23,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(736,'1','3',15,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(737,'1','3',69,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(738,'1','3',16,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(739,'1','3',43,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(740,'1','3',44,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(741,'1','3',45,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(742,'1','3',46,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(743,'1','3',47,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(744,'1','3',51,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(745,'1','3',52,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(746,'1','3',53,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(747,'1','3',54,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(748,'1','3',56,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(749,'1','3',57,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(750,'1','3',58,'2012-11-12 14:48:07','2012-11-12 14:48:07'),(751,'1','3',2,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(752,'1','3',12,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(753,'1','3',23,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(754,'1','3',15,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(755,'1','3',69,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(756,'1','3',16,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(757,'1','3',43,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(758,'1','3',44,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(759,'1','3',45,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(760,'1','3',46,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(761,'1','3',47,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(762,'1','3',51,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(763,'1','3',52,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(764,'1','3',53,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(765,'1','3',54,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(766,'1','3',56,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(767,'1','3',57,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(768,'1','3',58,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(769,'1','3',59,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(770,'1','3',60,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(771,'1','3',61,'2012-11-12 14:48:14','2012-11-12 14:48:14'),(997,'1','1',1,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(998,'1','1',5,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(999,'1','1',6,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1000,'1','1',10,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1001,'1','1',37,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1002,'1','1',38,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1003,'1','1',39,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1004,'1','1',40,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1005,'1','1',41,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1006,'1','1',70,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1007,'1','1',72,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1008,'1','1',74,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1009,'1','1',2,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1010,'1','1',12,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1011,'1','1',23,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1012,'1','1',42,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1013,'1','1',75,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1014,'1','1',15,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1015,'1','1',48,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1016,'1','1',66,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1017,'1','1',68,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1018,'1','1',69,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1019,'1','1',16,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1020,'1','1',17,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1021,'1','1',18,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1022,'1','1',43,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1023,'1','1',67,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1024,'1','1',44,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1025,'1','1',45,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1026,'1','1',46,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1027,'1','1',47,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1028,'1','1',51,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1029,'1','1',52,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1030,'1','1',53,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1031,'1','1',71,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1032,'1','1',54,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1033,'1','1',55,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1034,'1','1',56,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1035,'1','1',57,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1036,'1','1',58,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1037,'1','1',59,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1038,'1','1',60,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1039,'1','1',61,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1040,'1','1',73,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1041,'1','1',62,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1042,'1','1',63,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1043,'1','1',64,'2012-12-10 14:35:12','2012-12-10 14:35:12'),(1044,'1','1',65,'2012-12-10 14:35:12','2012-12-10 14:35:12');
/*!40000 ALTER TABLE `sys_right_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','0','2012-04-10 14:35:50','2012-04-10 14:35:50'),(2,'销售','0','2012-04-24 14:06:08','2012-04-24 14:06:09'),(3,'销售主管','0','2012-06-19 16:03:32','2012-06-19 16:03:32'),(4,'教务部主管','0','2012-04-24 14:06:09','2012-04-24 14:06:09'),(5,'班主任','0','2012-04-24 14:06:09','2012-04-24 14:06:09'),(6,'授课老师','0','2012-04-24 14:06:09','2012-04-24 14:06:09');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `dep_id` int(10) unsigned DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `sex` char(1) DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `iseff` char(1) DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `role_id` int(10) unsigned DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (5,'销售主管一号',2,'1','0',NULL,'212112','111','55','0','2012-08-18 10:36:06','2012-08-16 14:41:18',3,NULL),(7,'销售主管二号',2,'1','1',NULL,'13826031714','guangzhou','33','0','2012-08-18 10:36:06','2012-08-16 14:41:26',3,NULL),(10,'销售一号',2,'1',NULL,NULL,'212112','111','1@ye.com','0','2012-08-16 14:41:05','2012-08-16 14:41:05',2,NULL),(13,'销售二号',2,'1','1',NULL,'1','1','1','0','2012-08-16 14:39:24','2012-08-16 14:39:24',2,NULL),(14,'教务部主管一号',1,'1','1',NULL,'1','1','31','0','2012-11-25 11:30:06','2012-08-16 14:38:57',5,NULL),(15,'教务部主管二号',1,'1','0',NULL,'1','1','5135','0','2012-08-16 14:40:54','2012-08-16 14:40:54',4,NULL),(16,'班主任一号',1,'1','0',NULL,'11','11','11','0','2012-11-25 11:30:06','2012-08-16 14:40:23',5,NULL),(17,'班主任二号',1,'1','1',NULL,'1','11','1','0','2012-11-25 11:30:06','2012-08-16 14:42:09',5,NULL),(18,'国产007',1,'1','0',NULL,'22','111','22','0','2012-08-18 10:36:06','2012-07-28 12:59:50',1,''),(19,'王老师(授课)',1,'111111',NULL,NULL,'1','1','1','0','2012-11-25 11:19:43','2012-10-20 06:24:16',6,'1'),(20,'谢老师（授课）',1,'1',NULL,NULL,'1','111','1','0','2012-11-25 11:19:43','2012-08-16 14:47:40',6,'1'),(21,'林老师（授课）',1,'1',NULL,NULL,'1','1','1','0','2012-08-18 10:36:06','2012-08-16 14:48:03',6,'1'),(22,'陈老师（授课）',1,'111111','0',NULL,'138','111','2@163.com','0','2012-10-22 14:44:46','2012-10-22 14:44:46',6,'2@163.com'),(23,'Kelly',1,'111111','1',NULL,'1','1','1','0','2012-11-10 16:30:48','2012-11-22 12:31:20',6,'1');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_ability`
--

DROP TABLE IF EXISTS `teacher_ability`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `teacher_ability` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(50) NOT NULL,
  `course_type` varchar(50) NOT NULL COMMENT '课程类型 对应system_param的order_course',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grade_type` varchar(45) NOT NULL DEFAULT '' COMMENT '可教学的年级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `teacher_ability`
--

LOCK TABLES `teacher_ability` WRITE;
/*!40000 ALTER TABLE `teacher_ability` DISABLE KEYS */;
INSERT INTO `teacher_ability` VALUES (4,19,'2,3','2012-08-16 14:45:00','2,3'),(5,20,'1,5','2012-08-16 14:47:40','2'),(6,21,'1,5','2012-08-16 14:48:03','9'),(7,22,'2,6,7','2012-10-22 14:44:46','1,5,6,10'),(8,23,'1,2,3','2012-11-10 16:18:05','1,5'),(9,24,'1,5','2012-11-10 16:21:58','1'),(10,25,'1,5','2012-11-10 16:23:57','1,5');
/*!40000 ALTER TABLE `teacher_ability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `teacher_info`
--

DROP TABLE IF EXISTS `teacher_info`;
/*!50001 DROP VIEW IF EXISTS `teacher_info`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `teacher_info` (
  `id` int(10),
  `user_name` varchar(50),
  `dep_id` int(10) unsigned,
  `password` varchar(50),
  `sex` char(1),
  `position` varchar(10),
  `phone` varchar(100),
  `addr` varchar(200),
  `zipcode` varchar(10),
  `iseff` char(1),
  `create_time` timestamp,
  `last_update` timestamp,
  `role_id` int(10) unsigned,
  `email` varchar(100),
  `course_type` varchar(50),
  `grade_type` varchar(45)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `teacher_ref_student`
--

DROP TABLE IF EXISTS `teacher_ref_student`;
/*!50001 DROP VIEW IF EXISTS `teacher_ref_student`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `teacher_ref_student` (
  `id` bigint(10) unsigned,
  `teacher_id` int(10) unsigned,
  `student_id` int(10) unsigned,
  `course_type` char(1),
  `run_status` char(1),
  `name` varchar(50),
  `grade` varchar(10),
  `sex` char(1),
  `age` varchar(3)
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'crmdb'
--

--
-- Final view structure for view `customer_exchange_view`
--

/*!50001 DROP TABLE `customer_exchange_view`*/;
/*!50001 DROP VIEW IF EXISTS `customer_exchange_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `customer_exchange_view` AS select `c`.`id` AS `id`,`c`.`customer_id` AS `customer_id`,`c`.`cust_status` AS `cust_status`,`c`.`source_type` AS `source_type`,`c`.`is_book` AS `is_book`,`c`.`user_id` AS `user_id`,`c`.`content` AS `content`,`c`.`customer_attach_id` AS `customer_attach_id`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`c`.`book_time` AS `book_time`,`i`.`name` AS `name`,`i`.`sex` AS `sex`,`i`.`school` AS `school`,`i`.`classes` AS `classes`,`i`.`brithday` AS `brithday`,`i`.`age` AS `age`,`i`.`student_type` AS `student_type`,`i`.`resident_type` AS `resident_type`,`i`.`parent_name` AS `parent_name`,`i`.`phone` AS `phone`,`i`.`addr` AS `addr` from (`customer_exchange` `c` left join `customer_info` `i` on((`c`.`customer_id` = `i`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `order_info_daily`
--

/*!50001 DROP TABLE `order_info_daily`*/;
/*!50001 DROP VIEW IF EXISTS `order_info_daily`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_info_daily` AS select date_format(`order_info`.`create_time`,'%Y-%m-%d') AS `create_date`,count(0) AS `total` from `order_info` group by date_format(`order_info`.`create_time`,'%Y-%m-%d') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `order_info_monthly`
--

/*!50001 DROP TABLE `order_info_monthly`*/;
/*!50001 DROP VIEW IF EXISTS `order_info_monthly`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_info_monthly` AS select date_format(`order_info`.`create_time`,'%Y-%m') AS `month`,count(0) AS `total` from `order_info` group by date_format(`order_info`.`create_time`,'%Y-%m') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacher_info`
--

/*!50001 DROP TABLE `teacher_info`*/;
/*!50001 DROP VIEW IF EXISTS `teacher_info`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teacher_info` AS select `a`.`id` AS `id`,`a`.`user_name` AS `user_name`,`a`.`dep_id` AS `dep_id`,`a`.`password` AS `password`,`a`.`sex` AS `sex`,`a`.`position` AS `position`,`a`.`phone` AS `phone`,`a`.`addr` AS `addr`,`a`.`zipcode` AS `zipcode`,`a`.`iseff` AS `iseff`,`a`.`create_time` AS `create_time`,`a`.`last_update` AS `last_update`,`a`.`role_id` AS `role_id`,`a`.`email` AS `email`,`b`.`course_type` AS `course_type`,`b`.`grade_type` AS `grade_type` from (`sys_user` `a` join `teacher_ability` `b`) where (`a`.`id` = `b`.`user_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacher_ref_student`
--

/*!50001 DROP TABLE `teacher_ref_student`*/;
/*!50001 DROP VIEW IF EXISTS `teacher_ref_student`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teacher_ref_student` AS select crc32(concat(`c`.`charger_id`,`i`.`student_id`,`c`.`course_type`)) AS `id`,`c`.`charger_id` AS `teacher_id`,`i`.`student_id` AS `student_id`,`c`.`course_type` AS `course_type`,`i`.`run_status` AS `run_status`,`s`.`name` AS `name`,`s`.`grade` AS `grade`,`s`.`sex` AS `sex`,`s`.`age` AS `age` from ((`order_course` `c` left join `order_info` `i` on((`i`.`id` = `c`.`order_id`))) left join `student_info` `s` on((`i`.`student_id` = `s`.`id`))) where ((`c`.`charger_id` is not null) and (`i`.`student_id` is not null)) group by `c`.`charger_id`,`i`.`student_id`,`c`.`course_type` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-12-15  3:45:21
