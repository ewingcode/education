package com.web.model;

import java.sql.Timestamp;

/**
 * OrderCourseEvaluation entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseEvaluation implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
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

	/** minimal constructor */
	public OrderCourseEvaluation(Integer orderId, String courseType,
			Timestamp createTime, Timestamp lastUpdate, Timestamp courseTime) {
		this.orderId = orderId;
		this.courseType = courseType;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.courseTime = courseTime;
	}

	/** full constructor */
	public OrderCourseEvaluation(Integer orderId, Integer studentId,
			String courseType, Integer chargerId, String content,
			Integer orderAttachId, Timestamp createTime, Timestamp lastUpdate,
			Integer operator, Timestamp courseTime) {
		this.orderId = orderId;
		this.studentId = studentId;
		this.courseType = courseType;
		this.chargerId = chargerId;
		this.content = content;
		this.orderAttachId = orderAttachId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.operator = operator;
		this.courseTime = courseTime;
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