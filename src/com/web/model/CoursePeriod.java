package com.web.model;

import java.sql.Timestamp;

/**
 * CoursePeriod entity. @author MyEclipse Persistence Tools
 */

public class CoursePeriod implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer startTime;
	private Integer endTime;
	private Timestamp createTime;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}