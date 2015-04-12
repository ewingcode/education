/*
SQLyog v10.2 
MySQL - 5.1.30-community : Database - crmdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`crmdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `crmdb`;

/*Table structure for table `course_period` */

DROP TABLE IF EXISTS `course_period`;

CREATE TABLE `course_period` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `start_time` int(4) NOT NULL,
  `end_time` int(4) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='排课时间设置';

/*Data for the table `course_period` */

LOCK TABLES `course_period` WRITE;

insert  into `course_period`(`id`,`start_time`,`end_time`,`create_time`) values (1,800,900,'2015-03-15 10:36:45'),(2,900,1000,'2015-03-15 10:36:45'),(3,1000,1100,'2015-03-15 10:36:45'),(4,1100,1200,'2015-03-15 10:36:45'),(5,1400,1500,'2015-03-15 10:36:45'),(6,1500,1600,'2015-03-15 10:36:45'),(7,1600,1700,'2015-03-15 10:36:45'),(8,1700,1800,'2015-03-15 10:36:45');

UNLOCK TABLES;

/*Table structure for table `course_schedule` */

DROP TABLE IF EXISTS `course_schedule`;

CREATE TABLE `course_schedule` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `total_course_hour` int(10) unsigned DEFAULT NULL COMMENT '课时总数',
  `total_cost_hour` int(10) unsigned DEFAULT NULL COMMENT '课时消耗总数',
  `start_day` date NOT NULL COMMENT '开始日期',
  `end_day` date NOT NULL COMMENT '结束日期',
  `weekdays` varchar(50) NOT NULL COMMENT '排课日',
  `start_time` int(4) NOT NULL COMMENT '课程开始时间段',
  `end_time` int(4) NOT NULL COMMENT '课程开始时间段',
  `status` varchar(1) NOT NULL COMMENT '0:未开始 1:开始中 2:结束',
  `iseff` char(1) DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='排课计划';

/*Data for the table `course_schedule` */

LOCK TABLES `course_schedule` WRITE;

UNLOCK TABLES;

/*Table structure for table `course_schedule_detail` */

DROP TABLE IF EXISTS `course_schedule_detail`;

CREATE TABLE `course_schedule_detail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签单表主键',
  `order_course_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签单课程信息表主键',
  `schedule_id` int(10) unsigned DEFAULT '0' COMMENT '排课模板id',
  `date` date NOT NULL COMMENT '日期',
  `is_finish` int(1) NOT NULL DEFAULT '0' COMMENT '是否完结 0:没结束 1:已经结束',
  `start_time` int(4) NOT NULL COMMENT '课程开始时间段',
  `end_time` int(4) NOT NULL COMMENT '课程开始时间段',
  `iseff` char(1) DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='排课明细';

/*Data for the table `course_schedule_detail` */

LOCK TABLES `course_schedule_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `customer_exchange` */

DROP TABLE IF EXISTS `customer_exchange`;

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

/*Data for the table `customer_exchange` */

LOCK TABLES `customer_exchange` WRITE;

insert  into `customer_exchange`(`id`,`customer_id`,`cust_status`,`source_type`,`is_book`,`user_id`,`content`,`customer_attach_id`,`create_time`,`last_update`,`book_time`) values (4,2,'0','0','1',18,'阿瑟大大',NULL,'2012-10-08 22:43:52','2012-10-20 12:56:59','2012-10-27 00:00:00'),(5,2,'0','1','0',18,'12121',NULL,'2012-10-20 13:07:06','2012-10-20 13:07:06','2012-10-20 13:07:06'),(6,2,'1','1','1',18,'212121',NULL,'2012-10-20 13:07:26','2012-11-06 23:24:07','2012-11-07 00:00:00'),(7,3,'1','1','0',18,'1213dd',NULL,'2012-10-20 13:08:21','2012-10-20 13:08:21','2012-10-20 13:08:21'),(8,2,'1','1','1',18,'9849848',NULL,'2012-12-06 22:13:02','2012-12-06 22:13:02','2012-12-13 00:00:00');

UNLOCK TABLES;

/*Table structure for table `customer_info` */

DROP TABLE IF EXISTS `customer_info`;

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

/*Data for the table `customer_info` */

LOCK TABLES `customer_info` WRITE;

insert  into `customer_info`(`id`,`name`,`sex`,`school`,`classes`,`brithday`,`age`,`student_type`,`resident_type`,`parent_name`,`phone`,`addr`,`iseff`,`create_time`,`last_update`,`email`,`class`) values (2,'tanson lin','0','guangzhou 17 ','初中','1998-08-27','14','1','2','老林','2121312','1','0','2012-08-22 20:40:32','2012-08-22 20:40:32','22@163.com',NULL),(3,'林','0',NULL,NULL,'2008-10-01','4','0','0',NULL,NULL,NULL,NULL,'2012-10-08 22:29:37','2012-10-08 22:29:37',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `flow_task` */

DROP TABLE IF EXISTS `flow_task`;

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

/*Data for the table `flow_task` */

LOCK TABLES `flow_task` WRITE;

insert  into `flow_task`(`id`,`process_name`,`task_name`,`assign_type`,`assigner`,`create_time`,`last_update`,`busi_page_name`,`type`) values (1,'orderProcess','签约','1','1','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/saler_confirm.jsp','0'),(2,'orderProcess','销售主管审批','1','2','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/market_confirm.jsp','1'),(3,'orderProcess','教务部处理','1','3','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/eduadmin_dispatch.jsp','1'),(4,'orderProcess2','待班主任确认','1','4','2015-04-06 22:31:47','2012-04-29 11:25:19','/page/contract/follow/mainteacher_confirm.jsp','1'),(5,'orderProcess','班主任处理中','1','4','2015-04-06 22:31:52','2012-04-29 11:25:19','/page/contract/follow/mainteacher_handle.jsp','1'),(6,'orderProcess','教务部审批','1','3','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/eduadmin_confirm.jsp','1'),(7,'orderProcess','审批通过','','','2012-11-14 21:00:31','2012-04-29 11:25:19','/page/contract/follow/order_detail.jsp','2'),(8,'orderProcess','结束',NULL,NULL,'2012-10-30 21:02:16','2012-04-29 11:25:19',NULL,''),(9,'orderLastProcess','续签','1','3','2012-11-27 22:19:05','2012-07-08 09:46:02','/page/contract/last/last.jsp','0'),(10,'orderLastProcess','审批通过',NULL,'','2012-11-27 22:19:05','2012-10-29 22:01:35',NULL,'2'),(11,'orderLastProcess','结束',NULL,NULL,'2012-10-29 22:01:35','2012-10-29 22:01:35',NULL,'');

UNLOCK TABLES;

/*Table structure for table `flow_task_transition` */

DROP TABLE IF EXISTS `flow_task_transition`;

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

/*Data for the table `flow_task_transition` */

LOCK TABLES `flow_task_transition` WRITE;

insert  into `flow_task_transition`(`id`,`task_id`,`name`,`to`,`create_time`,`last_update`,`need_arrange`,`to_id`) values (1,1,'待审批','销售主管审批','2012-04-17 20:40:59','2012-12-01 00:00:00','0',2),(2,2,'通过','教务部处理','2012-04-17 20:40:59','2012-12-01 00:00:00','1',3),(3,2,'不通过','签约','2012-04-17 20:40:59','2012-12-01 00:00:00','0',1),(4,3,'分配任务','班主任处理中','2012-04-17 20:40:59','2012-12-01 00:00:00','1',5),(5,5,'确认','教务部审批','2012-04-17 20:40:59','2012-12-01 00:00:00','1',6),(6,5,'拒绝','教务部处理','2012-04-17 20:40:59','2012-12-01 00:00:00','0',3),(8,6,'通过','审批通过','2012-04-17 20:40:59','2012-12-01 00:00:00','0',7),(9,6,'不通过','班主任处理中','2012-04-17 20:40:59','2012-12-01 00:00:00','0',5),(10,7,'判断授课时间','结束','2012-04-17 20:40:59','2012-04-17 20:40:59','2',0),(11,9,'继单','审批通过','2012-04-17 20:40:59','2012-04-17 20:40:59','0',10),(12,10,'判断授课时间','结束','2012-04-17 20:40:59','2012-04-17 20:40:59','0',0);

UNLOCK TABLES;

/*Table structure for table `jbpm4_deployment` */

DROP TABLE IF EXISTS `jbpm4_deployment`;

CREATE TABLE `jbpm4_deployment` (
  `DBID_` bigint(20) NOT NULL,
  `NAME_` longtext,
  `TIMESTAMP_` bigint(20) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_deployment` */

LOCK TABLES `jbpm4_deployment` WRITE;

insert  into `jbpm4_deployment`(`DBID_`,`NAME_`,`TIMESTAMP_`,`STATE_`) values (1,NULL,0,'active');

UNLOCK TABLES;

/*Table structure for table `jbpm4_deployprop` */

DROP TABLE IF EXISTS `jbpm4_deployprop`;

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

/*Data for the table `jbpm4_deployprop` */

LOCK TABLES `jbpm4_deployprop` WRITE;

insert  into `jbpm4_deployprop`(`DBID_`,`DEPLOYMENT_`,`OBJNAME_`,`KEY_`,`STRINGVAL_`,`LONGVAL_`) values (3,1,'orderProcess','langid','jpdl-4.4',NULL),(4,1,'orderProcess','pdid','orderProcess-1',NULL),(5,1,'orderProcess','pdkey','orderProcess',NULL),(6,1,'orderProcess','pdversion',NULL,1);

UNLOCK TABLES;

/*Table structure for table `jbpm4_execution` */

DROP TABLE IF EXISTS `jbpm4_execution`;

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

/*Data for the table `jbpm4_execution` */

LOCK TABLES `jbpm4_execution` WRITE;

