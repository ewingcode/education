package com.web.model;

import java.sql.Timestamp;

/**
 * TeacherAbility entity. @author MyEclipse Persistence Tools
 */

public class TeacherAbility implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private String courseType;
	private Timestamp createTime;
	private String gradeType;

	// Constructors

	/** default constructor */
	public TeacherAbility() {
	}

	/** full constructor */
	public TeacherAbility(Integer userId, String courseType,
			Timestamp createTime, String gradeType) {
		this.userId = userId;
		this.courseType = courseType;
		this.createTime = createTime;
		this.gradeType = gradeType;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCourseType() {
		return this.courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public String getGradeType() {
		return this.gradeType;
	}

	public void setGradeType(String gradeType) {
		this.gradeType = gradeType;
	}

}