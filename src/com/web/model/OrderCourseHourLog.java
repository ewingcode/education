package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * OrderCourseHour entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseHourLog implements java.io.Serializable {

	// Fields

	private Integer id;
	private String courseType;
	private Integer studentId;
	private Integer costHour;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer operator;
	private Date teachTime;
	private Integer teacherId;
	private String status;
	private Integer scheduleId;
	private Integer orderId;
	private Integer orderCourseId;

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getOrderCourseId() {
		return orderCourseId;
	}

	public void setOrderCourseId(Integer orderCourseId) {
		this.orderCourseId = orderCourseId;
	}

	public Integer getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(Integer scheduleId) {
		this.scheduleId = scheduleId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	/** default constructor */
	public OrderCourseHourLog() {
	}

	/** minimal constructor */
	public OrderCourseHourLog(Timestamp createTime, Timestamp lastUpdate,
			Timestamp teachTime) {
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.teachTime = teachTime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCourseType() {
		return courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
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

	public Date getTeachTime() {
		return this.teachTime;
	}

	public void setTeachTime(Date teachTime) {
		this.teachTime = teachTime;
	}

}