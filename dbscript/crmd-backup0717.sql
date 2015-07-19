/*
SQLyog Professional v10.42 
MySQL - 5.1.30-community : Database - crmdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='排课时间设置';

/*Data for the table `course_period` */

insert  into `course_period`(`id`,`start_time`,`end_time`,`create_time`) values (1,800,1000,'2015-03-15 10:36:45'),(2,1000,1200,'2015-03-15 10:36:45'),(3,1300,1500,'2015-03-15 10:36:45'),(4,1500,1700,'2015-03-15 10:36:45'),(5,1700,1900,'2015-03-15 10:36:45'),(6,1900,2100,'2015-03-15 10:36:45');

/*Table structure for table `course_schedule` */

DROP TABLE IF EXISTS `course_schedule`;

CREATE TABLE `course_schedule` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `course_type` char(2) NOT NULL COMMENT '课程类型',
  `total_course_hour` int(10) unsigned DEFAULT NULL COMMENT '课时总数',
  `total_cost_hour` int(10) unsigned DEFAULT NULL COMMENT '课时消耗总数',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  `week_days` varchar(50) NOT NULL COMMENT '排课日',
  `start_time` int(4) NOT NULL COMMENT '课程开始时间段',
  `end_time` int(4) NOT NULL COMMENT '课程开始时间段',
  `status` char(1) NOT NULL COMMENT '0:未开始 1:开始中 2:结束',
  `iseff` char(1) DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='排课计划';

/*Data for the table `course_schedule` */