insert  into `jbpm4_execution`(`DBID_`,`CLASS_`,`DBVERSION_`,`ACTIVITYNAME_`,`PROCDEFID_`,`HASVARS_`,`NAME_`,`KEY_`,`ID_`,`STATE_`,`SUSPHISTSTATE_`,`PRIORITY_`,`HISACTINST_`,`PARENT_`,`INSTANCE_`,`SUPEREXEC_`,`SUBPROCINST_`,`PARENT_IDX_`) values (10001,'pvm',9,'授课中','orderProcess-1','',NULL,'109','orderProcess.109','active-root',NULL,0,10020,NULL,10001,NULL,NULL,NULL),(20001,'pvm',9,'授课中','orderProcess-1','',NULL,'110','orderProcess.110','active-root',NULL,0,70006,NULL,20001,NULL,NULL,NULL),(30001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'75','orderProcess.75','active-root',NULL,0,30006,NULL,30001,NULL,NULL,NULL),(40001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'76','orderProcess.76','active-root',NULL,0,40006,NULL,40001,NULL,NULL,NULL),(50001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'77','orderProcess.77','active-root',NULL,0,50006,NULL,50001,NULL,NULL,NULL),(50005,'pvm',7,'授课中','orderProcess-1','',NULL,'114','orderProcess.114','active-root',NULL,0,50020,NULL,50005,NULL,NULL,NULL),(50007,'pvm',3,'教务部处理','orderProcess-1','',NULL,'78','orderProcess.78','active-root',NULL,0,60002,NULL,50007,NULL,NULL,NULL),(70001,'pvm',3,'教务部处理','orderProcess-1','',NULL,'79','orderProcess.79','active-root',NULL,0,80002,NULL,70001,NULL,NULL,NULL),(80003,'pvm',10,'教务部审批','orderProcess-1','',NULL,'80','orderProcess.80','active-root',NULL,0,80024,NULL,80003,NULL,NULL,NULL),(90001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'86','orderProcess.86','active-root',NULL,0,90014,NULL,90001,NULL,NULL,NULL),(100001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'96','orderProcess.96','active-root',NULL,0,100006,NULL,100001,NULL,NULL,NULL),(100005,'pvm',1,'签约','orderProcess-1','',NULL,'119','orderProcess.119','active-root',NULL,0,100008,NULL,100005,NULL,NULL,NULL),(110001,'pvm',1,'签约','orderProcess-1','',NULL,'120','orderProcess.120','active-root',NULL,0,110004,NULL,110001,NULL,NULL,NULL),(120001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'121','orderProcess.121','active-root',NULL,0,120006,NULL,120001,NULL,NULL,NULL),(130001,'pvm',3,'教务部处理','orderProcess-1','',NULL,'1','orderProcess.1','active-root',NULL,0,130008,NULL,130001,NULL,NULL,NULL),(140001,'pvm',5,'班主任处理中','orderProcess-1','',NULL,'2','orderProcess.2','active-root',NULL,0,140012,NULL,140001,NULL,NULL,NULL),(150001,'pvm',1,'签约','orderProcess-1','',NULL,'3','orderProcess.3','active-root',NULL,0,150004,NULL,150001,NULL,NULL,NULL),(150005,'pvm',1,'签约','orderProcess-1','',NULL,'4','orderProcess.4','active-root',NULL,0,150008,NULL,150005,NULL,NULL,NULL),(160001,'pvm',1,'签约','orderProcess-1','',NULL,'103','orderProcess.103','active-root',NULL,0,160004,NULL,160001,NULL,NULL,NULL),(160005,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'6','orderProcess.6','active-root',NULL,0,160010,NULL,160005,NULL,NULL,NULL),(170001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'7','orderProcess.7','active-root',NULL,0,170006,NULL,170001,NULL,NULL,NULL),(170007,'pvm',1,'签约','orderProcess-1','',NULL,'8','orderProcess.8','active-root',NULL,0,170010,NULL,170007,NULL,NULL,NULL),(180001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'105','orderProcess.105','active-root',NULL,0,180006,NULL,180001,NULL,NULL,NULL),(180005,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'10','orderProcess.10','active-root',NULL,0,180010,NULL,180005,NULL,NULL,NULL),(190001,'pvm',1,'签约','orderProcess-1','',NULL,'106','orderProcess.106','active-root',NULL,0,190004,NULL,190001,NULL,NULL,NULL),(190005,'pvm',5,'班主任处理中','orderProcess-1','',NULL,'12','orderProcess.12','active-root',NULL,0,200006,NULL,190005,NULL,NULL,NULL),(200001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'107','orderProcess.107','active-root',NULL,0,220002,NULL,200001,NULL,NULL,NULL),(210001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'13','orderProcess.13','active-root',NULL,0,210014,NULL,210001,NULL,NULL,NULL),(230001,'pvm',7,'待授课老师确认','orderProcess-1','',NULL,'108','orderProcess.108','active-root',NULL,0,230016,NULL,230001,NULL,NULL,NULL),(230005,'pvm',7,'授课中','orderProcess-1','',NULL,'16','orderProcess.16','active-root',NULL,0,230020,NULL,230005,NULL,NULL,NULL),(240001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'17','orderProcess.17','active-root',NULL,0,240006,NULL,240001,NULL,NULL,NULL),(250001,'pvm',6,'教务部审批','orderProcess-1','',NULL,'18','orderProcess.18','active-root',NULL,0,270006,NULL,250001,NULL,NULL,NULL),(280001,'pvm',7,'授课中','orderProcess-1','',NULL,'19','orderProcess.19','active-root',NULL,0,300002,NULL,280001,NULL,NULL,NULL),(310001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'27','orderProcess.27','active-root',NULL,0,310006,NULL,310001,NULL,NULL,NULL),(320001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'28','orderProcess.28','active-root',NULL,0,320006,NULL,320001,NULL,NULL,NULL),(320007,'pvm',7,'授课中','orderProcess-1','',NULL,'29','orderProcess.29','active-root',NULL,0,320022,NULL,320007,NULL,NULL,NULL),(320023,'pvm',4,'待班主任确认','orderProcess-1','',NULL,'30','orderProcess.30','active-root',NULL,0,320032,NULL,320023,NULL,NULL,NULL),(330001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'31','orderProcess.31','active-root',NULL,0,330006,NULL,330001,NULL,NULL,NULL),(340001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'32','orderProcess.32','active-root',NULL,0,340006,NULL,340001,NULL,NULL,NULL),(340007,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'33','orderProcess.33','active-root',NULL,0,340012,NULL,340007,NULL,NULL,NULL),(350001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'34','orderProcess.34','active-root',NULL,0,350006,NULL,350001,NULL,NULL,NULL),(360001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'35','orderProcess.35','active-root',NULL,0,360006,NULL,360001,NULL,NULL,NULL),(370001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'36','orderProcess.36','active-root',NULL,0,370006,NULL,370001,NULL,NULL,NULL),(380001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'37','orderProcess.37','active-root',NULL,0,380006,NULL,380001,NULL,NULL,NULL),(390001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'38','orderProcess.38','active-root',NULL,0,390006,NULL,390001,NULL,NULL,NULL),(400001,'pvm',3,'教务部处理','orderProcess-1','',NULL,'39','orderProcess.39','active-root',NULL,0,400008,NULL,400001,NULL,NULL,NULL),(410001,'pvm',4,'待班主任确认','orderProcess-1','',NULL,'40','orderProcess.40','active-root',NULL,0,420002,NULL,410001,NULL,NULL,NULL),(430001,'pvm',4,'待班主任确认','orderProcess-1','',NULL,'41','orderProcess.41','active-root',NULL,0,430010,NULL,430001,NULL,NULL,NULL),(440001,'pvm',3,'签约','orderProcess-1','',NULL,'42','orderProcess.42','active-root',NULL,0,440008,NULL,440001,NULL,NULL,NULL),(470001,'pvm',3,'签约','orderProcess-1','',NULL,'45','orderProcess.45','active-root',NULL,0,470008,NULL,470001,NULL,NULL,NULL),(480001,'pvm',3,'签约','orderProcess-1','',NULL,'46','orderProcess.46','active-root',NULL,0,480008,NULL,480001,NULL,NULL,NULL),(490001,'pvm',3,'签约','orderProcess-1','',NULL,'47','orderProcess.47','active-root',NULL,0,490008,NULL,490001,NULL,NULL,NULL),(490009,'pvm',3,'签约','orderProcess-1','',NULL,'48','orderProcess.48','active-root',NULL,0,490016,NULL,490009,NULL,NULL,NULL),(490017,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'49','orderProcess.49','active-root',NULL,0,490022,NULL,490017,NULL,NULL,NULL),(500001,'pvm',4,'销售主管审批','orderProcess-1','',NULL,'50','orderProcess.50','active-root',NULL,0,510006,NULL,500001,NULL,NULL,NULL),(520001,'pvm',1,'签约','orderProcess-1','',NULL,'51','orderProcess.51','active-root',NULL,0,520004,NULL,520001,NULL,NULL,NULL),(530001,'pvm',8,'销售主管审批','orderProcess-1','',NULL,'52','orderProcess.52','active-root',NULL,0,560002,NULL,530001,NULL,NULL,NULL),(560003,'pvm',4,'销售主管审批','orderProcess-1','',NULL,'53','orderProcess.53','active-root',NULL,0,570004,NULL,560003,NULL,NULL,NULL),(570005,'pvm',4,'销售主管审批','orderProcess-1','',NULL,'54','orderProcess.54','active-root',NULL,0,570014,NULL,570005,NULL,NULL,NULL),(580001,'pvm',3,'签约','orderProcess-1','',NULL,'55','orderProcess.55','active-root',NULL,0,590002,NULL,580001,NULL,NULL,NULL),(600001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'56','orderProcess.56','active-root',NULL,0,600006,NULL,600001,NULL,NULL,NULL),(600007,'pvm',3,'签约','orderProcess-1','',NULL,'57','orderProcess.57','active-root',NULL,0,600014,NULL,600007,NULL,NULL,NULL),(630001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'60','orderProcess.60','active-root',NULL,0,630006,NULL,630001,NULL,NULL,NULL),(640001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'61','orderProcess.61','active-root',NULL,0,640006,NULL,640001,NULL,NULL,NULL),(650005,'pvm',3,'教务部处理','orderProcess-1','',NULL,'64','orderProcess.64','active-root',NULL,0,670002,NULL,650005,NULL,NULL,NULL),(660001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'65','orderProcess.65','active-root',NULL,0,660006,NULL,660001,NULL,NULL,NULL),(680001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'66','orderProcess.66','active-root',NULL,0,680006,NULL,680001,NULL,NULL,NULL),(690001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'67','orderProcess.67','active-root',NULL,0,690006,NULL,690001,NULL,NULL,NULL),(690007,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'68','orderProcess.68','active-root',NULL,0,690012,NULL,690007,NULL,NULL,NULL),(700001,'pvm',9,'授课中','orderProcess-1','',NULL,'69','orderProcess.69','active-root',NULL,0,700020,NULL,700001,NULL,NULL,NULL),(700021,'pvm',5,'班主任处理中','orderProcess-1','',NULL,'70','orderProcess.70','active-root',NULL,0,700032,NULL,700021,NULL,NULL,NULL),(700033,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'71','orderProcess.71','active-root',NULL,0,700038,NULL,700033,NULL,NULL,NULL),(710001,'pvm',2,'销售主管审批','orderProcess-1','',NULL,'72','orderProcess.72','active-root',NULL,0,710006,NULL,710001,NULL,NULL,NULL),(720001,'pvm',7,'授课中','orderProcess-1','',NULL,'73','orderProcess.73','active-root',NULL,0,720016,NULL,720001,NULL,NULL,NULL),(720017,'pvm',3,'教务部处理','orderProcess-1','',NULL,'74','orderProcess.74','active-root',NULL,0,720024,NULL,720017,NULL,NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `jbpm4_hist_actinst` */

DROP TABLE IF EXISTS `jbpm4_hist_actinst`;

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

/*Data for the table `jbpm4_hist_actinst` */

LOCK TABLES `jbpm4_hist_actinst` WRITE;

insert  into `jbpm4_hist_actinst`(`DBID_`,`CLASS_`,`DBVERSION_`,`HPROCI_`,`TYPE_`,`EXECUTION_`,`ACTIVITY_NAME_`,`START_`,`END_`,`DURATION_`,`TRANSITION_`,`NEXTIDX_`,`HTASK_`) values (10004,'task',1,10001,'task','orderProcess.109','签约','2012-07-08 09:39:20','2012-07-08 09:39:21',1273,'待审批',1,10003),(10006,'task',1,10001,'task','orderProcess.109','销售主管审批','2012-07-08 09:39:21','2012-07-08 09:40:14',53258,'通过',1,10005),(10008,'task',1,10001,'task','orderProcess.109','教务部处理','2012-07-08 09:40:14','2012-07-08 09:44:32',258271,'分配任务',1,10007),(10010,'task',1,10001,'task','orderProcess.109','待班主任确认','2012-07-08 09:44:32','2012-07-08 09:49:32',300106,'确认',1,10009),(10012,'task',1,10001,'task','orderProcess.109','班主任处理中','2012-07-08 09:49:32','2012-07-08 09:58:16',524408,'待审批',1,10011),(10014,'task',1,10001,'task','orderProcess.109','教务部审批','2012-07-08 09:58:16','2012-07-08 10:30:30',1934422,'不通过',1,10013),(10016,'task',1,10001,'task','orderProcess.109','班主任处理中','2012-07-08 10:30:30','2012-07-08 13:30:04',10774434,'待审批',1,10015),(10018,'task',1,10001,'task','orderProcess.109','教务部审批','2012-07-08 13:30:04','2012-07-08 13:58:52',1728723,'通过',1,10017),(10020,'task',0,10001,'task','orderProcess.109','授课中','2012-07-08 13:58:52',NULL,0,NULL,1,10019),(20004,'task',1,20001,'task','orderProcess.110','签约','2012-07-08 14:54:32','2012-07-08 14:54:33',1562,'待审批',1,20003),(20006,'task',1,20001,'task','orderProcess.110','销售主管审批','2012-07-08 14:54:33','2012-07-08 14:58:52',259432,'不通过',1,20005),(20008,'task',1,20001,'task','orderProcess.110','签约','2012-07-08 14:58:52','2012-07-08 14:59:32',40531,'待审批',1,20007),(20010,'task',1,20001,'task','orderProcess.110','销售主管审批','2012-07-08 14:59:32','2012-07-08 23:38:01',31109089,'通过',1,20009),(50008,'task',1,50005,'task','orderProcess.114','签约','2012-07-08 15:33:35','2012-07-08 15:34:57',82152,'待审批',1,50007),(50010,'task',1,50005,'task','orderProcess.114','销售主管审批','2012-07-08 15:34:57','2012-07-08 15:35:45',48578,'通过',1,50009),(50012,'task',1,50005,'task','orderProcess.114','教务部处理','2012-07-08 15:35:45','2012-07-08 15:36:15',30222,'分配任务',1,50011),(50014,'task',1,50005,'task','orderProcess.114','待班主任确认','2012-07-08 15:36:15','2012-07-08 15:36:39',24108,'确认',1,50013),(50016,'task',1,50005,'task','orderProcess.114','班主任处理中','2012-07-08 15:36:39','2012-07-08 15:37:12',33401,'待审批',1,50015),(50018,'task',1,50005,'task','orderProcess.114','教务部审批','2012-07-08 15:37:12','2012-07-08 15:37:48',36373,'通过',1,50017),(50020,'task',0,50005,'task','orderProcess.114','授课中','2012-07-08 15:37:48',NULL,0,NULL,1,50019),(60002,'task',1,20001,'task','orderProcess.110','教务部处理','2012-07-08 23:38:01','2012-07-09 00:30:33',3152192,'分配任务',1,60001),(60004,'task',1,20001,'task','orderProcess.110','待班主任确认','2012-07-09 00:30:33','2012-07-09 20:46:24',72951122,'确认',1,60003),(70002,'task',1,20001,'task','orderProcess.110','班主任处理中','2012-07-09 20:46:24','2012-07-09 20:46:50',26049,'待审批',1,70001),(70004,'task',1,20001,'task','orderProcess.110','教务部审批','2012-07-09 20:46:50','2012-07-09 20:47:10',20179,'通过',1,70003),(70006,'task',0,20001,'task','orderProcess.110','授课中','2012-07-09 20:47:10',NULL,0,NULL,1,70005),(100008,'task',0,100005,'task','orderProcess.119','签约','2012-07-09 23:04:33',NULL,0,NULL,1,100007),(110004,'task',0,110001,'task','orderProcess.120','签约','2012-07-09 23:06:37',NULL,0,NULL,1,110003),(120004,'task',1,120001,'task','orderProcess.121','签约','2012-07-09 23:10:26','2012-07-09 23:10:30',4722,'待审批',1,120003),(120006,'task',0,120001,'task','orderProcess.121','销售主管审批','2012-07-09 23:10:30',NULL,0,NULL,1,120005),(130004,'task',1,130001,'task','orderProcess.1','签约','2012-07-10 20:07:20','2012-07-10 20:07:21',1330,'待审批',1,130003),(130006,'task',1,130001,'task','orderProcess.1','销售主管审批','2012-07-10 20:07:21','2012-07-10 20:07:59',38504,'通过',1,130005),(130008,'task',0,130001,'task','orderProcess.1','教务部处理','2012-07-10 20:07:59',NULL,0,NULL,1,130007),(140004,'task',1,140001,'task','orderProcess.2','签约','2012-07-10 20:10:27','2012-07-10 20:10:27',883,'待审批',1,140003),(140006,'task',1,140001,'task','orderProcess.2','销售主管审批','2012-07-10 20:10:27','2012-07-10 20:14:35',248878,'通过',1,140005),(140008,'task',1,140001,'task','orderProcess.2','教务部处理','2012-07-10 20:14:35','2012-07-10 20:15:09',34080,'分配任务',1,140007),(140010,'task',1,140001,'task','orderProcess.2','待班主任确认','2012-07-10 20:15:09','2012-07-10 20:15:38',29594,'确认',1,140009),(140012,'task',0,140001,'task','orderProcess.2','班主任处理中','2012-07-10 20:15:38',NULL,0,NULL,1,140011),(150004,'task',0,150001,'task','orderProcess.3','签约','2012-07-10 21:07:29',NULL,0,NULL,1,150003),(150008,'task',0,150005,'task','orderProcess.4','签约','2012-07-10 21:10:45',NULL,0,NULL,1,150007),(160008,'task',1,160005,'task','orderProcess.6','签约','2012-07-10 21:12:53','2012-07-10 21:13:11',18180,'待审批',1,160007),(160010,'task',0,160005,'task','orderProcess.6','销售主管审批','2012-07-10 21:13:11',NULL,0,NULL,1,160009),(170004,'task',1,170001,'task','orderProcess.7','签约','2012-07-10 21:22:20','2012-07-10 21:22:22',2220,'待审批',1,170003),(170006,'task',0,170001,'task','orderProcess.7','销售主管审批','2012-07-10 21:22:22',NULL,0,NULL,1,170005),(170010,'task',0,170007,'task','orderProcess.8','签约','2012-07-10 21:24:15',NULL,0,NULL,1,170009),(180008,'task',1,180005,'task','orderProcess.10','签约','2012-07-10 21:29:59','2012-07-10 21:30:00',1768,'待审批',1,180007),(180010,'task',0,180005,'task','orderProcess.10','销售主管审批','2012-07-10 21:30:00',NULL,0,NULL,1,180009),(190008,'task',1,190005,'task','orderProcess.12','签约','2012-07-10 21:37:30','2012-07-10 21:37:31',1511,'待审批',1,190007),(190010,'task',1,190005,'task','orderProcess.12','销售主管审批','2012-07-10 21:37:31','2012-07-10 21:43:28',357199,'通过',1,190009),(200002,'task',1,190005,'task','orderProcess.12','教务部处理','2012-07-10 21:43:30','2012-07-10 22:06:07',1357565,'分配任务',1,200001),(200004,'task',1,190005,'task','orderProcess.12','待班主任确认','2012-07-10 22:06:07','2012-07-10 22:09:14',187069,'确认',1,200003),(200006,'task',0,190005,'task','orderProcess.12','班主任处理中','2012-07-10 22:09:14',NULL,0,NULL,1,200005),(210004,'task',1,210001,'task','orderProcess.13','签约','2012-07-10 22:13:11','2012-07-10 22:13:12',1262,'待审批',1,210003),(210006,'task',1,210001,'task','orderProcess.13','销售主管审批','2012-07-10 22:13:12','2012-07-10 22:13:36',24367,'通过',1,210005),(210008,'task',1,210001,'task','orderProcess.13','教务部处理','2012-07-10 22:13:36','2012-07-10 22:14:06',30845,'分配任务',1,210007),(210010,'task',1,210001,'task','orderProcess.13','待班主任确认','2012-07-10 22:14:06','2012-07-10 22:14:26',20352,'确认',1,210009),(210012,'task',1,210001,'task','orderProcess.13','班主任处理中','2012-07-10 22:14:26','2012-07-10 22:15:21',55236,'待审批',1,210011),(210014,'task',0,210001,'task','orderProcess.13','教务部审批','2012-07-10 22:15:21',NULL,0,NULL,1,210013),(230008,'task',1,230005,'task','orderProcess.16','签约','2012-07-10 22:28:49','2012-07-10 22:28:50',1878,'待审批',1,230007),(230010,'task',1,230005,'task','orderProcess.16','销售主管审批','2012-07-10 22:28:50','2012-07-10 22:29:53',63457,'通过',1,230009),(230012,'task',1,230005,'task','orderProcess.16','教务部处理','2012-07-10 22:29:53','2012-07-10 22:30:39',46133,'分配任务',1,230011),(230014,'task',1,230005,'task','orderProcess.16','待班主任确认','2012-07-10 22:30:39','2012-07-10 22:31:06',27886,'确认',1,230013),(230016,'task',1,230005,'task','orderProcess.16','班主任处理中','2012-07-10 22:31:06','2012-07-10 22:31:51',45679,'待审批',1,230015),(230018,'task',1,230005,'task','orderProcess.16','教务部审批','2012-07-10 22:31:51','2012-07-10 22:32:12',21379,'通过',1,230017),(230020,'task',0,230005,'task','orderProcess.16','授课中','2012-07-10 22:32:12',NULL,0,NULL,1,230019),(240004,'task',1,240001,'task','orderProcess.17','签约','2012-07-11 22:35:01','2012-07-11 22:35:02',1325,'待审批',1,240003),(240006,'task',0,240001,'task','orderProcess.17','销售主管审批','2012-07-11 22:35:02',NULL,0,NULL,1,240005),(250004,'task',1,250001,'task','orderProcess.18','签约','2012-07-11 22:59:28','2012-07-11 22:59:29',1435,'待审批',1,250003),(250006,'task',1,250001,'task','orderProcess.18','销售主管审批','2012-07-11 22:59:29','2012-07-11 23:33:24',2035464,'通过',1,250005),(260002,'task',1,250001,'task','orderProcess.18','教务部处理','2012-07-11 23:33:25','2012-07-11 23:40:03',398528,'分配任务',1,260001),(270002,'task',1,250001,'task','orderProcess.18','待班主任确认','2012-07-11 23:40:04','2012-07-11 23:41:50',106237,'确认',1,270001),(270004,'task',1,250001,'task','orderProcess.18','班主任处理中','2012-07-11 23:41:50','2012-07-11 23:45:02',192958,'待审批',1,270003),(270006,'task',0,250001,'task','orderProcess.18','教务部审批','2012-07-11 23:45:02',NULL,0,NULL,1,270005),(280004,'task',1,280001,'task','orderProcess.19','签约','2012-07-22 20:40:29','2012-07-22 20:40:29',788,'待审批',1,280003),(280006,'task',1,280001,'task','orderProcess.19','销售主管审批','2012-07-22 20:40:29','2012-07-22 20:43:51',202952,'通过',1,280005),(280008,'task',1,280001,'task','orderProcess.19','教务部处理','2012-07-22 20:43:51','2012-07-22 20:44:09',18829,'分配任务',1,280007),(280010,'task',1,280001,'task','orderProcess.19','待班主任确认','2012-07-22 20:44:09','2012-07-22 20:44:22',13755,'确认',1,280009),(280012,'task',1,280001,'task','orderProcess.19','班主任处理中','2012-07-22 20:44:22','2012-07-22 20:44:41',19596,'待审批',1,280011),(280014,'task',1,280001,'task','orderProcess.19','教务部审批','2012-07-22 20:44:41','2012-07-22 20:52:13',452677,'通过',1,280013),(300002,'task',0,280001,'task','orderProcess.19','授课中','2012-07-22 20:52:15',NULL,0,NULL,1,300001),(310004,'task',1,310001,'task','orderProcess.27','签约','2012-08-15 23:39:58','2012-08-15 23:39:59',1558,'待审批',1,310003),(310006,'task',0,310001,'task','orderProcess.27','销售主管审批','2012-08-15 23:39:59',NULL,0,NULL,1,310005),(320004,'task',1,320001,'task','orderProcess.28','签约','2012-08-15 23:55:08','2012-08-15 23:55:09',1285,'待审批',1,320003),(320006,'task',0,320001,'task','orderProcess.28','销售主管审批','2012-08-15 23:55:09',NULL,0,NULL,1,320005),(320010,'task',1,320007,'task','orderProcess.29','签约','2012-08-16 00:05:31','2012-08-16 00:05:31',964,'待审批',1,320009),(320012,'task',1,320007,'task','orderProcess.29','销售主管审批','2012-08-16 00:05:31','2012-08-16 00:09:58',267189,'通过',1,320011),(320014,'task',1,320007,'task','orderProcess.29','教务部处理','2012-08-16 00:09:58','2012-08-16 00:18:07',489163,'分配任务',1,320013),(320016,'task',1,320007,'task','orderProcess.29','待班主任确认','2012-08-16 00:18:07','2012-08-16 00:18:17',10162,'确认',1,320015),(320018,'task',1,320007,'task','orderProcess.29','班主任处理中','2012-08-16 00:18:17','2012-08-16 00:18:42',25249,'待审批',1,320017),(320020,'task',1,320007,'task','orderProcess.29','教务部审批','2012-08-16 00:18:42','2012-08-16 00:18:55',13642,'通过',1,320019),(320022,'task',0,320007,'task','orderProcess.29','授课中','2012-08-16 00:18:55',NULL,0,NULL,1,320021),(320026,'task',1,320023,'task','orderProcess.30','签约','2012-08-16 00:29:35','2012-08-16 00:29:35',679,'待审批',1,320025),(320028,'task',1,320023,'task','orderProcess.30','销售主管审批','2012-08-16 00:29:35','2012-08-16 00:29:56',21313,'通过',1,320027),(320030,'task',1,320023,'task','orderProcess.30','教务部处理','2012-08-16 00:29:56','2012-08-16 00:30:55',59949,'分配任务',1,320029),(320032,'task',0,320023,'task','orderProcess.30','待班主任确认','2012-08-16 00:30:55',NULL,0,NULL,1,320031),(330004,'task',1,330001,'task','orderProcess.31','签约','2012-08-16 20:07:46','2012-08-16 20:07:47',1062,'待审批',1,330003),(330006,'task',0,330001,'task','orderProcess.31','销售主管审批','2012-08-16 20:07:47',NULL,0,NULL,1,330005),(340004,'task',1,340001,'task','orderProcess.32','签约','2012-08-16 20:14:21','2012-08-16 20:14:21',943,'待审批',1,340003),(340006,'task',0,340001,'task','orderProcess.32','销售主管审批','2012-08-16 20:14:21',NULL,0,NULL,1,340005),(340010,'task',1,340007,'task','orderProcess.33','签约','2012-08-16 20:17:16','2012-08-16 20:17:17',1344,'待审批',1,340009),(340012,'task',0,340007,'task','orderProcess.33','销售主管审批','2012-08-16 20:17:17',NULL,0,NULL,1,340011),(350004,'task',1,350001,'task','orderProcess.34','签约','2012-08-16 20:21:38','2012-08-16 20:21:39',1283,'待审批',1,350003),(350006,'task',0,350001,'task','orderProcess.34','销售主管审批','2012-08-16 20:21:39',NULL,0,NULL,1,350005),(360004,'task',1,360001,'task','orderProcess.35','签约','2012-08-16 23:22:53','2012-08-16 23:22:54',1413,'待审批',1,360003),(360006,'task',0,360001,'task','orderProcess.35','销售主管审批','2012-08-16 23:22:54',NULL,0,NULL,1,360005),(370004,'task',1,370001,'task','orderProcess.36','签约','2012-08-17 00:44:47','2012-08-17 00:44:48',1145,'待审批',1,370003),(370006,'task',0,370001,'task','orderProcess.36','销售主管审批','2012-08-17 00:44:48',NULL,0,NULL,1,370005),(380004,'task',1,380001,'task','orderProcess.37','签约','2012-08-17 00:47:24','2012-08-17 00:48:35',71220,'待审批',1,380003),(380006,'task',0,380001,'task','orderProcess.37','销售主管审批','2012-08-17 00:48:35',NULL,0,NULL,1,380005),(390004,'task',1,390001,'task','orderProcess.38','签约','2012-08-17 00:57:00','2012-08-17 00:57:20',20660,'待审批',1,390003),(390006,'task',0,390001,'task','orderProcess.38','销售主管审批','2012-08-17 00:57:20',NULL,0,NULL,1,390005),(400004,'task',1,400001,'task','orderProcess.39','签约','2012-08-17 01:08:54','2012-08-17 01:08:55',1485,'待审批',1,400003),(400006,'task',1,400001,'task','orderProcess.39','销售主管审批','2012-08-17 01:08:55','2012-08-17 01:10:36',101897,'通过',1,400005),(400008,'task',0,400001,'task','orderProcess.39','教务部处理','2012-08-17 01:10:36',NULL,0,NULL,1,400007),(410004,'task',1,410001,'task','orderProcess.40','签约','2012-08-17 23:00:08','2012-08-17 23:00:08',748,'待审批',1,410003),(410006,'task',1,410001,'task','orderProcess.40','销售主管审批','2012-08-17 23:00:08','2012-08-17 23:07:05',417372,'通过',1,410005),(410008,'task',1,410001,'task','orderProcess.40','教务部处理','2012-08-17 23:07:05','2012-08-17 23:25:51',1126408,'分配任务',1,410007),(420002,'task',0,410001,'task','orderProcess.40','待班主任确认','2012-08-17 23:25:51',NULL,0,NULL,1,420001),(430004,'task',1,430001,'task','orderProcess.41','签约','2012-08-17 23:29:34','2012-08-17 23:29:53',19060,'待审批',1,430003),(430006,'task',1,430001,'task','orderProcess.41','销售主管审批','2012-08-17 23:29:53','2012-08-17 23:31:07',74834,'通过',1,430005),(430008,'task',1,430001,'task','orderProcess.41','教务部处理','2012-08-17 23:31:07','2012-08-17 23:31:47',40825,'分配任务',1,430007),(430010,'task',0,430001,'task','orderProcess.41','待班主任确认','2012-08-17 23:31:47',NULL,0,NULL,1,430009),(440004,'task',1,440001,'task','orderProcess.42','签约','2012-08-18 00:49:12','2012-08-18 00:49:13',1447,'待审批',1,440003),(440006,'task',1,440001,'task','orderProcess.42','销售主管审批','2012-08-18 00:49:13','2012-08-18 00:52:54',221571,'不通过',1,440005),(440008,'task',0,440001,'task','orderProcess.42','签约','2012-08-18 00:52:54',NULL,0,NULL,1,440007),(470004,'task',1,470001,'task','orderProcess.45','签约','2012-08-18 01:02:39','2012-08-18 01:02:39',883,'待审批',1,470003),(470006,'task',1,470001,'task','orderProcess.45','销售主管审批','2012-08-18 01:02:39','2012-08-18 01:03:27',48632,'不通过',1,470005),(470008,'task',0,470001,'task','orderProcess.45','签约','2012-08-18 01:03:27',NULL,0,NULL,1,470007),(480004,'task',1,480001,'task','orderProcess.46','签约','2012-08-18 01:10:33','2012-08-18 01:10:33',651,'待审批',1,480003),(480006,'task',1,480001,'task','orderProcess.46','销售主管审批','2012-08-18 01:10:33','2012-08-18 01:11:33',60725,'不通过',1,480005),(480008,'task',0,480001,'task','orderProcess.46','签约','2012-08-18 01:11:33',NULL,0,NULL,1,480007),(490004,'task',1,490001,'task','orderProcess.47','签约','2012-08-18 01:15:10','2012-08-18 01:15:10',935,'待审批',1,490003),(490006,'task',1,490001,'task','orderProcess.47','销售主管审批','2012-08-18 01:15:10','2012-08-18 01:16:24',74562,'不通过',1,490005),(490008,'task',0,490001,'task','orderProcess.47','签约','2012-08-18 01:16:24',NULL,0,NULL,1,490007),(490012,'task',1,490009,'task','orderProcess.48','签约','2012-08-18 01:18:35','2012-08-18 01:18:35',541,'待审批',1,490011),(490014,'task',1,490009,'task','orderProcess.48','销售主管审批','2012-08-18 01:18:35','2012-08-18 01:19:14',39361,'不通过',1,490013),(490016,'task',0,490009,'task','orderProcess.48','签约','2012-08-18 01:19:14',NULL,0,NULL,1,490015),(490020,'task',1,490017,'task','orderProcess.49','签约','2012-08-18 01:20:19','2012-08-18 01:20:23',4094,'待审批',1,490019),(490022,'task',0,490017,'task','orderProcess.49','销售主管审批','2012-08-18 01:20:23',NULL,0,NULL,1,490021),(500004,'task',1,500001,'task','orderProcess.50','签约','2012-08-18 01:26:40','2012-08-18 01:26:43',3146,'待审批',1,500003),(500006,'task',1,500001,'task','orderProcess.50','销售主管审批','2012-08-18 01:26:43','2012-08-18 01:30:50',247499,'不通过',1,500005),(510004,'task',1,500001,'task','orderProcess.50','签约','2012-08-18 01:30:50','2012-08-18 01:32:25',95978,'待审批',1,510003),(510006,'task',0,500001,'task','orderProcess.50','销售主管审批','2012-08-18 01:32:25',NULL,0,NULL,1,510005),(520004,'task',0,520001,'task','orderProcess.51','签约','2012-08-18 18:20:22',NULL,0,NULL,1,520003),(530004,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:21:46','2012-08-18 18:21:47',1376,'待审批',1,530003),(530006,'task',1,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:21:47','2012-08-18 18:37:46',959820,'不通过',1,530005),(540002,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:37:47','2012-08-18 18:39:11',84496,'待审批',1,540001),(540004,'task',1,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:39:11','2012-08-18 18:40:44',93099,'不通过',1,540003),(540006,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:40:44','2012-08-18 18:41:38',54041,'待审批',1,540005),(540008,'task',1,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:41:38','2012-08-18 18:45:22',224472,'不通过',1,540007),(550002,'task',1,530001,'task','orderProcess.52','签约','2012-08-18 18:45:23','2012-08-18 18:51:01',338117,'待审批',1,550001),(560002,'task',0,530001,'task','orderProcess.52','销售主管审批','2012-08-18 18:51:01',NULL,0,NULL,1,560001),(560006,'task',1,560003,'task','orderProcess.53','签约','2012-08-18 19:24:21','2012-08-18 19:24:22',1551,'待审批',1,560005),(560008,'task',1,560003,'task','orderProcess.53','销售主管审批','2012-08-18 19:24:22','2012-08-18 19:30:53',391699,'不通过',1,560007),(570002,'task',1,560003,'task','orderProcess.53','签约','2012-08-18 19:30:55','2012-08-18 19:32:12',77178,'待审批',1,570001),(570004,'task',0,560003,'task','orderProcess.53','销售主管审批','2012-08-18 19:32:12',NULL,0,NULL,1,570003),(570008,'task',1,570005,'task','orderProcess.54','签约','2012-08-18 19:33:38','2012-08-18 19:33:49',11353,'待审批',1,570007),(570010,'task',1,570005,'task','orderProcess.54','销售主管审批','2012-08-18 19:33:49','2012-08-18 19:34:30',41978,'不通过',1,570009),(570012,'task',1,570005,'task','orderProcess.54','签约','2012-08-18 19:34:30','2012-08-18 19:35:25',55239,'待审批',1,570011),(570014,'task',0,570005,'task','orderProcess.54','销售主管审批','2012-08-18 19:35:25',NULL,0,NULL,1,570013),(580004,'task',1,580001,'task','orderProcess.55','签约','2012-08-18 19:39:48','2012-08-18 19:39:57',9347,'待审批',1,580003),(580006,'task',1,580001,'task','orderProcess.55','销售主管审批','2012-08-18 19:39:57','2012-08-18 19:41:53',116009,'不通过',1,580005),(590002,'task',0,580001,'task','orderProcess.55','签约','2012-08-18 19:41:53',NULL,0,NULL,1,590001),(600004,'task',1,600001,'task','orderProcess.56','签约','2012-08-18 19:44:43','2012-08-18 19:44:44',1831,'待审批',1,600003),(600006,'task',0,600001,'task','orderProcess.56','销售主管审批','2012-08-18 19:44:44',NULL,0,NULL,1,600005),(600010,'task',1,600007,'task','orderProcess.57','签约','2012-08-18 19:45:31','2012-08-18 19:45:31',906,'待审批',1,600009),(600012,'task',1,600007,'task','orderProcess.57','销售主管审批','2012-08-18 19:45:31','2012-08-18 19:46:08',37653,'不通过',1,600011),(600014,'task',0,600007,'task','orderProcess.57','签约','2012-08-18 19:46:08',NULL,0,NULL,1,600013),(610004,'task',1,610001,'task','orderProcess.58','签约','2012-08-18 19:48:34','2012-08-18 19:48:34',825,'待审批',1,610003),(610006,'task',1,610001,'task','orderProcess.58','销售主管审批','2012-08-18 19:48:34','2012-08-18 19:49:01',27344,'不通过',1,610005),(610008,'task',1,610001,'task','orderProcess.58','签约','2012-08-18 19:49:01','2012-08-18 19:50:02',61056,'待审批',1,610007),(610010,'task',1,610001,'task','orderProcess.58','销售主管审批','2012-08-18 19:50:02','2012-08-18 19:51:59',117502,'通过',1,610009),(610012,'task',1,610001,'task','orderProcess.58','教务部处理','2012-08-18 19:51:59','2012-08-18 20:44:50',3171495,'分配任务',1,610011),(610014,'task',1,610001,'task','orderProcess.58','待班主任确认','2012-08-18 20:44:50','2012-08-18 20:46:09',79816,'确认',1,610013),(610016,'task',1,610001,'task','orderProcess.58','班主任处理中','2012-08-18 20:46:09','2012-08-18 20:49:05',176929,'待审批',1,610015),(610018,'task',1,610001,'task','orderProcess.58','教务部审批','2012-08-18 20:49:05','2012-08-18 20:50:30',85323,'不通过',1,610017),(610020,'task',1,610001,'task','orderProcess.58','班主任处理中','2012-08-18 20:50:30','2012-08-18 20:52:06',96436,'待审批',1,610019),(610022,'task',1,610001,'task','orderProcess.58','教务部审批','2012-08-18 20:52:06','2012-08-18 20:53:22',76123,'通过',1,610021),(610024,'task',1,610001,'task','orderProcess.58','授课中','2012-08-18 20:53:22','2012-08-18 22:13:18',4796213,'判断授课时间',1,610023),(620004,'task',1,620001,'task','orderProcess.59','签约','2012-08-18 22:41:04','2012-08-18 22:41:04',881,'待审批',1,620003),(620006,'task',1,620001,'task','orderProcess.59','销售主管审批','2012-08-18 22:41:04','2012-08-18 22:41:35',31005,'通过',1,620005),(620008,'task',1,620001,'task','orderProcess.59','教务部处理','2012-08-18 22:41:35','2012-08-18 22:42:17',42816,'分配任务',1,620007),(620010,'task',1,620001,'task','orderProcess.59','待班主任确认','2012-08-18 22:42:17','2012-08-18 22:43:14',57361,'确认',1,620009),(620012,'task',1,620001,'task','orderProcess.59','班主任处理中','2012-08-18 22:43:14','2012-08-18 22:44:26',72524,'待审批',1,620011),(620014,'task',1,620001,'task','orderProcess.59','教务部审批','2012-08-18 22:44:26','2012-08-18 22:45:20',54973,'通过',1,620013),(620016,'task',1,620001,'task','orderProcess.59','授课中','2012-08-18 22:45:20','2012-08-18 22:50:00',280089,'判断授课时间',1,620015),(630004,'task',1,630001,'task','orderProcess.60','签约','2012-08-19 08:17:33','2012-08-19 08:17:43',10591,'待审批',1,630003),(630006,'task',0,630001,'task','orderProcess.60','销售主管审批','2012-08-19 08:17:43',NULL,0,NULL,1,630005),(640004,'task',1,640001,'task','orderProcess.61','签约','2012-08-19 09:04:54','2012-08-19 09:04:55',1104,'待审批',1,640003),(640006,'task',0,640001,'task','orderProcess.61','销售主管审批','2012-08-19 09:04:55',NULL,0,NULL,1,640005),(640010,'task',1,640007,'task','orderProcess.62','签约','2012-08-19 11:02:03','2012-08-19 11:02:03',423,'待审批',1,640009),(640012,'task',1,640007,'task','orderProcess.62','销售主管审批','2012-08-19 11:02:03','2012-08-19 11:04:18',135225,'不通过',1,640011),(640014,'task',1,640007,'task','orderProcess.62','签约','2012-08-19 11:04:18','2012-08-19 11:05:40',82937,'待审批',1,640013),(640016,'task',1,640007,'task','orderProcess.62','销售主管审批','2012-08-19 11:05:40','2012-08-19 11:07:10',90982,'通过',1,640015),(640018,'task',1,640007,'task','orderProcess.62','教务部处理','2012-08-19 11:07:10','2012-08-19 11:21:40',870113,'分配任务',1,640017),(640020,'task',1,640007,'task','orderProcess.62','待班主任确认','2012-08-19 11:21:40','2012-08-19 11:23:38',118552,'确认',1,640019),(640022,'task',1,640007,'task','orderProcess.62','班主任处理中','2012-08-19 11:23:38','2012-08-19 11:27:27',229244,'待审批',1,640021),(640024,'task',1,640007,'task','orderProcess.62','教务部审批','2012-08-19 11:27:27','2012-08-19 11:28:24',57251,'通过',1,640023),(640026,'task',1,640007,'task','orderProcess.62','授课中','2012-08-19 11:28:24','2012-08-19 11:30:00',96122,'判断授课时间',1,640025),(650008,'task',1,650005,'task','orderProcess.64','签约','2012-08-26 16:59:34','2012-08-26 16:59:34',803,'待审批',1,650007),(650010,'task',1,650005,'task','orderProcess.64','销售主管审批','2012-08-26 16:59:34','2012-08-27 20:54:46',100512808,'通过',1,650009),(660004,'task',1,660001,'task','orderProcess.65','签约','2012-08-27 20:45:18','2012-08-27 20:45:18',724,'待审批',1,660003),(660006,'task',0,660001,'task','orderProcess.65','销售主管审批','2012-08-27 20:45:18',NULL,0,NULL,1,660005),(670002,'task',0,650005,'task','orderProcess.64','教务部处理','2012-08-27 20:54:47',NULL,0,NULL,1,670001),(680004,'task',1,680001,'task','orderProcess.66','签约','2012-09-11 22:36:55','2012-09-11 22:36:56',1066,'待审批',1,680003),(680006,'task',0,680001,'task','orderProcess.66','销售主管审批','2012-09-11 22:36:56',NULL,0,NULL,1,680005),(690004,'task',1,690001,'task','orderProcess.67','签约','2012-10-10 21:03:05','2012-10-10 21:03:06',1057,'待审批',1,690003),(690006,'task',0,690001,'task','orderProcess.67','销售主管审批','2012-10-10 21:03:06',NULL,0,NULL,1,690005),(690010,'task',1,690007,'task','orderProcess.68','签约','2012-10-10 21:12:36','2012-10-10 21:12:36',841,'待审批',1,690009),(690012,'task',0,690007,'task','orderProcess.68','销售主管审批','2012-10-10 21:12:36',NULL,0,NULL,1,690011),(700004,'task',1,700001,'task','orderProcess.69','签约','2012-10-10 21:19:29','2012-10-10 21:19:31',2423,'待审批',1,700003),(700006,'task',1,700001,'task','orderProcess.69','销售主管审批','2012-10-10 21:19:31','2012-10-10 21:25:37',366294,'通过',1,700005),(700008,'task',1,700001,'task','orderProcess.69','教务部处理','2012-10-10 21:25:37','2012-10-10 21:26:04',27487,'分配任务',1,700007),(700010,'task',1,700001,'task','orderProcess.69','待班主任确认','2012-10-10 21:26:04','2012-10-10 21:26:56',52422,'确认',1,700009),(700012,'task',1,700001,'task','orderProcess.69','班主任处理中','2012-10-10 21:26:56','2012-10-10 21:35:18',502000,'待审批',1,700011),(700014,'task',1,700001,'task','orderProcess.69','教务部审批','2012-10-10 21:35:18','2012-10-10 21:35:47',29473,'不通过',1,700013),(700016,'task',1,700001,'task','orderProcess.69','班主任处理中','2012-10-10 21:35:47','2012-10-10 21:37:09',82093,'待审批',1,700015),(700018,'task',1,700001,'task','orderProcess.69','教务部审批','2012-10-10 21:37:09','2012-10-10 21:37:28',19552,'通过',1,700017),(700020,'task',0,700001,'task','orderProcess.69','授课中','2012-10-10 21:37:28',NULL,0,NULL,1,700019),(700024,'task',1,700021,'task','orderProcess.70','签约','2012-10-10 21:49:43','2012-10-10 21:49:44',1845,'待审批',1,700023),(700026,'task',1,700021,'task','orderProcess.70','销售主管审批','2012-10-10 21:49:44','2012-10-10 21:50:51',67434,'通过',1,700025),(700028,'task',1,700021,'task','orderProcess.70','教务部处理','2012-10-10 21:50:51','2012-10-10 21:51:10',19936,'分配任务',1,700027),(700030,'task',1,700021,'task','orderProcess.70','待班主任确认','2012-10-10 21:51:10','2012-10-10 21:54:49',219999,'确认',1,700029),(700032,'task',0,700021,'task','orderProcess.70','班主任处理中','2012-10-10 21:54:50',NULL,0,NULL,1,700031),(700036,'task',1,700033,'task','orderProcess.71','签约','2012-10-10 22:26:29','2012-10-10 22:26:30',1382,'待审批',1,700035),(700038,'task',0,700033,'task','orderProcess.71','销售主管审批','2012-10-10 22:26:30',NULL,0,NULL,1,700037),(710004,'task',1,710001,'task','orderProcess.72','签约','2012-10-16 22:59:05','2012-10-16 22:59:05',891,'待审批',1,710003),(710006,'task',0,710001,'task','orderProcess.72','销售主管审批','2012-10-16 22:59:05',NULL,0,NULL,1,710005),(720004,'task',1,720001,'task','orderProcess.73','签约','2012-10-18 22:00:50','2012-10-18 22:00:59',9177,'待审批',1,720003),(720006,'task',1,720001,'task','orderProcess.73','销售主管审批','2012-10-18 22:00:59','2012-10-18 22:01:40',41041,'通过',1,720005),(720008,'task',1,720001,'task','orderProcess.73','教务部处理','2012-10-18 22:01:40','2012-10-18 22:02:42',62981,'分配任务',1,720007),(720010,'task',1,720001,'task','orderProcess.73','待班主任确认','2012-10-18 22:02:43','2012-10-18 22:03:31',48150,'确认',1,720009),(720012,'task',1,720001,'task','orderProcess.73','班主任处理中','2012-10-18 22:03:31','2012-10-18 22:04:13',42149,'待审批',1,720011),(720014,'task',1,720001,'task','orderProcess.73','教务部审批','2012-10-18 22:04:13','2012-10-18 22:04:37',24000,'通过',1,720013),(720016,'task',0,720001,'task','orderProcess.73','授课中','2012-10-18 22:04:37',NULL,0,NULL,1,720015),(720020,'task',1,720017,'task','orderProcess.74','签约','2012-10-18 22:08:35','2012-10-18 22:08:36',1533,'待审批',1,720019),(720022,'task',1,720017,'task','orderProcess.74','销售主管审批','2012-10-18 22:08:36','2012-10-18 22:09:30',54543,'通过',1,720021),(720024,'task',0,720017,'task','orderProcess.74','教务部处理','2012-10-18 22:09:30',NULL,0,NULL,1,720023);

UNLOCK TABLES;

/*Table structure for table `jbpm4_hist_detail` */

DROP TABLE IF EXISTS `jbpm4_hist_detail`;

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

/*Data for the table `jbpm4_hist_detail` */

LOCK TABLES `jbpm4_hist_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_hist_procinst` */

DROP TABLE IF EXISTS `jbpm4_hist_procinst`;

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

/*Data for the table `jbpm4_hist_procinst` */

LOCK TABLES `jbpm4_hist_procinst` WRITE;

insert  into `jbpm4_hist_procinst`(`DBID_`,`DBVERSION_`,`ID_`,`PROCDEFID_`,`KEY_`,`START_`,`END_`,`DURATION_`,`STATE_`,`ENDACTIVITY_`,`NEXTIDX_`) values (10001,0,'orderProcess.109','orderProcess-1','109','2012-07-08 09:39:20',NULL,NULL,'active',NULL,1),(20001,0,'orderProcess.110','orderProcess-1','110','2012-07-08 14:54:32',NULL,NULL,'active',NULL,1),(50005,0,'orderProcess.114','orderProcess-1','114','2012-07-08 15:33:35',NULL,NULL,'active',NULL,1),(100005,0,'orderProcess.119','orderProcess-1','119','2012-07-09 23:04:33',NULL,NULL,'active',NULL,1),(110001,0,'orderProcess.120','orderProcess-1','120','2012-07-09 23:06:37',NULL,NULL,'active',NULL,1),(120001,0,'orderProcess.121','orderProcess-1','121','2012-07-09 23:10:26',NULL,NULL,'active',NULL,1),(130001,0,'orderProcess.1','orderProcess-1','1','2012-07-10 20:07:20',NULL,NULL,'active',NULL,1),(140001,0,'orderProcess.2','orderProcess-1','2','2012-07-10 20:10:27',NULL,NULL,'active',NULL,1),(150001,0,'orderProcess.3','orderProcess-1','3','2012-07-10 21:07:29',NULL,NULL,'active',NULL,1),(150005,0,'orderProcess.4','orderProcess-1','4','2012-07-10 21:10:45',NULL,NULL,'active',NULL,1),(160005,0,'orderProcess.6','orderProcess-1','6','2012-07-10 21:12:53',NULL,NULL,'active',NULL,1),(170001,0,'orderProcess.7','orderProcess-1','7','2012-07-10 21:22:20',NULL,NULL,'active',NULL,1),(170007,0,'orderProcess.8','orderProcess-1','8','2012-07-10 21:24:15',NULL,NULL,'active',NULL,1),(180005,0,'orderProcess.10','orderProcess-1','10','2012-07-10 21:29:59',NULL,NULL,'active',NULL,1),(190005,0,'orderProcess.12','orderProcess-1','12','2012-07-10 21:37:30',NULL,NULL,'active',NULL,1),(210001,0,'orderProcess.13','orderProcess-1','13','2012-07-10 22:13:11',NULL,NULL,'active',NULL,1),(230005,0,'orderProcess.16','orderProcess-1','16','2012-07-10 22:28:49',NULL,NULL,'active',NULL,1),(240001,0,'orderProcess.17','orderProcess-1','17','2012-07-11 22:35:01',NULL,NULL,'active',NULL,1),(250001,0,'orderProcess.18','orderProcess-1','18','2012-07-11 22:59:28',NULL,NULL,'active',NULL,1),(280001,0,'orderProcess.19','orderProcess-1','19','2012-07-22 20:40:29',NULL,NULL,'active',NULL,1),(310001,0,'orderProcess.27','orderProcess-1','27','2012-08-15 23:39:58',NULL,NULL,'active',NULL,1),(320001,0,'orderProcess.28','orderProcess-1','28','2012-08-15 23:55:08',NULL,NULL,'active',NULL,1),(320007,0,'orderProcess.29','orderProcess-1','29','2012-08-16 00:05:31',NULL,NULL,'active',NULL,1),(320023,0,'orderProcess.30','orderProcess-1','30','2012-08-16 00:29:35',NULL,NULL,'active',NULL,1),(330001,0,'orderProcess.31','orderProcess-1','31','2012-08-16 20:07:46',NULL,NULL,'active',NULL,1),(340001,0,'orderProcess.32','orderProcess-1','32','2012-08-16 20:14:21',NULL,NULL,'active',NULL,1),(340007,0,'orderProcess.33','orderProcess-1','33','2012-08-16 20:17:16',NULL,NULL,'active',NULL,1),(350001,0,'orderProcess.34','orderProcess-1','34','2012-08-16 20:21:38',NULL,NULL,'active',NULL,1),(360001,0,'orderProcess.35','orderProcess-1','35','2012-08-16 23:22:53',NULL,NULL,'active',NULL,1),(370001,0,'orderProcess.36','orderProcess-1','36','2012-08-17 00:44:47',NULL,NULL,'active',NULL,1),(380001,0,'orderProcess.37','orderProcess-1','37','2012-08-17 00:47:24',NULL,NULL,'active',NULL,1),(390001,0,'orderProcess.38','orderProcess-1','38','2012-08-17 00:57:00',NULL,NULL,'active',NULL,1),(400001,0,'orderProcess.39','orderProcess-1','39','2012-08-17 01:08:54',NULL,NULL,'active',NULL,1),(410001,0,'orderProcess.40','orderProcess-1','40','2012-08-17 23:00:08',NULL,NULL,'active',NULL,1),(430001,0,'orderProcess.41','orderProcess-1','41','2012-08-17 23:29:34',NULL,NULL,'active',NULL,1),(440001,0,'orderProcess.42','orderProcess-1','42','2012-08-18 00:49:12',NULL,NULL,'active',NULL,1),(470001,0,'orderProcess.45','orderProcess-1','45','2012-08-18 01:02:39',NULL,NULL,'active',NULL,1),(480001,0,'orderProcess.46','orderProcess-1','46','2012-08-18 01:10:33',NULL,NULL,'active',NULL,1),(490001,0,'orderProcess.47','orderProcess-1','47','2012-08-18 01:15:10',NULL,NULL,'active',NULL,1),(490009,0,'orderProcess.48','orderProcess-1','48','2012-08-18 01:18:35',NULL,NULL,'active',NULL,1),(490017,0,'orderProcess.49','orderProcess-1','49','2012-08-18 01:20:19',NULL,NULL,'active',NULL,1),(500001,0,'orderProcess.50','orderProcess-1','50','2012-08-18 01:26:40',NULL,NULL,'active',NULL,1),(520001,0,'orderProcess.51','orderProcess-1','51','2012-08-18 18:20:22',NULL,NULL,'active',NULL,1),(530001,0,'orderProcess.52','orderProcess-1','52','2012-08-18 18:21:46',NULL,NULL,'active',NULL,1),(560003,0,'orderProcess.53','orderProcess-1','53','2012-08-18 19:24:21',NULL,NULL,'active',NULL,1),(570005,0,'orderProcess.54','orderProcess-1','54','2012-08-18 19:33:38',NULL,NULL,'active',NULL,1),(580001,0,'orderProcess.55','orderProcess-1','55','2012-08-18 19:39:48',NULL,NULL,'active',NULL,1),(600001,0,'orderProcess.56','orderProcess-1','56','2012-08-18 19:44:43',NULL,NULL,'active',NULL,1),(600007,0,'orderProcess.57','orderProcess-1','57','2012-08-18 19:45:31',NULL,NULL,'active',NULL,1),(610001,1,'orderProcess.58','orderProcess-1','58','2012-08-18 19:48:34','2012-08-18 22:13:20',8686439,'ended','结束',1),(620001,1,'orderProcess.59','orderProcess-1','59','2012-08-18 22:41:04','2012-08-18 22:50:00',536157,'ended','结束',1),(630001,0,'orderProcess.60','orderProcess-1','60','2012-08-19 08:17:33',NULL,NULL,'active',NULL,1),(640001,0,'orderProcess.61','orderProcess-1','61','2012-08-19 09:04:54',NULL,NULL,'active',NULL,1),(640007,1,'orderProcess.62','orderProcess-1','62','2012-08-19 11:02:03','2012-08-19 11:30:00',1677136,'ended','结束',1),(650005,0,'orderProcess.64','orderProcess-1','64','2012-08-26 16:59:34',NULL,NULL,'active',NULL,1),(660001,0,'orderProcess.65','orderProcess-1','65','2012-08-27 20:45:18',NULL,NULL,'active',NULL,1),(680001,0,'orderProcess.66','orderProcess-1','66','2012-09-11 22:36:55',NULL,NULL,'active',NULL,1),(690001,0,'orderProcess.67','orderProcess-1','67','2012-10-10 21:03:05',NULL,NULL,'active',NULL,1),(690007,0,'orderProcess.68','orderProcess-1','68','2012-10-10 21:12:36',NULL,NULL,'active',NULL,1),(700001,0,'orderProcess.69','orderProcess-1','69','2012-10-10 21:19:29',NULL,NULL,'active',NULL,1),(700021,0,'orderProcess.70','orderProcess-1','70','2012-10-10 21:49:43',NULL,NULL,'active',NULL,1),(700033,0,'orderProcess.71','orderProcess-1','71','2012-10-10 22:26:29',NULL,NULL,'active',NULL,1),(710001,0,'orderProcess.72','orderProcess-1','72','2012-10-16 22:59:05',NULL,NULL,'active',NULL,1),(720001,0,'orderProcess.73','orderProcess-1','73','2012-10-18 22:00:50',NULL,NULL,'active',NULL,1),(720017,0,'orderProcess.74','orderProcess-1','74','2012-10-18 22:08:35',NULL,NULL,'active',NULL,1);

UNLOCK TABLES;

/*Table structure for table `jbpm4_hist_task` */

DROP TABLE IF EXISTS `jbpm4_hist_task`;

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

/*Data for the table `jbpm4_hist_task` */

LOCK TABLES `jbpm4_hist_task` WRITE;

insert  into `jbpm4_hist_task`(`DBID_`,`DBVERSION_`,`EXECUTION_`,`OUTCOME_`,`ASSIGNEE_`,`PRIORITY_`,`STATE_`,`CREATE_`,`END_`,`DURATION_`,`NEXTIDX_`,`SUPERTASK_`) values (10003,1,'orderProcess.109','待审批','17',0,'completed','2012-07-08 09:39:20','2012-07-08 09:39:21',1286,1,NULL),(10005,1,'orderProcess.109','通过','2',0,'completed','2012-07-08 09:39:21','2012-07-08 09:40:14',53264,1,NULL),(10007,1,'orderProcess.109','分配任务','3',0,'completed','2012-07-08 09:40:14','2012-07-08 09:44:32',258279,1,NULL),(10009,1,'orderProcess.109','确认','11',0,'completed','2012-07-08 09:44:32','2012-07-08 09:49:32',300113,1,NULL),(10011,1,'orderProcess.109','待审批','5',0,'completed','2012-07-08 09:49:32','2012-07-08 09:58:16',524422,1,NULL),(10013,1,'orderProcess.109','不通过','5',0,'completed','2012-07-08 09:58:16','2012-07-08 10:30:30',1934432,1,NULL),(10015,1,'orderProcess.109','待审批','4',0,'completed','2012-07-08 10:30:30','2012-07-08 13:30:04',10774441,1,NULL),(10017,1,'orderProcess.109','通过','5',0,'completed','2012-07-08 13:30:04','2012-07-08 13:58:52',1728736,1,NULL),(10019,0,'orderProcess.109',NULL,'4',0,NULL,'2012-07-08 13:58:52',NULL,0,1,NULL),(20003,1,'orderProcess.110','待审批','17',0,'completed','2012-07-08 14:54:32','2012-07-08 14:54:33',1579,1,NULL),(20005,1,'orderProcess.110','不通过','2',0,'completed','2012-07-08 14:54:33','2012-07-08 14:58:52',259442,1,NULL),(20007,1,'orderProcess.110','待审批','3',0,'completed','2012-07-08 14:58:52','2012-07-08 14:59:32',40538,1,NULL),(20009,1,'orderProcess.110','通过','2',0,'completed','2012-07-08 14:59:32','2012-07-08 23:38:01',31109101,1,NULL),(50007,1,'orderProcess.114','待审批','17',0,'completed','2012-07-08 15:33:35','2012-07-08 15:34:57',82165,1,NULL),(50009,1,'orderProcess.114','通过','2',0,'completed','2012-07-08 15:34:57','2012-07-08 15:35:45',48591,1,NULL),(50011,1,'orderProcess.114','分配任务','3',0,'completed','2012-07-08 15:35:45','2012-07-08 15:36:15',30232,1,NULL),(50013,1,'orderProcess.114','确认','11',0,'completed','2012-07-08 15:36:15','2012-07-08 15:36:39',24119,1,NULL),(50015,1,'orderProcess.114','待审批','5',0,'completed','2012-07-08 15:36:39','2012-07-08 15:37:12',33410,1,NULL),(50017,1,'orderProcess.114','通过','5',0,'completed','2012-07-08 15:37:12','2012-07-08 15:37:48',36381,1,NULL),(50019,0,'orderProcess.114',NULL,'4',0,NULL,'2012-07-08 15:37:48',NULL,0,1,NULL),(60001,1,'orderProcess.110','分配任务','3',0,'completed','2012-07-08 23:38:01','2012-07-09 00:30:33',3152198,1,NULL),(60003,1,'orderProcess.110','确认','11',0,'completed','2012-07-09 00:30:33','2012-07-09 20:46:24',72951184,1,NULL),(70001,1,'orderProcess.110','待审批','5',0,'completed','2012-07-09 20:46:24','2012-07-09 20:46:50',26049,1,NULL),(70003,1,'orderProcess.110','通过','5',0,'completed','2012-07-09 20:46:50','2012-07-09 20:47:10',20179,1,NULL),(70005,0,'orderProcess.110',NULL,'4',0,NULL,'2012-07-09 20:47:10',NULL,0,1,NULL),(100007,0,'orderProcess.119',NULL,'17',0,NULL,'2012-07-09 23:04:33',NULL,0,1,NULL),(110003,0,'orderProcess.120',NULL,'17',0,NULL,'2012-07-09 23:06:37',NULL,0,1,NULL),(120003,1,'orderProcess.121','待审批','17',0,'completed','2012-07-09 23:10:26','2012-07-09 23:10:30',4732,1,NULL),(120005,0,'orderProcess.121',NULL,'1',0,NULL,'2012-07-09 23:10:30',NULL,0,1,NULL),(130003,1,'orderProcess.1','待审批','17',0,'completed','2012-07-10 20:07:20','2012-07-10 20:07:21',1342,1,NULL),(130005,1,'orderProcess.1','通过','1',0,'completed','2012-07-10 20:07:21','2012-07-10 20:07:59',38512,1,NULL),(130007,0,'orderProcess.1',NULL,'2',0,NULL,'2012-07-10 20:07:59',NULL,0,1,NULL),(140003,1,'orderProcess.2','待审批','17',0,'completed','2012-07-10 20:10:27','2012-07-10 20:10:27',896,1,NULL),(140005,1,'orderProcess.2','通过','1',0,'completed','2012-07-10 20:10:27','2012-07-10 20:14:35',248884,1,NULL),(140007,1,'orderProcess.2','分配任务','2',0,'completed','2012-07-10 20:14:35','2012-07-10 20:15:09',34085,1,NULL),(140009,1,'orderProcess.2','确认','10',0,'completed','2012-07-10 20:15:09','2012-07-10 20:15:38',29600,1,NULL),(140011,0,'orderProcess.2',NULL,'4',0,NULL,'2012-07-10 20:15:38',NULL,0,1,NULL),(150003,0,'orderProcess.3',NULL,'17',0,NULL,'2012-07-10 21:07:29',NULL,0,1,NULL),(150007,0,'orderProcess.4',NULL,'17',0,NULL,'2012-07-10 21:10:45',NULL,0,1,NULL),(160007,1,'orderProcess.6','待审批','17',0,'completed','2012-07-10 21:12:53','2012-07-10 21:13:11',18212,1,NULL),(160009,0,'orderProcess.6',NULL,'0',0,NULL,'2012-07-10 21:13:11',NULL,0,1,NULL),(170003,1,'orderProcess.7','待审批','17',0,'completed','2012-07-10 21:22:20','2012-07-10 21:22:22',2231,1,NULL),(170005,0,'orderProcess.7',NULL,'0',0,NULL,'2012-07-10 21:22:22',NULL,0,1,NULL),(170009,0,'orderProcess.8',NULL,'17',0,NULL,'2012-07-10 21:24:15',NULL,0,1,NULL),(180007,1,'orderProcess.10','待审批','17',0,'completed','2012-07-10 21:29:59','2012-07-10 21:30:00',1779,1,NULL),(180009,0,'orderProcess.10',NULL,'0',0,NULL,'2012-07-10 21:30:00',NULL,0,1,NULL),(190007,1,'orderProcess.12','待审批','17',0,'completed','2012-07-10 21:37:30','2012-07-10 21:37:31',1523,1,NULL),(190009,1,'orderProcess.12','通过','0',0,'completed','2012-07-10 21:37:31','2012-07-10 21:43:28',357213,1,NULL),(200001,1,'orderProcess.12','分配任务','0',0,'completed','2012-07-10 21:43:30','2012-07-10 22:06:07',1357587,1,NULL),(200003,1,'orderProcess.12','确认','10',0,'completed','2012-07-10 22:06:07','2012-07-10 22:09:14',187075,1,NULL),(200005,0,'orderProcess.12',NULL,'0',0,NULL,'2012-07-10 22:09:14',NULL,0,1,NULL),(210003,1,'orderProcess.13','待审批','17',0,'completed','2012-07-10 22:13:11','2012-07-10 22:13:12',1276,1,NULL),(210005,1,'orderProcess.13','通过','0',0,'completed','2012-07-10 22:13:12','2012-07-10 22:13:36',24376,1,NULL),(210007,1,'orderProcess.13','分配任务','0',0,'completed','2012-07-10 22:13:36','2012-07-10 22:14:06',30853,1,NULL),(210009,1,'orderProcess.13','确认','10',0,'completed','2012-07-10 22:14:06','2012-07-10 22:14:26',20361,1,NULL),(210011,1,'orderProcess.13','待审批','0',0,'completed','2012-07-10 22:14:26','2012-07-10 22:15:21',55243,1,NULL),(210013,0,'orderProcess.13',NULL,'0',0,NULL,'2012-07-10 22:15:21',NULL,0,1,NULL),(230007,1,'orderProcess.16','待审批','17',0,'completed','2012-07-10 22:28:49','2012-07-10 22:28:50',1891,1,NULL),(230009,1,'orderProcess.16','通过','0',0,'completed','2012-07-10 22:28:50','2012-07-10 22:29:53',63462,1,NULL),(230011,1,'orderProcess.16','分配任务','0',0,'completed','2012-07-10 22:29:53','2012-07-10 22:30:39',46142,1,NULL),(230013,1,'orderProcess.16','确认','10',0,'completed','2012-07-10 22:30:39','2012-07-10 22:31:06',27897,1,NULL),(230015,1,'orderProcess.16','待审批','0',0,'completed','2012-07-10 22:31:06','2012-07-10 22:31:51',45685,1,NULL),(230017,1,'orderProcess.16','通过','0',0,'completed','2012-07-10 22:31:51','2012-07-10 22:32:12',21384,1,NULL),(230019,0,'orderProcess.16',NULL,'0',0,NULL,'2012-07-10 22:32:12',NULL,0,1,NULL),(240003,1,'orderProcess.17','待审批','17',0,'completed','2012-07-11 22:35:01','2012-07-11 22:35:02',1336,1,NULL),(240005,0,'orderProcess.17',NULL,'0',0,NULL,'2012-07-11 22:35:02',NULL,0,1,NULL),(250003,1,'orderProcess.18','待审批','3',0,'completed','2012-07-11 22:59:28','2012-07-11 22:59:29',1448,1,NULL),(250005,1,'orderProcess.18','通过','0',0,'completed','2012-07-11 22:59:29','2012-07-11 23:33:24',2035475,1,NULL),(260001,1,'orderProcess.18','分配任务','0',0,'completed','2012-07-11 23:33:26','2012-07-11 23:40:03',397541,1,NULL),(270001,1,'orderProcess.18','确认','14',0,'completed','2012-07-11 23:40:04','2012-07-11 23:41:50',106245,1,NULL),(270003,1,'orderProcess.18','待审批','0',0,'completed','2012-07-11 23:41:50','2012-07-11 23:45:02',192965,1,NULL),(270005,0,'orderProcess.18',NULL,'0',0,NULL,'2012-07-11 23:45:03',NULL,0,1,NULL),(280003,1,'orderProcess.19','待审批','14',0,'completed','2012-07-22 20:40:29','2012-07-22 20:40:29',801,1,NULL),(280005,1,'orderProcess.19','通过','0',0,'completed','2012-07-22 20:40:29','2012-07-22 20:43:51',202956,1,NULL),(280007,1,'orderProcess.19','分配任务','0',0,'completed','2012-07-22 20:43:51','2012-07-22 20:44:09',18835,1,NULL),(280009,1,'orderProcess.19','确认','15',0,'completed','2012-07-22 20:44:09','2012-07-22 20:44:22',13762,1,NULL),(280011,1,'orderProcess.19','待审批','0',0,'completed','2012-07-22 20:44:22','2012-07-22 20:44:41',19603,1,NULL),(280013,1,'orderProcess.19','通过','0',0,'completed','2012-07-22 20:44:41','2012-07-22 20:52:13',452688,1,NULL),(300001,0,'orderProcess.19',NULL,'0',0,NULL,'2012-07-22 20:52:15',NULL,0,1,NULL),(310003,1,'orderProcess.27','待审批','14',0,'completed','2012-08-15 23:39:58','2012-08-15 23:39:59',1564,1,NULL),(310005,0,'orderProcess.27',NULL,'0',0,NULL,'2012-08-15 23:39:59',NULL,0,1,NULL),(320003,1,'orderProcess.28','待审批','14',0,'completed','2012-08-15 23:55:08','2012-08-15 23:55:09',1290,1,NULL),(320005,0,'orderProcess.28',NULL,'0',0,NULL,'2012-08-15 23:55:09',NULL,0,1,NULL),(320009,1,'orderProcess.29','待审批','14',0,'completed','2012-08-16 00:05:31','2012-08-16 00:05:31',966,1,NULL),(320011,1,'orderProcess.29','通过','0',0,'completed','2012-08-16 00:05:31','2012-08-16 00:09:58',267191,1,NULL),(320013,1,'orderProcess.29','分配任务','0',0,'completed','2012-08-16 00:09:58','2012-08-16 00:18:07',489165,1,NULL),(320015,1,'orderProcess.29','确认','14',0,'completed','2012-08-16 00:18:07','2012-08-16 00:18:17',10163,1,NULL),(320017,1,'orderProcess.29','待审批','0',0,'completed','2012-08-16 00:18:17','2012-08-16 00:18:42',25251,1,NULL),(320019,1,'orderProcess.29','通过','0',0,'completed','2012-08-16 00:18:42','2012-08-16 00:18:55',13644,1,NULL),(320021,0,'orderProcess.29',NULL,'0',0,NULL,'2012-08-16 00:18:55',NULL,0,1,NULL),(320025,1,'orderProcess.30','待审批','14',0,'completed','2012-08-16 00:29:35','2012-08-16 00:29:35',682,1,NULL),(320027,1,'orderProcess.30','通过','0',0,'completed','2012-08-16 00:29:35','2012-08-16 00:29:56',21315,1,NULL),(320029,1,'orderProcess.30','分配任务','0',0,'completed','2012-08-16 00:29:56','2012-08-16 00:30:55',59951,1,NULL),(320031,0,'orderProcess.30',NULL,'15',0,NULL,'2012-08-16 00:30:55',NULL,0,1,NULL),(330003,1,'orderProcess.31','待审批','14',0,'completed','2012-08-16 20:07:46','2012-08-16 20:07:47',1067,1,NULL),(330005,0,'orderProcess.31',NULL,'0',0,NULL,'2012-08-16 20:07:47',NULL,0,1,NULL),(340003,1,'orderProcess.32','待审批','14',0,'completed','2012-08-16 20:14:21','2012-08-16 20:14:21',949,1,NULL),(340005,0,'orderProcess.32',NULL,'0',0,NULL,'2012-08-16 20:14:21',NULL,0,1,NULL),(340009,1,'orderProcess.33','待审批','14',0,'completed','2012-08-16 20:17:16','2012-08-16 20:17:17',1347,1,NULL),(340011,0,'orderProcess.33',NULL,'0',0,NULL,'2012-08-16 20:17:17',NULL,0,1,NULL),(350003,1,'orderProcess.34','待审批','14',0,'completed','2012-08-16 20:21:38','2012-08-16 20:21:39',1288,1,NULL),(350005,0,'orderProcess.34',NULL,'0',0,NULL,'2012-08-16 20:21:39',NULL,0,1,NULL),(360003,1,'orderProcess.35','待审批','10',0,'completed','2012-08-16 23:22:53','2012-08-16 23:22:54',1417,1,NULL),(360005,0,'orderProcess.35',NULL,'0',0,NULL,'2012-08-16 23:22:54',NULL,0,1,NULL),(370003,1,'orderProcess.36','待审批','10',0,'completed','2012-08-17 00:44:47','2012-08-17 00:44:48',1149,1,NULL),(370005,0,'orderProcess.36',NULL,'0',0,NULL,'2012-08-17 00:44:48',NULL,0,1,NULL),(380003,1,'orderProcess.37','待审批','10',0,'completed','2012-08-17 00:47:24','2012-08-17 00:48:35',71225,1,NULL),(380005,0,'orderProcess.37',NULL,'0',0,NULL,'2012-08-17 00:48:35',NULL,0,1,NULL),(390003,1,'orderProcess.38','待审批','10',0,'completed','2012-08-17 00:57:00','2012-08-17 00:57:20',20667,1,NULL),(390005,0,'orderProcess.38',NULL,'0',0,NULL,'2012-08-17 00:57:20',NULL,0,1,NULL),(400003,1,'orderProcess.39','待审批','10',0,'completed','2012-08-17 01:08:54','2012-08-17 01:08:55',1490,1,NULL),(400005,1,'orderProcess.39','通过','0',0,'completed','2012-08-17 01:08:55','2012-08-17 01:10:36',101899,1,NULL),(400007,0,'orderProcess.39',NULL,'0',0,NULL,'2012-08-17 01:10:36',NULL,0,1,NULL),(410003,1,'orderProcess.40','待审批','10',0,'completed','2012-08-17 23:00:08','2012-08-17 23:00:08',754,1,NULL),(410005,1,'orderProcess.40','通过','0',0,'completed','2012-08-17 23:00:08','2012-08-17 23:07:05',417374,1,NULL),(410007,1,'orderProcess.40','分配任务','0',0,'completed','2012-08-17 23:07:05','2012-08-17 23:25:51',1126413,1,NULL),(420001,0,'orderProcess.40',NULL,'16',0,NULL,'2012-08-17 23:25:51',NULL,0,1,NULL),(430003,1,'orderProcess.41','待审批','10',0,'completed','2012-08-17 23:29:34','2012-08-17 23:29:53',19066,1,NULL),(430005,1,'orderProcess.41','通过','0',0,'completed','2012-08-17 23:29:53','2012-08-17 23:31:07',74835,1,NULL),(430007,1,'orderProcess.41','分配任务','0',0,'completed','2012-08-17 23:31:07','2012-08-17 23:31:47',40827,1,NULL),(430009,0,'orderProcess.41',NULL,'16',0,NULL,'2012-08-17 23:31:47',NULL,0,1,NULL),(440003,1,'orderProcess.42','待审批','10',0,'completed','2012-08-18 00:49:12','2012-08-18 00:49:13',1454,1,NULL),(440005,1,'orderProcess.42','不通过','0',0,'completed','2012-08-18 00:49:13','2012-08-18 00:52:54',221573,1,NULL),(440007,0,'orderProcess.42',NULL,'0',0,NULL,'2012-08-18 00:52:54',NULL,0,1,NULL),(470003,1,'orderProcess.45','待审批','10',0,'completed','2012-08-18 01:02:39','2012-08-18 01:02:39',888,1,NULL),(470005,1,'orderProcess.45','不通过','0',0,'completed','2012-08-18 01:02:39','2012-08-18 01:03:27',48634,1,NULL),(470007,0,'orderProcess.45',NULL,'0',0,NULL,'2012-08-18 01:03:27',NULL,0,1,NULL),(480003,1,'orderProcess.46','待审批','10',0,'completed','2012-08-18 01:10:33','2012-08-18 01:10:33',656,1,NULL),(480005,1,'orderProcess.46','不通过','0',0,'completed','2012-08-18 01:10:33','2012-08-18 01:11:33',60727,1,NULL),(480007,0,'orderProcess.46',NULL,'0',0,NULL,'2012-08-18 01:11:33',NULL,0,1,NULL),(490003,1,'orderProcess.47','待审批','10',0,'completed','2012-08-18 01:15:10','2012-08-18 01:15:10',940,1,NULL),(490005,1,'orderProcess.47','不通过','0',0,'completed','2012-08-18 01:15:10','2012-08-18 01:16:24',74564,1,NULL),(490007,0,'orderProcess.47',NULL,'0',0,NULL,'2012-08-18 01:16:24',NULL,0,1,NULL),(490011,1,'orderProcess.48','待审批','10',0,'completed','2012-08-18 01:18:35','2012-08-18 01:18:35',542,1,NULL),(490013,1,'orderProcess.48','不通过','0',0,'completed','2012-08-18 01:18:35','2012-08-18 01:19:14',39364,1,NULL),(490015,0,'orderProcess.48',NULL,'0',0,NULL,'2012-08-18 01:19:14',NULL,0,1,NULL),(490019,1,'orderProcess.49','待审批','10',0,'completed','2012-08-18 01:20:19','2012-08-18 01:20:23',4096,1,NULL),(490021,0,'orderProcess.49',NULL,'0',0,NULL,'2012-08-18 01:20:23',NULL,0,1,NULL),(500003,1,'orderProcess.50','待审批','10',0,'completed','2012-08-18 01:26:40','2012-08-18 01:26:43',3154,1,NULL),(500005,1,'orderProcess.50','不通过','0',0,'completed','2012-08-18 01:26:43','2012-08-18 01:30:50',247504,1,NULL),(510003,1,'orderProcess.50','待审批','0',0,'completed','2012-08-18 01:30:50','2012-08-18 01:32:25',95981,1,NULL),(510005,0,'orderProcess.50',NULL,'0',0,NULL,'2012-08-18 01:32:25',NULL,0,1,NULL),(520003,0,'orderProcess.51',NULL,'10',0,NULL,'2012-08-18 18:20:22',NULL,0,1,NULL),(530003,1,'orderProcess.52','待审批','10',0,'completed','2012-08-18 18:21:46','2012-08-18 18:21:47',1381,1,NULL),(530005,1,'orderProcess.52','不通过','0',0,'completed','2012-08-18 18:21:47','2012-08-18 18:37:46',959824,1,NULL),(540001,1,'orderProcess.52','待审批','0',0,'completed','2012-08-18 18:37:47','2012-08-18 18:39:11',84501,1,NULL),(540003,1,'orderProcess.52','不通过','0',0,'completed','2012-08-18 18:39:11','2012-08-18 18:40:44',93102,1,NULL),(540005,1,'orderProcess.52','待审批','0',0,'completed','2012-08-18 18:40:44','2012-08-18 18:41:38',54043,1,NULL),(540007,1,'orderProcess.52','不通过','0',0,'completed','2012-08-18 18:41:38','2012-08-18 18:45:22',224477,1,NULL),(550001,1,'orderProcess.52','待审批','0',0,'completed','2012-08-18 18:45:23','2012-08-18 18:51:01',338121,1,NULL),(560001,0,'orderProcess.52',NULL,'0',0,NULL,'2012-08-18 18:51:01',NULL,0,1,NULL),(560005,1,'orderProcess.53','待审批','10',0,'completed','2012-08-18 19:24:21','2012-08-18 19:24:22',1553,1,NULL),(560007,1,'orderProcess.53','不通过','0',0,'completed','2012-08-18 19:24:22','2012-08-18 19:30:53',391704,1,NULL),(570001,1,'orderProcess.53','待审批','0',0,'completed','2012-08-18 19:30:55','2012-08-18 19:32:12',77181,1,NULL),(570003,0,'orderProcess.53',NULL,'0',0,NULL,'2012-08-18 19:32:12',NULL,0,1,NULL),(570007,1,'orderProcess.54','待审批','10',0,'completed','2012-08-18 19:33:38','2012-08-18 19:33:49',11356,1,NULL),(570009,1,'orderProcess.54','不通过','0',0,'completed','2012-08-18 19:33:49','2012-08-18 19:34:30',41980,1,NULL),(570011,1,'orderProcess.54','待审批','0',0,'completed','2012-08-18 19:34:30','2012-08-18 19:35:25',55245,1,NULL),(570013,0,'orderProcess.54',NULL,'0',0,NULL,'2012-08-18 19:35:25',NULL,0,1,NULL),(580003,1,'orderProcess.55','待审批','10',0,'completed','2012-08-18 19:39:48','2012-08-18 19:39:57',9354,1,NULL),(580005,1,'orderProcess.55','不通过','0',0,'completed','2012-08-18 19:39:57','2012-08-18 19:41:53',116014,1,NULL),(590001,0,'orderProcess.55',NULL,'0',0,NULL,'2012-08-18 19:41:53',NULL,0,1,NULL),(600003,1,'orderProcess.56','待审批','10',0,'completed','2012-08-18 19:44:43','2012-08-18 19:44:44',1836,1,NULL),(600005,0,'orderProcess.56',NULL,'0',0,NULL,'2012-08-18 19:44:44',NULL,0,1,NULL),(600009,1,'orderProcess.57','待审批','10',0,'completed','2012-08-18 19:45:31','2012-08-18 19:45:31',908,1,NULL),(600011,1,'orderProcess.57','不通过','0',0,'completed','2012-08-18 19:45:31','2012-08-18 19:46:08',37656,1,NULL),(600013,0,'orderProcess.57',NULL,'0',0,NULL,'2012-08-18 19:46:08',NULL,0,1,NULL),(610003,1,'orderProcess.58','待审批','10',0,'completed','2012-08-18 19:48:34','2012-08-18 19:48:34',830,1,NULL),(610005,1,'orderProcess.58','不通过','0',0,'completed','2012-08-18 19:48:34','2012-08-18 19:49:01',27347,1,NULL),(610007,1,'orderProcess.58','待审批','0',0,'completed','2012-08-18 19:49:01','2012-08-18 19:50:02',61058,1,NULL),(610009,1,'orderProcess.58','通过','0',0,'completed','2012-08-18 19:50:02','2012-08-18 19:51:59',117504,1,NULL),(610011,1,'orderProcess.58','分配任务','0',0,'completed','2012-08-18 19:51:59','2012-08-18 20:44:50',3171551,1,NULL),(610013,1,'orderProcess.58','确认','16',0,'completed','2012-08-18 20:44:50','2012-08-18 20:46:09',79818,1,NULL),(610015,1,'orderProcess.58','待审批','0',0,'completed','2012-08-18 20:46:09','2012-08-18 20:49:05',176932,1,NULL),(610017,1,'orderProcess.58','不通过','0',0,'completed','2012-08-18 20:49:05','2012-08-18 20:50:30',85325,1,NULL),(610019,1,'orderProcess.58','待审批','0',0,'completed','2012-08-18 20:50:30','2012-08-18 20:52:06',96438,1,NULL),(610021,1,'orderProcess.58','通过','0',0,'completed','2012-08-18 20:52:06','2012-08-18 20:53:22',76126,1,NULL),(610023,1,'orderProcess.58','判断授课时间','0',0,'completed','2012-08-18 20:53:22','2012-08-18 22:13:18',4796238,1,NULL),(620003,1,'orderProcess.59','待审批','10',0,'completed','2012-08-18 22:41:04','2012-08-18 22:41:04',886,1,NULL),(620005,1,'orderProcess.59','通过','0',0,'completed','2012-08-18 22:41:04','2012-08-18 22:41:35',31008,1,NULL),(620007,1,'orderProcess.59','分配任务','0',0,'completed','2012-08-18 22:41:35','2012-08-18 22:42:17',42818,1,NULL),(620009,1,'orderProcess.59','确认','17',0,'completed','2012-08-18 22:42:17','2012-08-18 22:43:14',57363,1,NULL),(620011,1,'orderProcess.59','待审批','0',0,'completed','2012-08-18 22:43:14','2012-08-18 22:44:26',72525,1,NULL),(620013,1,'orderProcess.59','通过','0',0,'completed','2012-08-18 22:44:26','2012-08-18 22:45:20',54975,1,NULL),(620015,1,'orderProcess.59','判断授课时间','0',0,'completed','2012-08-18 22:45:20','2012-08-18 22:50:00',280091,1,NULL),(630003,1,'orderProcess.60','待审批','10',0,'completed','2012-08-19 08:17:33','2012-08-19 08:17:43',10591,1,NULL),(630005,0,'orderProcess.60',NULL,'0',0,NULL,'2012-08-19 08:17:43',NULL,0,1,NULL),(640003,1,'orderProcess.61','待审批','10',0,'completed','2012-08-19 09:04:54','2012-08-19 09:04:55',1120,1,NULL),(640005,0,'orderProcess.61',NULL,'0',0,NULL,'2012-08-19 09:04:55',NULL,0,1,NULL),(640009,1,'orderProcess.62','待审批','10',0,'completed','2012-08-19 11:02:03','2012-08-19 11:02:03',425,1,NULL),(640011,1,'orderProcess.62','不通过','0',0,'completed','2012-08-19 11:02:03','2012-08-19 11:04:18',135228,1,NULL),(640013,1,'orderProcess.62','待审批','0',0,'completed','2012-08-19 11:04:18','2012-08-19 11:05:40',82939,1,NULL),(640015,1,'orderProcess.62','通过','0',0,'completed','2012-08-19 11:05:40','2012-08-19 11:07:10',90984,1,NULL),(640017,1,'orderProcess.62','分配任务','0',0,'completed','2012-08-19 11:07:10','2012-08-19 11:21:40',870114,1,NULL),(640019,1,'orderProcess.62','确认','16',0,'completed','2012-08-19 11:21:40','2012-08-19 11:23:38',118555,1,NULL),(640021,1,'orderProcess.62','待审批','0',0,'completed','2012-08-19 11:23:38','2012-08-19 11:27:27',229246,1,NULL),(640023,1,'orderProcess.62','通过','0',0,'completed','2012-08-19 11:27:27','2012-08-19 11:28:24',57254,1,NULL),(640025,1,'orderProcess.62','判断授课时间','0',0,'completed','2012-08-19 11:28:24','2012-08-19 11:30:00',96124,1,NULL),(650007,1,'orderProcess.64','待审批','10',0,'completed','2012-08-26 16:59:34','2012-08-26 16:59:34',809,1,NULL),(650009,1,'orderProcess.64','通过','0',0,'completed','2012-08-26 16:59:34','2012-08-27 20:54:46',100512816,1,NULL),(660003,1,'orderProcess.65','待审批','10',0,'completed','2012-08-27 20:45:18','2012-08-27 20:45:18',729,1,NULL),(660005,0,'orderProcess.65',NULL,'0',0,NULL,'2012-08-27 20:45:18',NULL,0,1,NULL),(670001,0,'orderProcess.64',NULL,'0',0,NULL,'2012-08-27 20:54:47',NULL,0,1,NULL),(680003,1,'orderProcess.66','待审批','18',0,'completed','2012-09-11 22:36:55','2012-09-11 22:36:56',1072,1,NULL),(680005,0,'orderProcess.66',NULL,'0',0,NULL,'2012-09-11 22:36:56',NULL,0,1,NULL),(690003,1,'orderProcess.67','待审批','18',0,'completed','2012-10-10 21:03:05','2012-10-10 21:03:06',1071,1,NULL),(690005,0,'orderProcess.67',NULL,'0',0,NULL,'2012-10-10 21:03:06',NULL,0,1,NULL),(690009,1,'orderProcess.68','待审批','18',0,'completed','2012-10-10 21:12:36','2012-10-10 21:12:36',850,1,NULL),(690011,0,'orderProcess.68',NULL,'0',0,NULL,'2012-10-10 21:12:36',NULL,0,1,NULL),(700003,1,'orderProcess.69','待审批','18',0,'completed','2012-10-10 21:19:29','2012-10-10 21:19:31',2435,1,NULL),(700005,1,'orderProcess.69','通过','0',0,'completed','2012-10-10 21:19:31','2012-10-10 21:25:37',366309,1,NULL),(700007,1,'orderProcess.69','分配任务','0',0,'completed','2012-10-10 21:25:37','2012-10-10 21:26:04',27500,1,NULL),(700009,1,'orderProcess.69','确认','17',0,'completed','2012-10-10 21:26:04','2012-10-10 21:26:56',52443,1,NULL),(700011,1,'orderProcess.69','待审批','0',0,'completed','2012-10-10 21:26:56','2012-10-10 21:35:18',502005,1,NULL),(700013,1,'orderProcess.69','不通过','0',0,'completed','2012-10-10 21:35:18','2012-10-10 21:35:47',29480,1,NULL),(700015,1,'orderProcess.69','待审批','0',0,'completed','2012-10-10 21:35:47','2012-10-10 21:37:09',82103,1,NULL),(700017,1,'orderProcess.69','通过','0',0,'completed','2012-10-10 21:37:09','2012-10-10 21:37:28',19560,1,NULL),(700019,0,'orderProcess.69',NULL,'0',0,NULL,'2012-10-10 21:37:28',NULL,0,1,NULL),(700023,1,'orderProcess.70','待审批','18',0,'completed','2012-10-10 21:49:43','2012-10-10 21:49:44',1856,1,NULL),(700025,1,'orderProcess.70','通过','0',0,'completed','2012-10-10 21:49:44','2012-10-10 21:50:51',67443,1,NULL),(700027,1,'orderProcess.70','分配任务','0',0,'completed','2012-10-10 21:50:51','2012-10-10 21:51:10',19942,1,NULL),(700029,1,'orderProcess.70','确认','16',0,'completed','2012-10-10 21:51:10','2012-10-10 21:54:50',220006,1,NULL),(700031,0,'orderProcess.70',NULL,'0',0,NULL,'2012-10-10 21:54:50',NULL,0,1,NULL),(700035,1,'orderProcess.71','待审批','10',0,'completed','2012-10-10 22:26:29','2012-10-10 22:26:30',1389,1,NULL),(700037,0,'orderProcess.71',NULL,'0',0,NULL,'2012-10-10 22:26:30',NULL,0,1,NULL),(710003,1,'orderProcess.72','待审批','18',0,'completed','2012-10-16 22:59:05','2012-10-16 22:59:05',891,1,NULL),(710005,0,'orderProcess.72',NULL,'0',0,NULL,'2012-10-16 22:59:05',NULL,0,1,NULL),(720003,1,'orderProcess.73','待审批','18',0,'completed','2012-10-18 22:00:50','2012-10-18 22:00:59',9224,1,NULL),(720005,1,'orderProcess.73','通过','0',0,'completed','2012-10-18 22:00:59','2012-10-18 22:01:40',41057,1,NULL),(720007,1,'orderProcess.73','分配任务','0',0,'completed','2012-10-18 22:01:40','2012-10-18 22:02:42',62997,1,NULL),(720009,1,'orderProcess.73','确认','17',0,'completed','2012-10-18 22:02:43','2012-10-18 22:03:31',48166,1,NULL),(720011,1,'orderProcess.73','待审批','0',0,'completed','2012-10-18 22:03:31','2012-10-18 22:04:13',42165,1,NULL),(720013,1,'orderProcess.73','通过','0',0,'completed','2012-10-18 22:04:13','2012-10-18 22:04:37',24000,1,NULL),(720015,0,'orderProcess.73',NULL,'0',0,NULL,'2012-10-18 22:04:37',NULL,0,1,NULL),(720019,1,'orderProcess.74','待审批','18',0,'completed','2012-10-18 22:08:35','2012-10-18 22:08:36',1548,1,NULL),(720021,1,'orderProcess.74','通过','0',0,'completed','2012-10-18 22:08:36','2012-10-18 22:09:30',54543,1,NULL),(720023,0,'orderProcess.74',NULL,'0',0,NULL,'2012-10-18 22:09:30',NULL,0,1,NULL);

UNLOCK TABLES;

/*Table structure for table `jbpm4_hist_var` */

DROP TABLE IF EXISTS `jbpm4_hist_var`;

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

/*Data for the table `jbpm4_hist_var` */

LOCK TABLES `jbpm4_hist_var` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_id_group` */

DROP TABLE IF EXISTS `jbpm4_id_group`;

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

/*Data for the table `jbpm4_id_group` */

LOCK TABLES `jbpm4_id_group` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_id_membership` */

DROP TABLE IF EXISTS `jbpm4_id_membership`;

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

/*Data for the table `jbpm4_id_membership` */

LOCK TABLES `jbpm4_id_membership` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_id_user` */

DROP TABLE IF EXISTS `jbpm4_id_user`;

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

/*Data for the table `jbpm4_id_user` */

LOCK TABLES `jbpm4_id_user` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_job` */

DROP TABLE IF EXISTS `jbpm4_job`;

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

/*Data for the table `jbpm4_job` */

LOCK TABLES `jbpm4_job` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_lob` */

DROP TABLE IF EXISTS `jbpm4_lob`;

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

/*Data for the table `jbpm4_lob` */

LOCK TABLES `jbpm4_lob` WRITE;

insert  into `jbpm4_lob`(`DBID_`,`DBVERSION_`,`BLOB_VALUE_`,`DEPLOYMENT_`,`NAME_`) values (2,0,'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n\r\n<process key=\"orderProcess\" name=\"orderProcess\" xmlns=\"http://jbpm.org/4.4/jpdl\">\r\n	<start g=\"-2,55,45,23\" name=\"开始\">\r\n		<transition g=\"-19,-19\" name=\"新签单\" to=\"签约\" />\r\n	</start>\r\n	<task assignee=\"#{userid}\" g=\"113,56,89,40\" name=\"签约\">\r\n		<transition g=\"-37,-14\" name=\"待审批\" to=\"销售主管审批\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"107,135,96,40\" name=\"销售主管审批\">\r\n		<transition g=\"156,189:-33,-14\" name=\"通过\" to=\"教务部处理\" />\r\n		<transition g=\"244,142;247,105;248,79;223,77:-18,7\" name=\"不通过\"\r\n			to=\"签约\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"110,214,89,40\" name=\"教务部处理\">\r\n		<transition name=\"分配任务\" to=\"待班主任确认\" g=\"-22,-13\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"279,216,100,40\" name=\"待班主任确认\">\r\n		<transition g=\"-12,-12\" name=\"确认\" to=\"班主任处理中\" />\r\n		<transition g=\"330,166;251,166:-23,-19\" name=\"拒绝\" to=\"教务部处理\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"274,308,112,40\" name=\"班主任处理中\">\r\n		<transition g=\"-28,-15\" name=\"待审批\" to=\"教务部审批\" />\r\n	</task>\r\n	<task assignee=\"#{userid}\" g=\"100,386,89,40\" name=\"教务部审批\">\r\n		<transition g=\"145,328:-18,9\" name=\"不通过\" to=\"班主任处理中\" />\r\n		<transition name=\"通过\" to=\"授课中\" g=\"-11,-13\" />\r\n	</task> \r\n	<task assignee=\"#{userid}\" g=\"295,549,89,40\" name=\"授课中\">\r\n		<transition g=\"4,-11\" name=\"判断授课时间\" to=\"结束\" />\r\n	</task>\r\n	<end g=\"318,653,28,23\" name=\"结束\" />\r\n</process>',1,'com/core/jbpm/jpdl/order.jpdl.xml');

UNLOCK TABLES;

/*Table structure for table `jbpm4_participation` */

DROP TABLE IF EXISTS `jbpm4_participation`;

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

/*Data for the table `jbpm4_participation` */

LOCK TABLES `jbpm4_participation` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_property` */

DROP TABLE IF EXISTS `jbpm4_property`;

CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_property` */

LOCK TABLES `jbpm4_property` WRITE;

insert  into `jbpm4_property`(`KEY_`,`VERSION_`,`VALUE_`) values ('next.dbid',73,'730001');

UNLOCK TABLES;

/*Table structure for table `jbpm4_swimlane` */

DROP TABLE IF EXISTS `jbpm4_swimlane`;

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

/*Data for the table `jbpm4_swimlane` */

LOCK TABLES `jbpm4_swimlane` WRITE;

UNLOCK TABLES;

/*Table structure for table `jbpm4_task` */

DROP TABLE IF EXISTS `jbpm4_task`;

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

/*Data for the table `jbpm4_task` */

LOCK TABLES `jbpm4_task` WRITE;

insert  into `jbpm4_task`(`DBID_`,`CLASS_`,`DBVERSION_`,`NAME_`,`DESCR_`,`STATE_`,`SUSPHISTSTATE_`,`ASSIGNEE_`,`FORM_`,`PRIORITY_`,`CREATE_`,`DUEDATE_`,`PROGRESS_`,`SIGNALLING_`,`EXECUTION_ID_`,`ACTIVITY_NAME_`,`HASVARS_`,`SUPERTASK_`,`EXECUTION_`,`PROCINST_`,`SWIMLANE_`,`TASKDEFNAME_`) values (10019,'T',1,'授课中',NULL,'open',NULL,'4',NULL,0,'2012-07-08 13:58:52',NULL,NULL,'','orderProcess.109','授课中','\0',NULL,10001,10001,NULL,'授课中'),(50019,'T',1,'授课中',NULL,'open',NULL,'4',NULL,0,'2012-07-08 15:37:48',NULL,NULL,'','orderProcess.114','授课中','\0',NULL,50005,50005,NULL,'授课中'),(70005,'T',1,'授课中',NULL,'open',NULL,'4',NULL,0,'2012-07-09 20:47:10',NULL,NULL,'','orderProcess.110','授课中','\0',NULL,20001,20001,NULL,'授课中'),(100007,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-09 23:04:33',NULL,NULL,'','orderProcess.119','签约','\0',NULL,100005,100005,NULL,'签约'),(110003,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-09 23:06:37',NULL,NULL,'','orderProcess.120','签约','\0',NULL,110001,110001,NULL,'签约'),(120005,'T',1,'销售主管审批',NULL,'open',NULL,'1',NULL,0,'2012-07-09 23:10:30',NULL,NULL,'','orderProcess.121','销售主管审批','\0',NULL,120001,120001,NULL,'销售主管审批'),(130007,'T',1,'教务部处理',NULL,'open',NULL,'2',NULL,0,'2012-07-10 20:07:59',NULL,NULL,'','orderProcess.1','教务部处理','\0',NULL,130001,130001,NULL,'教务部处理'),(140011,'T',1,'班主任处理中',NULL,'open',NULL,'4',NULL,0,'2012-07-10 20:15:38',NULL,NULL,'','orderProcess.2','班主任处理中','\0',NULL,140001,140001,NULL,'班主任处理中'),(150003,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-10 21:07:29',NULL,NULL,'','orderProcess.3','签约','\0',NULL,150001,150001,NULL,'签约'),(150007,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-10 21:10:45',NULL,NULL,'','orderProcess.4','签约','\0',NULL,150005,150005,NULL,'签约'),(160009,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 21:13:11',NULL,NULL,'','orderProcess.6','销售主管审批','\0',NULL,160005,160005,NULL,'销售主管审批'),(170005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 21:22:22',NULL,NULL,'','orderProcess.7','销售主管审批','\0',NULL,170001,170001,NULL,'销售主管审批'),(170009,'T',1,'签约',NULL,'open',NULL,'17',NULL,0,'2012-07-10 21:24:15',NULL,NULL,'','orderProcess.8','签约','\0',NULL,170007,170007,NULL,'签约'),(180009,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 21:30:00',NULL,NULL,'','orderProcess.10','销售主管审批','\0',NULL,180005,180005,NULL,'销售主管审批'),(200005,'T',1,'班主任处理中',NULL,'open',NULL,'0',NULL,0,'2012-07-10 22:09:14',NULL,NULL,'','orderProcess.12','班主任处理中','\0',NULL,190005,190005,NULL,'班主任处理中'),(210013,'T',1,'教务部审批',NULL,'open',NULL,'0',NULL,0,'2012-07-10 22:15:21',NULL,NULL,'','orderProcess.13','教务部审批','\0',NULL,210001,210001,NULL,'教务部审批'),(230019,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-07-10 22:32:12',NULL,NULL,'','orderProcess.16','授课中','\0',NULL,230005,230005,NULL,'授课中'),(240005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-07-11 22:35:02',NULL,NULL,'','orderProcess.17','销售主管审批','\0',NULL,240001,240001,NULL,'销售主管审批'),(270005,'T',1,'教务部审批',NULL,'open',NULL,'0',NULL,0,'2012-07-11 23:45:02',NULL,NULL,'','orderProcess.18','教务部审批','\0',NULL,250001,250001,NULL,'教务部审批'),(300001,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-07-22 20:52:15',NULL,NULL,'','orderProcess.19','授课中','\0',NULL,280001,280001,NULL,'授课中'),(310005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-15 23:39:59',NULL,NULL,'','orderProcess.27','销售主管审批','\0',NULL,310001,310001,NULL,'销售主管审批'),(320005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-15 23:55:09',NULL,NULL,'','orderProcess.28','销售主管审批','\0',NULL,320001,320001,NULL,'销售主管审批'),(320021,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-08-16 00:18:55',NULL,NULL,'','orderProcess.29','授课中','\0',NULL,320007,320007,NULL,'授课中'),(320031,'T',1,'待班主任确认',NULL,'open',NULL,'15',NULL,0,'2012-08-16 00:30:55',NULL,NULL,'','orderProcess.30','待班主任确认','\0',NULL,320023,320023,NULL,'待班主任确认'),(330005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:07:47',NULL,NULL,'','orderProcess.31','销售主管审批','\0',NULL,330001,330001,NULL,'销售主管审批'),(340005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:14:21',NULL,NULL,'','orderProcess.32','销售主管审批','\0',NULL,340001,340001,NULL,'销售主管审批'),(340011,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:17:17',NULL,NULL,'','orderProcess.33','销售主管审批','\0',NULL,340007,340007,NULL,'销售主管审批'),(350005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 20:21:39',NULL,NULL,'','orderProcess.34','销售主管审批','\0',NULL,350001,350001,NULL,'销售主管审批'),(360005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-16 23:22:54',NULL,NULL,'','orderProcess.35','销售主管审批','\0',NULL,360001,360001,NULL,'销售主管审批'),(370005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-17 00:44:48',NULL,NULL,'','orderProcess.36','销售主管审批','\0',NULL,370001,370001,NULL,'销售主管审批'),(380005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-17 00:48:35',NULL,NULL,'','orderProcess.37','销售主管审批','\0',NULL,380001,380001,NULL,'销售主管审批'),(390005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-17 00:57:20',NULL,NULL,'','orderProcess.38','销售主管审批','\0',NULL,390001,390001,NULL,'销售主管审批'),(400007,'T',1,'教务部处理',NULL,'open',NULL,'0',NULL,0,'2012-08-17 01:10:36',NULL,NULL,'','orderProcess.39','教务部处理','\0',NULL,400001,400001,NULL,'教务部处理'),(420001,'T',1,'待班主任确认',NULL,'open',NULL,'16',NULL,0,'2012-08-17 23:25:51',NULL,NULL,'','orderProcess.40','待班主任确认','\0',NULL,410001,410001,NULL,'待班主任确认'),(430009,'T',1,'待班主任确认',NULL,'open',NULL,'16',NULL,0,'2012-08-17 23:31:47',NULL,NULL,'','orderProcess.41','待班主任确认','\0',NULL,430001,430001,NULL,'待班主任确认'),(440007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 00:52:54',NULL,NULL,'','orderProcess.42','签约','\0',NULL,440001,440001,NULL,'签约'),(470007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:03:27',NULL,NULL,'','orderProcess.45','签约','\0',NULL,470001,470001,NULL,'签约'),(480007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:11:33',NULL,NULL,'','orderProcess.46','签约','\0',NULL,480001,480001,NULL,'签约'),(490007,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:16:24',NULL,NULL,'','orderProcess.47','签约','\0',NULL,490001,490001,NULL,'签约'),(490015,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:19:14',NULL,NULL,'','orderProcess.48','签约','\0',NULL,490009,490009,NULL,'签约'),(490021,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:20:23',NULL,NULL,'','orderProcess.49','销售主管审批','\0',NULL,490017,490017,NULL,'销售主管审批'),(510005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 01:32:25',NULL,NULL,'','orderProcess.50','销售主管审批','\0',NULL,500001,500001,NULL,'销售主管审批'),(520003,'T',1,'签约',NULL,'open',NULL,'10',NULL,0,'2012-08-18 18:20:22',NULL,NULL,'','orderProcess.51','签约','\0',NULL,520001,520001,NULL,'签约'),(560001,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 18:51:01',NULL,NULL,'','orderProcess.52','销售主管审批','\0',NULL,530001,530001,NULL,'销售主管审批'),(570003,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:32:12',NULL,NULL,'','orderProcess.53','销售主管审批','\0',NULL,560003,560003,NULL,'销售主管审批'),(570013,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:35:25',NULL,NULL,'','orderProcess.54','销售主管审批','\0',NULL,570005,570005,NULL,'销售主管审批'),(590001,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:41:53',NULL,NULL,'','orderProcess.55','签约','\0',NULL,580001,580001,NULL,'签约'),(600005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:44:44',NULL,NULL,'','orderProcess.56','销售主管审批','\0',NULL,600001,600001,NULL,'销售主管审批'),(600013,'T',1,'签约',NULL,'open',NULL,'0',NULL,0,'2012-08-18 19:46:08',NULL,NULL,'','orderProcess.57','签约','\0',NULL,600007,600007,NULL,'签约'),(630005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-19 08:17:43',NULL,NULL,'','orderProcess.60','销售主管审批','\0',NULL,630001,630001,NULL,'销售主管审批'),(640005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-19 09:04:55',NULL,NULL,'','orderProcess.61','销售主管审批','\0',NULL,640001,640001,NULL,'销售主管审批'),(660005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-08-27 20:45:18',NULL,NULL,'','orderProcess.65','销售主管审批','\0',NULL,660001,660001,NULL,'销售主管审批'),(670001,'T',1,'教务部处理',NULL,'open',NULL,'0',NULL,0,'2012-08-27 20:54:47',NULL,NULL,'','orderProcess.64','教务部处理','\0',NULL,650005,650005,NULL,'教务部处理'),(680005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-09-11 22:36:56',NULL,NULL,'','orderProcess.66','销售主管审批','\0',NULL,680001,680001,NULL,'销售主管审批'),(690005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:03:06',NULL,NULL,'','orderProcess.67','销售主管审批','\0',NULL,690001,690001,NULL,'销售主管审批'),(690011,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:12:36',NULL,NULL,'','orderProcess.68','销售主管审批','\0',NULL,690007,690007,NULL,'销售主管审批'),(700019,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:37:28',NULL,NULL,'','orderProcess.69','授课中','\0',NULL,700001,700001,NULL,'授课中'),(700031,'T',1,'班主任处理中',NULL,'open',NULL,'0',NULL,0,'2012-10-10 21:54:50',NULL,NULL,'','orderProcess.70','班主任处理中','\0',NULL,700021,700021,NULL,'班主任处理中'),(700037,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-10 22:26:30',NULL,NULL,'','orderProcess.71','销售主管审批','\0',NULL,700033,700033,NULL,'销售主管审批'),(710005,'T',1,'销售主管审批',NULL,'open',NULL,'0',NULL,0,'2012-10-16 22:59:05',NULL,NULL,'','orderProcess.72','销售主管审批','\0',NULL,710001,710001,NULL,'销售主管审批'),(720015,'T',1,'授课中',NULL,'open',NULL,'0',NULL,0,'2012-10-18 22:04:37',NULL,NULL,'','orderProcess.73','授课中','\0',NULL,720001,720001,NULL,'授课中'),(720023,'T',1,'教务部处理',NULL,'open',NULL,'0',NULL,0,'2012-10-18 22:09:30',NULL,NULL,'','orderProcess.74','教务部处理','\0',NULL,720017,720017,NULL,'教务部处理');

UNLOCK TABLES;

/*Table structure for table `jbpm4_variable` */

DROP TABLE IF EXISTS `jbpm4_variable`;

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

/*Data for the table `jbpm4_variable` */

LOCK TABLES `jbpm4_variable` WRITE;

insert  into `jbpm4_variable`(`DBID_`,`CLASS_`,`DBVERSION_`,`KEY_`,`CONVERTER_`,`HIST_`,`EXECUTION_`,`TASK_`,`LOB_`,`DATE_VALUE_`,`DOUBLE_VALUE_`,`CLASSNAME_`,`LONG_VALUE_`,`STRING_VALUE_`,`TEXT_VALUE_`,`EXESYS_`) values (10002,'string',7,'userid',NULL,'\0',10001,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(20002,'string',7,'userid',NULL,'\0',20001,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(50006,'string',5,'userid',NULL,'\0',50005,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(100006,'string',0,'userid',NULL,'\0',100005,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(110002,'string',0,'userid',NULL,'\0',110001,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(120002,'string',1,'userid',NULL,'\0',120001,NULL,NULL,NULL,NULL,NULL,NULL,'1',NULL,NULL),(130002,'string',2,'userid',NULL,'\0',130001,NULL,NULL,NULL,NULL,NULL,NULL,'2',NULL,NULL),(140002,'string',4,'userid',NULL,'\0',140001,NULL,NULL,NULL,NULL,NULL,NULL,'4',NULL,NULL),(150002,'string',0,'userid',NULL,'\0',150001,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(150006,'string',0,'userid',NULL,'\0',150005,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(160006,'string',1,'userid',NULL,'\0',160005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(170002,'string',1,'userid',NULL,'\0',170001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(170008,'string',0,'userid',NULL,'\0',170007,NULL,NULL,NULL,NULL,NULL,NULL,'17',NULL,NULL),(180006,'string',1,'userid',NULL,'\0',180005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(190006,'string',3,'userid',NULL,'\0',190005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(210002,'string',3,'userid',NULL,'\0',210001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(230006,'string',3,'userid',NULL,'\0',230005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(240002,'string',1,'userid',NULL,'\0',240001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(250002,'string',3,'userid',NULL,'\0',250001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(280002,'string',3,'userid',NULL,'\0',280001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(310002,'string',1,'userid',NULL,'\0',310001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(320002,'string',1,'userid',NULL,'\0',320001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(320008,'string',3,'userid',NULL,'\0',320007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(320024,'string',2,'userid',NULL,'\0',320023,NULL,NULL,NULL,NULL,NULL,NULL,'15',NULL,NULL),(330002,'string',1,'userid',NULL,'\0',330001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(340002,'string',1,'userid',NULL,'\0',340001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(340008,'string',1,'userid',NULL,'\0',340007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(350002,'string',1,'userid',NULL,'\0',350001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(360002,'string',1,'userid',NULL,'\0',360001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(370002,'string',1,'userid',NULL,'\0',370001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(380002,'string',1,'userid',NULL,'\0',380001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(390002,'string',1,'userid',NULL,'\0',390001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(400002,'string',1,'userid',NULL,'\0',400001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(410002,'string',2,'userid',NULL,'\0',410001,NULL,NULL,NULL,NULL,NULL,NULL,'16',NULL,NULL),(430002,'string',2,'userid',NULL,'\0',430001,NULL,NULL,NULL,NULL,NULL,NULL,'16',NULL,NULL),(440002,'string',1,'userid',NULL,'\0',440001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(470002,'string',1,'userid',NULL,'\0',470001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(480002,'string',1,'userid',NULL,'\0',480001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(490002,'string',1,'userid',NULL,'\0',490001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(490010,'string',1,'userid',NULL,'\0',490009,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(490018,'string',1,'userid',NULL,'\0',490017,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(500002,'string',1,'userid',NULL,'\0',500001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(520002,'string',0,'userid',NULL,'\0',520001,NULL,NULL,NULL,NULL,NULL,NULL,'10',NULL,NULL),(530002,'string',1,'userid',NULL,'\0',530001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(560004,'string',1,'userid',NULL,'\0',560003,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(570006,'string',1,'userid',NULL,'\0',570005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(580002,'string',1,'userid',NULL,'\0',580001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(600002,'string',1,'userid',NULL,'\0',600001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(600008,'string',1,'userid',NULL,'\0',600007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(630002,'string',1,'userid',NULL,'\0',630001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(640002,'string',1,'userid',NULL,'\0',640001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(650006,'string',1,'userid',NULL,'\0',650005,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(660002,'string',1,'userid',NULL,'\0',660001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(680002,'string',1,'userid',NULL,'\0',680001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(690002,'string',1,'userid',NULL,'\0',690001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(690008,'string',1,'userid',NULL,'\0',690007,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(700002,'string',3,'userid',NULL,'\0',700001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(700022,'string',3,'userid',NULL,'\0',700021,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(700034,'string',1,'userid',NULL,'\0',700033,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(710002,'string',1,'userid',NULL,'\0',710001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(720002,'string',3,'userid',NULL,'\0',720001,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL),(720018,'string',1,'userid',NULL,'\0',720017,NULL,NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `notice` */

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) NOT NULL COMMENT '发送者id',
  `receiver_id` int(10) NOT NULL COMMENT '接收者id ',
  `status` char(1) NOT NULL COMMENT '通知状态 0: 未读, 1:已读 ',
  `content` varchar(2000) NOT NULL COMMENT '交流内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=379 DEFAULT CHARSET=utf8 COMMENT='公告表';

/*Data for the table `notice` */

LOCK TABLES `notice` WRITE;

insert  into `notice`(`id`,`sender_id`,`receiver_id`,`status`,`content`,`create_time`,`last_update`) values (193,18,14,'0','222222','2012-11-10 23:50:05','2012-11-10 23:50:05'),(194,18,15,'0','222222','2012-11-10 23:50:05','2012-11-10 23:50:05'),(195,18,16,'0','222222','2012-11-10 23:50:05','2012-11-10 23:50:05'),(196,18,17,'0','222222','2012-11-10 23:50:05','2012-11-10 23:50:05'),(197,18,18,'1','222222','2012-11-10 23:50:05','2012-11-10 23:50:28'),(198,18,19,'0','222222','2012-11-10 23:50:05','2012-11-10 23:50:05'),(199,18,20,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(200,18,21,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(201,18,22,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(202,18,5,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(203,18,7,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(204,18,10,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(205,18,13,'0','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(206,18,5,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:08:47','2012-11-11 00:08:47'),(207,18,7,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:08:47','2012-11-11 00:08:47'),(208,18,14,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:02','2012-11-11 00:13:02'),(209,18,15,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:02','2012-11-11 00:13:02'),(210,18,17,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:21','2012-11-11 00:13:21'),(211,18,17,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:36','2012-11-11 00:13:36'),(212,18,14,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:14:08','2012-11-11 00:14:08'),(213,18,15,'0','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:14:08','2012-11-11 00:14:08'),(214,18,5,'0','你有1条新的未办签单信息，请查看签单编号【112】','2012-11-14 21:54:59','2012-11-14 21:54:59'),(215,18,7,'0','你有1条新的未办签单信息，请查看签单编号【112】','2012-11-14 21:54:59','2012-11-14 21:54:59'),(216,18,5,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:05:10','2012-11-14 22:05:10'),(217,18,7,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:05:10','2012-11-14 22:05:10'),(218,18,14,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:31:23','2012-11-14 22:31:23'),(219,18,15,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:31:23','2012-11-14 22:31:23'),(220,18,16,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:31:46','2012-11-14 22:31:46'),(221,18,16,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:32:03','2012-11-14 22:32:03'),(222,18,14,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:32:29','2012-11-14 22:32:29'),(223,18,15,'0','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:32:29','2012-11-14 22:32:29'),(224,18,5,'0','你有1条新的未办签单信息，请查看签单编号【116】','2012-11-19 21:11:20','2012-11-19 21:11:20'),(225,18,7,'0','你有1条新的未办签单信息，请查看签单编号【116】','2012-11-19 21:11:20','2012-11-19 21:11:20'),(226,18,5,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-19 21:18:09','2012-11-19 21:18:09'),(227,18,7,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-19 21:18:09','2012-11-19 21:18:09'),(228,18,5,'0','你有1条新的未办签单信息，请查看签单编号【118】','2012-11-19 21:24:57','2012-11-19 21:24:57'),(229,18,7,'0','你有1条新的未办签单信息，请查看签单编号【118】','2012-11-19 21:24:57','2012-11-19 21:24:57'),(230,18,5,'0','你有1条新的未办签单信息，请查看签单编号【120】','2012-11-19 22:11:30','2012-11-19 22:11:30'),(231,18,7,'0','你有1条新的未办签单信息，请查看签单编号【120】','2012-11-19 22:11:30','2012-11-19 22:11:30'),(232,18,5,'0','你有1条新的未办签单信息，请查看签单编号【121】','2012-11-19 22:13:35','2012-11-19 22:13:35'),(233,18,7,'0','你有1条新的未办签单信息，请查看签单编号【121】','2012-11-19 22:13:35','2012-11-19 22:13:35'),(234,18,5,'0','你有1条新的未办签单信息，请查看签单编号【123】','2012-11-19 22:29:44','2012-11-19 22:29:44'),(235,18,7,'0','你有1条新的未办签单信息，请查看签单编号【123】','2012-11-19 22:29:44','2012-11-19 22:29:44'),(236,18,5,'0','你有1条新的未办签单信息，请查看签单编号【125】','2012-11-21 22:12:55','2012-11-21 22:12:55'),(237,18,7,'0','你有1条新的未办签单信息，请查看签单编号【125】','2012-11-21 22:12:55','2012-11-21 22:12:55'),(238,18,5,'0','你有1条新的未办签单信息，请查看签单编号【126】','2012-11-21 22:33:15','2012-11-21 22:33:15'),(239,18,7,'0','你有1条新的未办签单信息，请查看签单编号【126】','2012-11-21 22:33:15','2012-11-21 22:33:15'),(240,18,5,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:37:25','2012-11-21 22:37:25'),(241,18,7,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:37:25','2012-11-21 22:37:25'),(242,18,14,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:43:09','2012-11-21 22:43:09'),(243,18,15,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:43:09','2012-11-21 22:43:09'),(244,18,16,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:43:41','2012-11-21 22:43:41'),(245,18,16,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:44:03','2012-11-21 22:44:03'),(246,18,14,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:44:37','2012-11-21 22:44:37'),(247,18,15,'0','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:44:37','2012-11-21 22:44:37'),(248,18,15,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 23:04:07','2012-11-27 23:04:07'),(249,18,15,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 23:16:29','2012-11-27 23:16:29'),(250,18,15,'0','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 23:16:42','2012-11-27 23:16:42'),(251,18,5,'0','你有1条新的未办签单信息，请查看签单编号【128】','2012-12-01 23:16:11','2012-12-01 23:16:11'),(252,18,7,'0','你有1条新的未办签单信息，请查看签单编号【128】','2012-12-01 23:16:11','2012-12-01 23:16:11'),(253,18,5,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:33:58','2012-12-03 21:33:58'),(254,18,7,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:33:58','2012-12-03 21:33:58'),(255,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:37:57','2012-12-03 21:37:57'),(256,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:39:40','2012-12-03 21:39:40'),(257,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:40:38','2012-12-03 21:40:38'),(258,18,15,'0','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:51:32','2012-12-03 21:51:32'),(259,18,5,'0','你有1条新的未办签单信息，请查看签单编号【130】','2012-12-03 22:40:21','2012-12-03 22:40:21'),(260,18,7,'0','你有1条新的未办签单信息，请查看签单编号【130】','2012-12-03 22:40:21','2012-12-03 22:40:21'),(261,18,5,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:26:39','2012-12-04 22:26:39'),(262,18,7,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:26:39','2012-12-04 22:26:39'),(263,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:29:28','2012-12-04 22:29:28'),(264,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:33:03','2012-12-04 22:33:03'),(265,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:33:32','2012-12-04 22:33:32'),(266,18,15,'0','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:34:36','2012-12-04 22:34:36'),(267,18,5,'0','你有1条新的未办签单信息，请查看签单编号【5】','2012-12-10 22:36:56','2012-12-10 22:36:56'),(268,18,7,'0','你有1条新的未办签单信息，请查看签单编号【5】','2012-12-10 22:36:56','2012-12-10 22:36:56'),(269,18,5,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-01-31 09:37:40','2015-01-31 09:37:40'),(270,18,7,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-01-31 09:37:40','2015-01-31 09:37:40'),(271,18,5,'0','你有1条新的未办签单信息，请查看签单编号【7】','2015-01-31 09:48:25','2015-01-31 09:48:25'),(272,18,7,'0','你有1条新的未办签单信息，请查看签单编号【7】','2015-01-31 09:48:25','2015-01-31 09:48:25'),(273,18,5,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-01-31 10:00:00','2015-01-31 10:00:00'),(274,18,7,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-01-31 10:00:00','2015-01-31 10:00:00'),(275,18,5,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-01-31 10:02:36','2015-01-31 10:02:36'),(276,18,7,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-01-31 10:02:36','2015-01-31 10:02:36'),(277,18,5,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-01-31 10:10:47','2015-01-31 10:10:47'),(278,18,7,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-01-31 10:10:47','2015-01-31 10:10:47'),(279,18,15,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-01-31 10:27:10','2015-01-31 10:27:10'),(280,18,5,'0','你有1条新的未办签单信息，请查看签单编号【11】','2015-01-31 11:07:13','2015-01-31 11:07:13'),(281,18,7,'0','你有1条新的未办签单信息，请查看签单编号【11】','2015-01-31 11:07:13','2015-01-31 11:07:13'),(282,18,5,'0','你有1条新的未办签单信息，请查看签单编号【1】','2015-04-04 22:41:18','2015-04-04 22:41:18'),(283,18,7,'0','你有1条新的未办签单信息，请查看签单编号【1】','2015-04-04 22:41:18','2015-04-04 22:41:18'),(284,18,5,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 22:47:36','2015-04-04 22:47:36'),(285,18,7,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 22:47:36','2015-04-04 22:47:36'),(286,18,5,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-04 22:51:11','2015-04-04 22:51:11'),(287,18,7,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-04 22:51:11','2015-04-04 22:51:11'),(288,18,5,'0','你有1条新的未办签单信息，请查看签单编号【1】','2015-04-04 23:15:21','2015-04-04 23:15:21'),(289,18,7,'0','你有1条新的未办签单信息，请查看签单编号【1】','2015-04-04 23:15:21','2015-04-04 23:15:21'),(290,18,5,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 23:22:02','2015-04-04 23:22:02'),(291,18,7,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 23:22:02','2015-04-04 23:22:02'),(292,18,15,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 23:35:35','2015-04-04 23:35:35'),(293,18,15,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-05 00:57:51','2015-04-05 00:57:51'),(294,18,18,'0','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-06 10:12:50','2015-04-06 10:12:50'),(295,18,10,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:20:23','2015-04-06 10:20:23'),(296,18,13,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:20:23','2015-04-06 10:20:23'),(297,18,5,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:20:31','2015-04-06 10:20:31'),(298,18,7,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:20:31','2015-04-06 10:20:31'),(299,18,14,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:21:13','2015-04-06 10:21:13'),(300,18,14,'0','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:21:30','2015-04-06 10:21:30'),(301,18,5,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:22:50','2015-04-06 10:22:50'),(302,18,7,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:22:50','2015-04-06 10:22:50'),(303,18,14,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:10','2015-04-06 10:23:10'),(304,18,15,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:10','2015-04-06 10:23:10'),(305,18,14,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:19','2015-04-06 10:23:19'),(306,18,14,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:38','2015-04-06 10:23:38'),(307,18,14,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:39:47','2015-04-06 10:39:47'),(308,18,15,'0','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:39:47','2015-04-06 10:39:47'),(309,18,18,'1','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 11:58:57','2015-04-06 22:31:00'),(310,18,18,'1','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 12:07:29','2015-04-06 22:30:58'),(311,18,5,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:38','2015-04-06 12:11:38'),(312,18,7,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:38','2015-04-06 12:11:38'),(313,18,14,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:50','2015-04-06 12:11:50'),(314,18,15,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:50','2015-04-06 12:11:50'),(315,18,14,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:59','2015-04-06 12:11:59'),(316,18,14,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:12:06','2015-04-06 12:12:06'),(317,18,14,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:12:24','2015-04-06 12:12:24'),(318,18,15,'0','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:12:24','2015-04-06 12:12:24'),(319,18,5,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:16:24','2015-04-06 22:16:24'),(320,18,7,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:16:24','2015-04-06 22:16:24'),(321,18,14,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:19:00','2015-04-06 22:19:00'),(322,18,15,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:19:00','2015-04-06 22:19:00'),(323,18,15,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:20:18','2015-04-06 22:20:18'),(324,18,18,'1','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:21:28','2015-04-06 22:30:52'),(325,18,17,'0','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:30:06','2015-04-06 22:30:06'),(326,18,5,'0','你有1条新的未办签单信息，请查看签单编号【7】','2015-04-06 22:33:29','2015-04-06 22:33:29'),(327,18,7,'0','你有1条新的未办签单信息，请查看签单编号【7】','2015-04-06 22:33:29','2015-04-06 22:33:29'),(328,18,14,'0','你有1条新的未办签单信息，请查看签单编号【7】','2015-04-06 22:33:45','2015-04-06 22:33:45'),(329,18,15,'0','你有1条新的未办签单信息，请查看签单编号【7】','2015-04-06 22:33:45','2015-04-06 22:33:45'),(330,18,5,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:43:53','2015-04-06 22:43:53'),(331,18,7,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:43:53','2015-04-06 22:43:53'),(332,18,14,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:45:13','2015-04-06 22:45:13'),(333,18,15,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:45:13','2015-04-06 22:45:13'),(334,18,16,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:45:37','2015-04-06 22:45:37'),(335,18,18,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:50:07','2015-04-06 22:50:07'),(336,18,16,'0','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:52:45','2015-04-06 22:52:45'),(337,18,5,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:02','2015-04-06 22:56:02'),(338,18,7,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:02','2015-04-06 22:56:02'),(339,18,14,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:12','2015-04-06 22:56:12'),(340,18,15,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:12','2015-04-06 22:56:12'),(341,18,16,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:19','2015-04-06 22:56:19'),(342,18,17,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:19','2015-04-06 22:56:19'),(343,18,18,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:39','2015-04-06 22:56:39'),(344,18,18,'0','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:50','2015-04-06 22:56:50'),(345,18,5,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 22:59:30','2015-04-06 22:59:30'),(346,18,7,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 22:59:30','2015-04-06 22:59:30'),(347,18,15,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:00:42','2015-04-06 23:00:42'),(348,18,17,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:01:00','2015-04-06 23:01:00'),(349,18,18,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:01:13','2015-04-06 23:01:13'),(350,18,17,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:01:30','2015-04-06 23:01:30'),(351,18,15,'0','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:02:00','2015-04-06 23:02:00'),(352,18,5,'0','你有1条新的未办签单信息，请查看签单编号【12】','2015-04-06 23:16:03','2015-04-06 23:16:03'),(353,18,7,'0','你有1条新的未办签单信息，请查看签单编号【12】','2015-04-06 23:16:03','2015-04-06 23:16:03'),(354,18,5,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:20:36','2015-04-06 23:20:36'),(355,18,7,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:20:36','2015-04-06 23:20:36'),(356,18,14,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:21:51','2015-04-06 23:21:51'),(357,18,17,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:22:04','2015-04-06 23:22:04'),(358,18,14,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:22:34','2015-04-06 23:22:34'),(359,18,18,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:23:36','2015-04-06 23:23:36'),(360,18,14,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:23:53','2015-04-06 23:23:53'),(361,18,18,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:24:31','2015-04-06 23:24:31'),(362,18,14,'0','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:25:42','2015-04-06 23:25:42'),(363,18,5,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-06 23:26:33','2015-04-06 23:26:33'),(364,18,7,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-06 23:26:33','2015-04-06 23:26:33'),(365,18,14,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-06 23:26:48','2015-04-06 23:26:48'),(366,18,16,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:52:36','2015-04-08 20:52:36'),(367,18,18,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:52:53','2015-04-08 20:52:53'),(368,18,17,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:53:35','2015-04-08 20:53:35'),(369,18,14,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:53:52','2015-04-08 20:53:52'),(370,18,18,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:55:28','2015-04-08 20:55:28'),(371,18,14,'0','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:59:13','2015-04-08 20:59:13'),(372,18,5,'0','你有1条新的未办签单信息，请查看签单编号【15】','2015-04-08 21:29:30','2015-04-08 21:29:30'),(373,18,7,'0','你有1条新的未办签单信息，请查看签单编号【15】','2015-04-08 21:29:30','2015-04-08 21:29:30'),(374,18,5,'0','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:37:19','2015-04-10 22:37:19'),(375,18,7,'0','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:37:19','2015-04-10 22:37:19'),(376,18,14,'0','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:54:05','2015-04-10 22:54:05'),(377,18,16,'0','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:55:09','2015-04-10 22:55:09'),(378,18,14,'0','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:56:15','2015-04-10 22:56:15');

UNLOCK TABLES;

/*Table structure for table `notice_his` */

DROP TABLE IF EXISTS `notice_his`;

CREATE TABLE `notice_his` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `sender_id` int(10) NOT NULL COMMENT '发送者id',
  `receiver_type` char(1) NOT NULL COMMENT '接收者类型 0:个人 1:角色 2:部门 3:全部人',
  `receiver_id` varchar(500) NOT NULL COMMENT '接收者id,多个以，分隔',
  `content` varchar(2000) NOT NULL COMMENT '交流内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=utf8 COMMENT='公告表历史表';

/*Data for the table `notice_his` */

LOCK TABLES `notice_his` WRITE;

insert  into `notice_his`(`id`,`sender_id`,`receiver_type`,`receiver_id`,`content`,`create_time`,`last_update`) values (116,18,'0','14,15,16,17,18,19,20,21,22,5,7,10,13','222222','2012-11-10 23:50:06','2012-11-10 23:50:06'),(117,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:08:47','2012-11-11 00:08:47'),(118,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:02','2012-11-11 00:13:02'),(119,18,'0','17','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:21','2012-11-11 00:13:21'),(120,18,'0','17','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:13:36','2012-11-11 00:13:36'),(121,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【110】','2012-11-11 00:14:08','2012-11-11 00:14:08'),(122,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【112】','2012-11-14 21:54:59','2012-11-14 21:54:59'),(123,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:05:10','2012-11-14 22:05:10'),(124,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:31:23','2012-11-14 22:31:23'),(125,18,'0','16','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:31:46','2012-11-14 22:31:46'),(126,18,'0','16','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:32:03','2012-11-14 22:32:03'),(127,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【113】','2012-11-14 22:32:29','2012-11-14 22:32:29'),(128,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【116】','2012-11-19 21:11:20','2012-11-19 21:11:20'),(129,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-19 21:18:09','2012-11-19 21:18:09'),(130,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【118】','2012-11-19 21:24:57','2012-11-19 21:24:57'),(131,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【120】','2012-11-19 22:11:30','2012-11-19 22:11:30'),(132,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【121】','2012-11-19 22:13:35','2012-11-19 22:13:35'),(133,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【123】','2012-11-19 22:29:44','2012-11-19 22:29:44'),(134,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【125】','2012-11-21 22:12:55','2012-11-21 22:12:55'),(135,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【126】','2012-11-21 22:33:15','2012-11-21 22:33:15'),(136,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:37:25','2012-11-21 22:37:25'),(137,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:43:09','2012-11-21 22:43:09'),(138,18,'0','16','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:43:41','2012-11-21 22:43:41'),(139,18,'0','16','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:44:03','2012-11-21 22:44:03'),(140,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【127】','2012-11-21 22:44:37','2012-11-21 22:44:37'),(141,18,'1','15','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 23:04:07','2012-11-27 23:04:07'),(142,18,'0','15','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 23:16:29','2012-11-27 23:16:29'),(143,18,'0','15','你有1条新的未办签单信息，请查看签单编号【117】','2012-11-27 23:16:42','2012-11-27 23:16:42'),(144,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【128】','2012-12-01 23:16:11','2012-12-01 23:16:11'),(145,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:33:58','2012-12-03 21:33:58'),(146,18,'1','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:37:57','2012-12-03 21:37:57'),(147,18,'0','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:39:40','2012-12-03 21:39:40'),(148,18,'0','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:40:38','2012-12-03 21:40:38'),(149,18,'1','15','你有1条新的未办签单信息，请查看签单编号【129】','2012-12-03 21:51:32','2012-12-03 21:51:32'),(150,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【130】','2012-12-03 22:40:21','2012-12-03 22:40:21'),(151,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:26:39','2012-12-04 22:26:39'),(152,18,'1','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:29:28','2012-12-04 22:29:28'),(153,18,'0','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:33:03','2012-12-04 22:33:03'),(154,18,'0','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:33:32','2012-12-04 22:33:32'),(155,18,'1','15','你有1条新的未办签单信息，请查看签单编号【1】','2012-12-04 22:34:36','2012-12-04 22:34:36'),(156,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【5】','2012-12-10 22:36:56','2012-12-10 22:36:56'),(157,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【6】','2015-01-31 09:37:40','2015-01-31 09:37:40'),(158,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【7】','2015-01-31 09:48:25','2015-01-31 09:48:25'),(159,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【8】','2015-01-31 10:00:00','2015-01-31 10:00:00'),(160,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【9】','2015-01-31 10:02:36','2015-01-31 10:02:36'),(161,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【10】','2015-01-31 10:10:47','2015-01-31 10:10:47'),(162,18,'1','15','你有1条新的未办签单信息，请查看签单编号【10】','2015-01-31 10:27:10','2015-01-31 10:27:10'),(163,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【11】','2015-01-31 11:07:13','2015-01-31 11:07:13'),(164,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【1】','2015-04-04 22:41:18','2015-04-04 22:41:18'),(165,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 22:47:36','2015-04-04 22:47:36'),(166,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-04 22:51:11','2015-04-04 22:51:11'),(167,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【1】','2015-04-04 23:15:21','2015-04-04 23:15:21'),(168,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 23:22:02','2015-04-04 23:22:02'),(169,18,'1','15','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-04 23:35:35','2015-04-04 23:35:35'),(170,18,'0','15','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-05 00:57:51','2015-04-05 00:57:51'),(171,18,'0','18','你有1条新的未办签单信息，请查看签单编号【2】','2015-04-06 10:12:50','2015-04-06 10:12:50'),(172,18,'1','10,13','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:20:23','2015-04-06 10:20:23'),(173,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:20:31','2015-04-06 10:20:31'),(174,18,'0','14','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:21:13','2015-04-06 10:21:13'),(175,18,'0','14','你有1条新的未办签单信息，请查看签单编号【3】','2015-04-06 10:21:30','2015-04-06 10:21:30'),(176,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:22:50','2015-04-06 10:22:50'),(177,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:10','2015-04-06 10:23:10'),(178,18,'0','14','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:19','2015-04-06 10:23:19'),(179,18,'0','14','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:23:38','2015-04-06 10:23:38'),(180,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 10:39:47','2015-04-06 10:39:47'),(181,18,'0','18','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 11:58:57','2015-04-06 11:58:57'),(182,18,'0','18','你有1条新的未办签单信息，请查看签单编号【4】','2015-04-06 12:07:29','2015-04-06 12:07:29'),(183,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:38','2015-04-06 12:11:38'),(184,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:50','2015-04-06 12:11:50'),(185,18,'0','14','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:11:59','2015-04-06 12:11:59'),(186,18,'0','14','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:12:06','2015-04-06 12:12:06'),(187,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【5】','2015-04-06 12:12:24','2015-04-06 12:12:24'),(188,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:16:24','2015-04-06 22:16:24'),(189,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:19:00','2015-04-06 22:19:00'),(190,18,'0','15','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:20:18','2015-04-06 22:20:18'),(191,18,'0','18','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:21:28','2015-04-06 22:21:28'),(192,18,'0','17','你有1条新的未办签单信息，请查看签单编号【6】','2015-04-06 22:30:06','2015-04-06 22:30:06'),(193,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【7】','2015-04-06 22:33:29','2015-04-06 22:33:29'),(194,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【7】','2015-04-06 22:33:45','2015-04-06 22:33:45'),(195,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:43:53','2015-04-06 22:43:53'),(196,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:45:13','2015-04-06 22:45:13'),(197,18,'0','16','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:45:37','2015-04-06 22:45:37'),(198,18,'0','18','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:50:07','2015-04-06 22:50:07'),(199,18,'0','16','你有1条新的未办签单信息，请查看签单编号【8】','2015-04-06 22:52:45','2015-04-06 22:52:45'),(200,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:02','2015-04-06 22:56:02'),(201,18,'1','14,15','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:12','2015-04-06 22:56:12'),(202,18,'1','16,17','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:19','2015-04-06 22:56:19'),(203,18,'0','18','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:39','2015-04-06 22:56:39'),(204,18,'0','18','你有1条新的未办签单信息，请查看签单编号【9】','2015-04-06 22:56:50','2015-04-06 22:56:50'),(205,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 22:59:30','2015-04-06 22:59:30'),(206,18,'0','15','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:00:42','2015-04-06 23:00:42'),(207,18,'0','17','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:01:00','2015-04-06 23:01:00'),(208,18,'0','18','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:01:13','2015-04-06 23:01:13'),(209,18,'0','17','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:01:30','2015-04-06 23:01:30'),(210,18,'0','15','你有1条新的未办签单信息，请查看签单编号【10】','2015-04-06 23:02:00','2015-04-06 23:02:00'),(211,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【12】','2015-04-06 23:16:03','2015-04-06 23:16:03'),(212,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:20:36','2015-04-06 23:20:36'),(213,18,'0','14','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:21:51','2015-04-06 23:21:51'),(214,18,'0','17','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:22:04','2015-04-06 23:22:04'),(215,18,'0','14','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:22:34','2015-04-06 23:22:34'),(216,18,'0','18','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:23:36','2015-04-06 23:23:36'),(217,18,'0','14','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:23:53','2015-04-06 23:23:53'),(218,18,'0','18','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:24:31','2015-04-06 23:24:31'),(219,18,'0','14','你有1条新的未办签单信息，请查看签单编号【13】','2015-04-06 23:25:42','2015-04-06 23:25:42'),(220,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-06 23:26:33','2015-04-06 23:26:33'),(221,18,'0','14','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-06 23:26:48','2015-04-06 23:26:48'),(222,18,'0','16','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:52:36','2015-04-08 20:52:36'),(223,18,'0','18','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:52:53','2015-04-08 20:52:53'),(224,18,'0','17','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:53:35','2015-04-08 20:53:35'),(225,18,'0','14','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:53:52','2015-04-08 20:53:52'),(226,18,'0','18','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:55:28','2015-04-08 20:55:28'),(227,18,'0','14','你有1条新的未办签单信息，请查看签单编号【14】','2015-04-08 20:59:13','2015-04-08 20:59:13'),(228,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【15】','2015-04-08 21:29:30','2015-04-08 21:29:30'),(229,18,'1','5,7','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:37:19','2015-04-10 22:37:19'),(230,18,'0','14','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:54:05','2015-04-10 22:54:05'),(231,18,'0','16','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:55:09','2015-04-10 22:55:09'),(232,18,'0','14','你有1条新的未办签单信息，请查看签单编号【16】','2015-04-10 22:56:15','2015-04-10 22:56:15');

UNLOCK TABLES;

/*Table structure for table `order_attach` */

DROP TABLE IF EXISTS `order_attach`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签单附件表';

/*Data for the table `order_attach` */

LOCK TABLES `order_attach` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_course` */

DROP TABLE IF EXISTS `order_course`;

CREATE TABLE `order_course` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `charger_id` int(10) unsigned DEFAULT NULL COMMENT '负责人',
  `status` char(1) CHARACTER SET latin1 NOT NULL DEFAULT '0' COMMENT '0:未确认 1:确认 2:拒绝',
  `order_attach_id` int(10) unsigned NOT NULL DEFAULT '0',
  `hour` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时',
  `cost_hour` int(10) DEFAULT '0' COMMENT '消耗的课时',
  `schedule_hour` int(10) DEFAULT '0' COMMENT '已排课的课时',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='签单课程信息';

/*Data for the table `order_course` */

LOCK TABLES `order_course` WRITE;

insert  into `order_course`(`id`,`order_id`,`course_type`,`charger_id`,`status`,`order_attach_id`,`hour`,`cost_hour`,`schedule_hour`,`create_time`,`last_update`) values (60,16,'2',19,'1',0,50,0,0,'2015-04-11 22:25:34','2015-04-11 14:11:02'),(61,16,'1',20,'1',0,50,NULL,NULL,'2015-04-10 22:37:19','2015-04-10 22:56:28');

UNLOCK TABLES;

/*Table structure for table `order_course_evaluation` */

DROP TABLE IF EXISTS `order_course_evaluation`;

CREATE TABLE `order_course_evaluation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `student_id` int(10) unsigned DEFAULT '0',
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `charger_id` int(10) unsigned DEFAULT NULL COMMENT '负责人',
  `content` varchar(500) DEFAULT NULL COMMENT '评价',
  `order_attach_id` int(10) unsigned DEFAULT '0' COMMENT '附件',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) unsigned DEFAULT NULL,
  `course_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程后评价';

/*Data for the table `order_course_evaluation` */

LOCK TABLES `order_course_evaluation` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_course_hour` */

DROP TABLE IF EXISTS `order_course_hour`;

CREATE TABLE `order_course_hour` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `student_id` int(10) unsigned NOT NULL DEFAULT '0',
  `teacher_id` int(10) unsigned NOT NULL DEFAULT '0',
  `teach_time` date NOT NULL DEFAULT '0000-00-00',
  `schedule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排课表主键',
  `cost_hour` int(10) unsigned DEFAULT '0' COMMENT '课时',
  `pay_hour` int(10) unsigned DEFAULT '0' COMMENT '已经清算的课时',
  `status` varchar(1) NOT NULL COMMENT '0:课时全部清算 1:课时部分清算 2:删除',
  `msg` varchar(200) NOT NULL COMMENT '描述',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) unsigned DEFAULT NULL COMMENT '操作人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课时管理';

