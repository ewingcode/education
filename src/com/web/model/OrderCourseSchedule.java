package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * OrderCourseSchedule entity. @author MyEclipse Persistence Tools
 */

public class OrderCourseSchedule implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private Integer userId;
	private Integer studentId;
	private Date startDate;
	private Date endDate;
	private Integer coursePeriodId;
	private String courseType;
	private String status;
	private Timestamp createTime;

	// Constructors

	/** default constructor */
	public OrderCourseSchedule() {
	}

	/** full constructor */
	public OrderCourseSchedule(Integer orderId, Integer userId,
			Integer studentId, Date startDate, Date endDate,
			Integer coursePeriodId, String courseType, String status,
			Timestamp createTime) {
		this.orderId = orderId;
		this.userId = userId;
		this.studentId = studentId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.coursePeriodId = coursePeriodId;
		this.courseType = courseType;
		this.status = status;
		this.createTime = createTime;
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

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStudentId() {
		return this.studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return this.endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getCoursePeriodId() {
		return this.coursePeriodId;
	}

	public void setCoursePeriodId(Integer coursePeriodId) {
		this.coursePeriodId = coursePeriodId;
	}

	public String getCourseType() {
		return this.courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}