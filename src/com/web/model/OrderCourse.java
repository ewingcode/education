package com.web.model;

import java.sql.Timestamp;

import com.core.app.anno.IgnoreField;

/**
 * OrderCourse entity. @author MyEclipse Persistence Tools
 */

public class OrderCourse implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private String courseType;
	private Integer chargerId;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private String status;
	private Integer hour;
	private Integer costHour;
	private Integer scheduleHour;
	@IgnoreField
	private String chargerName; 

	public String getChargerName() {
		return chargerName;
	}

	public void setChargerName(String chargerName) {
		this.chargerName = chargerName;
	}

	public Integer getScheduleHour() {
		return scheduleHour;
	}

	public void setScheduleHour(Integer scheduleHour) {
		this.scheduleHour = scheduleHour;
	}

	public OrderCourse() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getCourseType() {
		return courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}

	public Integer getChargerId() {
		return chargerId;
	}

	public void setChargerId(Integer chargerId) {
		this.chargerId = chargerId;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Integer getCostHour() {
		return costHour;
	}

	public void setCostHour(Integer costHour) {
		this.costHour = costHour;
	}

	public Timestamp getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getHour() {
		return hour;
	}

	public void setHour(Integer hour) {
		this.hour = hour;
	}

	public OrderCourse(Integer id, Integer orderId, String courseType,
			Integer chargerId, Timestamp createTime, Timestamp lastUpdate,
			String status, Integer hour, Integer costHour) {
		super();
		this.id = id;
		this.orderId = orderId;
		this.courseType = courseType;
		this.chargerId = chargerId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.status = status;
		this.hour = hour;
		this.costHour = costHour;
	}

}