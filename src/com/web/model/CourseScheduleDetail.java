package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

import com.core.app.anno.IgnoreField;

/**
 * CourseSchedule entity. @author MyEclipse Persistence Tools
 */

public class CourseScheduleDetail implements java.io.Serializable {

	private Integer id;
	private Integer scheduleId;
	private Integer orderCourseId;
	private Integer orderId;
	private Integer teacherId;
	private Integer studentId;
	private String courseType;
	private Date date;
	private Integer startTime;
	private Integer endTime;
	private Integer isFinish;
	private String iseff;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	@IgnoreField
	private String desc;
	@IgnoreField
	private Long totalScheduleHour;
	@IgnoreField
	private Long totalCostScheduleHour;

	public Long getTotalCostScheduleHour() {
		return totalCostScheduleHour;
	}

	public void setTotalCostScheduleHour(Long totalCostScheduleHour) {
		this.totalCostScheduleHour = totalCostScheduleHour;
	}

	public Long getTotalScheduleHour() {
		return totalScheduleHour;
	}

	public void setTotalScheduleHour(Long totalScheduleHour) {
		this.totalScheduleHour = totalScheduleHour;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

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

	public Integer getIsFinish() {
		return isFinish;
	}

	public void setIsFinish(Integer isFinish) {
		this.isFinish = isFinish;
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

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getIseff() {
		return iseff;
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

	public Integer getScheduleId() {
		return scheduleId;
	}

	public void setScheduleId(Integer scheduleId) {
		this.scheduleId = scheduleId;
	}

	@Override
	public String toString() {
		return "CourseScheduleDetail [id=" + id + ", scheduleId=" + scheduleId
				+ ", orderCourseId=" + orderCourseId + ", orderId=" + orderId
				+ ", teacherId=" + teacherId + ", studentId=" + studentId
				+ ", courseType=" + courseType + ", date=" + date
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", isFinish=" + isFinish + ", iseff=" + iseff + ", desc="
				+ desc + "]";
	}
}