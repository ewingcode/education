package com.web.bean;

import java.sql.Timestamp;

/**
 * CoursePeriod entity. @author MyEclipse Persistence Tools
 */

public class CoursePeriodDto implements java.io.Serializable {

	// Fields

	private Integer id;
	private String startTime;
	private String endTime;
	private Timestamp createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}