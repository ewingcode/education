package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * OrderCourseHour entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseHour implements java.io.Serializable {

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
	private String msg;
	private Integer payHour;
	// Constructors

	public Integer getPayHour() {
		return payHour;
	}

	public void setPayHour(Integer payHour) {
		this.payHour = payHour;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
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
	public OrderCourseHour() {
	}

	/** minimal constructor */
	public OrderCourseHour(Timestamp createTime, Timestamp lastUpdate,
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