/*Data for the table `order_course_hour` */

LOCK TABLES `order_course_hour` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_course_hour_log` */

DROP TABLE IF EXISTS `order_course_hour_log`;

CREATE TABLE `order_course_hour_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签单表主键',
  `order_course_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '签单课程信息表主键',
  `schedule_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排课表主键',
  `schedule_detail_id` int(10) unsigned DEFAULT '0' COMMENT '排课明细id',
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `student_id` int(10) unsigned NOT NULL DEFAULT '0',
  `teacher_id` int(10) unsigned NOT NULL DEFAULT '0',
  `teach_time` date NOT NULL DEFAULT '0000-00-00',
  `cost_hour` int(10) unsigned DEFAULT '0' COMMENT '课时',
  `status` varchar(1) NOT NULL COMMENT '0:课时全部清算 1:删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) unsigned DEFAULT NULL COMMENT '操作人',
  `orderId` int(11) DEFAULT NULL,
  `orderCourseId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课时消耗记录';

/*Data for the table `order_course_hour_log` */

LOCK TABLES `order_course_hour_log` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_course_log` */

DROP TABLE IF EXISTS `order_course_log`;

CREATE TABLE `order_course_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `course_type` varchar(1) NOT NULL COMMENT '课程类型',
  `charger_id` int(11) DEFAULT NULL COMMENT '负责人',
  `create_time` datetime DEFAULT NULL,
  `status` varchar(1) NOT NULL COMMENT '0:未确认 1:确认 2:拒绝',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_course_log` */

