package com.web.model;

import java.sql.Timestamp;

/**
 * OrderCourseLog entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private String courseType;
	private Integer chargerId;
	private Timestamp createTime;
	private String status;

	// Constructors

	/** default constructor */
	public OrderCourseLog() {
	}

	/** minimal constructor */
	public OrderCourseLog(Integer orderId, String courseType,
			Timestamp createTime, String status) {
		this.orderId = orderId;
		this.courseType = courseType;
		this.createTime = createTime;
		this.status = status;
	}

	/** full constructor */
	public OrderCourseLog(Integer orderId, String courseType,
			Integer chargerId, Timestamp createTime, String status) {
		this.orderId = orderId;
		this.courseType = courseType;
		this.chargerId = chargerId;
		this.createTime = createTime;
		this.status = status;
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

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}