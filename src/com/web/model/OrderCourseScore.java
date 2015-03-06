package com.web.model;

import java.sql.Timestamp;

/**
 * OrderCourseScore entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseScore implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private String courseType;
	private Integer chargerId;
	private Timestamp createTime;
	private Integer studentId;
	private Integer score;
	private Timestamp examTime;
	private Timestamp lastUpdate;
	private Integer operator;

	// Constructors

	/** default constructor */
	public OrderCourseScore() {
	}

	/** minimal constructor */
	public OrderCourseScore(Integer orderId, String courseType,
			Timestamp createTime, Timestamp examTime, Timestamp lastUpdate) {
		this.orderId = orderId;
		this.courseType = courseType;
		this.createTime = createTime;
		this.examTime = examTime;
		this.lastUpdate = lastUpdate;
	}

	/** full constructor */
	public OrderCourseScore(Integer orderId, String courseType,
			Integer chargerId, Timestamp createTime, Integer studentId,
			Integer score, Timestamp examTime, Timestamp lastUpdate,
			Integer operator) {
		this.orderId = orderId;
		this.courseType = courseType;
		this.chargerId = chargerId;
		this.createTime = createTime;
		this.studentId = studentId;
		this.score = score;
		this.examTime = examTime;
		this.lastUpdate = lastUpdate;
		this.operator = operator;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getCourseType() {
		return this.courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public Integer getChargerId() {
		return this.chargerId;
	}

	public void setChargerId(Integer chargerId) {
		this.chargerId = chargerId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Integer getStudentId() {
		return this.studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public Integer getScore() {
		return this.score;
	}

	public void setScore(Integer score) {
		this.score = score;
	}

	public Timestamp getExamTime() {
		return this.examTime;
	}

	public void setExamTime(Timestamp examTime) {
		this.examTime = examTime;
	}

	public Timestamp getLastUpdate() {
		return this.lastUpdate;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

}