LOCK TABLES `order_course_log` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_course_schedule` */

DROP TABLE IF EXISTS `order_course_schedule`;

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

/*Data for the table `order_course_schedule` */

LOCK TABLES `order_course_schedule` WRITE;

insert  into `order_course_schedule`(`id`,`order_id`,`user_id`,`student_id`,`start_date`,`end_date`,`course_period_id`,`course_type`,`status`,`create_time`) values (1,18,5,5,'2012-07-07','2012-08-08',1,'1','0','2012-07-27 22:33:37'),(2,18,5,5,'2012-10-07','2012-12-08',2,'2','0','2012-07-27 22:33:37');

UNLOCK TABLES;

/*Table structure for table `order_course_score` */

DROP TABLE IF EXISTS `order_course_score`;

CREATE TABLE `order_course_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `charger_id` int(10) unsigned DEFAULT NULL COMMENT '负责人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `student_id` int(10) unsigned DEFAULT NULL,
  `score` int(5) unsigned DEFAULT NULL COMMENT '分数',
  `exam_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `operator` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签单课程负责人日志记录表';

/*Data for the table `order_course_score` */

LOCK TABLES `order_course_score` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_exchange` */

DROP TABLE IF EXISTS `order_exchange`;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签单客户交流表';

/*Data for the table `order_exchange` */

