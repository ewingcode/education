package com.web.model;

import java.sql.Timestamp;

import com.core.app.anno.IgnoreField;

/**
 * OrderInfo entity. @author MyEclipse Persistence Tools
 */

public class OrderInfoView implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer studentId;
	private String orderType;
	private String status;
	private Long fee;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private String des;
	private String orderNo;
	private String flowInsId;
	private Timestamp startTime;
	private Timestamp endTime;
	private String grade;
	private Integer courseHour;
	private String runStatus;
	private Integer parentOrderId;
	private Integer curOperator;
	private String isLast;
	private Integer costCourseHour;
	private Integer adjustHour;
	private String iseff;
	private Integer scheduleHour;
	private Integer areaId; 
	private String studentName;
	@IgnoreField
	private String feeFloat;

	public Integer getAreaId() {
		return areaId;
	}

	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}

	public Integer getAdjustHour() {
		return adjustHour;
	}

	public void setAdjustHour(Integer adjustHour) {
		this.adjustHour = adjustHour;
	}

	// Constructors

	public String getFeeFloat() {
		return feeFloat;
	}

	public void setFeeFloat(String feeFloat) {
		this.feeFloat = feeFloat;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public Integer getScheduleHour() {
		return scheduleHour;
	}

	public void setScheduleHour(Integer scheduleHour) {
		this.scheduleHour = scheduleHour;
	}

	/** default constructor */
	public OrderInfoView() {
	}

	public String getIseff() {
		return iseff;
	}

	public void setIseff(String iseff) {
		this.iseff = iseff;
	}

	/** minimal constructor */
	public OrderInfoView(Integer studentId, Timestamp createTime,
			Timestamp lastUpdate, Timestamp startTime, Timestamp endTime,
			String runStatus, String isLast) {
		this.studentId = studentId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.startTime = startTime;
		this.endTime = endTime;
		this.runStatus = runStatus;
		this.isLast = isLast;
	}

	/** full constructor */
	public OrderInfoView(Integer studentId, String orderType, String status,
			Timestamp createTime, Timestamp lastUpdate, String des,
			String orderNo, String flowInsId, Timestamp startTime,
			Timestamp endTime, String grade, Integer courseHour,
			String runStatus, Integer parentOrderId, Integer curOperator,
			String isLast, Integer costCourseHour) {
		this.studentId = studentId;
		this.orderType = orderType;
		this.status = status;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.des = des;
		this.orderNo = orderNo;
		this.flowInsId = flowInsId;
		this.startTime = startTime;
		this.endTime = endTime;
		this.grade = grade;
		this.courseHour = courseHour;
		this.runStatus = runStatus;
		this.parentOrderId = parentOrderId;
		this.curOperator = curOperator;
		this.isLast = isLast;
		this.costCourseHour = costCourseHour;
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

	public String getOrderType() {
		return this.orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
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

	public Timestamp getLastUpdate() {
		return this.lastUpdate;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getDes() {
		return this.des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public String getOrderNo() {
		return this.orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getFlowInsId() {
		return this.flowInsId;
	}

	public void setFlowInsId(String flowInsId) {
		this.flowInsId = flowInsId;
	}

	public Timestamp getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return this.endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	public String getGrade() {
		return this.grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public Integer getTotalCourseHour() {
		if (this.adjustHour != null)
			return this.courseHour - this.adjustHour;
		return this.courseHour;
	}

	public Integer getCourseHour() {
		return this.courseHour;
	}

	public void setCourseHour(Integer courseHour) {
		this.courseHour = courseHour;
	}

	public String getRunStatus() {
		return this.runStatus;
	}

	public void setRunStatus(String runStatus) {
		this.runStatus = runStatus;
	}

	public Integer getParentOrderId() {
		return this.parentOrderId;
	}

	public void setParentOrderId(Integer parentOrderId) {
		this.parentOrderId = parentOrderId;
	}

	public Integer getCurOperator() {
		return this.curOperator;
	}

	public void setCurOperator(Integer curOperator) {
		this.curOperator = curOperator;
	}

	public String getIsLast() {
		return this.isLast;
	}

	public void setIsLast(String isLast) {
		this.isLast = isLast;
	}

	public Integer getCostCourseHour() {
		return this.costCourseHour;
	}

	public void setCostCourseHour(Integer costCourseHour) {
		this.costCourseHour = costCourseHour;
	}

	public Long getFee() {
		return fee;
	}

	public void setFee(Long fee) {
		this.fee = fee;
	}

}