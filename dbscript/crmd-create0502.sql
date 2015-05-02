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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='排课计划';

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
) ENGINE=InnoDB AUTO_INCREMENT=314 DEFAULT CHARSET=utf8 COMMENT='排课明细';

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='回访客户交流表';

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='客户信息表';

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

/*Table structure for table `jbpm4_deployment` */

DROP TABLE IF EXISTS `jbpm4_deployment`;

CREATE TABLE `jbpm4_deployment` (
  `DBID_` bigint(20) NOT NULL,
  `NAME_` longtext,
  `TIMESTAMP_` bigint(20) DEFAULT NULL,
  `STATE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`DBID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

/*Table structure for table `jbpm4_property` */

DROP TABLE IF EXISTS `jbpm4_property`;

CREATE TABLE `jbpm4_property` (
  `KEY_` varchar(255) NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `VALUE_` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8 COMMENT='公告表';

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
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8 COMMENT='公告表历史表';

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
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='签单课程信息';

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
  `desc` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='课时消耗记录';

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='签单课程负责人日志记录表';

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='签单表';

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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='签单参与者历史表';

/*Table structure for table `order_role` */

DROP TABLE IF EXISTS `order_role`;

CREATE TABLE `order_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `charger` int(10) NOT NULL COMMENT '1:销售 2: 销售主管 3:教务部主管 4:班主任 5:授课老师',
  `role_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='签单负责人配置';

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
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8 COMMENT='签单流程跟踪表';

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='学生交流表';

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='学生信息表';

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

/*Table structure for table `sys_log_trace` */

DROP TABLE IF EXISTS `sys_log_trace`;

CREATE TABLE `sys_log_trace` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `module_name` varchar(200) NOT NULL DEFAULT '' COMMENT '模块名称',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1365 DEFAULT CHARSET=utf8 COMMENT='系统跟踪表';

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
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=1901 DEFAULT CHARSET=utf8 COMMENT='权限菜单关联';

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

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
 `student_name` varchar(50) 
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

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `order_course_view` AS select `c`.`id` AS `id`,`c`.`order_id` AS `order_id`,`c`.`course_type` AS `course_type`,`c`.`charger_id` AS `charger_id`,`c`.`status` AS `status`,`c`.`order_attach_id` AS `order_attach_id`,`c`.`hour` AS `hour`,`c`.`cost_hour` AS `cost_hour`,`c`.`schedule_hour` AS `schedule_hour`,`c`.`create_time` AS `create_time`,`c`.`last_update` AS `last_update`,`o`.`student_id` AS `student_id`,`s`.`param_name` AS `course_name`,`u`.`user_name` AS `charger_name`,`d`.`name` AS `student_name` from ((((`order_course` `c` join `order_info` `o` on(((`c`.`order_id` = `o`.`id`) and (`o`.`run_status` <> 0)))) join `sys_param` `s` on(((`s`.`root_code` = 'ORDER_COURSE') and (`s`.`param_value` = `c`.`course_type`)))) join `sys_user` `u` on((`c`.`charger_id` = `u`.`id`))) join `student_info` `d` on((`d`.`id` = `o`.`student_id`))) */;

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

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teacher_ref_student` AS select crc32(concat(`c`.`charger_id`,`i`.`student_id`,`c`.`course_type`)) AS `id`,`c`.`charger_id` AS `teacher_id`,`i`.`student_id` AS `student_id`,`c`.`course_type` AS `course_type`,`i`.`run_status` AS `run_status`,`s`.`name` AS `name`,`s`.`grade` AS `grade`,`s`.`sex` AS `sex`,`s`.`age` AS `age`,`s`.`area_id` AS `area_id` from ((`order_course` `c` left join `order_info` `i` on((`i`.`id` = `c`.`order_id`))) left join `student_info` `s` on((`i`.`student_id` = `s`.`id`))) where ((`c`.`charger_id` is not null) and (`i`.`student_id` is not null)) group by `c`.`charger_id`,`i`.`student_id`,`c`.`course_type` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