LOCK TABLES `order_exchange` WRITE;

UNLOCK TABLES;

/*Table structure for table `order_info` */

DROP TABLE IF EXISTS `order_info`;

CREATE TABLE `order_info` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) DEFAULT NULL COMMENT '签单编号',
  `student_id` int(10) unsigned NOT NULL DEFAULT '0',
  `fee` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '签单总额',
  `order_type` char(2) DEFAULT NULL COMMENT '签单类型',
  `status` char(20) DEFAULT NULL COMMENT '签单审批状态',
  `des` varchar(250) DEFAULT NULL,
  `flow_ins_id` varchar(20) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `grade` varchar(10) DEFAULT NULL COMMENT '年级',
  `course_hour` int(10) unsigned DEFAULT NULL COMMENT '课时总数',
  `cost_course_hour` int(10) unsigned DEFAULT NULL COMMENT '已经消耗课时',
  `schedule_hour` int(10) DEFAULT '0' COMMENT '已排课的课时',
  `run_status` char(1) NOT NULL DEFAULT '0' COMMENT '签单执行状态 0:审批 1:教学中 2:结束',
  `parent_order_id` int(10) unsigned DEFAULT NULL,
  `cur_operator` int(10) unsigned DEFAULT NULL,
  `is_last` char(1) NOT NULL DEFAULT '0' COMMENT '是否被续签',
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='签单表';

/*Data for the table `order_info` */

LOCK TABLES `order_info` WRITE;

insert  into `order_info`(`id`,`order_no`,`student_id`,`fee`,`order_type`,`status`,`des`,`flow_ins_id`,`start_time`,`end_time`,`grade`,`course_hour`,`cost_course_hour`,`schedule_hour`,`run_status`,`parent_order_id`,`cur_operator`,`is_last`,`iseff`,`create_time`,`last_update`) values (16,'no1111',1,1200000,'0','审批通过',NULL,NULL,'2015-04-10 00:00:00','2015-04-30 00:00:00','2',100,1,1,'1',NULL,18,'0','0','2015-04-10 22:37:19','2015-04-11 14:11:07');

UNLOCK TABLES;

/*Table structure for table `order_rel_his` */

DROP TABLE IF EXISTS `order_rel_his`;

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COMMENT='签单参与者历史表';

/*Data for the table `order_rel_his` */

LOCK TABLES `order_rel_his` WRITE;

insert  into `order_rel_his`(`id`,`order_id`,`task_name`,`chargerType`,`operator`,`create_time`,`last_update`,`task_id`) values (77,15,'签约','1',18,'2015-04-08 21:29:30','2015-04-08 21:29:30',1),(78,16,'签约','1',18,'2015-04-10 22:37:19','2015-04-10 22:37:19',1),(79,16,'销售主管审批','2',18,'2015-04-10 22:54:05','2015-04-10 22:54:05',2),(80,16,'教务部处理','3',18,'2015-04-10 22:55:09','2015-04-10 22:55:09',3),(81,16,'班主任处理中','4',18,'2015-04-10 22:56:15','2015-04-10 22:56:15',5),(82,16,'教务部审批','3',18,'2015-04-10 22:56:28','2015-04-10 22:56:28',6);

UNLOCK TABLES;

/*Table structure for table `order_role` */

DROP TABLE IF EXISTS `order_role`;

CREATE TABLE `order_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `charger` int(10) NOT NULL COMMENT '1:销售 2: 销售主管 3:教务部主管 4:班主任 5:授课老师',
  `role_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='签单负责人配置';

/*Data for the table `order_role` */

LOCK TABLES `order_role` WRITE;

insert  into `order_role`(`id`,`charger`,`role_id`) values (1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6);

UNLOCK TABLES;

/*Table structure for table `order_trace` */

DROP TABLE IF EXISTS `order_trace`;

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
  `transition` varchar(50) DEFAULT NULL COMMENT '处理动作',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COMMENT='签单流程跟踪表';

/*Data for the table `order_trace` */

LOCK TABLES `order_trace` WRITE;

insert  into `order_trace`(`id`,`order_id`,`task_name`,`role_id`,`user_id`,`operator`,`oper`,`create_time`,`last_update`,`oper_sort`,`task_id`,`transition`) values (114,15,'签约',1,NULL,18,'0','2015-04-08 21:29:30','2015-04-08 21:29:30',NULL,1,'待审批'),(115,15,'销售主管审批',2,NULL,NULL,NULL,'2015-04-08 21:29:30','2015-04-08 21:29:30',NULL,2,NULL),(116,16,'签约',1,NULL,18,'0','2015-04-10 22:37:19','2015-04-10 22:37:19',NULL,1,'待审批'),(117,16,'销售主管审批',2,NULL,18,'0','2015-04-10 22:37:19','2015-04-10 22:54:05',NULL,2,'通过'),(118,16,'教务部处理',NULL,14,18,'0','2015-04-10 22:54:05','2015-04-10 22:55:09',NULL,3,'分配任务'),(119,16,'班主任处理中',NULL,16,18,'0','2015-04-10 22:55:09','2015-04-10 22:56:15',NULL,5,'确认'),(120,16,'教务部审批',NULL,14,18,'0','2015-04-10 22:56:15','2015-04-10 22:56:28',NULL,6,'通过'),(121,16,'审批通过',NULL,NULL,NULL,NULL,'2015-04-10 22:56:28','2015-04-10 22:56:28',NULL,7,NULL);

UNLOCK TABLES;

/*Table structure for table `order_trace_detail` */

DROP TABLE IF EXISTS `order_trace_detail`;

CREATE TABLE `order_trace_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_attach_id` int(11) NOT NULL,
  `status` varchar(1) DEFAULT NULL COMMENT '0:待审批,1:通过,2:不通过',
  `commet` text NOT NULL COMMENT '留言',
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_trace_detail` */

LOCK TABLES `order_trace_detail` WRITE;

UNLOCK TABLES;

/*Table structure for table `student_info` */

DROP TABLE IF EXISTS `student_info`;

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
  `area_id` int(11) NOT NULL COMMENT '区域id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='学生信息表';

/*Data for the table `student_info` */

LOCK TABLES `student_info` WRITE;

insert  into `student_info`(`id`,`name`,`grade`,`school`,`age`,`brithday`,`sex`,`homephone`,`phone`,`addr`,`father_name`,`father_phone`,`father_unit`,`father_position`,`mother_name`,`mother_phone`,`mother_unit`,`mother_position`,`interest`,`last_exam_date`,`score_yuwen`,`score_shuxue`,`score_yingwen`,`score_zhengzhi`,`score_wuli`,`score_huaxue`,`score_lishi`,`score_shengwu`,`selfevaluation`,`create_time`,`last_update`,`liketeacherstyle`,`likecoursestyle`,`livehabit`,`score_dili`,`self_assessment`,`area_id`) values (1,'林小朋友','1','广州市第十七中','29','1983-12-14','0','2121',NULL,'赤岗','林','11','在家','煮饭','罗','22','在家2','吃饭','11','2012-10-18','11','22','33','55','22','44','66','22','33','2012-08-22 22:29:34','2012-10-20 14:21:08','44','55','22',NULL,NULL,0),(2,'111','1111',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-23 21:21:27','2012-06-23 21:21:27',NULL,NULL,NULL,NULL,NULL,0),(3,'2222333','1',NULL,'0','2012-12-10','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-24 14:07:43','2012-12-10 22:39:41',NULL,NULL,NULL,NULL,NULL,0),(4,'萝莉亲','2',NULL,'0','2012-07-03','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-07-08 08:59:17','2012-07-08 08:59:17',NULL,NULL,NULL,NULL,NULL,0),(5,'王小朋友','1',NULL,'23','1989-07-04','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-16 23:19:59','2012-12-10 22:41:20',NULL,NULL,NULL,NULL,NULL,0),(6,'qqq','2',NULL,'29','1983-05-26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-15 23:52:02','2012-08-15 23:52:02',NULL,NULL,NULL,NULL,NULL,0),(7,'黄飞','3','121221','29','1983-08-07','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-08-19 11:29:41','2012-08-19 11:29:41',NULL,NULL,NULL,NULL,NULL,0),(8,'嘿嘿嘿','4',NULL,'13','1999-11-05','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2012-11-11 00:15:02','2012-11-11 00:15:02',NULL,NULL,NULL,NULL,NULL,0);

UNLOCK TABLES;

/*Table structure for table `sys_area` */

DROP TABLE IF EXISTS `sys_area`;

CREATE TABLE `sys_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `parentid` int(10) DEFAULT '0' COMMENT '上一层的区域',
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `des` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='区域';

/*Data for the table `sys_area` */

LOCK TABLES `sys_area` WRITE;

insert  into `sys_area`(`id`,`name`,`parentid`,`iseff`,`create_time`,`last_update`,`des`) values (4,'天河校区',0,'0','2015-03-08 11:28:11','2015-03-08 11:31:10',NULL),(5,'海珠校区',0,'0','2015-03-08 11:31:20','2015-03-08 11:31:20',NULL);

UNLOCK TABLES;

/*Table structure for table `sys_department` */

DROP TABLE IF EXISTS `sys_department`;

CREATE TABLE `sys_department` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `des` varchar(250) DEFAULT NULL,
  `parentid` int(10) DEFAULT NULL COMMENT '上一层的部门构架',
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `sys_department` */

LOCK TABLES `sys_department` WRITE;

insert  into `sys_department`(`id`,`name`,`des`,`parentid`,`iseff`,`create_time`,`last_update`) values (1,'教务部',NULL,0,'0','2012-08-14 22:10:09','2012-04-16 20:40:02'),(2,'销售部',NULL,0,'0','2012-08-14 22:10:10','2012-04-16 20:40:13');

UNLOCK TABLES;

/*Table structure for table `sys_log_trace` */

DROP TABLE IF EXISTS `sys_log_trace`;

CREATE TABLE `sys_log_trace` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `module_name` varchar(200) NOT NULL DEFAULT '' COMMENT '模块名称',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1365 DEFAULT CHARSET=utf8 COMMENT='系统跟踪表';

/*Data for the table `sys_log_trace` */

LOCK TABLES `sys_log_trace` WRITE;

