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
WHERE (`a`.`id` = `b`.`user_id`)