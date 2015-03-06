package com.web.model;

import java.sql.Timestamp;

/**
 * OrderCourseHour entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseHour implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private Integer studentId;
	private Integer costHour;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer operator;
	private Timestamp teachTime;

	// Constructors

	/** default constructor */
	public OrderCourseHour() {
	}

	/** minimal constructor */
	public OrderCourseHour(Timestamp createTime, Timestamp lastUpdate,
			Timestamp teachTime) {
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.teachTime = teachTime;
	}

	/** full constructor */
	public OrderCourseHour(Integer orderId, Integer studentId,
			Integer costHour, Timestamp createTime, Timestamp lastUpdate,
			Integer operator, Timestamp teachTime) {
		this.orderId = orderId;
		this.studentId = studentId;
		this.costHour = costHour;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.operator = operator;
		this.teachTime = teachTime;
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

	public Integer getCostHour() {
		return this.costHour;
	}

	public void setCostHour(Integer costHour) {
		this.costHour = costHour;
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

	public Timestamp getTeachTime() {
		return this.teachTime;
	}

	public void setTeachTime(Timestamp teachTime) {
		this.teachTime = teachTime;
	}

}