insert  into `sys_log_trace`(`id`,`user_id`,`module_name`,`login_time`) values (1,18,'已处理任务','2012-12-10 20:28:43'),(2,18,'登陆','2012-12-10 20:38:47'),(3,18,'学生信息交流','2012-12-10 20:39:02'),(4,18,'已处理任务','2012-12-10 20:39:06'),(5,18,'登陆','2012-12-10 20:43:09'),(6,18,'学生信息交流','2012-12-10 20:44:05'),(7,18,'学生信息交流','2012-12-10 20:44:14'),(8,18,'登陆','2012-12-10 21:05:55'),(9,18,'已处理任务','2012-12-10 21:06:06'),(10,18,'登陆','2012-12-10 21:18:46'),(11,18,'权限管理','2012-12-10 21:19:56'),(12,18,'登陆','2012-12-10 21:20:23'),(13,18,'系统访问日志','2012-12-10 21:20:27'),(14,18,'系统访问日志','2012-12-10 21:21:04'),(15,18,'系统访问日志','2012-12-10 21:21:20'),(16,18,'登陆','2012-12-10 21:21:31'),(17,18,'系统访问日志','2012-12-10 21:21:38'),(18,18,'权限管理','2012-12-10 21:22:03'),(19,18,'权限管理','2012-12-10 21:22:12'),(20,18,'系统用户','2012-12-10 21:22:18'),(21,18,'全部消息历史','2012-12-10 21:22:21'),(22,18,'发送消息','2012-12-10 21:22:21'),(23,18,'已发消息','2012-12-10 21:22:22'),(24,18,'收件箱','2012-12-10 21:22:23'),(25,18,'发送消息','2012-12-10 21:29:55'),(26,18,'已发消息','2012-12-10 21:29:56'),(27,18,'发送消息','2012-12-10 21:29:58'),(28,18,'已发消息','2012-12-10 21:30:00'),(29,18,'发送消息','2012-12-10 21:30:02'),(30,18,'已发消息','2012-12-10 21:30:03'),(31,18,'发送消息','2012-12-10 21:30:05'),(32,18,'已发消息','2012-12-10 21:30:06'),(33,18,'发送消息','2012-12-10 21:30:09'),(34,18,'已发消息','2012-12-10 21:30:10'),(35,18,'发送消息','2012-12-10 21:30:17'),(36,18,'已发消息','2012-12-10 21:30:18'),(37,18,'发送消息','2012-12-10 21:30:21'),(38,18,'已发消息','2012-12-10 21:30:22'),(39,18,'发送消息','2012-12-10 21:30:25'),(40,18,'已发消息','2012-12-10 21:30:26'),(41,18,'发送消息','2012-12-10 21:30:28'),(42,18,'已发消息','2012-12-10 21:30:29'),(43,18,'发送消息','2012-12-10 21:30:31'),(44,18,'已发消息','2012-12-10 21:30:33'),(45,18,'发送消息','2012-12-10 21:30:35'),(46,18,'已发消息','2012-12-10 21:30:36'),(47,18,'发送消息','2012-12-10 21:30:49'),(48,18,'已发消息','2012-12-10 21:30:50'),(49,18,'发送消息','2012-12-10 21:30:54'),(50,18,'已发消息','2012-12-10 21:30:55'),(51,18,'发送消息','2012-12-10 21:30:57'),(52,18,'已发消息','2012-12-10 21:30:58'),(53,18,'已发消息','2012-12-10 21:31:05'),(54,18,'发送消息','2012-12-10 21:31:06'),(55,18,'已发消息','2012-12-10 21:31:08'),(56,18,'发送消息','2012-12-10 21:31:09'),(57,18,'已发消息','2012-12-10 21:31:13'),(58,18,'系统访问日志','2012-12-10 21:36:35'),(59,18,'系统访问日志','2012-12-10 21:36:58'),(60,18,'课程分数管理','2012-12-10 21:49:04'),(61,18,'课程评价管理','2012-12-10 21:49:05'),(62,18,'未处理任务','2012-12-10 22:11:38'),(63,18,'已处理任务','2012-12-10 22:11:59'),(64,18,'学生信息交流','2012-12-10 22:12:48'),(65,18,'全部消息历史','2012-12-10 22:13:10'),(66,18,'发送消息','2012-12-10 22:13:28'),(67,18,'已发消息','2012-12-10 22:13:30'),(68,18,'收件箱','2012-12-10 22:13:54'),(69,18,'客户管理','2012-12-10 22:14:00'),(70,18,'来电交流管理','2012-12-10 22:14:12'),(71,18,'来电交流管理','2012-12-10 22:14:20'),(72,18,'续单管理','2012-12-10 22:18:52'),(73,18,'续单管理','2012-12-10 22:22:57'),(74,18,'续单管理','2012-12-10 22:23:50'),(75,18,'续单管理','2012-12-10 22:24:32'),(76,18,'签单信息查询','2012-12-10 22:28:28'),(77,18,'签单信息查询','2012-12-10 22:28:49'),(78,18,'学生信息管理','2012-12-10 22:29:09'),(79,18,'学生信息管理','2012-12-10 22:30:36'),(80,18,'学生信息管理','2012-12-10 22:31:13'),(81,18,'权限管理','2012-12-10 22:34:59'),(82,18,'登陆','2012-12-10 22:36:10'),(83,18,'新签单登记','2012-12-10 22:36:20'),(84,18,'签单日统计','2012-12-10 22:37:08'),(85,18,'登陆','2012-12-10 22:37:30'),(86,18,'学生信息管理','2012-12-10 22:37:55'),(87,18,'学生信息管理','2012-12-10 22:37:59'),(88,18,'学生信息管理','2012-12-10 22:38:10'),(89,18,'学生信息管理','2012-12-10 22:39:31'),(90,18,'学生信息管理','2012-12-10 22:39:32'),(91,18,'学生信息管理','2012-12-10 22:40:59'),(92,18,'登陆','2012-12-10 22:42:04'),(93,18,'登陆','2012-12-10 22:46:12'),(94,18,'登陆','2012-12-10 22:46:54'),(95,18,'登陆','2012-12-10 22:49:54'),(96,18,'登陆','2012-12-10 22:50:38'),(97,18,'登陆','2012-12-10 22:51:50'),(98,18,'登陆','2012-12-10 22:52:52'),(99,18,'登陆','2012-12-10 22:58:19'),(100,18,'登陆','2012-12-10 22:59:10'),(101,18,'登陆','2012-12-10 22:59:38'),(102,18,'登陆','2012-12-12 21:37:58'),(103,18,'课程评价管理','2012-12-12 21:39:01'),(104,18,'课时管理','2012-12-12 21:40:23'),(105,18,'课程分数管理','2012-12-12 21:40:36'),(106,18,'课程分数管理','2012-12-12 21:44:54'),(107,18,'课程评价管理','2012-12-12 21:45:00'),(108,18,'课程评价管理','2012-12-12 21:47:03'),(109,18,'课程评价管理','2012-12-12 21:49:14'),(110,18,'课程评价管理','2012-12-12 21:49:26'),(111,18,'登陆','2012-12-12 21:49:35'),(112,18,'课程评价管理','2012-12-12 21:49:44'),(113,18,'课程评价管理','2012-12-12 21:52:37'),(114,18,'课程评价管理','2012-12-12 21:56:41'),(115,18,'课程分数管理','2012-12-12 21:57:40'),(116,18,'课程分数管理','2012-12-12 21:59:44'),(117,18,'课程分数管理','2012-12-12 22:00:12'),(118,18,'课时管理','2012-12-12 22:01:00'),(119,18,'课时管理','2012-12-12 22:02:56'),(120,18,'登陆','2012-12-12 22:03:55'),(121,18,'已处理任务','2012-12-12 22:17:18'),(122,18,'登陆','2012-12-12 22:18:23'),(123,18,'登陆','2012-12-12 22:20:13'),(124,18,'登陆','2012-12-12 22:21:19'),(125,18,'登陆','2012-12-12 22:25:33'),(126,18,'登陆','2012-12-12 22:26:06'),(127,18,'登陆','2012-12-12 22:26:37'),(128,18,'登陆','2012-12-12 22:27:12'),(129,18,'登陆','2012-12-12 22:28:31'),(130,18,'登陆','2012-12-12 22:29:17'),(131,18,'登陆','2012-12-12 22:29:38'),(132,18,'登陆','2012-12-12 22:30:14'),(133,18,'登陆','2012-12-12 22:30:42'),(134,18,'登陆','2012-12-12 22:33:44'),(135,18,'收件箱','2012-12-12 22:35:25'),(136,18,'登陆','2012-12-12 22:40:43'),(137,18,'登陆','2012-12-12 22:42:15'),(138,18,'登陆','2012-12-12 22:42:46'),(139,18,'登陆','2012-12-12 22:43:49'),(140,18,'收件箱','2012-12-12 22:45:19'),(141,18,'登陆','2015-01-31 09:58:55'),(142,18,'未处理任务','2015-01-31 09:59:09'),(143,18,'已处理任务','2015-01-31 09:59:15'),(144,18,'新签单登记','2015-01-31 09:59:21'),(145,18,'签单信息查询','2015-01-31 10:00:03'),(146,18,'签单流程管理','2015-01-31 10:01:34'),(147,18,'签单信息查询','2015-01-31 10:01:35'),(148,18,'签单信息查询','2015-01-31 10:02:40'),(149,18,'课时管理','2015-01-31 10:03:37'),(150,18,'课程评价管理','2015-01-31 10:03:42'),(151,18,'学生信息管理','2015-01-31 10:03:56'),(152,18,'登陆','2015-01-31 10:10:17'),(153,18,'新签单登记','2015-01-31 10:10:20'),(154,18,'签单流程管理','2015-01-31 10:11:04'),(155,18,'登陆','2015-01-31 10:20:51'),(156,18,'签单流程管理','2015-01-31 10:20:58'),(157,18,'登陆','2015-01-31 10:21:44'),(158,18,'登陆','2015-01-31 10:21:46'),(159,18,'签单流程管理','2015-01-31 10:21:48'),(160,18,'登陆','2015-01-31 10:23:13'),(161,18,'登陆','2015-01-31 10:23:14'),(162,18,'登陆','2015-01-31 10:23:14'),(163,18,'登陆','2015-01-31 10:23:15'),(164,18,'签单流程管理','2015-01-31 10:23:19'),(165,18,'登陆','2015-01-31 10:24:11'),(166,18,'登陆','2015-01-31 10:24:12'),(167,18,'签单流程管理','2015-01-31 10:24:15'),(168,18,'登陆','2015-01-31 10:24:42'),(169,18,'签单流程管理','2015-01-31 10:24:57'),(170,18,'签单流程管理','2015-01-31 10:25:05'),(171,18,'登陆','2015-01-31 10:26:34'),(172,18,'签单流程管理','2015-01-31 10:26:39'),(173,18,'登陆','2015-01-31 10:29:07'),(174,18,'签单流程管理','2015-01-31 10:29:10'),(175,18,'登陆','2015-01-31 10:31:22'),(176,18,'登陆','2015-01-31 10:31:23'),(177,18,'签单流程管理','2015-01-31 10:31:26'),(178,18,'登陆','2015-01-31 10:32:23'),(179,18,'登陆','2015-01-31 10:32:41'),(180,18,'签单流程管理','2015-01-31 10:32:44'),(181,18,'登陆','2015-01-31 10:35:12'),(182,18,'登陆','2015-01-31 10:35:13'),(183,18,'签单流程管理','2015-01-31 10:35:16'),(184,18,'登陆','2015-01-31 10:35:34'),(185,18,'登陆','2015-01-31 10:35:36'),(186,18,'新签单登记','2015-01-31 10:35:40'),(187,18,'签单流程管理','2015-01-31 10:35:40'),(188,18,'登陆','2015-01-31 10:37:05'),(189,18,'登陆','2015-01-31 10:37:06'),(190,18,'签单流程管理','2015-01-31 10:37:09'),(191,18,'新签单登记','2015-01-31 10:37:27'),(192,18,'签单流程管理','2015-01-31 10:37:34'),(193,18,'新签单登记','2015-01-31 10:37:35'),(194,18,'登陆','2015-01-31 10:50:27'),(195,18,'签单流程管理','2015-01-31 10:50:40'),(196,18,'新签单登记','2015-01-31 10:50:41'),(197,18,'登陆','2015-01-31 10:51:15'),(198,18,'新签单登记','2015-01-31 10:51:18'),(199,18,'登陆','2015-01-31 10:54:13'),(200,18,'登陆','2015-01-31 10:54:14'),(201,18,'新签单登记','2015-01-31 10:54:16'),(202,18,'新签单登记','2015-01-31 10:55:22'),(203,18,'登陆','2015-01-31 10:58:31'),(204,18,'新签单登记','2015-01-31 10:58:33'),(205,18,'登陆','2015-01-31 10:59:03'),(206,18,'登陆','2015-01-31 10:59:11'),(207,18,'新签单登记','2015-01-31 10:59:17'),(208,18,'登陆','2015-01-31 10:59:35'),(209,18,'新签单登记','2015-01-31 10:59:38'),(210,18,'登陆','2015-01-31 11:06:45'),(211,18,'新签单登记','2015-01-31 11:06:47'),(212,18,'签单流程管理','2015-01-31 11:07:16'),(213,18,'登陆','2015-01-31 11:10:45'),(214,18,'签单流程管理','2015-01-31 11:10:48'),(215,18,'登陆','2015-01-31 11:11:22'),(216,18,'签单流程管理','2015-01-31 11:11:25'),(217,18,'新签单登记','2015-01-31 11:11:57'),(218,18,'登陆','2015-02-01 08:41:00'),(219,18,'新签单登记','2015-02-01 08:41:08'),(220,18,'签单流程管理','2015-02-01 08:41:11'),(221,18,'登陆','2015-02-01 09:13:15'),(222,18,'未处理任务','2015-02-01 09:13:21'),(223,18,'已处理任务','2015-02-01 09:13:23'),(224,18,'学生信息交流','2015-02-01 09:13:24'),(225,18,'签单日统计','2015-02-01 09:13:28'),(226,18,'全部消息历史','2015-02-01 09:13:33'),(227,18,'发送消息','2015-02-01 09:13:34'),(228,18,'已发消息','2015-02-01 09:13:35'),(229,18,'收件箱','2015-02-01 09:13:36'),(230,18,'来电交流管理','2015-02-01 09:13:38'),(231,18,'客户管理','2015-02-01 09:13:39'),(232,18,'来电交流管理','2015-02-01 09:13:40'),(233,18,'登陆','2015-03-05 21:35:28'),(234,18,'客户管理','2015-03-05 21:35:34'),(235,18,'登陆','2015-03-08 09:18:13'),(236,18,'教师信息管理','2015-03-08 09:18:20'),(237,18,'教师信息管理','2015-03-08 09:18:23'),(238,18,'学生信息管理','2015-03-08 09:27:19'),(239,18,'权限管理','2015-03-08 09:29:18'),(240,18,'菜单管理','2015-03-08 09:29:26'),(241,18,'系统访问日志','2015-03-08 09:29:34'),(242,18,'权限管理','2015-03-08 09:29:44'),(243,18,'部门管理','2015-03-08 09:29:59'),(244,18,'系统用户','2015-03-08 09:30:33'),(245,18,'登陆','2015-03-08 09:39:34'),(246,18,'权限管理','2015-03-08 09:39:37'),(247,18,'菜单管理','2015-03-08 09:39:38'),(248,18,'登陆','2015-03-08 09:49:52'),(249,18,'区域管理','2015-03-08 09:50:00'),(250,18,'登陆','2015-03-08 09:56:33'),(251,18,'登陆','2015-03-08 09:56:34'),(252,18,'区域管理','2015-03-08 09:56:38'),(253,18,'登陆','2015-03-08 09:57:46'),(254,18,'登陆','2015-03-08 09:57:47'),(255,18,'区域管理','2015-03-08 09:57:50'),(256,18,'登陆','2015-03-08 10:01:48'),(257,18,'区域管理','2015-03-08 10:01:53'),(258,18,'系统用户','2015-03-08 10:03:17'),(259,18,'权限管理','2015-03-08 10:03:56'),(260,18,'登陆','2015-03-08 11:05:38'),(261,18,'登陆','2015-03-08 11:07:58'),(262,18,'登陆','2015-03-08 11:12:18'),(263,18,'权限管理','2015-03-08 11:12:24'),(264,18,'登陆','2015-03-08 11:13:18'),(265,18,'登陆','2015-03-08 11:13:20'),(266,18,'区域管理','2015-03-08 11:13:23'),(267,18,'权限管理','2015-03-08 11:13:26'),(268,18,'登陆','2015-03-08 11:13:53'),(269,18,'权限管理','2015-03-08 11:14:00'),(270,18,'登陆','2015-03-08 11:14:25'),(271,18,'权限管理','2015-03-08 11:14:34'),(272,18,'登陆','2015-03-08 11:15:08'),(273,18,'权限管理','2015-03-08 11:15:15'),(274,18,'登陆','2015-03-08 11:15:53'),(275,18,'菜单管理','2015-03-08 11:15:56'),(276,18,'权限管理','2015-03-08 11:15:57'),(277,18,'区域管理','2015-03-08 11:16:20'),(278,18,'登陆','2015-03-08 11:18:28'),(279,18,'权限管理','2015-03-08 11:18:32'),(280,18,'区域管理','2015-03-08 11:18:36'),(281,18,'登陆','2015-03-08 11:20:48'),(282,18,'区域管理','2015-03-08 11:20:51'),(283,18,'权限管理','2015-03-08 11:21:37'),(284,18,'登陆','2015-03-08 11:25:07'),(285,18,'系统用户','2015-03-08 11:25:15'),(286,18,'权限管理','2015-03-08 11:25:16'),(287,18,'登陆','2015-03-08 11:27:50'),(288,18,'区域管理','2015-03-08 11:27:55'),(289,18,'权限管理','2015-03-08 11:28:20'),(290,18,'登陆','2015-03-08 11:30:11'),(291,18,'权限管理','2015-03-08 11:30:17'),(292,18,'区域管理','2015-03-08 11:30:55'),(293,18,'登陆','2015-03-08 11:33:39'),(294,18,'权限管理','2015-03-08 11:33:44'),(295,18,'系统用户','2015-03-08 11:35:42'),(296,18,'部门管理','2015-03-08 11:35:46'),(297,18,'权限管理','2015-03-08 11:35:58'),(298,18,'登陆','2015-03-08 11:37:46'),(299,18,'权限管理','2015-03-08 11:37:50'),(300,18,'权限管理','2015-03-08 11:37:56'),(301,18,'部门管理','2015-03-08 11:37:57'),(302,18,'区域管理','2015-03-08 12:38:08'),(303,18,'续单管理','2015-03-08 12:38:22'),(304,18,'系统访问日志','2015-03-08 12:38:26'),(305,18,'系统用户','2015-03-08 12:39:23'),(306,18,'登陆','2015-03-08 18:10:21'),(307,18,'教师信息管理','2015-03-08 18:10:31'),(308,18,'登陆','2015-03-08 18:21:45'),(309,18,'教师信息管理','2015-03-08 18:21:49'),(310,18,'登陆','2015-03-08 18:23:05'),(311,18,'教师信息管理','2015-03-08 18:23:08'),(312,18,'登陆','2015-03-08 18:24:01'),(313,18,'教师信息管理','2015-03-08 18:24:07'),(314,18,'登陆','2015-03-08 18:24:29'),(315,18,'教师信息管理','2015-03-08 18:24:31'),(316,18,'登陆','2015-03-08 19:52:40'),(317,18,'教师信息管理','2015-03-08 19:52:43'),(318,18,'登陆','2015-03-08 19:53:44'),(319,18,'教师信息管理','2015-03-08 19:53:46'),(320,18,'登陆','2015-03-08 19:55:54'),(321,18,'教师信息管理','2015-03-08 19:55:58'),(322,18,'登陆','2015-03-08 19:56:54'),(323,18,'教师信息管理','2015-03-08 19:57:00'),(324,18,'授课老师关联学生','2015-03-08 19:57:27'),(325,18,'教师信息管理','2015-03-08 19:57:28'),(326,18,'教师信息管理','2015-03-08 19:57:41'),(327,18,'登陆','2015-03-08 19:58:25'),(328,18,'教师信息管理','2015-03-08 19:58:29'),(329,18,'登陆','2015-03-08 19:58:30'),(330,18,'教师信息管理','2015-03-08 19:58:32'),(331,18,'登陆','2015-03-08 19:58:43'),(332,18,'教师信息管理','2015-03-08 19:58:45'),(333,18,'登陆','2015-03-08 19:59:45'),(334,18,'教师信息管理','2015-03-08 19:59:54'),(335,18,'登陆','2015-03-08 20:00:14'),(336,18,'教师信息管理','2015-03-08 20:00:21'),(337,18,'登陆','2015-03-08 20:01:26'),(338,18,'教师信息管理','2015-03-08 20:01:37'),(339,18,'登陆','2015-03-08 20:02:14'),(340,18,'登陆','2015-03-08 20:02:21'),(341,18,'登陆','2015-03-08 20:02:22'),(342,18,'登陆','2015-03-08 20:02:23'),(343,18,'登陆','2015-03-08 20:02:24'),(344,18,'教师信息管理','2015-03-08 20:02:27'),(345,18,'登陆','2015-03-08 20:40:36'),(346,18,'登陆','2015-03-08 20:40:37'),(347,18,'教师信息管理','2015-03-08 20:40:39'),(348,18,'登陆','2015-03-08 20:41:12'),(349,18,'登陆','2015-03-08 20:41:13'),(350,18,'教师信息管理','2015-03-08 20:41:15'),(351,18,'登陆','2015-03-08 20:44:57'),(352,18,'登陆','2015-03-08 20:46:48'),(353,18,'教师信息管理','2015-03-08 20:46:51'),(354,18,'登陆','2015-03-08 20:48:35'),(355,18,'教师信息管理','2015-03-08 20:48:38'),(356,18,'登陆','2015-03-08 20:49:45'),(357,18,'教师信息管理','2015-03-08 20:49:47'),(358,18,'登陆','2015-03-08 20:50:10'),(359,18,'教师信息管理','2015-03-08 20:50:12'),(360,18,'登陆','2015-03-08 20:50:43'),(361,18,'教师信息管理','2015-03-08 20:50:46'),(362,18,'登陆','2015-03-08 20:51:41'),(363,18,'教师信息管理','2015-03-08 20:51:45'),(364,18,'登陆','2015-03-08 20:52:08'),(365,18,'教师信息管理','2015-03-08 20:52:10'),(366,18,'授课老师关联学生','2015-03-08 20:53:06'),(367,18,'登陆','2015-03-08 20:57:24'),(368,18,'教师信息管理','2015-03-08 20:57:26'),(369,18,'登陆','2015-03-08 20:58:02'),(370,18,'教师信息管理','2015-03-08 20:58:40'),(371,18,'登陆','2015-03-08 21:00:30'),(372,18,'教师信息管理','2015-03-08 21:00:34'),(373,18,'登陆','2015-03-08 21:04:51'),(374,18,'教师信息管理','2015-03-08 21:05:05'),(375,18,'登陆','2015-03-08 21:08:43'),(376,18,'教师信息管理','2015-03-08 21:08:54'),(377,18,'登陆','2015-03-08 21:09:24'),(378,18,'教师信息管理','2015-03-08 21:09:31'),(379,18,'登陆','2015-03-08 21:14:12'),(380,18,'教师信息管理','2015-03-08 21:14:21'),(381,18,'登陆','2015-03-08 21:17:10'),(382,18,'教师信息管理','2015-03-08 21:17:17'),(383,18,'登陆','2015-03-08 21:19:14'),(384,18,'教师信息管理','2015-03-08 21:19:26'),(385,18,'登陆','2015-03-08 21:21:02'),(386,18,'教师信息管理','2015-03-08 21:21:10'),(387,18,'登陆','2015-03-08 21:24:52'),(388,18,'教师信息管理','2015-03-08 21:24:56'),(389,18,'登陆','2015-03-08 21:26:11'),(390,18,'教师信息管理','2015-03-08 21:26:13'),(391,18,'登陆','2015-03-08 21:45:48'),(392,18,'教师信息管理','2015-03-08 21:46:02'),(393,18,'登陆','2015-03-08 21:48:03'),(394,18,'教师信息管理','2015-03-08 21:48:12'),(395,18,'登陆','2015-03-08 21:49:28'),(396,18,'登陆','2015-03-08 21:49:29'),(397,18,'登陆','2015-03-08 21:49:29'),(398,18,'登陆','2015-03-08 21:49:30'),(399,18,'登陆','2015-03-08 21:49:49'),(400,18,'教师信息管理','2015-03-08 21:49:52'),(401,18,'登陆','2015-03-08 21:54:50'),(402,18,'教师信息管理','2015-03-08 21:54:52'),(403,18,'登陆','2015-03-08 22:04:22'),(404,18,'教师信息管理','2015-03-08 22:04:25'),(405,18,'登陆','2015-03-08 22:07:21'),(406,18,'教师信息管理','2015-03-08 22:07:24'),(407,18,'登陆','2015-03-08 22:13:14'),(408,18,'教师信息管理','2015-03-08 22:13:17'),(409,18,'登陆','2015-03-08 22:15:01'),(410,18,'教师信息管理','2015-03-08 22:15:14'),(411,18,'登陆','2015-03-08 22:16:30'),(412,18,'教师信息管理','2015-03-08 22:16:32'),(413,18,'登陆','2015-03-08 22:21:34'),(414,18,'教师信息管理','2015-03-08 22:21:37'),(415,18,'系统用户','2015-03-08 22:21:43'),(416,18,'登陆','2015-03-08 22:30:34'),(417,18,'系统用户','2015-03-08 22:30:38'),(418,18,'登陆','2015-03-08 22:32:36'),(419,18,'系统用户','2015-03-08 22:32:40'),(420,18,'登陆','2015-03-08 22:32:54'),(421,18,'系统用户','2015-03-08 22:32:57'),(422,18,'登陆','2015-03-08 22:33:07'),(423,18,'系统用户','2015-03-08 22:33:10'),(424,18,'登陆','2015-03-08 22:33:33'),(425,18,'系统用户','2015-03-08 22:33:36'),(426,18,'教师信息管理','2015-03-08 22:34:22'),(427,18,'登陆','2015-03-08 22:38:55'),(428,18,'教师信息管理','2015-03-08 22:38:57'),(429,18,'登陆','2015-03-14 20:04:43'),(430,18,'课程分数管理','2015-03-14 20:04:49'),(431,18,'新签单登记','2015-03-14 20:04:58'),(432,18,'签单流程管理','2015-03-14 20:05:01'),(433,18,'签单信息查询','2015-03-14 20:05:33'),(434,18,'系统用户','2015-03-14 20:05:38'),(435,18,'权限管理','2015-03-14 20:06:26'),(436,18,'菜单管理','2015-03-14 20:06:43'),(437,18,'系统访问日志','2015-03-14 20:06:51'),(438,18,'区域管理','2015-03-14 20:06:53'),(439,18,'部门管理','2015-03-14 20:06:54'),(440,18,'权限管理','2015-03-14 20:06:55'),(441,18,'区域管理','2015-03-14 20:07:20'),(442,18,'登陆','2015-03-14 21:41:25'),(443,18,'权限管理','2015-03-14 21:41:56'),(444,18,'系统用户','2015-03-14 21:42:09'),(445,18,'教师信息管理','2015-03-14 21:44:41'),(446,18,'登陆','2015-03-14 21:45:35'),(447,18,'教师信息管理','2015-03-14 21:45:38'),(448,18,'登陆','2015-03-14 21:45:54'),(449,18,'教师信息管理','2015-03-14 21:45:57'),(450,18,'菜单管理','2015-03-14 21:48:31'),(451,18,'权限管理','2015-03-14 21:48:33'),(452,18,'登陆','2015-03-14 21:48:58'),(453,18,'教师排课','2015-03-14 21:49:00'),(454,18,'登陆','2015-03-14 21:49:22'),(455,18,'登陆','2015-03-14 21:49:23'),(456,18,'教师排课','2015-03-14 21:49:28'),(457,18,'登陆','2015-03-14 21:53:39'),(458,18,'教师排课','2015-03-14 21:53:41'),(459,18,'登陆','2015-03-14 21:57:46'),(460,18,'教师信息管理','2015-03-14 21:57:48'),(461,18,'教师排课','2015-03-14 21:57:49'),(462,18,'登陆','2015-03-14 21:58:04'),(463,18,'教师排课','2015-03-14 21:58:07'),(464,18,'登陆','2015-03-14 21:58:28'),(465,18,'教师排课','2015-03-14 21:58:31'),(466,18,'登陆','2015-03-14 22:12:13'),(467,18,'教师排课','2015-03-14 22:12:16'),(468,18,'教师排课','2015-03-14 22:12:23'),(469,18,'教师排课','2015-03-14 22:34:10'),(470,18,'登陆','2015-03-14 22:34:32'),(471,18,'教师排课','2015-03-14 22:34:35'),(472,18,'登陆','2015-03-14 22:35:09'),(473,18,'教师排课','2015-03-14 22:35:11'),(474,18,'登陆','2015-03-14 22:35:14'),(475,18,'登陆','2015-03-14 22:35:27'),(476,18,'教师排课','2015-03-14 22:35:29'),(477,18,'登陆','2015-03-14 22:36:04'),(478,18,'教师排课','2015-03-14 22:36:06'),(479,18,'登陆','2015-03-15 10:34:00'),(480,18,'教师排课','2015-03-15 10:34:02'),(481,18,'签单信息查询','2015-03-15 11:17:01'),(482,18,'登陆','2015-03-15 11:18:49'),(483,18,'教师排课','2015-03-15 11:18:52'),(484,18,'登陆','2015-03-15 11:19:06'),(485,18,'教师排课','2015-03-15 11:19:11'),(486,18,'登陆','2015-03-15 11:19:44'),(487,18,'教师排课','2015-03-15 11:19:47'),(488,18,'登陆','2015-03-15 11:23:44'),(489,18,'登陆','2015-03-15 11:23:45'),(490,18,'教师排课','2015-03-15 11:23:47'),(491,18,'登陆','2015-03-15 11:23:53'),(492,18,'登陆','2015-03-15 11:23:54'),(493,18,'教师排课','2015-03-15 11:23:56'),(494,18,'登陆','2015-03-15 11:25:44'),(495,18,'登陆','2015-03-15 11:25:45'),(496,18,'教师排课','2015-03-15 11:25:47'),(497,18,'登陆','2015-03-15 11:27:19'),(498,18,'登陆','2015-03-15 11:27:20'),(499,18,'教师排课','2015-03-15 11:27:22'),(500,18,'登陆','2015-03-15 11:27:40'),(501,18,'登陆','2015-03-15 11:27:41'),(502,18,'教师排课','2015-03-15 11:27:42'),(503,18,'登陆','2015-03-15 11:29:19'),(504,18,'登陆','2015-03-15 11:29:20'),(505,18,'教师排课','2015-03-15 11:29:24'),(506,18,'登陆','2015-03-15 11:30:37'),(507,18,'登陆','2015-03-15 11:30:38'),(508,18,'教师排课','2015-03-15 11:30:40'),(509,18,'登陆','2015-03-15 11:31:38'),(510,18,'登陆','2015-03-15 11:31:39'),(511,18,'教师排课','2015-03-15 11:31:41'),(512,18,'登陆','2015-03-15 11:32:15'),(513,18,'登陆','2015-03-15 11:32:16'),(514,18,'教师排课','2015-03-15 11:32:18'),(515,18,'登陆','2015-03-15 11:35:42'),(516,18,'登陆','2015-03-15 11:35:43'),(517,18,'教师排课','2015-03-15 11:35:45'),(518,18,'登陆','2015-03-15 11:36:10'),(519,18,'教师排课','2015-03-15 11:36:14'),(520,18,'登陆','2015-03-15 11:36:35'),(521,18,'登陆','2015-03-15 11:36:36'),(522,18,'教师排课','2015-03-15 11:36:38'),(523,18,'登陆','2015-03-15 11:52:02'),(524,18,'登陆','2015-03-15 11:52:03'),(525,18,'登陆','2015-03-15 11:52:04'),(526,18,'登陆','2015-03-15 11:52:05'),(527,18,'教师排课','2015-03-15 11:52:08'),(528,18,'登陆','2015-03-15 11:52:24'),(529,18,'教师排课','2015-03-15 11:52:27'),(530,18,'登陆','2015-03-15 11:52:39'),(531,18,'登陆','2015-03-15 11:52:40'),(532,18,'教师排课','2015-03-15 11:52:42'),(533,18,'登陆','2015-03-15 11:55:34'),(534,18,'登陆','2015-03-15 11:55:35'),(535,18,'教师排课','2015-03-15 11:55:37'),(536,18,'登陆','2015-03-15 11:56:04'),(537,18,'登陆','2015-03-15 11:56:05'),(538,18,'教师排课','2015-03-15 11:56:08'),(539,18,'登陆','2015-03-15 11:57:03'),(540,18,'登陆','2015-03-15 11:57:04'),(541,18,'教师排课','2015-03-15 11:57:06'),(542,18,'登陆','2015-03-15 12:48:00'),(543,18,'登陆','2015-03-15 12:48:01'),(544,18,'教师排课','2015-03-15 12:48:15'),(545,18,'登陆','2015-03-15 12:49:03'),(546,18,'登陆','2015-03-15 12:49:04'),(547,18,'教师排课','2015-03-15 12:49:07'),(548,18,'登陆','2015-03-15 12:52:23'),(549,18,'教师排课','2015-03-15 12:52:26'),(550,18,'登陆','2015-03-15 12:53:42'),(551,18,'登陆','2015-03-15 12:53:43'),(552,18,'教师信息管理','2015-03-15 12:53:45'),(553,18,'教师排课','2015-03-15 12:53:46'),(554,18,'登陆','2015-03-15 12:58:08'),(555,18,'教师排课','2015-03-15 12:58:19'),(556,18,'登陆','2015-03-15 12:59:10'),(557,18,'登陆','2015-03-15 12:59:12'),(558,18,'教师排课','2015-03-15 12:59:14'),(559,18,'登陆','2015-03-15 12:59:59'),(560,18,'登陆','2015-03-15 13:00:00'),(561,18,'教师排课','2015-03-15 13:00:03'),(562,18,'登陆','2015-03-15 13:00:51'),(563,18,'登陆','2015-03-15 13:00:52'),(564,18,'教师排课','2015-03-15 13:00:54'),(565,18,'登陆','2015-03-15 13:01:11'),(566,18,'登陆','2015-03-15 13:01:12'),(567,18,'教师排课','2015-03-15 13:01:14'),(568,18,'登陆','2015-03-15 13:01:39'),(569,18,'登陆','2015-03-15 13:01:40'),(570,18,'教师排课','2015-03-15 13:01:42'),(571,18,'登陆','2015-03-15 13:02:10'),(572,18,'登陆','2015-03-15 13:02:11'),(573,18,'教师排课','2015-03-15 13:02:13'),(574,18,'登陆','2015-03-15 13:02:34'),(575,18,'登陆','2015-03-15 13:02:35'),(576,18,'教师排课','2015-03-15 13:02:36'),(577,18,'登陆','2015-03-15 13:03:04'),(578,18,'教师排课','2015-03-15 13:03:07'),(579,18,'登陆','2015-03-15 13:03:57'),(580,18,'登陆','2015-03-15 13:03:58'),(581,18,'教师排课','2015-03-15 13:04:01'),(582,18,'登陆','2015-03-15 13:04:04'),(583,18,'教师排课','2015-03-15 13:04:06'),(584,18,'登陆','2015-03-15 13:05:25'),(585,18,'登陆','2015-03-15 13:05:26'),(586,18,'教师排课','2015-03-15 13:05:28'),(587,18,'登陆','2015-03-15 13:06:01'),(588,18,'登陆','2015-03-15 13:06:02'),(589,18,'教师排课','2015-03-15 13:06:04'),(590,18,'登陆','2015-03-15 13:06:23'),(591,18,'登陆','2015-03-15 13:06:24'),(592,18,'教师排课','2015-03-15 13:06:26'),(593,18,'登陆','2015-03-15 13:06:45'),(594,18,'登陆','2015-03-15 13:06:46'),(595,18,'教师排课','2015-03-15 13:06:48'),(596,18,'登陆','2015-03-15 13:07:16'),(597,18,'登陆','2015-03-15 13:07:17'),(598,18,'教师排课','2015-03-15 13:07:22'),(599,18,'登陆','2015-03-15 13:07:45'),(600,18,'教师排课','2015-03-15 13:07:47'),(601,18,'登陆','2015-03-15 13:08:00'),(602,18,'教师排课','2015-03-15 13:08:02'),(603,18,'登陆','2015-03-15 13:09:07'),(604,18,'登陆','2015-03-15 13:09:08'),(605,18,'教师排课','2015-03-15 13:09:10'),(606,18,'登陆','2015-03-15 13:09:37'),(607,18,'登陆','2015-03-15 13:09:39'),(608,18,'教师排课','2015-03-15 13:09:41'),(609,18,'登陆','2015-03-15 13:10:21'),(610,18,'教师排课','2015-03-15 13:10:24'),(611,18,'登陆','2015-03-15 13:10:55'),(612,18,'教师排课','2015-03-15 13:14:06'),(613,18,'登陆','2015-03-15 13:16:43'),(614,18,'教师排课','2015-03-15 13:16:45'),(615,18,'登陆','2015-03-15 13:17:15'),(616,18,'登陆','2015-03-15 13:17:16'),(617,18,'教师排课','2015-03-15 13:17:18'),(618,18,'登陆','2015-03-15 13:17:31'),(619,18,'教师排课','2015-03-15 13:17:33'),(620,18,'登陆','2015-03-15 13:17:54'),(621,18,'教师排课','2015-03-15 13:17:56'),(622,18,'登陆','2015-03-15 13:18:31'),(623,18,'登陆','2015-03-15 13:18:31'),(624,18,'教师排课','2015-03-15 13:18:34'),(625,18,'登陆','2015-03-15 18:54:29'),(626,18,'登陆','2015-03-15 18:54:43'),(627,18,'教师排课','2015-03-15 18:54:46'),(628,18,'登陆','2015-03-15 18:56:55'),(629,18,'教师排课','2015-03-15 18:56:58'),(630,18,'登陆','2015-03-15 18:58:15'),(631,18,'教师排课','2015-03-15 18:58:17'),(632,18,'登陆','2015-03-15 19:04:57'),(633,18,'登陆','2015-03-15 19:04:58'),(634,18,'教师排课','2015-03-15 19:05:00'),(635,18,'登陆','2015-03-15 19:53:19'),(636,18,'教师排课','2015-03-15 19:53:22'),(637,18,'登陆','2015-03-15 19:54:34'),(638,18,'教师排课','2015-03-15 19:54:37'),(639,18,'登陆','2015-03-15 19:55:33'),(640,18,'教师排课','2015-03-15 19:55:36'),(641,18,'登陆','2015-03-15 19:56:25'),(642,18,'教师排课','2015-03-15 19:56:28'),(643,18,'登陆','2015-03-15 19:56:36'),(644,18,'登陆','2015-03-15 19:56:37'),(645,18,'登陆','2015-03-15 19:56:38'),(646,18,'登陆','2015-03-15 19:56:55'),(647,18,'登陆','2015-03-15 19:56:56'),(648,18,'教师排课','2015-03-15 19:57:00'),(649,18,'登陆','2015-03-15 19:57:35'),(650,18,'登陆','2015-03-15 19:57:36'),(651,18,'教师信息管理','2015-03-15 19:57:38'),(652,18,'教师排课','2015-03-15 19:57:39'),(653,18,'登陆','2015-03-15 19:58:11'),(654,18,'教师排课','2015-03-15 19:58:14'),(655,18,'登陆','2015-03-15 20:23:00'),(656,18,'教师排课','2015-03-15 20:23:06'),(657,18,'登陆','2015-03-15 20:29:19'),(658,18,'教师排课','2015-03-15 20:29:23'),(659,18,'登陆','2015-03-15 20:29:36'),(660,18,'教师排课','2015-03-15 20:29:39'),(661,18,'登陆','2015-03-15 20:29:59'),(662,18,'教师排课','2015-03-15 20:30:02'),(663,18,'登陆','2015-03-15 20:31:03'),(664,18,'教师排课','2015-03-15 20:31:06'),(665,18,'登陆','2015-03-15 20:31:54'),(666,18,'教师排课','2015-03-15 20:31:56'),(667,18,'登陆','2015-03-15 20:32:38'),(668,18,'教师排课','2015-03-15 20:32:41'),(669,18,'登陆','2015-03-15 20:33:30'),(670,18,'登陆','2015-03-15 20:33:31'),(671,18,'教师排课','2015-03-15 20:33:33'),(672,18,'登陆','2015-03-15 20:34:01'),(673,18,'登陆','2015-03-15 20:34:02'),(674,18,'教师信息管理','2015-03-15 20:34:04'),(675,18,'教师排课','2015-03-15 20:34:05'),(676,18,'登陆','2015-03-15 20:34:32'),(677,18,'登陆','2015-03-15 20:34:39'),(678,18,'教师排课','2015-03-15 20:34:42'),(679,18,'登陆','2015-03-15 20:34:58'),(680,18,'教师排课','2015-03-15 20:35:00'),(681,18,'登陆','2015-03-15 20:35:18'),(682,18,'教师排课','2015-03-15 20:35:21'),(683,18,'登陆','2015-03-15 20:36:02'),(684,18,'教师排课','2015-03-15 20:36:04'),(685,18,'系统用户','2015-03-15 20:37:04'),(686,18,'登陆','2015-03-15 20:38:36'),(687,18,'教师排课','2015-03-15 20:38:38'),(688,18,'登陆','2015-03-15 20:40:52'),(689,18,'教师排课','2015-03-15 20:40:54'),(690,18,'登陆','2015-03-15 20:41:23'),(691,18,'教师排课','2015-03-15 20:41:25'),(692,18,'登陆','2015-03-15 20:41:54'),(693,18,'教师排课','2015-03-15 20:41:57'),(694,18,'登陆','2015-03-15 20:42:35'),(695,18,'教师排课','2015-03-15 20:42:37'),(696,18,'登陆','2015-03-15 20:43:04'),(697,18,'教师排课','2015-03-15 20:43:06'),(698,18,'登陆','2015-03-15 20:43:49'),(699,18,'教师排课','2015-03-15 20:43:52'),(700,18,'登陆','2015-03-15 20:44:25'),(701,18,'登陆','2015-03-15 20:44:26'),(702,18,'教师排课','2015-03-15 20:44:28'),(703,18,'登陆','2015-03-15 20:44:38'),(704,18,'登陆','2015-03-15 20:44:39'),(705,18,'登陆','2015-03-15 20:44:40'),(706,18,'教师排课','2015-03-15 20:44:42'),(707,18,'登陆','2015-03-15 20:45:06'),(708,18,'登陆','2015-03-15 20:45:07'),(709,18,'教师排课','2015-03-15 20:45:10'),(710,18,'登陆','2015-03-15 20:45:28'),(711,18,'教师排课','2015-03-15 20:45:30'),(712,18,'登陆','2015-03-15 20:46:06'),(713,18,'登陆','2015-03-15 20:46:20'),(714,18,'教师排课','2015-03-15 20:46:22'),(715,18,'登陆','2015-03-15 20:54:25'),(716,18,'教师排课','2015-03-15 20:54:27'),(717,18,'登陆','2015-03-15 21:15:26'),(718,18,'教师排课','2015-03-15 21:15:29'),(719,18,'登陆','2015-03-15 21:16:49'),(720,18,'教师排课','2015-03-15 21:16:51'),(721,18,'登陆','2015-03-15 21:19:10'),(722,18,'教师排课','2015-03-15 21:19:13'),(723,18,'登陆','2015-03-15 21:32:48'),(724,18,'教师排课','2015-03-15 21:32:52'),(725,18,'登陆','2015-03-15 21:34:25'),(726,18,'教师排课','2015-03-15 21:34:28'),(727,18,'授课老师关联学生','2015-03-15 21:34:51'),(728,18,'教师排课','2015-03-15 21:34:53'),(729,18,'登陆','2015-03-15 21:35:37'),(730,18,'教师排课','2015-03-15 21:35:40'),(731,18,'登陆','2015-03-15 22:02:28'),(732,18,'教师排课','2015-03-15 22:02:39'),(733,18,'登陆','2015-03-15 22:06:51'),(734,18,'教师排课','2015-03-15 22:06:53'),(735,18,'登陆','2015-03-15 22:07:22'),(736,18,'登陆','2015-03-15 22:07:53'),(737,18,'登陆','2015-03-15 22:07:54'),(738,18,'教师排课','2015-03-15 22:07:57'),(739,18,'登陆','2015-03-15 22:08:50'),(740,18,'登陆','2015-03-15 22:08:51'),(741,18,'教师排课','2015-03-15 22:08:53'),(742,18,'登陆','2015-03-15 22:55:01'),(743,18,'教师排课','2015-03-15 22:55:03'),(744,18,'教师排课','2015-03-15 22:55:46'),(745,18,'登陆','2015-03-15 22:56:09'),(746,18,'教师排课','2015-03-15 22:56:12'),(747,18,'登陆','2015-03-15 22:57:18'),(748,18,'教师排课','2015-03-15 22:57:21'),(749,18,'登陆','2015-03-15 22:58:20'),(750,18,'教师排课','2015-03-15 22:58:23'),(751,18,'登陆','2015-03-15 23:14:58'),(752,18,'教师排课','2015-03-15 23:15:03'),(753,18,'登陆','2015-03-15 23:17:20'),(754,18,'教师排课','2015-03-15 23:17:23'),(755,18,'登陆','2015-03-15 23:20:53'),(756,18,'教师排课','2015-03-15 23:20:58'),(757,18,'登陆','2015-03-15 23:24:30'),(758,18,'教师排课','2015-03-15 23:24:33'),(759,18,'登陆','2015-03-15 23:26:52'),(760,18,'登陆','2015-03-15 23:26:53'),(761,18,'教师排课','2015-03-15 23:26:56'),(762,18,'登陆','2015-03-15 23:29:38'),(763,18,'教师排课','2015-03-15 23:29:41'),(764,18,'登陆','2015-03-15 23:29:54'),(765,18,'教师排课','2015-03-15 23:29:57'),(766,18,'登陆','2015-03-15 23:31:12'),(767,18,'教师排课','2015-03-15 23:31:15'),(768,18,'登陆','2015-03-15 23:31:49'),(769,18,'教师排课','2015-03-15 23:31:52'),(770,18,'登陆','2015-03-15 23:32:33'),(771,18,'教师排课','2015-03-15 23:32:36'),(772,18,'登陆','2015-03-15 23:34:04'),(773,18,'教师排课','2015-03-15 23:34:07'),(774,18,'登陆','2015-03-17 22:08:16'),(775,18,'教师排课','2015-03-17 22:08:50'),(776,18,'新签单登记','2015-03-17 22:10:22'),(777,18,'签单流程管理','2015-03-17 22:10:23'),(778,18,'签单流程管理','2015-03-17 22:11:23'),(779,18,'新签单登记','2015-03-17 22:11:45'),(780,18,'签单流程管理','2015-03-17 22:11:45'),(781,18,'角色树','2015-03-17 22:11:51'),(782,18,'签单流程管理','2015-03-17 22:12:02'),(783,18,'登陆','2015-03-17 22:36:09'),(784,18,'教师排课','2015-03-17 22:37:59'),(785,18,'登陆','2015-03-17 22:38:00'),(786,18,'教师排课','2015-03-17 22:38:03'),(787,18,'登陆','2015-03-17 22:38:40'),(788,18,'登陆','2015-03-17 22:38:42'),(789,18,'教师排课','2015-03-17 22:38:45'),(790,18,'登陆','2015-03-17 22:42:24'),(791,18,'教师排课','2015-03-17 22:42:26'),(792,18,'登陆','2015-03-17 22:42:59'),(793,18,'教师排课','2015-03-17 22:43:01'),(794,18,'登陆','2015-03-17 22:43:54'),(795,18,'教师排课','2015-03-17 22:43:57'),(796,18,'登陆','2015-03-17 22:45:03'),(797,18,'教师排课','2015-03-17 22:45:06'),(798,18,'登陆','2015-03-17 22:45:11'),(799,18,'登陆','2015-03-17 22:45:42'),(800,18,'登陆','2015-03-17 22:45:46'),(801,18,'登陆','2015-03-17 22:46:21'),(802,18,'登陆','2015-03-17 22:46:54'),(803,18,'教师排课','2015-03-17 22:47:01'),(804,18,'登陆','2015-03-17 22:47:35'),(805,18,'教师排课','2015-03-17 22:47:37'),(806,18,'登陆','2015-03-17 22:48:14'),(807,18,'教师排课','2015-03-17 22:48:19'),(808,18,'登陆','2015-03-17 22:48:36'),(809,18,'教师排课','2015-03-17 22:48:38'),(810,18,'登陆','2015-03-17 22:48:48'),(811,18,'教师排课','2015-03-17 22:48:50'),(812,18,'登陆','2015-03-17 22:49:02'),(813,18,'教师排课','2015-03-17 22:49:04'),(814,18,'登陆','2015-03-17 22:49:16'),(815,18,'教师排课','2015-03-17 22:49:19'),(816,18,'登陆','2015-03-17 22:49:46'),(817,18,'教师排课','2015-03-17 22:49:48'),(818,18,'登陆','2015-03-17 22:50:10'),(819,18,'教师排课','2015-03-17 22:50:13'),(820,18,'登陆','2015-03-17 22:51:03'),(821,18,'登陆','2015-03-17 22:51:04'),(822,18,'教师排课','2015-03-17 22:51:06'),(823,18,'登陆','2015-03-17 22:52:21'),(824,18,'教师排课','2015-03-17 22:52:23'),(825,18,'登陆','2015-03-17 22:52:35'),(826,18,'教师排课','2015-03-17 22:52:38'),(827,18,'登陆','2015-03-17 22:52:50'),(828,18,'教师信息管理','2015-03-17 22:52:53'),(829,18,'教师排课','2015-03-17 22:52:53'),(830,18,'登陆','2015-03-17 22:53:06'),(831,18,'教师排课','2015-03-17 22:53:09'),(832,18,'登陆','2015-03-17 22:54:45'),(833,18,'教师排课','2015-03-17 22:54:48'),(834,18,'客户管理','2015-03-17 22:55:24'),(835,18,'来电交流管理','2015-03-17 22:55:32'),(836,18,'登陆','2015-03-17 22:55:47'),(837,18,'教师排课','2015-03-17 22:55:52'),(838,18,'登陆','2015-03-17 22:56:14'),(839,18,'教师排课','2015-03-17 22:56:17'),(840,18,'登陆','2015-03-17 23:00:21'),(841,18,'教师排课','2015-03-17 23:00:24'),(842,18,'登陆','2015-03-17 23:01:35'),(843,18,'教师信息管理','2015-03-17 23:01:38'),(844,18,'教师排课','2015-03-17 23:01:47'),(845,18,'登陆','2015-03-17 23:02:09'),(846,18,'教师排课','2015-03-17 23:02:11'),(847,18,'登陆','2015-03-17 23:03:34'),(848,18,'登陆','2015-03-17 23:03:35'),(849,18,'教师排课','2015-03-17 23:03:37'),(850,18,'权限管理','2015-03-17 23:04:53'),(851,18,'系统用户','2015-03-17 23:04:54'),(852,18,'续单管理','2015-03-17 23:13:38'),(853,18,'教师排课','2015-03-17 23:13:48'),(854,18,'教师排课','2015-03-17 23:15:55'),(855,18,'教师信息管理','2015-03-17 23:16:09'),(856,18,'教师排课','2015-03-17 23:17:49'),(857,18,'登陆','2015-03-17 23:19:22'),(858,18,'教师排课','2015-03-17 23:19:25'),(859,18,'登陆','2015-03-17 23:22:56'),(860,18,'教师排课','2015-03-17 23:22:58'),(861,18,'登陆','2015-03-17 23:23:34'),(862,18,'教师排课','2015-03-17 23:23:36'),(863,18,'登陆','2015-03-17 23:23:56'),(864,18,'教师排课','2015-03-17 23:23:59'),(865,18,'系统用户','2015-03-17 23:24:41'),(866,18,'登陆','2015-03-17 23:25:17'),(867,18,'教师排课','2015-03-17 23:25:19'),(868,18,'登陆','2015-03-17 23:26:02'),(869,18,'教师排课','2015-03-17 23:26:05'),(870,18,'登陆','2015-03-17 23:26:22'),(871,18,'教师排课','2015-03-17 23:26:24'),(872,18,'登陆','2015-03-17 23:26:29'),(873,18,'教师排课','2015-03-17 23:26:31'),(874,18,'登陆','2015-03-17 23:29:21'),(875,18,'教师排课','2015-03-17 23:29:23'),(876,18,'登陆','2015-03-17 23:29:51'),(877,18,'教师排课','2015-03-17 23:29:53'),(878,18,'登陆','2015-03-17 23:30:51'),(879,18,'教师排课','2015-03-17 23:30:54'),(880,18,'登陆','2015-03-17 23:31:07'),(881,18,'教师排课','2015-03-17 23:31:09'),(882,18,'登陆','2015-03-17 23:32:34'),(883,18,'教师排课','2015-03-17 23:32:37'),(884,18,'登陆','2015-03-17 23:32:50'),(885,18,'教师排课','2015-03-17 23:32:52'),(886,18,'登陆','2015-03-17 23:33:21'),(887,18,'教师排课','2015-03-17 23:33:24'),(888,18,'登陆','2015-03-17 23:33:40'),(889,18,'教师排课','2015-03-17 23:33:43'),(890,18,'登陆','2015-03-17 23:33:54'),(891,18,'教师排课','2015-03-17 23:33:57'),(892,18,'登陆','2015-03-17 23:34:59'),(893,18,'教师排课','2015-03-17 23:35:01'),(894,18,'登陆','2015-03-17 23:35:42'),(895,18,'教师排课','2015-03-17 23:35:44'),(896,18,'登陆','2015-03-17 23:36:21'),(897,18,'教师信息管理','2015-03-17 23:36:23'),(898,18,'教师排课','2015-03-17 23:36:23'),(899,18,'登陆','2015-03-17 23:36:41'),(900,18,'教师排课','2015-03-17 23:36:44'),(901,18,'登陆','2015-03-17 23:37:26'),(902,18,'教师排课','2015-03-17 23:37:28'),(903,18,'登陆','2015-03-17 23:38:08'),(904,18,'登陆','2015-03-17 23:38:09'),(905,18,'教师排课','2015-03-17 23:38:11'),(906,18,'登陆','2015-03-17 23:39:46'),(907,18,'教师排课','2015-03-17 23:39:49'),(908,18,'登陆','2015-03-18 21:25:25'),(909,18,'教师排课','2015-03-18 21:25:57'),(910,18,'来电交流管理','2015-03-18 21:27:30'),(911,18,'来电交流管理','2015-03-18 21:27:32'),(912,18,'客户管理','2015-03-18 21:27:33'),(913,18,'来电交流管理','2015-03-18 21:27:40'),(914,18,'来电交流管理','2015-03-18 21:27:51'),(915,18,'学生沟通记录','2015-03-18 21:28:04'),(916,18,'学生信息登记','2015-03-18 21:28:06'),(917,18,'学生信息管理','2015-03-18 21:28:08'),(918,18,'客户管理','2015-03-18 21:28:35'),(919,18,'来电交流管理','2015-03-18 21:28:40'),(920,18,'来电交流管理','2015-03-18 21:28:46'),(921,18,'来电交流管理','2015-03-18 21:28:57'),(922,18,'学生信息管理','2015-03-18 21:30:07'),(923,18,'学生沟通记录','2015-03-18 21:30:08'),(924,18,'学生信息登记','2015-03-18 21:30:09'),(925,18,'新签单登记','2015-03-18 21:30:14'),(926,18,'登陆','2015-03-18 21:34:28'),(927,18,'教师排课','2015-03-18 21:34:31'),(928,18,'登陆','2015-03-18 21:34:45'),(929,18,'教师排课','2015-03-18 21:34:48'),(930,18,'登陆','2015-03-18 21:37:29'),(931,18,'教师排课','2015-03-18 21:37:32'),(932,18,'登陆','2015-03-18 21:41:08'),(933,18,'登陆','2015-03-18 21:41:10'),(934,18,'教师排课','2015-03-18 21:41:12'),(935,18,'登陆','2015-03-18 21:41:35'),(936,18,'教师排课','2015-03-18 21:41:38'),(937,18,'登陆','2015-03-18 21:42:30'),(938,18,'教师排课','2015-03-18 21:42:33'),(939,18,'登陆','2015-03-18 21:44:21'),(940,18,'教师排课','2015-03-18 21:44:24'),(941,18,'登陆','2015-03-18 21:44:38'),(942,18,'教师排课','2015-03-18 21:44:40'),(943,18,'登陆','2015-03-18 21:44:49'),(944,18,'教师排课','2015-03-18 21:44:51'),(945,18,'登陆','2015-03-18 21:46:17'),(946,18,'教师排课','2015-03-18 21:46:19'),(947,18,'登陆','2015-03-18 21:46:36'),(948,18,'教师排课','2015-03-18 21:46:38'),(949,18,'登陆','2015-03-18 21:47:26'),(950,18,'教师排课','2015-03-18 21:47:29'),(951,18,'登陆','2015-03-18 21:47:55'),(952,18,'教师排课','2015-03-18 21:47:57'),(953,18,'登陆','2015-03-18 21:49:30'),(954,18,'教师排课','2015-03-18 21:49:32'),(955,18,'登陆','2015-03-18 21:50:09'),(956,18,'教师排课','2015-03-18 21:50:11'),(957,18,'登陆','2015-03-18 21:50:42'),(958,18,'教师排课','2015-03-18 21:50:44'),(959,18,'教师排课','2015-03-18 21:51:00'),(960,18,'登陆','2015-03-18 21:53:00'),(961,18,'教师排课','2015-03-18 21:53:03'),(962,18,'登陆','2015-03-18 21:53:24'),(963,18,'教师排课','2015-03-18 21:53:27'),(964,18,'登陆','2015-03-18 21:53:44'),(965,18,'教师排课','2015-03-18 21:53:46'),(966,18,'登陆','2015-03-18 21:53:56'),(967,18,'教师排课','2015-03-18 21:53:59'),(968,18,'登陆','2015-03-18 21:54:13'),(969,18,'教师排课','2015-03-18 21:54:15'),(970,18,'登陆','2015-03-18 21:54:57'),(971,18,'教师排课','2015-03-18 21:55:00'),(972,18,'登陆','2015-03-18 21:55:19'),(973,18,'教师排课','2015-03-18 21:55:21'),(974,18,'登陆','2015-03-18 21:58:30'),(975,18,'教师排课','2015-03-18 21:58:32'),(976,18,'登陆','2015-03-18 22:00:24'),(977,18,'教师排课','2015-03-18 22:00:26'),(978,18,'登陆','2015-03-18 22:00:55'),(979,18,'登陆','2015-03-18 22:00:56'),(980,18,'教师排课','2015-03-18 22:00:58'),(981,18,'登陆','2015-03-18 22:01:53'),(982,18,'教师排课','2015-03-18 22:01:55'),(983,18,'登陆','2015-03-18 22:02:06'),(984,18,'登陆','2015-03-18 22:02:07'),(985,18,'教师排课','2015-03-18 22:02:09'),(986,18,'登陆','2015-03-18 22:04:01'),(987,18,'教师排课','2015-03-18 22:04:03'),(988,18,'登陆','2015-03-18 22:07:40'),(989,18,'教师排课','2015-03-18 22:07:42'),(990,18,'登陆','2015-03-18 22:07:54'),(991,18,'登陆','2015-03-18 22:07:55'),(992,18,'教师信息管理','2015-03-18 22:07:57'),(993,18,'教师排课','2015-03-18 22:07:58'),(994,18,'登陆','2015-03-18 22:08:14'),(995,18,'教师排课','2015-03-18 22:08:17'),(996,18,'登陆','2015-03-18 22:08:25'),(997,18,'教师排课','2015-03-18 22:08:27'),(998,18,'登陆','2015-03-18 22:13:37'),(999,18,'登陆','2015-03-18 22:13:39'),(1000,18,'教师排课','2015-03-18 22:13:41'),(1001,18,'登陆','2015-03-18 22:21:18'),(1002,18,'教师排课','2015-03-18 22:21:21'),(1003,18,'登陆','2015-03-18 22:21:53'),(1004,18,'教师排课','2015-03-18 22:21:56'),(1005,18,'登陆','2015-03-18 22:22:44'),(1006,18,'教师排课','2015-03-18 22:22:47'),(1007,18,'登陆','2015-03-18 22:23:38'),(1008,18,'教师排课','2015-03-18 22:23:40'),(1009,18,'登陆','2015-03-18 22:24:07'),(1010,18,'教师排课','2015-03-18 22:24:10'),(1011,18,'登陆','2015-03-18 22:24:26'),(1012,18,'教师排课','2015-03-18 22:24:28'),(1013,18,'登陆','2015-03-18 22:24:52'),(1014,18,'教师排课','2015-03-18 22:24:55'),(1015,18,'登陆','2015-03-18 22:25:05'),(1016,18,'教师排课','2015-03-18 22:25:07'),(1017,18,'登陆','2015-03-18 22:25:31'),(1018,18,'教师信息管理','2015-03-18 22:25:34'),(1019,18,'教师排课','2015-03-18 22:25:34'),(1020,18,'登陆','2015-03-18 22:26:31'),(1021,18,'教师排课','2015-03-18 22:26:33'),(1022,18,'教师排课','2015-03-18 22:27:20'),(1023,18,'登陆','2015-03-19 21:06:39'),(1024,18,'教师排课','2015-03-19 21:06:41'),(1025,18,'登陆','2015-03-19 21:12:27'),(1026,18,'教师排课','2015-03-19 21:12:30'),(1027,18,'登陆','2015-03-19 21:12:33'),(1028,18,'登陆','2015-03-19 21:16:11'),(1029,18,'教师排课','2015-03-19 21:16:15'),(1030,18,'客户管理','2015-03-19 21:16:34'),(1031,18,'来电交流管理','2015-03-19 21:16:39'),(1032,18,'登陆','2015-03-19 21:19:29'),(1033,18,'教师排课','2015-03-19 21:19:31'),(1034,18,'登陆','2015-03-19 21:22:03'),(1035,18,'教师排课','2015-03-19 21:22:05'),(1036,18,'登陆','2015-03-19 21:25:50'),(1037,18,'教师排课','2015-03-19 21:25:53'),(1038,18,'登陆','2015-03-19 21:26:04'),(1039,18,'教师排课','2015-03-19 21:26:06'),(1040,18,'登陆','2015-03-19 21:26:41'),(1041,18,'教师排课','2015-03-19 21:26:43'),(1042,18,'登陆','2015-03-19 21:27:03'),(1043,18,'教师排课','2015-03-19 21:27:06'),(1044,18,'登陆','2015-03-19 21:27:16'),(1045,18,'教师排课','2015-03-19 21:27:19'),(1046,18,'登陆','2015-03-19 21:27:49'),(1047,18,'教师排课','2015-03-19 21:27:52'),(1048,18,'登陆','2015-03-19 21:29:34'),(1049,18,'教师排课','2015-03-19 21:29:38'),(1050,18,'登陆','2015-03-22 21:10:16'),(1051,18,'教师排课','2015-03-22 21:10:19'),(1052,18,'登陆','2015-03-22 21:14:02'),(1053,18,'教师排课','2015-03-22 21:14:04'),(1054,18,'登陆','2015-03-22 21:14:18'),(1055,18,'教师排课','2015-03-22 21:14:20'),(1056,18,'登陆','2015-03-22 21:17:21'),(1057,18,'教师排课','2015-03-22 21:17:24'),(1058,18,'新签单登记','2015-03-22 21:19:06'),(1059,18,'签单流程管理','2015-03-22 21:19:09'),(1060,18,'登陆','2015-03-22 21:31:41'),(1061,18,'教师排课','2015-03-22 21:31:44'),(1062,18,'登陆','2015-03-22 21:32:07'),(1063,18,'教师排课','2015-03-22 21:32:09'),(1064,18,'登陆','2015-03-22 21:32:25'),(1065,18,'教师排课','2015-03-22 21:32:28'),(1066,18,'登陆','2015-03-22 21:33:01'),(1067,18,'教师排课','2015-03-22 21:33:04'),(1068,18,'登陆','2015-03-22 21:33:18'),(1069,18,'登陆','2015-03-22 21:33:19'),(1070,18,'教师排课','2015-03-22 21:33:21'),(1071,18,'登陆','2015-03-22 21:33:36'),(1072,18,'教师排课','2015-03-22 21:33:39'),(1073,18,'登陆','2015-03-22 21:34:00'),(1074,18,'教师排课','2015-03-22 21:34:03'),(1075,18,'登陆','2015-03-22 21:36:05'),(1076,18,'教师排课','2015-03-22 21:36:09'),(1077,18,'登陆','2015-03-22 21:36:23'),(1078,18,'教师排课','2015-03-22 21:36:25'),(1079,18,'登陆','2015-03-22 21:39:09'),(1080,18,'教师排课','2015-03-22 21:39:11'),(1081,18,'登陆','2015-03-22 21:39:25'),(1082,18,'教师排课','2015-03-22 21:39:28'),(1083,18,'登陆','2015-03-22 21:40:07'),(1084,18,'登陆','2015-03-22 21:40:08'),(1085,18,'教师排课','2015-03-22 21:40:10'),(1086,18,'登陆','2015-03-22 21:40:36'),(1087,18,'教师排课','2015-03-22 21:40:38'),(1088,18,'登陆','2015-03-22 21:41:16'),(1089,18,'教师排课','2015-03-22 21:41:18'),(1090,18,'登陆','2015-03-22 21:41:25'),(1091,18,'登陆','2015-03-22 21:41:26'),(1092,18,'登陆','2015-03-22 21:41:26'),(1093,18,'登陆','2015-03-22 21:41:26'),(1094,18,'登陆','2015-03-22 21:41:34'),(1095,18,'教师排课','2015-03-22 21:41:37'),(1096,18,'登陆','2015-03-22 21:42:44'),(1097,18,'教师排课','2015-03-22 21:42:47'),(1098,18,'登陆','2015-03-22 21:43:08'),(1099,18,'教师排课','2015-03-22 21:43:10'),(1100,18,'登陆','2015-03-22 21:46:27'),(1101,18,'登陆','2015-03-22 21:46:28'),(1102,18,'教师排课','2015-03-22 21:46:31'),(1103,18,'登陆','2015-03-22 21:47:22'),(1104,18,'教师信息管理','2015-03-22 21:47:24'),(1105,18,'教师排课','2015-03-22 21:47:25'),(1106,18,'登陆','2015-03-22 21:47:57'),(1107,18,'登陆','2015-03-22 21:47:58'),(1108,18,'教师排课','2015-03-22 21:48:00'),(1109,18,'登陆','2015-03-22 21:48:17'),(1110,18,'登陆','2015-03-22 21:48:18'),(1111,18,'教师排课','2015-03-22 21:48:20'),(1112,18,'登陆','2015-03-22 21:48:33'),(1113,18,'登陆','2015-03-22 21:48:34'),(1114,18,'登陆','2015-03-22 21:48:34'),(1115,18,'教师排课','2015-03-22 21:48:36'),(1116,18,'新签单登记','2015-03-22 21:51:13'),(1117,18,'登陆','2015-03-22 21:53:45'),(1118,18,'教师排课','2015-03-22 21:53:48'),(1119,18,'登陆','2015-03-22 21:55:03'),(1120,18,'教师排课','2015-03-22 21:55:07'),(1121,18,'登陆','2015-03-22 21:55:51'),(1122,18,'教师排课','2015-03-22 21:55:53'),(1123,18,'新签单登记','2015-03-22 21:56:14'),(1124,18,'登陆','2015-03-22 21:58:29'),(1125,18,'教师排课','2015-03-22 21:58:31'),(1126,18,'登陆','2015-03-31 20:44:18'),(1127,18,'教师排课','2015-03-31 20:44:21'),(1128,18,'登陆','2015-03-31 20:51:28'),(1129,18,'教师排课','2015-03-31 20:51:31'),(1130,18,'登陆','2015-03-31 20:51:59'),(1131,18,'教师排课','2015-03-31 20:52:01'),(1132,18,'登陆','2015-03-31 20:52:12'),(1133,18,'教师排课','2015-03-31 20:52:14'),(1134,18,'登陆','2015-03-31 20:52:54'),(1135,18,'教师排课','2015-03-31 20:52:56'),(1136,18,'登陆','2015-03-31 20:53:36'),(1137,18,'教师排课','2015-03-31 20:53:39'),(1138,18,'登陆','2015-03-31 20:53:53'),(1139,18,'教师排课','2015-03-31 20:53:55'),(1140,18,'登陆','2015-03-31 21:01:04'),(1141,18,'教师排课','2015-03-31 21:01:07'),(1142,18,'登陆','2015-03-31 21:01:36'),(1143,18,'教师排课','2015-03-31 21:02:07'),(1144,18,'登陆','2015-03-31 21:02:55'),(1145,18,'教师排课','2015-03-31 21:02:57'),(1146,18,'登陆','2015-03-31 22:38:09'),(1147,18,'教师排课','2015-03-31 22:38:12'),(1148,18,'教师排课','2015-03-31 22:39:26'),(1149,18,'登陆','2015-03-31 22:40:27'),(1150,18,'教师排课','2015-03-31 22:40:30'),(1151,18,'登陆','2015-03-31 22:41:35'),(1152,18,'教师排课','2015-03-31 22:41:37'),(1153,18,'登陆','2015-03-31 22:41:50'),(1154,18,'登陆','2015-03-31 22:41:51'),(1155,18,'教师排课','2015-03-31 22:41:53'),(1156,18,'登陆','2015-03-31 22:44:57'),(1157,18,'教师排课','2015-03-31 22:44:59'),(1158,18,'登陆','2015-03-31 22:45:15'),(1159,18,'教师排课','2015-03-31 22:45:18'),(1160,18,'登陆','2015-03-31 22:46:53'),(1161,18,'教师排课','2015-03-31 22:46:55'),(1162,18,'登陆','2015-03-31 22:57:35'),(1163,18,'教师排课','2015-03-31 22:57:37'),(1164,18,'登陆','2015-03-31 22:58:16'),(1165,18,'教师信息管理','2015-03-31 22:58:20'),(1166,18,'教师排课','2015-03-31 22:58:20'),(1167,18,'登陆','2015-03-31 22:58:35'),(1168,18,'登陆','2015-03-31 22:58:36'),(1169,18,'教师排课','2015-03-31 22:58:38'),(1170,18,'登陆','2015-03-31 22:58:56'),(1171,18,'教师排课','2015-03-31 22:58:58'),(1172,18,'登陆','2015-03-31 23:02:49'),(1173,18,'教师排课','2015-03-31 23:02:51'),(1174,18,'登陆','2015-03-31 23:10:59'),(1175,18,'教师排课','2015-03-31 23:11:01'),(1176,18,'登陆','2015-03-31 23:12:12'),(1177,18,'教师排课','2015-03-31 23:12:14'),(1178,18,'登陆','2015-03-31 23:13:52'),(1179,18,'系统用户','2015-03-31 23:14:41'),(1180,18,'教师排课','2015-03-31 23:14:45'),(1181,18,'登陆','2015-03-31 23:15:18'),(1182,18,'登陆','2015-03-31 23:15:19'),(1183,18,'教师排课','2015-03-31 23:15:21'),(1184,18,'登陆','2015-03-31 23:17:23'),(1185,18,'登陆','2015-03-31 23:17:24'),(1186,18,'教师排课','2015-03-31 23:17:26'),(1187,18,'登陆','2015-03-31 23:18:02'),(1188,18,'登陆','2015-03-31 23:18:04'),(1189,18,'教师排课','2015-03-31 23:18:05'),(1190,18,'登陆','2015-03-31 23:20:51'),(1191,18,'教师排课','2015-03-31 23:20:54'),(1192,18,'登陆','2015-03-31 23:22:12'),(1193,18,'教师排课','2015-03-31 23:22:15'),(1194,18,'登陆','2015-04-01 21:14:45'),(1195,18,'未处理任务','2015-04-01 21:15:49'),(1196,18,'教师排课','2015-04-01 21:15:59'),(1197,18,'授课老师关联学生','2015-04-01 21:16:25'),(1198,18,'授课老师关联学生','2015-04-01 21:16:29'),(1199,18,'登陆','2015-04-01 21:19:34'),(1200,18,'教师排课','2015-04-01 21:19:51'),(1201,18,'登陆','2015-04-01 21:20:20'),(1202,18,'登陆','2015-04-01 21:20:21'),(1203,18,'教师排课','2015-04-01 21:20:23'),(1204,18,'登陆','2015-04-01 21:20:38'),(1205,18,'登陆','2015-04-01 21:20:38'),(1206,18,'教师排课','2015-04-01 21:20:40'),(1207,18,'登陆','2015-04-01 21:21:10'),(1208,18,'教师排课','2015-04-01 21:21:12'),(1209,18,'教师排课','2015-04-01 21:21:23'),(1210,18,'登陆','2015-04-01 21:21:51'),(1211,18,'登陆','2015-04-01 21:21:52'),(1212,18,'教师排课','2015-04-01 21:21:54'),(1213,18,'登陆','2015-04-01 21:22:35'),(1214,18,'登陆','2015-04-01 21:22:36'),(1215,18,'教师排课','2015-04-01 21:22:38'),(1216,18,'教师排课','2015-04-01 21:22:45'),(1217,18,'登陆','2015-04-01 21:23:05'),(1218,18,'教师排课','2015-04-01 21:23:07'),(1219,18,'签单日统计','2015-04-01 21:25:06'),(1220,18,'签单月统计','2015-04-01 21:25:07'),(1221,18,'签单月统计','2015-04-01 21:25:40'),(1222,18,'登陆','2015-04-01 21:27:07'),(1223,18,'教师排课','2015-04-01 21:27:09'),(1224,18,'登陆','2015-04-01 21:28:32'),(1225,18,'登陆','2015-04-01 21:28:33'),(1226,18,'教师排课','2015-04-01 21:28:35'),(1227,18,'登陆','2015-04-01 21:29:51'),(1228,18,'教师排课','2015-04-01 21:29:54'),(1229,18,'登陆','2015-04-01 21:30:12'),(1230,18,'教师排课','2015-04-01 21:30:14'),(1231,18,'登陆','2015-04-01 21:31:18'),(1232,18,'教师排课','2015-04-01 21:31:20'),(1233,18,'登陆','2015-04-01 21:31:36'),(1234,18,'教师排课','2015-04-01 21:31:37'),(1235,18,'登陆','2015-04-01 21:33:16'),(1236,18,'教师排课','2015-04-01 21:33:19'),(1237,18,'登陆','2015-04-01 21:35:15'),(1238,18,'教师排课','2015-04-01 21:35:18'),(1239,18,'登陆','2015-04-01 21:35:55'),(1240,18,'教师排课','2015-04-01 21:35:57'),(1241,18,'登陆','2015-04-01 21:36:17'),(1242,18,'教师排课','2015-04-01 21:36:20'),(1243,18,'登陆','2015-04-01 21:36:24'),(1244,18,'登陆','2015-04-01 21:37:00'),(1245,18,'登陆','2015-04-01 21:37:00'),(1246,18,'教师排课','2015-04-01 21:37:02'),(1247,18,'登陆','2015-04-01 21:37:36'),(1248,18,'登陆','2015-04-01 21:37:37'),(1249,18,'教师排课','2015-04-01 21:37:38'),(1250,18,'登陆','2015-04-01 21:40:15'),(1251,18,'教师排课','2015-04-01 21:40:18'),(1252,18,'登陆','2015-04-01 21:40:56'),(1253,18,'教师排课','2015-04-01 21:40:58'),(1254,18,'登陆','2015-04-01 21:43:29'),(1255,18,'教师排课','2015-04-01 21:43:32'),(1256,18,'登陆','2015-04-01 21:43:38'),(1257,18,'登陆','2015-04-01 21:43:38'),(1258,18,'登陆','2015-04-01 21:43:51'),(1259,18,'教师排课','2015-04-01 21:43:53'),(1260,18,'登陆','2015-04-01 21:45:03'),(1261,18,'教师排课','2015-04-01 21:45:07'),(1262,18,'登陆','2015-04-01 21:46:12'),(1263,18,'教师排课','2015-04-01 21:46:14'),(1264,18,'签单月统计','2015-04-01 21:46:39'),(1265,18,'登陆','2015-04-01 21:47:19'),(1266,18,'教师排课','2015-04-01 21:47:22'),(1267,18,'登陆','2015-04-01 21:47:40'),(1268,18,'教师排课','2015-04-01 21:47:42'),(1269,18,'登陆','2015-04-01 21:48:34'),(1270,18,'教师排课','2015-04-01 21:48:36'),(1271,18,'登陆','2015-04-01 21:49:26'),(1272,18,'教师排课','2015-04-01 21:49:28'),(1273,18,'登陆','2015-04-01 21:49:44'),(1274,18,'教师排课','2015-04-01 21:49:46'),(1275,18,'登陆','2015-04-01 21:50:01'),(1276,18,'教师排课','2015-04-01 21:50:03'),(1277,18,'登陆','2015-04-01 22:00:49'),(1278,18,'教师排课','2015-04-01 22:00:51'),(1279,18,'登陆','2015-04-01 22:01:08'),(1280,18,'教师排课','2015-04-01 22:01:10'),(1281,18,'登陆','2015-04-01 22:01:53'),(1282,18,'教师排课','2015-04-01 22:01:55'),(1283,18,'登陆','2015-04-01 22:05:12'),(1284,18,'教师排课','2015-04-01 22:05:14'),(1285,18,'登陆','2015-04-01 22:06:38'),(1286,18,'教师排课','2015-04-01 22:06:40'),(1287,18,'登陆','2015-04-01 22:07:12'),(1288,18,'教师排课','2015-04-01 22:07:15'),(1289,18,'登陆','2015-04-01 22:07:41'),(1290,18,'教师排课','2015-04-01 22:07:44'),(1291,18,'登陆','2015-04-01 22:08:04'),(1292,18,'教师排课','2015-04-01 22:08:07'),(1293,18,'登陆','2015-04-01 22:08:39'),(1294,18,'教师排课','2015-04-01 22:08:41'),(1295,18,'登陆','2015-04-01 22:09:24'),(1296,18,'教师排课','2015-04-01 22:09:27'),(1297,18,'登陆','2015-04-01 22:09:34'),(1298,18,'教师排课','2015-04-01 22:09:37'),(1299,18,'登陆','2015-04-01 22:09:40'),(1300,18,'登陆','2015-04-01 22:10:48'),(1301,18,'教师排课','2015-04-01 22:10:52'),(1302,18,'登陆','2015-04-01 22:12:07'),(1303,18,'教师排课','2015-04-01 22:12:09'),(1304,18,'新签单登记','2015-04-01 22:13:00'),(1305,18,'签单流程管理','2015-04-01 22:13:01'),(1306,18,'签单信息查询','2015-04-01 22:13:03'),(1307,18,'登陆','2015-04-01 22:16:11'),(1308,18,'教师排课','2015-04-01 22:16:13'),(1309,18,'登陆','2015-04-01 22:17:31'),(1310,18,'教师排课','2015-04-01 22:17:33'),(1311,18,'登陆','2015-04-01 22:22:36'),(1312,18,'教师排课','2015-04-01 22:22:38'),(1313,18,'登陆','2015-04-01 22:24:05'),(1314,18,'教师排课','2015-04-01 22:24:09'),(1315,18,'登陆','2015-04-01 22:26:06'),(1316,18,'教师排课','2015-04-01 22:26:10'),(1317,18,'登陆','2015-04-01 22:27:24'),(1318,18,'教师排课','2015-04-01 22:27:27'),(1319,18,'登陆','2015-04-01 22:27:46'),(1320,18,'教师排课','2015-04-01 22:27:49'),(1321,18,'登陆','2015-04-01 22:28:21'),(1322,18,'教师排课','2015-04-01 22:28:24'),(1323,18,'登陆','2015-04-01 22:53:18'),(1324,18,'教师排课','2015-04-01 22:54:51'),(1325,18,'新签单登记','2015-04-01 22:56:09'),(1326,18,'登陆','2015-04-01 22:57:03'),(1327,18,'教师排课','2015-04-01 22:57:06'),(1328,18,'登陆','2015-04-01 22:57:36'),(1329,18,'教师排课','2015-04-01 22:57:39'),(1330,18,'登陆','2015-04-01 22:57:54'),(1331,18,'教师排课','2015-04-01 22:57:56'),(1332,18,'登陆','2015-04-01 22:58:23'),(1333,18,'教师排课','2015-04-01 22:58:26'),(1334,18,'登陆','2015-04-01 22:58:39'),(1335,18,'教师排课','2015-04-01 22:58:41'),(1336,18,'登陆','2015-04-01 22:58:53'),(1337,18,'教师排课','2015-04-01 22:58:55'),(1338,18,'登陆','2015-04-01 22:59:26'),(1339,18,'教师排课','2015-04-01 22:59:29'),(1340,18,'登陆','2015-04-01 22:59:41'),(1341,18,'教师排课','2015-04-01 22:59:43'),(1342,18,'登陆','2015-04-01 23:06:48'),(1343,18,'教师排课','2015-04-01 23:06:50'),(1344,18,'登陆','2015-04-01 23:16:10'),(1345,18,'教师排课','2015-04-01 23:16:13'),(1346,18,'登陆','2015-04-01 23:17:43'),(1347,18,'教师排课','2015-04-01 23:17:46'),(1348,18,'新签单登记','2015-04-01 23:23:06'),(1349,18,'登陆','2015-04-01 23:25:22'),(1350,18,'教师排课','2015-04-01 23:25:25'),(1351,18,'登陆','2015-04-01 23:25:58'),(1352,18,'教师排课','2015-04-01 23:26:00'),(1353,18,'登陆','2015-04-01 23:26:23'),(1354,18,'教师排课','2015-04-01 23:26:25'),(1355,18,'登陆','2015-04-01 23:27:27'),(1356,18,'教师排课','2015-04-01 23:27:30'),(1357,18,'登陆','2015-04-01 23:28:12'),(1358,18,'教师排课','2015-04-01 23:28:14'),(1359,18,'登陆','2015-04-01 23:28:42'),(1360,18,'教师排课','2015-04-01 23:28:44'),(1361,18,'签单信息查询','2015-04-01 23:29:04'),(1362,18,'新签单登记','2015-04-01 23:29:05'),(1363,18,'登陆','2015-04-01 23:29:20'),(1364,18,'教师排课','2015-04-01 23:29:27');