insert  into `course_schedule`(`id`,`teacher_id`,`student_id`,`course_type`,`total_course_hour`,`total_cost_hour`,`start_date`,`end_date`,`week_days`,`start_time`,`end_time`,`status`,`iseff`,`create_time`,`last_update`) values (20,29,1,'2',50,NULL,'2015-07-16','2015-09-14','2,3,4',1000,1200,'0','0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(21,31,1,'1',50,2,'2015-07-16','2015-10-09','2,6',800,1000,'1','0','2015-07-16 22:53:35','2015-07-17 11:24:02');

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
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8 COMMENT='排课明细';

/*Data for the table `course_schedule_detail` */

insert  into `course_schedule_detail`(`id`,`teacher_id`,`student_id`,`course_type`,`order_id`,`order_course_id`,`schedule_id`,`date`,`is_finish`,`start_time`,`end_time`,`iseff`,`create_time`,`last_update`) values (316,29,1,'2',10,23,20,'2015-07-20',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(317,29,1,'2',10,23,20,'2015-07-21',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(318,29,1,'2',10,23,20,'2015-07-22',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(319,29,1,'2',10,23,20,'2015-07-27',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(320,29,1,'2',10,23,20,'2015-07-28',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(321,29,1,'2',10,23,20,'2015-07-29',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(322,29,1,'2',10,23,20,'2015-08-03',0,1000,1200,'0','2015-07-16 22:48:59','2015-07-16 22:48:59'),(323,29,1,'2',10,23,20,'2015-08-04',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(324,29,1,'2',10,23,20,'2015-08-05',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(325,29,1,'2',10,23,20,'2015-08-10',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(326,29,1,'2',10,23,20,'2015-08-11',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(327,29,1,'2',10,23,20,'2015-08-12',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(328,29,1,'2',10,23,20,'2015-08-17',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(329,29,1,'2',10,23,20,'2015-08-18',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(330,29,1,'2',10,23,20,'2015-08-19',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(331,29,1,'2',10,23,20,'2015-08-24',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(332,29,1,'2',10,23,20,'2015-08-25',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(333,29,1,'2',10,23,20,'2015-08-26',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(334,29,1,'2',10,23,20,'2015-08-31',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(335,29,1,'2',10,23,20,'2015-09-01',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(336,29,1,'2',10,23,20,'2015-09-02',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(337,29,1,'2',10,23,20,'2015-09-07',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(338,29,1,'2',10,23,20,'2015-09-08',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(339,29,1,'2',10,23,20,'2015-09-09',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(340,29,1,'2',10,23,20,'2015-09-14',0,1000,1200,'0','2015-07-16 22:49:00','2015-07-16 22:49:00'),(341,31,1,'1',10,24,21,'2015-07-17',1,800,1000,'0','2015-07-16 22:53:35','2015-07-17 11:24:02'),(342,31,1,'1',10,24,21,'2015-07-20',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(343,31,1,'1',10,24,21,'2015-07-24',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(344,31,1,'1',10,24,21,'2015-07-27',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(345,31,1,'1',10,24,21,'2015-07-31',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(346,31,1,'1',10,24,21,'2015-08-03',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(347,31,1,'1',10,24,21,'2015-08-07',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(348,31,1,'1',10,24,21,'2015-08-10',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(349,31,1,'1',10,24,21,'2015-08-14',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(350,31,1,'1',10,24,21,'2015-08-17',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(351,31,1,'1',10,24,21,'2015-08-21',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(352,31,1,'1',10,24,21,'2015-08-24',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(353,31,1,'1',10,24,21,'2015-08-28',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(354,31,1,'1',10,24,21,'2015-08-31',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(355,31,1,'1',10,24,21,'2015-09-04',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(356,31,1,'1',10,24,21,'2015-09-07',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(357,31,1,'1',10,24,21,'2015-09-11',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(358,31,1,'1',10,24,21,'2015-09-14',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(359,31,1,'1',10,24,21,'2015-09-18',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(360,31,1,'1',10,24,21,'2015-09-21',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(361,31,1,'1',10,24,21,'2015-09-25',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(362,31,1,'1',10,24,21,'2015-09-28',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(363,31,1,'1',10,24,21,'2015-10-02',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(364,31,1,'1',10,24,21,'2015-10-05',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35'),(365,31,1,'1',10,24,21,'2015-10-09',0,800,1000,'0','2015-07-16 22:53:35','2015-07-16 22:53:35');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='回访客户交流表';

/*Data for the table `customer_exchange` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户信息表';

/*Data for the table `customer_info` */

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

insert  into `flow_task`(`id`,`process_name`,`task_name`,`assign_type`,`assigner`,`create_time`,`last_update`,`busi_page_name`,`type`) values (1,'orderProcess','签约','1','1','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/saler_confirm.jsp','0'),(2,'orderProcess','销售主管审批','1','2','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/market_confirm.jsp','1'),(3,'orderProcess','教务部处理','1','3','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/eduadmin_dispatch.jsp','1'),(4,'orderProcess2','待班主任确认','1','4','2015-04-06 22:31:47','2012-04-29 11:25:19','/page/contract/follow/mainteacher_confirm.jsp','1'),(5,'orderProcess','班主任处理中','1','4','2015-04-06 22:31:52','2012-04-29 11:25:19','/page/contract/follow/mainteacher_handle.jsp','1'),(6,'orderProcess','教务部审批','1','3','2012-10-22 20:22:17','2012-04-29 11:25:19','/page/contract/follow/eduadmin_confirm.jsp','1'),(7,'orderProcess','审批通过','','','2012-11-14 21:00:31','2012-04-29 11:25:19','/page/contract/follow/order_detail.jsp','2'),(8,'orderProcess','结束',NULL,NULL,'2012-10-30 21:02:16','2012-04-29 11:25:19',NULL,''),(9,'orderLastProcess','续签','1','3','2012-11-27 22:19:05','2012-07-08 09:46:02','/page/contract/last/last.jsp','0'),(10,'orderLastProcess','审批通过',NULL,'','2012-11-27 22:19:05','2012-10-29 22:01:35',NULL,'2'),(11,'orderLastProcess','结束',NULL,NULL,'2012-10-29 22:01:35','2012-10-29 22:01:35',NULL,'');

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

insert  into `flow_task_transition`(`id`,`task_id`,`name`,`to`,`create_time`,`last_update`,`need_arrange`,`to_id`) values (1,1,'待审批','销售主管审批','2012-04-17 20:40:59','2012-12-01 00:00:00','1',2),(2,2,'通过','教务部处理','2012-04-17 20:40:59','2012-12-01 00:00:00','1',3),(3,2,'不通过','签约','2012-04-17 20:40:59','2012-12-01 00:00:00','0',1),(4,3,'分配任务','班主任处理中','2012-04-17 20:40:59','2012-12-01 00:00:00','1',5),(5,5,'确认','教务部审批','2012-04-17 20:40:59','2012-12-01 00:00:00','1',6),(6,5,'拒绝','教务部处理','2012-04-17 20:40:59','2012-12-01 00:00:00','0',3),(8,6,'通过','审批通过','2012-04-17 20:40:59','2012-12-01 00:00:00','0',7),(9,6,'不通过','班主任处理中','2012-04-17 20:40:59','2012-12-01 00:00:00','0',5),(10,7,'判断授课时间','结束','2012-04-17 20:40:59','2012-04-17 20:40:59','2',0),(11,9,'继单','审批通过','2012-04-17 20:40:59','2012-04-17 20:40:59','0',10),(12,10,'判断授课时间','结束','2012-04-17 20:40:59','2012-04-17 20:40:59','0',0);

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

/*Table structure for table `jbpm4_property` */

DROP TABLE IF EXISTS `jbpm4_property`;

CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `jbpm4_property` */

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='公告表';

/*Data for the table `notice` */

insert  into `notice`(`id`,`sender_id`,`receiver_id`,`status`,`content`,`create_time`,`last_update`) values (30,18,7,'0','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:33:02','2015-07-16 22:33:02'),(31,7,15,'0','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:40:39','2015-07-16 22:40:39'),(32,15,16,'0','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:42:25','2015-07-16 22:42:25'),(33,16,15,'0','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:45:10','2015-07-16 22:45:10');

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='公告表历史表';

/*Data for the table `notice_his` */

insert  into `notice_his`(`id`,`sender_id`,`receiver_type`,`receiver_id`,`content`,`create_time`,`last_update`) values (30,18,'0','7','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:33:02','2015-07-16 22:33:02'),(31,7,'0','15','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:40:39','2015-07-16 22:40:39'),(32,15,'0','16','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:42:25','2015-07-16 22:42:25'),(33,16,'0','15','你有1条新的未办签单信息，请查看签单编号【no121】','2015-07-16 22:45:10','2015-07-16 22:45:10');

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='签单课程信息';

/*Data for the table `order_course` */

insert  into `order_course`(`id`,`order_id`,`course_type`,`charger_id`,`status`,`order_attach_id`,`hour`,`cost_hour`,`schedule_hour`,`create_time`,`last_update`) values (23,10,'2',29,'1',0,50,0,50,'2015-07-16 22:33:01','2015-07-16 22:49:00'),(24,10,'1',31,'1',0,50,2,50,'2015-07-16 22:33:01','2015-07-17 11:24:02');

/*Table structure for table `order_course_evaluation` */

DROP TABLE IF EXISTS `order_course_evaluation`;

CREATE TABLE `order_course_evaluation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
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
  `reason` varchar(255) DEFAULT NULL COMMENT '撤销理由',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='课时消耗记录';

/*Data for the table `order_course_hour_log` */

insert  into `order_course_hour_log`(`id`,`order_id`,`order_course_id`,`schedule_id`,`schedule_detail_id`,`course_type`,`student_id`,`teacher_id`,`teach_time`,`cost_hour`,`status`,`create_time`,`last_update`,`operator`,`reason`) values (93,10,24,21,341,'1',1,31,'2015-07-17',2,'0','2015-07-17 11:24:02','2015-07-17 11:24:02',NULL,NULL);

/*Table structure for table `order_course_score` */

DROP TABLE IF EXISTS `order_course_score`;

CREATE TABLE `order_course_score` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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

/*Table structure for table `order_exchange` */

DROP TABLE IF EXISTS `order_exchange`;

CREATE TABLE `order_exchange` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` text NOT NULL COMMENT '交流内容',
  `order_attach_id` int(11) DEFAULT NULL COMMENT '交流录音记录',
  `create_time` datetime NOT NULL,
  `last_update` datetime NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_exchange` */

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
  `adjust_hour` int(10) unsigned DEFAULT NULL COMMENT '调整的课时，适用于历史签单的课时',
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='签单表';

/*Data for the table `order_info` */

insert  into `order_info`(`id`,`order_no`,`student_id`,`fee`,`order_type`,`status`,`des`,`flow_ins_id`,`start_time`,`end_time`,`grade`,`course_hour`,`adjust_hour`,`cost_course_hour`,`schedule_hour`,`run_status`,`parent_order_id`,`cur_operator`,`is_last`,`iseff`,`create_time`,`last_update`) values (10,'no121',1,1111100,'0','审批通过',NULL,NULL,'2015-07-16 00:00:00','2015-07-31 00:00:00','2',100,0,2,100,'1',NULL,15,'0','0','2015-07-16 00:00:00','2015-07-17 11:24:02');

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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='签单参与者历史表';

/*Data for the table `order_rel_his` */

insert  into `order_rel_his`(`id`,`order_id`,`task_name`,`chargerType`,`operator`,`create_time`,`last_update`,`task_id`) values (35,10,'签约','1',18,'2015-07-16 22:33:01','2015-07-16 22:33:01',1),(36,10,'销售主管审批','2',7,'2015-07-16 22:40:39','2015-07-16 22:40:39',2),(37,10,'教务部处理','3',15,'2015-07-16 22:42:25','2015-07-16 22:42:25',3),(38,10,'班主任处理中','4',16,'2015-07-16 22:45:10','2015-07-16 22:45:10',5),(39,10,'教务部审批','3',15,'2015-07-16 22:47:34','2015-07-16 22:47:34',6);

/*Table structure for table `order_role` */

DROP TABLE IF EXISTS `order_role`;

CREATE TABLE `order_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `charger` int(10) NOT NULL COMMENT '1:销售 2: 销售主管 3:教务部主管 4:班主任 5:授课老师',
  `role_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='签单负责人配置';

/*Data for the table `order_role` */

insert  into `order_role`(`id`,`charger`,`role_id`) values (1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6);

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='签单流程跟踪表';

/*Data for the table `order_trace` */

insert  into `order_trace`(`id`,`order_id`,`task_name`,`role_id`,`user_id`,`operator`,`oper`,`create_time`,`last_update`,`oper_sort`,`task_id`,`transition`) values (45,10,'签约',NULL,18,18,'0','2015-07-16 22:33:01','2015-07-16 22:33:01',NULL,1,'待审批'),(46,10,'销售主管审批',NULL,7,7,'0','2015-07-16 22:33:02','2015-07-16 22:40:39',NULL,2,'通过'),(47,10,'教务部处理',NULL,15,15,'0','2015-07-16 22:40:39','2015-07-16 22:42:25',NULL,3,'分配任务'),(48,10,'班主任处理中',NULL,16,16,'0','2015-07-16 22:42:25','2015-07-16 22:45:10',NULL,5,'确认'),(49,10,'教务部审批',NULL,15,15,'0','2015-07-16 22:45:10','2015-07-16 22:47:34',NULL,6,'通过'),(50,10,'审批通过',NULL,NULL,NULL,NULL,'2015-07-16 22:47:34','2015-07-16 22:47:34',NULL,7,NULL);

/*Table structure for table `student_exchange` */

DROP TABLE IF EXISTS `student_exchange`;

CREATE TABLE `student_exchange` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned NOT NULL,
  `operator` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登记人',
  `content` varchar(1000) NOT NULL COMMENT '交流内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生交流表';

/*Data for the table `student_exchange` */

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
  `email` varchar(100) DEFAULT NULL COMMENT 'email地址',
  `qq` varchar(100) DEFAULT NULL COMMENT 'qq号码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='学生信息表';

/*Data for the table `student_info` */

insert  into `student_info`(`id`,`name`,`grade`,`school`,`age`,`brithday`,`sex`,`homephone`,`phone`,`addr`,`father_name`,`father_phone`,`father_unit`,`father_position`,`mother_name`,`mother_phone`,`mother_unit`,`mother_position`,`interest`,`last_exam_date`,`score_yuwen`,`score_shuxue`,`score_yingwen`,`score_zhengzhi`,`score_wuli`,`score_huaxue`,`score_lishi`,`score_shengwu`,`selfevaluation`,`create_time`,`last_update`,`liketeacherstyle`,`likecoursestyle`,`livehabit`,`score_dili`,`self_assessment`,`area_id`,`email`,`qq`) values (1,'ken','2',NULL,'0','2015-05-03','0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-03 22:21:07','2015-05-03 22:21:07',NULL,NULL,NULL,NULL,NULL,4,NULL,NULL),(2,'罗子然','1','华师附小','0','2015-04-17','1','85217366',NULL,'华南师范大学中区','罗','1388888888','123',NULL,'阳','1399999999','321',NULL,NULL,'2015-07-10','80','80','90',NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-11 06:32:36','2015-06-11 06:32:36',NULL,NULL,NULL,NULL,NULL,4,NULL,NULL),(3,'罗梓刚','2','华师附小','0','2015-04-07','0','52122222','1223',' 啊啊啊啊啊啊啊',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-11 08:10:36','2015-06-11 08:10:36',NULL,NULL,NULL,NULL,NULL,4,NULL,NULL),(4,'欧柏江','7','华师附中','12','2003-05-01','0',NULL,NULL,'天河北路12345678号','欧欧','13833333333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-13','100','99','99',NULL,NULL,NULL,NULL,NULL,NULL,'2015-06-15 16:01:17','2015-06-15 16:01:17',NULL,NULL,NULL,NULL,NULL,4,NULL,NULL);

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

insert  into `sys_area`(`id`,`name`,`parentid`,`iseff`,`create_time`,`last_update`,`des`) values (4,'天河校区',0,'0','2015-03-08 11:28:11','2015-03-08 11:31:10',NULL),(5,'海珠校区',0,'0','2015-03-08 11:31:20','2015-03-08 11:31:20',NULL);

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

insert  into `sys_department`(`id`,`name`,`des`,`parentid`,`iseff`,`create_time`,`last_update`) values (1,'教务部',NULL,0,'0','2012-08-14 22:10:09','2012-04-16 20:40:02'),(2,'销售部',NULL,0,'0','2012-08-14 22:10:10','2012-04-16 20:40:13');

/*Table structure for table `sys_log_trace` */

DROP TABLE IF EXISTS `sys_log_trace`;

CREATE TABLE `sys_log_trace` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `module_name` varchar(200) NOT NULL DEFAULT '' COMMENT '模块名称',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统跟踪表';

/*Data for the table `sys_log_trace` */

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`name`,`url`,`level`,`parentid`,`iseff`,`isleaf`,`des`,`createtime`,`last_update`,`icon`,`sort`) values (1,'系统设置',NULL,'1',0,'0','0',NULL,'2015-07-17 11:20:11','2012-04-15 00:17:59',NULL,8),(2,'学生管理','','1',0,'0','0','','2012-03-19 20:52:03','2012-02-25 12:35:48','',2),(4,'登陆','/frame/main/main.jsp','1',0,'1','1',NULL,'2012-12-10 20:33:13','2012-11-28 23:26:15',NULL,NULL),(6,'权限管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-04-15 14:26:15','2012-04-15 14:26:15',NULL,3),(10,'系统用户','/page/system/user/user.jsp','2',1,'0','1',NULL,'2012-03-19 21:35:10','2012-03-03 01:18:21',NULL,NULL),(12,'学生信息管理','/page/student/infomrg/infomrg.jsp','2',2,'0','1',NULL,'2012-03-26 23:01:44','2012-03-06 19:47:18',NULL,NULL),(15,'教师管理',NULL,'1',0,'0','0',NULL,'2015-07-17 11:19:58','2012-04-15 00:18:32',NULL,3),(16,'签单管理',NULL,'1',0,'0','0',NULL,'2012-06-16 00:31:44','2012-04-15 00:18:17',NULL,1),(17,'新签单登记','/page/contract/register/register.jsp','2',16,'0','1',NULL,'2012-06-16 00:31:44','2012-03-06 19:47:18',NULL,NULL),(18,'签单流程管理(超级管理员)','/page/contract/mrg/info.jsp','2',16,'0','1',NULL,'2015-07-17 16:11:52','2012-03-06 19:47:18',NULL,NULL),(23,'学生沟通记录','/page/student/exchange/infomrg.jsp','2',2,'0','1',NULL,'2012-07-22 22:24:36','2012-03-06 19:47:18',NULL,NULL),(37,'角色管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-03-06 19:47:18','2012-03-06 19:47:18',NULL,NULL),(38,'菜单管理','/page/system/menu/menu.jsp','2',1,'0','1',NULL,'2012-03-06 19:47:18','2012-03-06 19:47:18',NULL,NULL),(39,'部门管理','/page/system/department/dep.jsp','2',1,'0','1',NULL,'2012-04-16 20:37:51','2012-04-16 20:37:51',NULL,4),(42,'学生信息登记','/page/student/register/register.jsp','3',16,'0','1',NULL,'2015-06-25 11:15:00','2012-04-17 22:31:12',NULL,NULL),(43,'签单信息查询','/page/contract/info/info.jsp','3',16,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,NULL),(45,'未处理签单','/page/personal/task/info.jsp','2',16,'0','1',NULL,'2015-07-16 21:54:24','2012-04-17 22:31:12',NULL,NULL),(46,'已处理签单','/page/personal/taskhis/info.jsp','2',16,'0','1',NULL,'2015-07-16 21:54:24','2012-04-17 22:31:12',NULL,NULL),(47,'学生信息交流','/page/personal/exchange/info.jsp','2',16,'1','1',NULL,'2015-07-16 21:54:24','2012-07-11 20:01:21',NULL,NULL),(48,'教师信息管理','/page/teacher/info/info.jsp','2',15,'0','1',NULL,'2012-08-02 20:40:49','2012-07-11 20:01:21',NULL,NULL),(51,'统计查询',NULL,'1',0,'0','0',NULL,'2015-07-17 11:20:08','2012-07-11 20:01:21',NULL,7),(52,'签单统计',NULL,'2',51,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(53,'签单日统计','/jasperreports/query/OrderCountDaily.jsp','3',52,'0','1',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(54,'消息管理',NULL,'1',0,'0','0',NULL,'2015-07-17 11:20:06','2012-07-11 20:01:21',NULL,6),(55,'全部消息历史','/page/notice/allhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-07-11 20:01:21',NULL,NULL),(56,'发送消息','/page/notice/edit/edit.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-12 22:41:53',NULL,NULL),(57,'已发消息','/page/notice/personalhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-12 22:41:53',NULL,NULL),(58,'收件箱','/page/notice/personalhis/noreadinfo.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:32:07',NULL,NULL),(59,'市场管理',NULL,'1',0,'0','0',NULL,'2015-07-17 11:20:03','2012-08-16 23:32:07',NULL,5),(60,'客户管理','/page/market/customer/info/info.jsp','2',59,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:45:07',NULL,NULL),(61,'来电交流管理','/page/market/customer/exchange/info.jsp','2',59,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:45:07',NULL,NULL),(62,'课程管理',NULL,'1',0,'0','0',NULL,'2015-07-17 11:20:00','2012-08-16 23:45:07',NULL,4),(63,'课程分数管理','/page/course/score/info.jsp','2',62,'0','1',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(64,'课程评价管理','/page/course/evaluation/info.jsp','2',62,'0','1',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(65,'课时管理','/page/course/hour/info.jsp','2',62,'0','1',NULL,'2015-05-05 22:21:33','2012-08-16 23:45:07',NULL,NULL),(66,'授课老师关联学生','/page/teacher/refstudent/info.jsp','2',15,'0','1',NULL,'2012-12-06 22:23:00','2012-09-12 22:02:37',NULL,NULL),(68,'我的学生','/page/teacher/refstudent/info.jsp?isLoginOper=true','2',15,'0','1',NULL,'2012-10-25 22:00:34','2012-10-25 22:00:34',NULL,NULL),(69,'教师信息查询','/page/teacher/info/info.jsp?isOnlyQuery=true','2',15,'0','1',NULL,'2012-11-12 22:31:59','2012-10-25 22:00:34',NULL,NULL),(71,'签单月统计','/jasperreports/query/OrderCountMonthly.jsp','3',52,'0','1',NULL,'2012-11-28 23:28:26','2012-11-12 22:31:59',NULL,NULL),(73,'来电交流查询','/page/market/customer/exchange/info.jsp?isOnlyQuery=true','2',59,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(74,'系统访问日志','/page/system/trace/trace.jsp','2',1,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(75,'学生信息查询','/page/student/infomrg/infomrg.jsp?isOnlyQuery=true','2',2,'0','1',NULL,'2012-12-10 22:34:48','2012-11-28 23:26:15',NULL,NULL),(76,'区域管理','/page/system/area/area.jsp','2',1,'0','1',NULL,'2012-12-10 22:34:48','2012-12-10 22:34:48',NULL,NULL),(77,'教师排课','/page/teacher/course/info.jsp','2',15,'0','1',NULL,'2012-12-10 22:34:48','2012-12-10 22:34:48',NULL,NULL),(78,'设置课时','/page/course/period/info.jsp','2',62,'0','1',NULL,'2015-05-05 22:21:43','2012-12-10 22:34:48',NULL,NULL),(79,'重设密码','/page/system/user/password.jsp','2',1,'0','1',NULL,'2015-04-20 18:17:29','2015-04-20 18:17:29',NULL,NULL),(80,'教师日程表','/page/teacher/course/myscheduledaily.jsp','2',15,'0','1',NULL,'2015-04-20 18:17:29','2015-04-20 18:17:29',NULL,NULL),(81,'签单管理','/page/contract/schedule/info.jsp','2',16,'0','1',NULL,'2015-07-17 16:12:02','2015-04-20 18:17:29',NULL,NULL),(82,'教师排课(班主任)','/page/teacher/course/info.jsp?forMain=true','2',15,'0','1',NULL,'2015-06-30 15:44:22','2015-06-30 15:44:17',NULL,NULL);

/*Table structure for table `sys_menu_bak` */

DROP TABLE IF EXISTS `sys_menu_bak`;

CREATE TABLE `sys_menu_bak` (
  `id` int(10) NOT NULL DEFAULT '0',
  `name` varchar(50) NOT NULL,
  `url` varchar(100) DEFAULT NULL,
  `level` char(1) NOT NULL,
  `parentid` int(10) NOT NULL,
  `iseff` char(1) NOT NULL DEFAULT '0' COMMENT '0:有效,1:无效',
  `isleaf` char(1) NOT NULL COMMENT '是否也是 0:不是, 1:是',
  `des` varchar(100) DEFAULT NULL,
  `createtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_update` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `icon` varchar(100) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_menu_bak` */

insert  into `sys_menu_bak`(`id`,`name`,`url`,`level`,`parentid`,`iseff`,`isleaf`,`des`,`createtime`,`last_update`,`icon`,`sort`) values (1,'系统设置',NULL,'1',0,'0','0',NULL,'2012-08-10 20:58:37','2012-04-15 00:17:59',NULL,0),(2,'学生管理','','1',0,'0','0','','2012-03-19 20:52:03','2012-02-25 12:35:48','',2),(4,'登陆','/frame/main/main.jsp','1',0,'1','1',NULL,'2012-12-10 20:33:13','2012-11-28 23:26:15',NULL,NULL),(6,'权限管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-04-15 14:26:15','2012-04-15 14:26:15',NULL,3),(10,'系统用户','/page/system/user/user.jsp','2',1,'0','1',NULL,'2012-03-19 21:35:10','2012-03-03 01:18:21',NULL,NULL),(12,'学生信息管理','/page/student/infomrg/infomrg.jsp','2',2,'0','1',NULL,'2012-03-26 23:01:44','2012-03-06 19:47:18',NULL,NULL),(15,'教师管理',NULL,'1',0,'0','0',NULL,'2012-07-23 22:17:48','2012-04-15 00:18:32',NULL,2),(16,'签单管理',NULL,'1',0,'0','0',NULL,'2012-06-16 00:31:44','2012-04-15 00:18:17',NULL,1),(17,'新签单登记','/page/contract/register/register.jsp','2',16,'0','1',NULL,'2012-06-16 00:31:44','2012-03-06 19:47:18',NULL,NULL),(18,'签单流程管理','/page/contract/mrg/info.jsp','2',16,'0','1',NULL,'2012-06-25 20:21:42','2012-03-06 19:47:18',NULL,NULL),(23,'学生沟通记录','/page/student/exchange/infomrg.jsp','2',2,'0','1',NULL,'2012-07-22 22:24:36','2012-03-06 19:47:18',NULL,NULL),(37,'角色管理','/page/system/role/role.jsp','2',1,'0','1',NULL,'2012-03-06 19:47:18','2012-03-06 19:47:18',NULL,NULL),(38,'菜单管理','/page/system/menu/menu.jsp','2',1,'0','1',NULL,'2012-03-06 19:47:18','2012-03-06 19:47:18',NULL,NULL),(39,'部门管理','/page/system/department/dep.jsp','2',1,'0','1',NULL,'2012-04-16 20:37:51','2012-04-16 20:37:51',NULL,4),(42,'学生信息登记','/page/student/register/register.jsp','3',2,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,NULL),(43,'签单信息查询','/page/contract/info/info.jsp','3',16,'0','1',NULL,'2012-04-17 22:31:12','2012-04-17 22:31:12',NULL,NULL),(44,'个人信息管理','','1',0,'0','0',NULL,'2012-07-11 20:00:56','2012-04-17 22:31:12',NULL,NULL),(45,'未处理签单','/page/personal/task/info.jsp','2',44,'0','1',NULL,'2015-04-28 16:15:28','2012-04-17 22:31:12',NULL,NULL),(46,'已处理签单','/page/personal/taskhis/info.jsp','2',44,'0','1',NULL,'2015-04-28 16:15:40','2012-04-17 22:31:12',NULL,NULL),(47,'学生信息交流','/page/personal/exchange/info.jsp','2',44,'1','1',NULL,'2015-04-28 16:13:06','2012-07-11 20:01:21',NULL,NULL),(48,'教师信息管理','/page/teacher/info/info.jsp','2',15,'0','1',NULL,'2012-08-02 20:40:49','2012-07-11 20:01:21',NULL,NULL),(51,'统计查询',NULL,'1',0,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(52,'签单统计',NULL,'2',51,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(53,'签单日统计','/jasperreports/query/OrderCountDaily.jsp','3',52,'0','1',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(54,'消息管理',NULL,'1',0,'0','0',NULL,'2012-07-11 20:01:21','2012-07-11 20:01:21',NULL,NULL),(55,'全部消息历史','/page/notice/allhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-07-11 20:01:21',NULL,NULL),(56,'发送消息','/page/notice/edit/edit.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-12 22:41:53',NULL,NULL),(57,'已发消息','/page/notice/personalhis/info.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-12 22:41:53',NULL,NULL),(58,'收件箱','/page/notice/personalhis/noreadinfo.jsp','2',54,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:32:07',NULL,NULL),(59,'市场管理',NULL,'1',0,'0','0',NULL,'2012-08-16 23:45:07','2012-08-16 23:32:07',NULL,NULL),(60,'客户管理','/page/market/customer/info/info.jsp','2',59,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:45:07',NULL,NULL),(61,'来电交流管理','/page/market/customer/exchange/info.jsp','2',59,'0','1',NULL,'2012-12-06 22:20:00','2012-08-16 23:45:07',NULL,NULL),(62,'课程管理',NULL,'1',0,'0','0',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(63,'课程分数管理','/page/course/score/info.jsp','2',62,'0','1',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(64,'课程评价管理','/page/course/evaluation/info.jsp','2',62,'0','1',NULL,'2012-08-16 23:45:07','2012-08-16 23:45:07',NULL,NULL),(65,'课时管理','/page/course/hour/info.jsp','2',62,'0','1',NULL,'2015-05-05 22:21:33','2012-08-16 23:45:07',NULL,NULL),(66,'授课老师关联学生','/page/teacher/refstudent/info.jsp','2',15,'0','1',NULL,'2012-12-06 22:23:00','2012-09-12 22:02:37',NULL,NULL),(68,'我的学生','/page/teacher/refstudent/info.jsp?isLoginOper=true','2',15,'0','1',NULL,'2012-10-25 22:00:34','2012-10-25 22:00:34',NULL,NULL),(69,'教师信息查询','/page/teacher/info/info.jsp?isOnlyQuery=true','2',15,'0','1',NULL,'2012-11-12 22:31:59','2012-10-25 22:00:34',NULL,NULL),(71,'签单月统计','/jasperreports/query/OrderCountMonthly.jsp','3',52,'0','1',NULL,'2012-11-28 23:28:26','2012-11-12 22:31:59',NULL,NULL),(73,'来电交流查询','/page/market/customer/exchange/info.jsp?isOnlyQuery=true','2',59,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(74,'系统访问日志','/page/system/trace/trace.jsp','2',1,'0','1',NULL,'2012-11-28 23:26:15','2012-11-28 23:26:15',NULL,NULL),(75,'学生信息查询','/page/student/infomrg/infomrg.jsp?isOnlyQuery=true','2',2,'0','1',NULL,'2012-12-10 22:34:48','2012-11-28 23:26:15',NULL,NULL),(76,'区域管理','/page/system/area/area.jsp','2',1,'0','1',NULL,'2012-12-10 22:34:48','2012-12-10 22:34:48',NULL,NULL),(77,'教师排课','/page/teacher/course/info.jsp','2',15,'0','1',NULL,'2012-12-10 22:34:48','2012-12-10 22:34:48',NULL,NULL),(78,'设置课时','/page/course/period/info.jsp','2',62,'0','1',NULL,'2015-05-05 22:21:43','2012-12-10 22:34:48',NULL,NULL),(79,'重设密码','/page/system/user/password.jsp','2',1,'0','1',NULL,'2015-04-20 18:17:29','2015-04-20 18:17:29',NULL,NULL),(80,'教师日程表','/page/teacher/course/myscheduledaily.jsp','2',15,'0','1',NULL,'2015-04-20 18:17:29','2015-04-20 18:17:29',NULL,NULL),(81,'签单排课','/page/contract/schedule/info.jsp','2',16,'0','1',NULL,'2015-04-20 18:17:29','2015-04-20 18:17:29',NULL,NULL);

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

insert  into `sys_param`(`param_code`,`param_name`,`param_value`,`root_code`,`des`,`seq`,`iseff`,`create_time`,`last_update`) values ('','',NULL,NULL,NULL,NULL,'0','2015-04-11 17:20:51','0000-00-00 00:00:00'),('ACCEPT','确认','0','TASK_OPER',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('APPLY_STATUS','审批结果',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_A','初期辅导方案','1','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_B','华实模拟协议','2','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_C','全方位测评报告','3','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_D','教学安排表','4','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ATTACH_TYPE_F','教学方案','5','ATTACH_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CONTRACT_STATUS','签单状态',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSEHOUR_CANCEL','已撤销','1','COURSE_HOUR_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSEHOUR_SETTLE','已清算','0','COURSE_HOUR_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_DILI','地理','9','ORDER_COURSE',NULL,'9','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_HUAXUE','化学','5','ORDER_COURSE',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_LISHI','历史','8','ORDER_COURSE',NULL,'8','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_SHENGWU','生物','7','ORDER_COURSE',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_SHUXUE','数学','2','ORDER_COURSE',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_WULI','物理','4','ORDER_COURSE',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_YINGWEN','英语','3','ORDER_COURSE',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_YUWEN','语文','1','ORDER_COURSE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('COURSE_ZHENGZHI','政治','6','ORDER_COURSE',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS','客户当前状态',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS_A','去电','0','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS_B','未上门','1','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('CUSTOMER_STATUS_C','已上门','2','CUSTOMER_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('EDUADMIN_CONFIRM','教务部审批','5','CONTRACT_STATUS',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('EDUADMIN_DISPATCH','教务部分配班主任','2','CONTRACT_STATUS',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('EFFECTIVE','有效','0','ISEFF',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('FORMAL_TEACHER','正式教师','0','TEACHER_TYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('FRIDAY','星期五','6','WEEK',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('GRADE','年级',NULL,NULL,NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_FIVE','高中二年级','11','GRADE',NULL,'11','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_FOUR','高中一年级','10','GRADE',NULL,'10','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_ONE','初中一年级','7','GRADE',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_SIX','高中三年级','12','GRADE',NULL,'12','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_THREE','初中三年级','9','GRADE',NULL,'9','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('HIGH_TWO','初中二年级','8','GRADE',NULL,'8','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('INEFFECTIVE','无效','1','ISEFF',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ISEFF','是否有效',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_FIVE',' 小学五年级','5','GRADE',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_FOUR',' 小学四年级','4','GRADE',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_ONE',' 小学一年级','1','GRADE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_SIX',' 小学六年级','6','GRADE',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_THREE',' 小学三年级','3','GRADE',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('JUNIOR_TWO',' 小学二年级','2','GRADE',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('LAERNING','授课中','7','CONTRACT_STATUS',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MAINTEACHER_CONFIRM','待班主任确认','3','CONTRACT_STATUS',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MAINTEACHER_HANDLE','班主任处理中','4','CONTRACT_STATUS',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MAN','男','0','SEXTYPE',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MARKETEXECUTIVE_HANDLE','销售主管审批','1','CONTRACT_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('MONDAY','星期一','2','WEEK',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NEW','新签单','0','CONTRACT_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NO','否','0','YESORNO',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTICER_DEPARTMENT','部门','2','NOTICER_TYPE',NULL,'2','0','2012-08-12 22:28:19','2012-08-12 22:28:19'),('NOTICER_PERSONAL','个人','0','NOTICER_TYPE',NULL,'0','0','2012-08-12 22:28:19','2012-08-12 22:28:19'),('NOTICER_TYPE','消息者类型',NULL,NULL,NULL,NULL,'0','2012-08-12 22:28:19','0000-00-00 00:00:00'),('NOTICE_NOREAD','未读','0','NOTICE_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTICE_READ','已读','1','NOTICE_STATUS',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTICE_STATUS','公告状态',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('NOTPASS','不通过','2','APPLY_STATUS',NULL,'2','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_COURSE','签单课程',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_A','审批中','0','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_C','授课中','1','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('ORDER_RUN_STATUS_D','结束','2','ORDER_RUN_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('OVER','结束','8','CONTRACT_STATUS',NULL,'8','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('PARTTIME_TEACHER','兼职教师','1','TEACHER_TYPE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('PASS','通过','1','APPLY_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('POSITION','职位',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('REJECT','拒绝','1','TASK_OPER',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE','户口类型',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE_A','非农业户口','0','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE_B','农业户口','1','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('RESIDENT_TYPE_C','居民户口','2','RESIDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SATURDAY','星期六','7','WEEK',NULL,'7','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SCHEDULE_DETAIL_FINISH','结束','1','SCHEDULE_DETAIL_STATUS',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SCHEDULE_DETAIL_NOTFINISH','没结束','0','SCHEDULE_DETAIL_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SCHEDULE_END','结束','2','SCHEDULE_STATUS',NULL,'2','0','2015-04-11 17:21:37','2012-03-13 20:50:21'),('SCHEDULE_NOTBEGIN','未开始','0','SCHEDULE_STATUS',NULL,'0','0','2015-04-11 17:23:40','2015-04-11 17:23:40'),('SCHEDULE_RUNNING','开始中','1','SCHEDULE_STATUS',NULL,'1','0','2015-04-11 17:21:29','2012-03-13 20:50:21'),('SELLER','销售','0','POSITION',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SEXTYPE','性别',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('STUDENT_TYPE','学生类型',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('STUDENT_TYPE_A','普通借读生','0','STUDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('STUDENT_TYPE_B','正式生','1','STUDENT_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('SUNDAY','星期日','1','WEEK',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('TEACHER','教师','1','POSITION',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('TEACHER_CONFIRM','待授课老师确认','6','CONTRACT_STATUS',NULL,'6','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('THURSDAY','星期四','5','WEEK',NULL,'5','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('TUESDAY','星期二','3','WEEK',NULL,'3','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE','访问来源',NULL,NULL,NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE_A','来电','0','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE_B','短信','1','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('VISIT_SOURCE_TYPE_C','老资料回访','2','VISIT_SOURCE_TYPE',NULL,NULL,'0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('WAIT','待审批','0','APPLY_STATUS',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('WEBNESDAY','星期三','4','WEEK',NULL,'4','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('WOMAN','女','1','SEXTYPE',NULL,'1','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('YES','是','1','YESORNO',NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21'),('YESORNO','是与否',NULL,NULL,NULL,'0','0','2012-03-13 20:50:21','2012-03-13 20:50:21');

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
) ENGINE=InnoDB AUTO_INCREMENT=2153 DEFAULT CHARSET=utf8 COMMENT='权限菜单关联';

/*Data for the table `sys_right_rel` */

insert  into `sys_right_rel`(`id`,`type`,`rel_id`,`target_id`,`create_time`,`last_update`,`rel_right`) values (20,'0','17',40,'2012-08-14 21:46:12','2012-08-14 21:46:12',0),(21,'0','17',41,'2012-08-14 21:46:12','2012-08-14 21:46:12',0),(262,'1','2',2,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(263,'1','2',12,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(264,'1','2',23,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(265,'1','2',42,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(266,'1','2',15,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(267,'1','2',48,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(268,'1','2',16,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(269,'1','2',17,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(270,'1','2',43,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(272,'1','2',45,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(273,'1','2',46,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(274,'1','2',47,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(275,'1','2',54,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(276,'1','2',56,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(277,'1','2',57,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(278,'1','2',58,'2012-08-18 20:17:27','2012-08-18 20:17:27',0),(589,'1','2',2,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(590,'1','2',12,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(591,'1','2',23,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(592,'1','2',42,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(593,'1','2',15,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(594,'1','2',48,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(595,'1','2',16,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(596,'1','2',17,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(597,'1','2',43,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(599,'1','2',45,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(600,'1','2',46,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(601,'1','2',47,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(602,'1','2',54,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(603,'1','2',56,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(604,'1','2',57,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(605,'1','2',58,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(606,'1','2',59,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(607,'1','2',60,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(608,'1','2',61,'2012-11-11 00:35:22','2012-11-11 00:35:22',0),(609,'1','2',2,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(610,'1','2',12,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(611,'1','2',23,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(612,'1','2',42,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(613,'1','2',16,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(614,'1','2',17,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(615,'1','2',43,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(617,'1','2',45,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(618,'1','2',46,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(619,'1','2',47,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(620,'1','2',54,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(621,'1','2',56,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(622,'1','2',57,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(623,'1','2',58,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(624,'1','2',59,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(625,'1','2',60,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(626,'1','2',61,'2012-11-11 00:35:27','2012-11-11 00:35:27',0),(669,'1','2',2,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(670,'1','2',12,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(671,'1','2',23,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(672,'1','2',42,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(673,'1','2',15,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(674,'1','2',66,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(675,'1','2',69,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(676,'1','2',16,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(677,'1','2',17,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(678,'1','2',43,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(680,'1','2',45,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(681,'1','2',46,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(682,'1','2',47,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(683,'1','2',54,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(684,'1','2',56,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(685,'1','2',57,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(686,'1','2',58,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(687,'1','2',59,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(688,'1','2',60,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(689,'1','2',61,'2012-11-12 22:47:23','2012-11-12 22:47:23',0),(690,'1','2',2,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(691,'1','2',12,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(692,'1','2',23,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(693,'1','2',42,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(694,'1','2',15,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(695,'1','2',66,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(696,'1','2',68,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(697,'1','2',69,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(698,'1','2',16,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(699,'1','2',17,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(700,'1','2',43,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(702,'1','2',45,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(703,'1','2',46,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(704,'1','2',47,'2012-11-12 22:47:28','2012-11-12 22:47:28',0),(705,'1','2',54,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(706,'1','2',56,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(707,'1','2',57,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(708,'1','2',58,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(709,'1','2',59,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(710,'1','2',60,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(711,'1','2',61,'2012-11-12 22:47:29','2012-11-12 22:47:29',0),(712,'1','2',2,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(713,'1','2',12,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(714,'1','2',23,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(715,'1','2',42,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(716,'1','2',15,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(717,'1','2',66,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(718,'1','2',69,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(719,'1','2',16,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(720,'1','2',17,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(721,'1','2',43,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(723,'1','2',45,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(724,'1','2',46,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(725,'1','2',47,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(726,'1','2',54,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(727,'1','2',56,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(728,'1','2',57,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(729,'1','2',58,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(730,'1','2',59,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(731,'1','2',60,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(732,'1','2',61,'2012-11-12 22:47:34','2012-11-12 22:47:34',0),(1097,'1','1',4,'2015-03-08 11:34:19','2015-03-08 11:34:19',1),(1098,'1','1',5,'2015-03-08 11:34:19','2015-03-08 11:34:19',1),(1421,'1','2',2,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1422,'1','2',12,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1423,'1','2',23,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1424,'1','2',42,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1425,'1','2',15,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1426,'1','2',48,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1427,'1','2',66,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1428,'1','2',68,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1429,'1','2',69,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1430,'1','2',16,'2015-05-01 22:46:11','2015-05-01 22:46:11',0),(1431,'1','2',17,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1432,'1','2',43,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1434,'1','2',45,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1435,'1','2',46,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1436,'1','2',47,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1437,'1','2',54,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1438,'1','2',56,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1439,'1','2',57,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1440,'1','2',58,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1441,'1','2',59,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1442,'1','2',60,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(1443,'1','2',61,'2015-05-01 22:46:12','2015-05-01 22:46:12',0),(2013,'1','1',16,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2014,'1','1',17,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2015,'1','1',18,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2016,'1','1',42,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2017,'1','1',43,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2018,'1','1',45,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2019,'1','1',46,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2020,'1','1',47,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2021,'1','1',2,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2022,'1','1',12,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2023,'1','1',23,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2024,'1','1',75,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2025,'1','1',15,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2026,'1','1',48,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2027,'1','1',66,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2028,'1','1',68,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2029,'1','1',69,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2030,'1','1',77,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2031,'1','1',80,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2032,'1','1',62,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2033,'1','1',63,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2034,'1','1',64,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2035,'1','1',65,'2015-07-17 15:52:56','2015-07-17 15:52:56',0),(2036,'1','1',78,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2037,'1','1',59,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2038,'1','1',60,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2039,'1','1',61,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2040,'1','1',73,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2041,'1','1',54,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2042,'1','1',55,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2043,'1','1',56,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2044,'1','1',57,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2045,'1','1',58,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2046,'1','1',51,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2047,'1','1',52,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2048,'1','1',53,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2049,'1','1',71,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2050,'1','1',1,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2051,'1','1',10,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2052,'1','1',37,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2053,'1','1',38,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2054,'1','1',74,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2055,'1','1',76,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2056,'1','1',79,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2057,'1','1',6,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2058,'1','1',39,'2015-07-17 15:52:57','2015-07-17 15:52:57',0),(2059,'1','5',16,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2060,'1','5',17,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2061,'1','5',42,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2062,'1','5',43,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2063,'1','5',45,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2064,'1','5',46,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2065,'1','5',47,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2066,'1','5',81,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2067,'1','5',2,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2068,'1','5',12,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2069,'1','5',23,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2070,'1','5',15,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2071,'1','5',48,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2072,'1','5',66,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2073,'1','5',69,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2074,'1','5',82,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2075,'1','5',62,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2076,'1','5',63,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2077,'1','5',64,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2078,'1','5',65,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2079,'1','5',54,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2080,'1','5',56,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2081,'1','5',57,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2082,'1','5',58,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2083,'1','5',51,'2015-07-17 15:54:21','2015-07-17 15:54:21',0),(2084,'1','5',52,'2015-07-17 15:54:22','2015-07-17 15:54:22',0),(2085,'1','5',53,'2015-07-17 15:54:22','2015-07-17 15:54:22',0),(2086,'1','5',71,'2015-07-17 15:54:22','2015-07-17 15:54:22',0),(2087,'1','5',79,'2015-07-17 15:54:22','2015-07-17 15:54:22',0),(2088,'1','6',47,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2089,'1','6',2,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2090,'1','6',23,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2091,'1','6',15,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2092,'1','6',68,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2093,'1','6',80,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2094,'1','6',62,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2095,'1','6',63,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2096,'1','6',64,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2097,'1','6',54,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2098,'1','6',56,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2099,'1','6',57,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2100,'1','6',58,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2101,'1','6',79,'2015-07-17 15:58:01','2015-07-17 15:58:01',0),(2102,'1','4',16,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2103,'1','4',43,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2104,'1','4',45,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2105,'1','4',46,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2106,'1','4',47,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2107,'1','4',2,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2108,'1','4',12,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2109,'1','4',23,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2110,'1','4',15,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2111,'1','4',48,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2112,'1','4',66,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2113,'1','4',69,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2114,'1','4',77,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2115,'1','4',62,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2116,'1','4',63,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2117,'1','4',64,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2118,'1','4',65,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2119,'1','4',54,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2120,'1','4',56,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2121,'1','4',57,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2122,'1','4',58,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2123,'1','4',51,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2124,'1','4',52,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2125,'1','4',53,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2126,'1','4',71,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2127,'1','4',79,'2015-07-17 16:04:11','2015-07-17 16:04:11',0),(2128,'1','3',16,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2129,'1','3',17,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2130,'1','3',18,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2131,'1','3',43,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2132,'1','3',45,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2133,'1','3',46,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2134,'1','3',47,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2135,'1','3',2,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2136,'1','3',12,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2137,'1','3',23,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2138,'1','3',15,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2139,'1','3',48,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2140,'1','3',66,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2141,'1','3',69,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2142,'1','3',59,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2143,'1','3',60,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2144,'1','3',61,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2145,'1','3',54,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2146,'1','3',56,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2147,'1','3',57,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2148,'1','3',58,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2149,'1','3',51,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2150,'1','3',52,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2151,'1','3',53,'2015-07-17 16:04:39','2015-07-17 16:04:39',0),(2152,'1','3',79,'2015-07-17 16:04:39','2015-07-17 16:04:39',0);

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

insert  into `sys_role`(`id`,`name`,`iseff`,`create_time`,`last_update`) values (1,'超级管理员','0','2012-04-10 22:35:50','2012-04-10 22:35:50'),(2,'销售','0','2012-04-24 22:06:08','2012-04-24 22:06:09'),(3,'销售主管','0','2012-06-20 00:03:32','2012-06-20 00:03:32'),(4,'教务部主管','0','2012-04-24 22:06:09','2012-04-24 22:06:09'),(5,'班主任','0','2012-04-24 22:06:09','2012-04-24 22:06:09'),(6,'授课老师','0','2012-04-24 22:06:09','2012-04-24 22:06:09');

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
  `qq` varchar(100) DEFAULT NULL COMMENT 'qq',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`user_name`,`dep_id`,`password`,`sex`,`position`,`phone`,`addr`,`zipcode`,`iseff`,`create_time`,`last_update`,`role_id`,`email`,`area_id`,`qq`) values (5,'销售主管一号',2,'1','0',NULL,'212112','111','55','0','2015-03-08 22:34:47','2015-04-30 22:25:46',3,NULL,5,NULL),(7,'销售主管二号',2,'1','1',NULL,'13826031714','guangzhou','33','0','2015-03-08 22:34:47','2012-08-16 22:41:26',3,NULL,4,NULL),(10,'销售一号',2,'1','0',NULL,'212112','111','1@ye.com','0','2015-03-08 22:34:47','2015-04-30 22:18:56',2,NULL,5,NULL),(13,'销售二号',2,'1','1',NULL,'1','1','1','0','2015-03-08 22:34:47','2012-08-16 22:39:24',2,NULL,4,NULL),(14,'教务部主管一号',1,'1','1',NULL,'1','1','31','0','2015-03-08 22:34:47','2015-04-30 22:25:58',4,NULL,5,NULL),(15,'教务部主管二号',1,'1','0',NULL,'1','1','5135','0','2015-03-08 22:34:47','2012-08-16 22:40:54',4,NULL,4,NULL),(16,'班主任一号',1,'1','0',NULL,'11','11','11','0','2015-03-08 22:34:47','2015-06-30 16:50:51',5,NULL,4,NULL),(17,'班主任二号',1,'1','1',NULL,'1','11','1','0','2015-03-08 22:34:47','2012-08-16 22:42:09',5,NULL,4,NULL),(18,'国产007',1,'1','0',NULL,'22','111','22','0','2015-04-24 21:56:53','2015-04-24 21:56:41',1,NULL,4,NULL),(27,'test111',NULL,'111',NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-01 23:28:47','2015-05-01 23:28:47',NULL,NULL,1,NULL),(28,'test111',NULL,'111',NULL,NULL,NULL,NULL,NULL,NULL,'2015-05-01 23:30:10','2015-05-01 23:30:10',NULL,NULL,1,NULL),(29,'林老师',1,'111111','0',NULL,'1','1',NULL,NULL,'2015-05-03 22:40:47','2015-05-03 22:40:47',6,NULL,4,NULL),(30,'黄老师',1,'111111','1',NULL,'2','1',NULL,NULL,'2015-05-03 22:41:16','2015-05-03 22:41:16',6,NULL,4,NULL),(31,'文老师',1,'111111','0',NULL,'321321','123123',NULL,NULL,'2015-06-11 07:04:10','2015-06-11 07:04:10',6,NULL,4,NULL),(32,'田老师',1,'111111','1',NULL,'123456789','123',NULL,'0','2015-06-11 07:05:30','2015-07-08 21:28:42',6,NULL,5,NULL);

/*Table structure for table `teacher_ability` */

DROP TABLE IF EXISTS `teacher_ability`;

CREATE TABLE `teacher_ability` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(50) NOT NULL,
  `course_type` varchar(50) NOT NULL COMMENT '课程类型 对应system_param的order_course',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grade_type` varchar(45) NOT NULL DEFAULT '' COMMENT '可教学的年级',
  `teacher_type` char(1) NOT NULL DEFAULT '0' COMMENT '0:正式 1:兼职',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `teacher_ability` */

insert  into `teacher_ability`(`id`,`user_id`,`course_type`,`create_time`,`grade_type`,`teacher_type`) values (1,29,'2,6','2015-05-03 22:40:47','1,5,6,10','0'),(2,30,'1,5,9','2015-05-03 22:41:16','1,5','1'),(3,31,'3','2015-06-11 07:04:10','9,10,7,11,8','0'),(4,32,'5,4','2015-06-11 07:05:30','9,10,7,11,8,12','0');

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

/*Table structure for table `order_course_view` */

DROP TABLE IF EXISTS `order_course_view`;

/*!50001 DROP VIEW IF EXISTS `order_course_view` */;
/*!50001 DROP TABLE IF EXISTS `order_course_view` */;

/*!50001 CREATE TABLE  `order_course_view`(
 `id` int(10) ,
 `order_id` int(10) unsigned ,
 `course_type` char(2) ,
 `charger_id` int(10) unsigned ,
 `status` char(1) ,
 `order_attach_id` int(10) unsigned ,
 `hour` int(10) unsigned ,
 `cost_hour` int(10) ,
 `schedule_hour` int(10) ,
 `create_time` timestamp ,
 `last_update` timestamp ,
 `student_id` int(10) unsigned ,
 `course_name` varchar(50) ,
 `charger_name` varchar(50) ,
 `student_name` varchar(50) ,
 `order_run_status` char(1) 
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

/*Table structure for table `order_info_view` */

DROP TABLE IF EXISTS `order_info_view`;

/*!50001 DROP VIEW IF EXISTS `order_info_view` */;
/*!50001 DROP TABLE IF EXISTS `order_info_view` */;

/*!50001 CREATE TABLE  `order_info_view`(
 `id` int(10) unsigned ,
 `order_no` varchar(100) ,
 `student_id` int(10) unsigned ,
 `fee` bigint(20) unsigned ,
 `order_type` char(2) ,
 `status` char(20) ,
 `des` varchar(250) ,
 `flow_ins_id` varchar(20) ,
 `start_time` timestamp ,
 `end_time` timestamp ,
 `grade` varchar(10) ,
 `course_hour` int(10) unsigned ,
 `adjust_hour` int(10) unsigned ,
 `cost_course_hour` int(10) unsigned ,
 `schedule_hour` int(10) ,
 `run_status` char(1) ,
 `parent_order_id` int(10) unsigned ,
 `cur_operator` int(10) unsigned ,
 `is_last` char(1) ,
 `iseff` char(1) ,
 `create_time` timestamp ,
 `last_update` timestamp ,
 `area_id` int(11) ,
 `student_name` varchar(50) ,
 `student_age` varchar(3) 
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
 `grade_type` varchar(45) ,
 `teacher_type` char(1) 
)*/;

/*Table structure for table `teacher_ref_student` */

DROP TABLE IF EXISTS `teacher_ref_student`;

/*!50001 DROP VIEW IF EXISTS `teacher_ref_student` */;
/*!50001 DROP TABLE IF EXISTS `teacher_ref_student` */;

/*!50001 CREATE TABLE  `teacher_ref_student`(
 `id` bigint(10) unsigned ,
 `order_id` int(10) unsigned ,
 `teacher_id` int(10) unsigned ,
 `student_id` int(10) unsigned ,
 `course_type` char(2) ,
 `run_status` char(1) ,
 `name` varchar(50) ,
 `grade` varchar(10) ,
 `sex` char(1) ,
 `age` varchar(3) ,
 `area_id` int(11) 
)*/;

/*View structure for view course_schedule_view */

/*!50001 DROP TABLE IF EXISTS `course_schedule_view` */;
/*!50001 DROP VIEW IF EXISTS `course_schedule_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `course_schedule_view` AS select `c`.`id` AS `id`,`c`.`teacher_id` AS `teacher_id`,`c`.`student_id` AS `student_id`,`c`.`course_type` AS `course_type`,`c`.`date` AS `date`,`c`.`start_time` AS `start_time`,`c`.`end_time` AS `end_time`,`c`.`iseff` AS `iseff`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`p`.`param_name` AS `course_name`,`s`.`name` AS `student_name`,`t`.`user_name` AS `teacher_name`,`c`.`is_finish` AS `is_finish` from (((`course_schedule_detail` `c` join `sys_param` `p`) join `student_info` `s`) join `teacher_info` `t`) where ((`p`.`root_code` = 'ORDER_COURSE') and (`p`.`param_value` = `c`.`course_type`) and (`s`.`id` = `c`.`student_id`) and (`t`.`id` = `c`.`teacher_id`)) */;

/*View structure for view customer_exchange_view */

/*!50001 DROP TABLE IF EXISTS `customer_exchange_view` */;
/*!50001 DROP VIEW IF EXISTS `customer_exchange_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customer_exchange_view` AS select `c`.`id` AS `id`,`c`.`customer_id` AS `customer_id`,`c`.`cust_status` AS `cust_status`,`c`.`source_type` AS `source_type`,`c`.`is_book` AS `is_book`,`c`.`user_id` AS `user_id`,`c`.`content` AS `content`,`c`.`customer_attach_id` AS `customer_attach_id`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`c`.`book_time` AS `book_time`,`i`.`name` AS `name`,`i`.`sex` AS `sex`,`i`.`school` AS `school`,`i`.`classes` AS `classes`,`i`.`brithday` AS `brithday`,`i`.`age` AS `age`,`i`.`student_type` AS `student_type`,`i`.`resident_type` AS `resident_type`,`i`.`parent_name` AS `parent_name`,`i`.`phone` AS `phone`,`i`.`addr` AS `addr` from (`customer_exchange` `c` left join `customer_info` `i` on((`c`.`customer_id` = `i`.`id`))) */;

/*View structure for view order_course_view */

/*!50001 DROP TABLE IF EXISTS `order_course_view` */;
/*!50001 DROP VIEW IF EXISTS `order_course_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_course_view` AS select `c`.`id` AS `id`,`c`.`order_id` AS `order_id`,`c`.`course_type` AS `course_type`,`c`.`charger_id` AS `charger_id`,`c`.`status` AS `status`,`c`.`order_attach_id` AS `order_attach_id`,`c`.`hour` AS `hour`,`c`.`cost_hour` AS `cost_hour`,`c`.`schedule_hour` AS `schedule_hour`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`o`.`student_id` AS `student_id`,`s`.`param_name` AS `course_name`,`u`.`user_name` AS `charger_name`,`d`.`name` AS `student_name`,`o`.`run_status` AS `order_run_status` from ((((`order_course` `c` join `order_info` `o` on((`c`.`order_id` = `o`.`id`))) join `sys_param` `s` on(((`s`.`root_code` = 'ORDER_COURSE') and (`s`.`param_value` = `c`.`course_type`)))) left join `sys_user` `u` on((`c`.`charger_id` = `u`.`id`))) join `student_info` `d` on((`d`.`id` = `o`.`student_id`))) */;

/*View structure for view order_info_daily */

/*!50001 DROP TABLE IF EXISTS `order_info_daily` */;
/*!50001 DROP VIEW IF EXISTS `order_info_daily` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_info_daily` AS select date_format(`order_info`.`create_time`,'%Y-%m-%d') AS `create_date`,count(0) AS `total` from `order_info` group by date_format(`order_info`.`create_time`,'%Y-%m-%d') */;

/*View structure for view order_info_monthly */

/*!50001 DROP TABLE IF EXISTS `order_info_monthly` */;
/*!50001 DROP VIEW IF EXISTS `order_info_monthly` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_info_monthly` AS select date_format(`order_info`.`create_time`,'%Y-%m') AS `month`,count(0) AS `total` from `order_info` group by date_format(`order_info`.`create_time`,'%Y-%m') */;

/*View structure for view order_info_view */

/*!50001 DROP TABLE IF EXISTS `order_info_view` */;
/*!50001 DROP VIEW IF EXISTS `order_info_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_info_view` AS select `o`.`id` AS `id`,`o`.`order_no` AS `order_no`,`o`.`student_id` AS `student_id`,`o`.`fee` AS `fee`,`o`.`order_type` AS `order_type`,`o`.`status` AS `status`,`o`.`des` AS `des`,`o`.`flow_ins_id` AS `flow_ins_id`,`o`.`start_time` AS `start_time`,`o`.`end_time` AS `end_time`,`o`.`grade` AS `grade`,`o`.`course_hour` AS `course_hour`,`o`.`adjust_hour` AS `adjust_hour`,`o`.`cost_course_hour` AS `cost_course_hour`,`o`.`schedule_hour` AS `schedule_hour`,`o`.`run_status` AS `run_status`,`o`.`parent_order_id` AS `parent_order_id`,`o`.`cur_operator` AS `cur_operator`,`o`.`is_last` AS `is_last`,`o`.`iseff` AS `iseff`,`o`.`create_time` AS `create_time`,`o`.`last_update` AS `last_update`,`s`.`area_id` AS `area_id`,`s`.`name` AS `student_name`,`s`.`age` AS `student_age` from (`order_info` `o` join `student_info` `s` on((`o`.`student_id` = `s`.`id`))) */;

/*View structure for view teacher_info */

/*!50001 DROP TABLE IF EXISTS `teacher_info` */;
/*!50001 DROP VIEW IF EXISTS `teacher_info` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_info` AS select `a`.`id` AS `id`,`a`.`user_name` AS `user_name`,`a`.`dep_id` AS `dep_id`,`a`.`area_id` AS `area_id`,`a`.`password` AS `password`,`a`.`sex` AS `sex`,`a`.`position` AS `position`,`a`.`phone` AS `phone`,`a`.`addr` AS `addr`,`a`.`zipcode` AS `zipcode`,`a`.`iseff` AS `iseff`,`a`.`create_time` AS `create_time`,`a`.`last_update` AS `last_update`,`a`.`role_id` AS `role_id`,`a`.`email` AS `email`,`b`.`course_type` AS `course_type`,`b`.`grade_type` AS `grade_type`,`b`.`teacher_type` AS `teacher_type` from (`sys_user` `a` join `teacher_ability` `b`) where (`a`.`id` = `b`.`user_id`) */;

/*View structure for view teacher_ref_student */

/*!50001 DROP TABLE IF EXISTS `teacher_ref_student` */;
/*!50001 DROP VIEW IF EXISTS `teacher_ref_student` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_ref_student` AS select crc32(concat(`c`.`charger_id`,`i`.`student_id`,`c`.`course_type`)) AS `id`,`i`.`id` AS `order_id`,`c`.`charger_id` AS `teacher_id`,`i`.`student_id` AS `student_id`,`c`.`course_type` AS `course_type`,`i`.`run_status` AS `run_status`,`s`.`name` AS `name`,`s`.`grade` AS `grade`,`s`.`sex` AS `sex`,`s`.`age` AS `age`,`s`.`area_id` AS `area_id` from ((`order_course` `c` left join `order_info` `i` on((`i`.`id` = `c`.`order_id`))) left join `student_info` `s` on((`i`.`student_id` = `s`.`id`))) where ((`c`.`charger_id` is not null) and (`i`.`student_id` is not null)) group by `c`.`charger_id`,`i`.`student_id`,`c`.`course_type` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;