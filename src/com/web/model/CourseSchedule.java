package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * CourseSchedule entity. @author MyEclipse Persistence Tools
 */

public class CourseSchedule implements java.io.Serializable {

	private Integer id;
	private Integer teacherId;
	private Integer studentId;
	private String courseType;
	private Date startDate;
	private Date endDate;
	private String weekDays;
	private Integer totalCourseHour;
	private Integer totalCostHour;
	private Integer startTime;
	private Integer endTime;
	private Integer isFinish;
	private String iseff;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private String status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getTotalCostHour() {
		return totalCostHour;
	}

	public void setTotalCostHour(Integer totalCostHour) {
		this.totalCostHour = totalCostHour;
	}

	public Integer getTotalCourseHour() {
		return totalCourseHour;
	}

	public void setTotalCourseHour(Integer totalCourseHour) {
		this.totalCourseHour = totalCourseHour;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public String getCourseType() {
		return courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getWeekDays() {
		return weekDays;
	}

	public void setWeekDays(String weekDays) {
		this.weekDays = weekDays;
	}

	public Integer getStartTime() {
		return startTime;
	}

	public void setStartTime(Integer startTime) {
		this.startTime = startTime;
	}

	public Integer getEndTime() {
		return endTime;
	}

	public void setEndTime(Integer endTime) {
		this.endTime = endTime;
	}

	public Integer getIsFinish() {
		return isFinish;
	}

	public void setIsFinish(Integer isFinish) {
		this.isFinish = isFinish;
	}

	public String getIseff() {
		return iseff;
	}

	public void setIseff(String iseff) {
		this.iseff = iseff;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

}