UNLOCK TABLES;

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

LOCK TABLES `sys_menu` WRITE;

insert  into `sys_menu`(`id`,`name`,`url`,`level`,`parentid`,`iseff`,`isleaf`,`des`,`createtime`,`last_update`,`icon`,`sort`) values (1,'系统设置',NULL,'1',0,'0','0',NULL,'2012-08-10 20:58:37','2012-04-15 00:17:59',NULL,0),(2,'学生管理','','1',0,'0','0','','2012-03-19 20:52:03','2012-02-25 12:35:48','',2),(4,'登陆','/frame/main/main.jsp','1',0,'1','1',NULL,'2012-12-10 20:33:13','2012-11-28 23:26:15',NULL,NULL),(5,'静态参数','','2',1,'0','0','','2012-02-25 12:35:48','2012-02-25 12:35:48','',2),(6,'权限管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-04-15 14:26:15','2012-04-15 14:26:15',NULL,3),(10,'系统用户','/page/system/user/user.jsp','2',1,'0','1',NULL,'2012-03-19 21:35:10','2012-03-03 01:18:21',NULL,NULL),(12,'学生信息管理','/page/student/infomrg/infomrg.jsp','2',2,'0','1',NULL,'2012-03-26 23:01:44','2012-03-06 19:47:18',NULL,NULL),(15,'教师管理',NULL,'1',0,'0','0',NULL,'2012-07-23 22:17:48','2012-04-15 00:18:32',NULL,2),(16,'签单管理',NULL,'1',0,'0','0',NULL,'2012-06-16 00:31:44','2012-04-15 00:18:17',NULL,1),(17,'新签单登记','/page/contract/register/register.jsp','2',16,'0','1',NULL,'2012-06-16 00:31:44','2012-03-06 19:47:18',NULL,NULL),(18,'签单流程管理','/page/contract/mrg/info.jsp','2',16,'0','1',NULL,'2012-06-25 20:21:42','2012-03-06 19:47:18',NULL,NULL),(23,'学生沟通记录','/page/student/exchange/infomrg.jsp','2',2,'0','1',NULL,'2012-07-22 22:24:36','2012-03-06 19:47:18',NULL,NULL),(37,'角色管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-03-06 19:47:18','2012-03-06 19:47:18',NULL,NULL),(38,'菜单管理','/page/system/menu/menu.jsp','2',1,'0','1',NULL,'2012-03-06 19:47:18','2012-03-06 19:47:18',NULL,NULL),(39,'部门管理','/page/system/department/dep.jsp','2',1,'0','1',NULL,'2012-04-16 20:37:51','2012-04-16 20:37:51',NULL,4),(40,'test',NULL,'2',1,'0','0',NULL,'2012-11-25 19:08:05','2012-04-17 22:30:26',NULL,5),(41,'文件操作','/demo/file/form.jsp','3',40,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,0),(42,'学生信息登记','/page/student/register/register.jsp','3',2,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,NULL),(43,'签单信息查询','/page/contract/info/info.jsp','3',16,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,NULL),(44,'个人信息管理','','1',0,'0','0',NULL,'2012-07-11 20:00:56','2012-04-17 22:31:12',NULL,NULL),(45,'未处理任务','/page/personal/task/info.jsp','2',44,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,NULL),(46,'已处理任务','/page/personal/taskhis/info.jsp','2',44,'0','1',NULL,'2012-07-11 20:01:21','2012-04-17 22:31:12',NULL,NULL),(47,'学生信息交流','/page/personal/exchange/info.jsp','2',44,'0','1',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(48,'教师信息管理','/page/teacher/info/info.jsp','2',15,'0','1',NULL,'2012-08-02 20:40:49','2012-07-11 20:01:21',NULL,NULL),(51,'统计查询',NULL,'1',0,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(52,'签单统计',NULL,'2',51,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(53,'签单日统计','/jasperreports/query/OrderCountDaily.jsp','3',52,'0','1',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(54,'消息管理',NULL,'1',0,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(55,'全部消息历史','/page/notice/allhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-07-11 20:01:21',NULL,NULL),(56,'发送消息','/page/notice/edit/edit.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-12 22:41:53',NULL,NULL),(57,'已发消息','/page/notice/personalhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-12 22:41:53',NULL,NULL),(58,'收件箱','/page/notice/personalhis/noreadinfo.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:32:07',NULL,NULL),(59,'市场管理',NULL,'1',0,'0','0',NULL,'2012-08-16 23:45:07','2012-08-16 23:32:07',NULL,NULL),(60,'客户管理','/page/market/customer/info/info.jsp','2',59,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:45:07',NULL,NULL),(61,'来电交流管理','/page/market/customer/exchange/info.jsp','2',59,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:45:07',NULL,NULL),(62,'课程管理',NULL,'1',0,'0','0',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(63,'课程分数管理','/page/course/score/info.jsp','2',62,'0','1',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(64,'课程评价管理','/page/course/evaluation/info.jsp','2',62,'0','1',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(65,'课时管理','/page/course/hour/info.jsp','2',62,'0','1',NULL,'2012-09-12 22:02:37','2012-08-16 23:45:07',NULL,NULL),(66,'授课老师关联学生','/page/teacher/refstudent/info.jsp','2',15,'0','1',NULL,'2012-12-06 22:23:00','2012-09-12 22:02:37',NULL,NULL),(67,'续单管理','/page/contract/last/info.jsp','2',16,'0','1',NULL,'2012-10-25 22:00:34','2012-09-12 22:02:37',NULL,NULL),(68,'我的学生','/page/teacher/refstudent/info.jsp?isLoginOper=true','2',15,'0','1',NULL,'2012-10-25 22:00:34','2012-10-25 22:00:34',NULL,NULL),(69,'教师信息查询','/page/teacher/info/info.jsp?isOnlyQuery=true','2',15,'0','1',NULL,'2012-11-12 22:31:59','2012-10-25 22:00:34',NULL,NULL),(70,'角色树','/page/system/role/roletree.jsp','2',40,'0','1',NULL,'2012-11-12 22:31:59','2012-11-12 22:31:59',NULL,NULL),(71,'签单月统计','/jasperreports/query/OrderCountMonthly.jsp','3',52,'0','1',NULL,'2012-11-28 23:28:26','2012-11-12 22:31:59',NULL,NULL),(72,'饼图','/demo/chart/chart.jsp','3',40,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(73,'来电交流查询','/page/market/customer/exchange/info.jsp?isOnlyQuery=true','2',59,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(74,'系统访问日志','/page/system/trace/trace.jsp','2',1,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(75,'学生信息查询','/page/student/infomrg/infomrg.jsp?isOnlyQuery=true','2',2,'0','1',NULL,'2012-12-10 22:34:48','2012-11-28 23:26:15',NULL,NULL),(76,'区域管理','/page/system/area/area.jsp','2',1,'0','1',NULL,'2012-12-10 22:34:48','2012-12-10 22:34:48',NULL,NULL),(77,'教师排课','/page/teacher/course/info.jsp','2',15,'0','1',NULL,'2012-12-10 22:34:48','2012-12-10 22:34:48',NULL,NULL);

UNLOCK TABLES;

/*Table structure for table `sys_param` */

DROP TABLE IF EXISTS `sys_param`;

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

/*Data for the table `sys_param` */

LOCK TABLES `sys_param` WRITE;

insert  into `sys_param`(`param_code`,`param_name`,`param_value`,`root_code`,`des`,`seq`,`iseff`,`create_time`,`last_update`) values ('','',NULL,NULL,NULL,NULL,'0','2015-04-11 17:20:51','0000-00-00 00:00:00'),('ACCEPT','确认','0','TASK_OPER',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('APPLY_STATUS','审批结果',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_A','初期辅导方案','1','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_B','华实模拟协议','2','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_C','全方位测评报告','3','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_D','教学安排表','4','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_F','教学方案','5','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CONTRACT_STATUS','签单状态',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_DILI','地理','9','ORDER_COURSE',NULL,'9','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_HUAXUE','化学','5','ORDER_COURSE',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_LISHI','历史','8','ORDER_COURSE',NULL,'8','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_SHENGWU','生物','7','ORDER_COURSE',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_SHUXUE','数学','2','ORDER_COURSE',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_WULI','物理','4','ORDER_COURSE',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_YINGWEN','英文','3','ORDER_COURSE',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_YUWEN','语文','1','ORDER_COURSE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_ZHENGZHI','政治','6','ORDER_COURSE',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS','客户当前状态',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS_A','去电','0','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS_B','未上门','1','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS_C','已上门','2','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('EDUADMIN_CONFIRM','教务部审批','5','CONTRACT_STATUS',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('EDUADMIN_DISPATCH','教务部分配班主任','2','CONTRACT_STATUS',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('EFFECTIVE','有效','0','ISEFF',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('FRIDAY','星期五','5','WEEK',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('GRADE','年级',NULL,NULL,NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_FIVE','高中二年级','11','GRADE',NULL,'11','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_FOUR','高中一年级','10','GRADE',NULL,'10','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_ONE','初中一年级','7','GRADE',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_SIX','高中三年级','12','GRADE',NULL,'12','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_THREE','初中三年级','9','GRADE',NULL,'9','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_TWO','初中二年级','8','GRADE',NULL,'8','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('INEFFECTIVE','无效','1','ISEFF',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ISEFF','是否有效',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_FIVE',' 小学五年级','5','GRADE',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_FOUR',' 小学四年级','4','GRADE',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_ONE',' 小学一年级','1','GRADE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_SIX',' 小学六年级','6','GRADE',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_THREE',' 小学三年级','3','GRADE',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_TWO',' 小学二年级','2','GRADE',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('LAERNING','授课中','7','CONTRACT_STATUS',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MAINTEACHER_CONFIRM','待班主任确认','3','CONTRACT_STATUS',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MAINTEACHER_HANDLE','班主任处理中','4','CONTRACT_STATUS',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MAN','男','0','SEXTYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MARKETEXECUTIVE_HANDLE','销售主管审批','1','CONTRACT_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MONDAY','星期一','1','WEEK',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NEW','新签单','0','CONTRACT_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NO','否','0','YESORNO',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTICER_DEPARTMENT','部门','2','NOTICER_TYPE',NULL,'2','0','2012-08-12 22:28:19','2012-08-12 22:28:19'),('NOTICER_PERSONAL','个人','0','NOTICER_TYPE',NULL,'0','0','2012-08-12 22:28:19','2012-08-12 22:28:19'),('NOTICER_TYPE','消息者类型',NULL,NULL,NULL,NULL,'0','2012-08-12 22:28:19','0000-00-00 00:00:00'),('NOTICE_NOREAD','未读','0','NOTICE_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTICE_READ','已读','1','NOTICE_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTICE_STATUS','公告状态',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTPASS','不通过','2','APPLY_STATUS',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_COURSE','签单课程',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_A','审批中','0','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_B','未开始','1','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_C','授课中','2','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_D','结束','3','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('OVER','结束','8','CONTRACT_STATUS',NULL,'8','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('PASS','通过','1','APPLY_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('POSITION','职位',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('REJECT','拒绝','1','TASK_OPER',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE','户口类型',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE_A','非农业户口','0','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE_B','农业户口','1','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE_C','居民户口','2','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SATURDAY','星期六','6','WEEK',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SCHEDULE_DETAIL_FINISH','结束','1','SCHEDULE_DETAIL_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SCHEDULE_DETAIL_NOTFINISH','没结束','0','SCHEDULE_DETAIL_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SCHEDULE_END','结束','2','SCHEDULE_STATUS',NULL,'2','0','2015-04-11 17:21:37','2012-03-13 20:50:21'),('SCHEDULE_NOTBEGIN','未开始','0','SCHEDULE_STATUS',NULL,'0','0','2015-04-11 17:23:40','2015-04-11 17:23:40'),('SCHEDULE_RUNNING','开始中','1','SCHEDULE_STATUS',NULL,'1','0','2015-04-11 17:21:29','2012-03-13 20:50:21'),('SELLER','销售','0','POSITION',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SEXTYPE','性别',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('STUDENT_TYPE','学生类型',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('STUDENT_TYPE_A','普通借读生','0','STUDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('STUDENT_TYPE_B','正式生','1','STUDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SUNDAY','星期日','7','WEEK',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('TEACHER','教师','1','POSITION',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('TEACHER_CONFIRM','待授课老师确认','6','CONTRACT_STATUS',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('THURSDAY','星期四','4','WEEK',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('TUESDAY','星期二','2','WEEK',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE','访问来源',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE_A','来电','0','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE_B','短信','1','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE_C','老资料回访','2','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('WAIT','待审批','0','APPLY_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('WEBNESDAY','星期三','3','WEEK',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('WOMAN','女','1','SEXTYPE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('YES','是','1','YESORNO',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('YESORNO','是与否',NULL,NULL,NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21');

UNLOCK TABLES;

/*Table structure for table `sys_right_rel` */

DROP TABLE IF EXISTS `sys_right_rel`;

CREATE TABLE `sys_right_rel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL COMMENT '关系类型 0:用户 1：角色 2：部门 ',
  `rel_id` varchar(250) DEFAULT NULL COMMENT '关联对象',
  `target_id` int(10) unsigned DEFAULT NULL COMMENT '对象ID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rel_right` int(1) NOT NULL DEFAULT '0' COMMENT '关系类型 0:菜单 1：区域',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1149 DEFAULT CHARSET=utf8 COMMENT='权限菜单关联';

/*Data for the table `sys_right_rel` */

LOCK TABLES `sys_right_rel` WRITE;

insert  into `sys_right_rel`(`id`,`type`,`rel_id`,`target_id`,`create_time`,`last_update`,`rel_right`) values (20,'0','17',40,'2012-08-14 21:46:12','2012-08-14 21:46:12',0),(21,'0','17',41,'2012-08-14 21:46:12','2012-08-14 21:46:12',0),(166,'1','4',2,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(167,'1','4',12,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(168,'1','4',23,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(169,'1','4',15,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(170,'1','4',48,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(171,'1','4',16,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(172,'1','4',43,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(173,'1','4',44,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(174,'1','4',45,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(175,'1','4',46,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(176,'1','4',47,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(177,'1','4',51,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(178,'1','4',52,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(179,'1','4',53,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(180,'1','4',54,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(181,'1','4',56,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(182,'1','4',57,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(183,'1','4',58,'2012-08-16 23:46:35','2012-08-16 23:46:35',0),(262,'1','2',2,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(263,'1','2',12,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(264,'1','2',23,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(265,'1','2',42,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(266,'1','2',15,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(267,'1','2',48,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(268,'1','2',16,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(269,'1','2',17,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(270,'1','2',43,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(271,'1','2',44,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(272,'1','2',45,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(273,'1','2',46,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(274,'1','2',47,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(275,'1','2',54,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(276,'1','2',56,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(277,'1','2',57,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(278,'1','2',58,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(279,'1','3',2,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(280,'1','3',12,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(281,'1','3',23,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(282,'1','3',15,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(283,'1','3',48,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(284,'1','3',16,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(285,'1','3',43,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(286,'1','3',44,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(287,'1','3',45,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(288,'1','3',46,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(289,'1','3',47,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(290,'1','3',51,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(291,'1','3',52,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(292,'1','3',53,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(293,'1','3',54,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(294,'1','3',56,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(295,'1','3',57,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(296,'1','3',58,'2012-08-18 20:17:36','2012-08-18 20:17:36',0),(406,'1','5',2,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(407,'1','5',12,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(408,'1','5',23,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(409,'1','5',42,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(410,'1','5',15,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(411,'1','5',48,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(412,'1','5',16,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(413,'1','5',43,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(414,'1','5',44,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(415,'1','5',45,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(416,'1','5',46,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(417,'1','5',47,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(418,'1','5',51,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(419,'1','5',52,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(420,'1','5',53,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(421,'1','5',54,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(422,'1','5',56,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(423,'1','5',57,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(424,'1','5',58,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(425,'1','5',62,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(426,'1','5',63,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(427,'1','5',64,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(428,'1','5',65,'2012-09-12 22:04:10','2012-09-12 22:04:10',0),(524,'1','6',2,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(525,'1','6',12,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(526,'1','6',23,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(527,'1','6',15,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(528,'1','6',68,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(529,'1','6',44,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(530,'1','6',45,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(531,'1','6',46,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(532,'1','6',47,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(533,'1','6',54,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(534,'1','6',56,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(535,'1','6',57,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(536,'1','6',58,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(537,'1','6',62,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(538,'1','6',63,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(539,'1','6',64,'2012-11-08 20:34:38','2012-11-08 20:34:38',0),(540,'1','5',2,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(541,'1','5',12,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(542,'1','5',23,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(543,'1','5',42,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(544,'1','5',15,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(545,'1','5',48,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(546,'1','5',68,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(547,'1','5',16,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(548,'1','5',43,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(549,'1','5',67,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(550,'1','5',44,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(551,'1','5',45,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(552,'1','5',46,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(553,'1','5',47,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(554,'1','5',51,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(555,'1','5',52,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(556,'1','5',53,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(557,'1','5',54,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(558,'1','5',56,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(559,'1','5',57,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(560,'1','5',58,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(561,'1','5',62,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(562,'1','5',63,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(563,'1','5',64,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(564,'1','5',65,'2012-11-11 00:34:17','2012-11-11 00:34:17',0),(565,'1','4',2,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(566,'1','4',12,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(567,'1','4',23,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(568,'1','4',15,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(569,'1','4',48,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(570,'1','4',68,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(571,'1','4',16,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(572,'1','4',43,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(573,'1','4',67,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(574,'1','4',44,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(575,'1','4',45,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(576,'1','4',46,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(577,'1','4',47,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(578,'1','4',51,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(579,'1','4',52,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(580,'1','4',53,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(581,'1','4',54,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(582,'1','4',56,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(583,'1','4',57,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(584,'1','4',58,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(585,'1','4',62,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(586,'1','4',63,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(587,'1','4',64,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(588,'1','4',65,'2012-11-11 00:34:42','2012-11-11 00:34:42',0),(589,'1','2',2,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(590,'1','2',12,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(591,'1','2',23,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(592,'1','2',42,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(593,'1','2',15,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(594,'1','2',48,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(595,'1','2',16,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(596,'1','2',17,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(597,'1','2',43,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(598,'1','2',44,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(599,'1','2',45,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(600,'1','2',46,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(601,'1','2',47,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(602,'1','2',54,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(603,'1','2',56,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(604,'1','2',57,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(605,'1','2',58,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(606,'1','2',59,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(607,'1','2',60,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(608,'1','2',61,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(609,'1','2',2,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(610,'1','2',12,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(611,'1','2',23,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(612,'1','2',42,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(613,'1','2',16,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(614,'1','2',17,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(615,'1','2',43,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(616,'1','2',44,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(617,'1','2',45,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(618,'1','2',46,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(619,'1','2',47,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(620,'1','2',54,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(621,'1','2',56,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(622,'1','2',57,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(623,'1','2',58,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(624,'1','2',59,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(625,'1','2',60,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(626,'1','2',61,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(669,'1','2',2,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(670,'1','2',12,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(671,'1','2',23,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(672,'1','2',42,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(673,'1','2',15,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(674,'1','2',66,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(675,'1','2',69,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(676,'1','2',16,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(677,'1','2',17,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(678,'1','2',43,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(679,'1','2',44,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(680,'1','2',45,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(681,'1','2',46,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(682,'1','2',47,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(683,'1','2',54,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(684,'1','2',56,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(685,'1','2',57,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(686,'1','2',58,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(687,'1','2',59,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(688,'1','2',60,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(689,'1','2',61,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(690,'1','2',2,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(691,'1','2',12,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(692,'1','2',23,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(693,'1','2',42,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(694,'1','2',15,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(695,'1','2',66,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(696,'1','2',68,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(697,'1','2',69,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(698,'1','2',16,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(699,'1','2',17,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(700,'1','2',43,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(701,'1','2',44,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(702,'1','2',45,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(703,'1','2',46,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(704,'1','2',47,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(705,'1','2',54,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(706,'1','2',56,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(707,'1','2',57,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(708,'1','2',58,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(709,'1','2',59,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(710,'1','2',60,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(711,'1','2',61,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(712,'1','2',2,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(713,'1','2',12,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(714,'1','2',23,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(715,'1','2',42,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(716,'1','2',15,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(717,'1','2',66,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(718,'1','2',69,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(719,'1','2',16,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(720,'1','2',17,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(721,'1','2',43,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(722,'1','2',44,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(723,'1','2',45,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(724,'1','2',46,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(725,'1','2',47,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(726,'1','2',54,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(727,'1','2',56,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(728,'1','2',57,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(729,'1','2',58,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(730,'1','2',59,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(731,'1','2',60,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(732,'1','2',61,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(733,'1','3',2,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(734,'1','3',12,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(735,'1','3',23,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(736,'1','3',15,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(737,'1','3',69,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(738,'1','3',16,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(739,'1','3',43,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(740,'1','3',44,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(741,'1','3',45,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(742,'1','3',46,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(743,'1','3',47,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(744,'1','3',51,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(745,'1','3',52,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(746,'1','3',53,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(747,'1','3',54,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(748,'1','3',56,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(749,'1','3',57,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(750,'1','3',58,'2012-11-12 22:48:07','2012-11-12 22:48:07',0),(751,'1','3',2,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(752,'1','3',12,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(753,'1','3',23,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(754,'1','3',15,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(755,'1','3',69,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(756,'1','3',16,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(757,'1','3',43,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(758,'1','3',44,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(759,'1','3',45,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(760,'1','3',46,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(761,'1','3',47,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(762,'1','3',51,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(763,'1','3',52,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(764,'1','3',53,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(765,'1','3',54,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(766,'1','3',56,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(767,'1','3',57,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(768,'1','3',58,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(769,'1','3',59,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(770,'1','3',60,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(771,'1','3',61,'2012-11-12 22:48:14','2012-11-12 22:48:14',0),(1097,'1','1',4,'2015-03-08 11:34:19','2015-03-08 11:34:19',1),(1098,'1','1',5,'2015-03-08 11:34:19','2015-03-08 11:34:19',1),(1099,'1','1',1,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1100,'1','1',5,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1101,'1','1',6,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1102,'1','1',10,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1103,'1','1',37,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1104,'1','1',38,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1105,'1','1',39,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1106,'1','1',40,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1107,'1','1',41,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1108,'1','1',70,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1109,'1','1',72,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1110,'1','1',74,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1111,'1','1',76,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1112,'1','1',2,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1113,'1','1',12,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1114,'1','1',23,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1115,'1','1',42,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1116,'1','1',75,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1117,'1','1',15,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1118,'1','1',48,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1119,'1','1',66,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1120,'1','1',68,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1121,'1','1',69,'2015-03-14 21:48:50','2015-03-14 21:48:50',0),(1122,'1','1',77,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1123,'1','1',16,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1124,'1','1',17,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1125,'1','1',18,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1126,'1','1',43,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1127,'1','1',67,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1128,'1','1',44,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1129,'1','1',45,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1130,'1','1',46,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1131,'1','1',47,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1132,'1','1',51,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1133,'1','1',52,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1134,'1','1',53,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1135,'1','1',71,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1136,'1','1',54,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1137,'1','1',55,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1138,'1','1',56,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1139,'1','1',57,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1140,'1','1',58,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1141,'1','1',59,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1142,'1','1',60,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1143,'1','1',61,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1144,'1','1',73,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1145,'1','1',62,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1146,'1','1',63,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1147,'1','1',64,'2015-03-14 21:48:51','2015-03-14 21:48:51',0),(1148,'1','1',65,'2015-03-14 21:48:51','2015-03-14 21:48:51',0);

UNLOCK TABLES;

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `iseff` char(1) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `sys_role` */

LOCK TABLES `sys_role` WRITE;

insert  into `sys_role`(`id`,`name`,`iseff`,`create_time`,`last_update`) values (1,'超级管理员','0','2012-04-10 22:35:50','2012-04-10 22:35:50'),(2,'销售','0','2012-04-24 22:06:08','2012-04-24 22:06:09'),(3,'销售主管','0','2012-06-20 00:03:32','2012-06-20 00:03:32'),(4,'教务部主管','0','2012-04-24 22:06:09','2012-04-24 22:06:09'),(5,'班主任','0','2012-04-24 22:06:09','2012-04-24 22:06:09'),(6,'授课老师','0','2012-04-24 22:06:09','2012-04-24 22:06:09');

UNLOCK TABLES;

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

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
  `area_id` int(11) NOT NULL COMMENT '区域id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

LOCK TABLES `sys_user` WRITE;

insert  into `sys_user`(`id`,`user_name`,`dep_id`,`password`,`sex`,`position`,`phone`,`addr`,`zipcode`,`iseff`,`create_time`,`last_update`,`role_id`,`email`,`area_id`) values (5,'销售主管一号',2,'1','0',NULL,'212112','111','55','0','2015-03-08 22:34:47','2012-08-16 22:41:18',3,NULL,4),(7,'销售主管二号',2,'1','1',NULL,'13826031714','guangzhou','33','0','2015-03-08 22:34:47','2012-08-16 22:41:26',3,NULL,4),(10,'销售一号',2,'1',NULL,NULL,'212112','111','1@ye.com','0','2015-03-08 22:34:47','2012-08-16 22:41:05',2,NULL,4),(13,'销售二号',2,'1','1',NULL,'1','1','1','0','2015-03-08 22:34:47','2012-08-16 22:39:24',2,NULL,4),(14,'教务部主管一号',1,'1','1',NULL,'1','1','31','0','2015-03-08 22:34:47','2015-04-06 10:21:05',4,NULL,4),(15,'教务部主管二号',1,'1','0',NULL,'1','1','5135','0','2015-03-08 22:34:47','2012-08-16 22:40:54',4,NULL,4),(16,'班主任一号',1,'1','0',NULL,'11','11','11','0','2015-03-08 22:34:47','2012-08-16 22:40:23',5,NULL,4),(17,'班主任二号',1,'1','1',NULL,'1','11','1','0','2015-03-08 22:34:47','2012-08-16 22:42:09',5,NULL,4),(18,'国产007',1,'1','0',NULL,'22','111','22','0','2015-03-08 21:09:12','2015-03-08 22:33:47',1,NULL,4),(19,'王老师(授课)',1,'111111','0',NULL,'1','1','1','0','2015-03-08 22:34:47','2015-03-08 20:46:56',6,'1',4),(20,'谢老师（授课）',1,'111111','1',NULL,'1','111','1','0','2015-03-08 22:34:47','2015-03-08 20:50:52',6,'1',4),(21,'林老师（授课）',1,'111111','0',NULL,'1','1','1','0','2015-03-08 22:34:47','2015-03-08 20:51:01',6,'1',4),(22,'陈老师（授课）',1,'111111','0',NULL,'138','111','2@163.com','0','2015-03-08 22:34:47','2012-10-22 22:44:46',6,'2@163.com',4),(23,'Kelly',1,'111111','1',NULL,'1','1','1','0','2015-03-08 22:34:47','2012-11-22 20:31:20',6,'1',4);

UNLOCK TABLES;

/*Table structure for table `teacher_ability` */

DROP TABLE IF EXISTS `teacher_ability`;

CREATE TABLE `teacher_ability` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(50) NOT NULL,
  `course_type` varchar(50) NOT NULL COMMENT '课程类型 对应system_param的order_course',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grade_type` varchar(45) NOT NULL DEFAULT '' COMMENT '可教学的年级',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `teacher_ability` */

LOCK TABLES `teacher_ability` WRITE;

insert  into `teacher_ability`(`id`,`user_id`,`course_type`,`create_time`,`grade_type`) values (4,19,'2,3','2012-08-16 22:45:00','2,3'),(5,20,'1,5','2012-08-16 22:47:40','2'),(6,21,'1,5','2012-08-16 22:48:03','9,2,6'),(7,22,'2,6,7','2012-10-22 22:44:46','1,5,6,10'),(8,23,'1,2,3','2012-11-11 00:18:05','1,5'),(9,24,'1,5','2012-11-11 00:21:58','1'),(10,25,'1,5','2012-11-11 00:23:57','1,5');

UNLOCK TABLES;

/*Table structure for table `course_schedule_view` */

DROP TABLE IF EXISTS `course_schedule_view`;

/*!50001 DROP VIEW IF EXISTS `course_schedule_view` */;
/*!50001 DROP TABLE IF EXISTS `course_schedule_view` */;

/*!50001 CREATE TABLE  `course_schedule_view`(
 `id` int(10) ,
 `teacher_id` int(10) unsigned ,
 `student_id` int(10) unsigned ,
 `course_type` char(2) ,
 `date` date ,
 `start_time` int(4) ,
 `end_time` int(4) ,
 `iseff` char(1) ,
 `create_time` timestamp ,
 `last_update` timestamp ,
 `course_name` varchar(50) ,
 `student_name` varchar(50) ,
 `teacher_name` varchar(50) ,
 `is_finish` int(1) 
)*/;

/*Table structure for table `customer_exchange_view` */

DROP TABLE IF EXISTS `customer_exchange_view`;

/*!50001 DROP VIEW IF EXISTS `customer_exchange_view` */;
/*!50001 DROP TABLE IF EXISTS `customer_exchange_view` */;

/*!50001 CREATE TABLE  `customer_exchange_view`(
 `id` int(10) ,
 `customer_id` int(10) ,
 `cust_status` char(1) ,
 `source_type` char(1) ,
 `is_book` char(1) ,
 `user_id` int(10) ,
 `content` varchar(1000) ,
 `customer_attach_id` varchar(1000) ,
 `create_time` timestamp ,
 `last_update` timestamp ,
 `book_time` timestamp ,
 `name` varchar(50) ,
 `sex` char(1) ,
 `school` varchar(200) ,
 `classes` varchar(50) ,
 `brithday` varchar(10) ,
 `age` varchar(3) ,
 `student_type` varchar(1) ,
 `resident_type` varchar(1) ,
 `parent_name` varchar(20) ,
 `phone` varchar(50) ,
 `addr` varchar(200) 
)*/;

/*Table structure for table `order_info_daily` */

DROP TABLE IF EXISTS `order_info_daily`;

/*!50001 DROP VIEW IF EXISTS `order_info_daily` */;
/*!50001 DROP TABLE IF EXISTS `order_info_daily` */;

/*!50001 CREATE TABLE  `order_info_daily`(
 `create_date` varchar(10) ,
 `total` bigint(21) 
)*/;

/*Table structure for table `order_info_monthly` */

DROP TABLE IF EXISTS `order_info_monthly`;

/*!50001 DROP VIEW IF EXISTS `order_info_monthly` */;
/*!50001 DROP TABLE IF EXISTS `order_info_monthly` */;

/*!50001 CREATE TABLE  `order_info_monthly`(
 `month` varchar(7) ,
 `total` bigint(21) 
)*/;

/*Table structure for table `teacher_info` */

DROP TABLE IF EXISTS `teacher_info`;

/*!50001 DROP VIEW IF EXISTS `teacher_info` */;
/*!50001 DROP TABLE IF EXISTS `teacher_info` */;

/*!50001 CREATE TABLE  `teacher_info`(
 `id` int(10) ,
 `user_name` varchar(50) ,
 `dep_id` int(10) unsigned ,
 `area_id` int(11) ,
 `password` varchar(50) ,
 `sex` char(1) ,
 `position` varchar(10) ,
 `phone` varchar(100) ,
 `addr` varchar(200) ,
 `zipcode` varchar(10) ,
 `iseff` char(1) ,
 `create_time` timestamp ,
 `last_update` timestamp ,
 `role_id` int(10) unsigned ,
 `email` varchar(100) ,
 `course_type` varchar(50) ,
 `grade_type` varchar(45) 
)*/;

/*Table structure for table `teacher_ref_student` */

DROP TABLE IF EXISTS `teacher_ref_student`;

/*!50001 DROP VIEW IF EXISTS `teacher_ref_student` */;
/*!50001 DROP TABLE IF EXISTS `teacher_ref_student` */;

/*!50001 CREATE TABLE  `teacher_ref_student`(
 `id` bigint(10) unsigned ,
 `teacher_id` int(10) unsigned ,
 `student_id` int(10) unsigned ,
 `course_type` char(2) ,
 `run_status` char(1) ,
 `name` varchar(50) ,
 `grade` varchar(10) ,
 `sex` char(1) ,
 `age` varchar(3) 
)*/;

/*View structure for view course_schedule_view */

/*!50001 DROP TABLE IF EXISTS `course_schedule_view` */;
/*!50001 DROP VIEW IF EXISTS `course_schedule_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `course_schedule_view` AS select `c`.`id` AS `id`,`c`.`teacher_id` AS `teacher_id`,`c`.`student_id` AS `student_id`,`c`.`course_type` AS `course_type`,`c`.`date` AS `date`,`c`.`start_time` AS `start_time`,`c`.`end_time` AS `end_time`,`c`.`iseff` AS `iseff`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`p`.`param_name` AS `course_name`,`s`.`name` AS `student_name`,`t`.`user_name` AS `teacher_name`,`c`.`is_finish` AS `is_finish` from (((`course_schedule_detail` `c` join `sys_param` `p`) join `student_info` `s`) join `teacher_info` `t`) where ((`p`.`root_code` = 'ORDER_COURSE') and (`p`.`param_value` = `c`.`course_type`) and (`s`.`id` = `c`.`student_id`) and (`t`.`id` = `c`.`teacher_id`)) */;

/*View structure for view customer_exchange_view */

/*!50001 DROP TABLE IF EXISTS `customer_exchange_view` */;
/*!50001 DROP VIEW IF EXISTS `customer_exchange_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_exchange_view` AS select `c`.`id` AS `id`,`c`.`customer_id` AS `customer_id`,`c`.`cust_status` AS `cust_status`,`c`.`source_type` AS `source_type`,`c`.`is_book` AS `is_book`,`c`.`user_id` AS `user_id`,`c`.`content` AS `content`,`c`.`customer_attach_id` AS `customer_attach_id`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`c`.`book_time` AS `book_time`,`i`.`name` AS `name`,`i`.`sex` AS `sex`,`i`.`school` AS `school`,`i`.`classes` AS `classes`,`i`.`brithday` AS `brithday`,`i`.`age` AS `age`,`i`.`student_type` AS `student_type`,`i`.`resident_type` AS `resident_type`,`i`.`parent_name` AS `parent_name`,`i`.`phone` AS `phone`,`i`.`addr` AS `addr` from (`customer_exchange` `c` left join `customer_info` `i` on((`c`.`customer_id` = `i`.`id`))) */;

/*View structure for view order_info_daily */

/*!50001 DROP TABLE IF EXISTS `order_info_daily` */;
/*!50001 DROP VIEW IF EXISTS `order_info_daily` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_info_daily` AS select date_format(`order_info`.`create_time`,'%Y-%m-%d') AS `create_date`,count(0) AS `total` from `order_info` group by date_format(`order_info`.`create_time`,'%Y-%m-%d') */;

/*View structure for view order_info_monthly */

/*!50001 DROP TABLE IF EXISTS `order_info_monthly` */;
/*!50001 DROP VIEW IF EXISTS `order_info_monthly` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_info_monthly` AS select date_format(`order_info`.`create_time`,'%Y-%m') AS `month`,count(0) AS `total` from `order_info` group by date_format(`order_info`.`create_time`,'%Y-%m') */;

/*View structure for view teacher_info */

/*!50001 DROP TABLE IF EXISTS `teacher_info` */;
/*!50001 DROP VIEW IF EXISTS `teacher_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_info` AS select `a`.`id` AS `id`,`a`.`user_name` AS `user_name`,`a`.`dep_id` AS `dep_id`,`a`.`area_id` AS `area_id`,`a`.`password` AS `password`,`a`.`sex` AS `sex`,`a`.`position` AS `position`,`a`.`phone` AS `phone`,`a`.`addr` AS `addr`,`a`.`zipcode` AS `zipcode`,`a`.`iseff` AS `iseff`,`a`.`create_time` AS `create_time`,`a`.`last_update` AS `last_update`,`a`.`role_id` AS `role_id`,`a`.`email` AS `email`,`b`.`course_type` AS `course_type`,`b`.`grade_type` AS `grade_type` from (`sys_user` `a` join `teacher_ability` `b`) where (`a`.`id` = `b`.`user_id`) */;

/*View structure for view teacher_ref_student */

/*!50001 DROP TABLE IF EXISTS `teacher_ref_student` */;
/*!50001 DROP VIEW IF EXISTS `teacher_ref_student` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_ref_student` AS select crc32(concat(`c`.`charger_id`,`i`.`student_id`,`c`.`course_type`)) AS `id`,`c`.`charger_id` AS `teacher_id`,`i`.`student_id` AS `student_id`,`c`.`course_type` AS `course_type`,`i`.`run_status` AS `run_status`,`s`.`name` AS `name`,`s`.`grade` AS `grade`,`s`.`sex` AS `sex`,`s`.`age` AS `age` from ((`order_course` `c` left join `order_info` `i` on((`i`.`id` = `c`.`order_id`))) left join `student_info` `s` on((`i`.`student_id` = `s`.`id`))) where ((`c`.`charger_id` is not null) and (`i`.`student_id` is not null)) group by `c`.`charger_id`,`i`.`student_id`,`c`.`course_type` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
