DROP TABLE IF EXISTS sys_area;
CREATE TABLE `sys_area` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `parentid` INT(10) DEFAULT 0 COMMENT '上一层的区域',
  `iseff` CHAR(1) NOT NULL DEFAULT '0',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT '区域' ;



ALTER TABLE sys_right_rel ADD `rel_right` INT(1) NOT NULL DEFAULT 0 COMMENT '关系类型 0:菜单 1：区域' ;

ALTER TABLE sys_right_rel CHANGE `menu_id` `target_id` INT(10) UNSIGNED DEFAULT NULL COMMENT '对象ID';


ALTER TABLE sys_user ADD `area_id` INT(11) NOT NULL  COMMENT '区域id' ;

ALTER TABLE student_info ADD `area_id` INT(11) NOT NULL  COMMENT '区域id' ;


DROP VIEW IF EXISTS teacher_info;
CREATE  VIEW `teacher_info` AS 
SELECT 
  `a`.`id` AS `id`,
  `a`.`user_name` AS `user_name`,
  `a`.`dep_id` AS `dep_id`,
  `a`.`area_id` AS `area_id`,
  `a`.`password` AS `password`,
  `a`.`sex` AS `sex`,
  `a`.`position` AS `position`,
  `a`.`phone` AS `phone`,
  `a`.`addr` AS `addr`,
  `a`.`zipcode` AS `zipcode`,
  `a`.`iseff` AS `iseff`,
  `a`.`create_time` AS `create_time`,
  `a`.`last_update` AS `last_update`,
  `a`.`role_id` AS `role_id`,
  `a`.`email` AS `email`,
  `b`.`course_type` AS `course_type`,
  `b`.`grade_type` AS `grade_type` 
FROM
  (
    `sys_user` `a` 
    JOIN `teacher_ability` `b`
  ) 
WHERE (`a`.`id` = `b`.`user_id`);

ALTER TABLE order_course CHANGE `course_type` `course_type` CHAR(2) NOT NULL   COMMENT '课程类型';
ALTER TABLE order_course_evaluation CHANGE `course_type` `course_type` CHAR(2) NOT NULL   COMMENT '课程类型';
ALTER TABLE order_course_score CHANGE `course_type` `course_type` CHAR(2) NOT NULL   COMMENT '课程类型'; 


DROP TABLE IF EXISTS course_schedule;
CREATE TABLE `course_schedule` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `teacher_id` INT(10) UNSIGNED DEFAULT NULL,
  `student_id` INT(10) UNSIGNED DEFAULT NULL, 
  `course_type` CHAR(2) NOT NULL  COMMENT '课程类型',
  `date`  DATE   NOT NULL COMMENT '日期', 
  `start_time` INT(4)   NOT NULL COMMENT '课程开始时间段',
  `end_time` INT(4)   NOT NULL COMMENT '课程开始时间段',  
  `iseff` CHAR(1) DEFAULT '0',
  `create_time` TIMESTAMP NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00', 
  PRIMARY KEY (`id`)
) ENGINE=INNODB   DEFAULT CHARSET=utf8 COMMENT '排课';

DROP TABLE IF EXISTS course_period;
CREATE TABLE `course_period` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `start_time` INT(4) NOT NULL,
  `end_time` INT(4) NOT NULL, 
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 
  PRIMARY KEY (`id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8 COMMENT '排课时间设置';


DROP VIEW IF EXISTS course_schedule_view;
CREATE  VIEW course_schedule_view AS 
SELECT c.*,p.param_name AS course_name,s.name AS student_name FROM course_schedule c , sys_param p,student_info s WHERE  p.root_code='ORDER_COURSE' AND p.param_value=c.`course_type` AND s.id = c.`student_id`;
