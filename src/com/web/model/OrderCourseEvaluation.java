package com.web.model;

import java.sql.Timestamp;

/**
 * OrderCourseEvaluation entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseEvaluation implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer studentId;
	private String courseType;
	private Integer chargerId;
	private String content;
	private Integer orderAttachId;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer operator;
	private Timestamp courseTime;

	// Constructors

	/** default constructor */
	public OrderCourseEvaluation() {
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStudentId() {
		return this.studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
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

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getOrderAttachId() {
		return this.orderAttachId;
	}

	public void setOrderAttachId(Integer orderAttachId) {
		this.orderAttachId = orderAttachId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
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

	public Timestamp getCourseTime() {
		return this.courseTime;
	}

	public void setCourseTime(Timestamp courseTime) {
		this.courseTime = courseTime;
	}

}