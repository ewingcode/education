package com.web.model;

import java.sql.Timestamp;

/**
 * CoursePeriod entity. @author MyEclipse Persistence Tools
 */

public class CoursePeriod implements java.io.Serializable {

	// Fields

	private Integer id;
	private String startTime;
	private String endTime;
	private Timestamp createTime;

	// Constructors

	/** default constructor */
	public CoursePeriod() {
	}

	/** full constructor */
	public CoursePeriod(String startTime, String endTime, Timestamp createTime) {
		this.startTime = startTime;
		this.endTime = endTime;
		this.createTime = createTime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStartTime() {
		return this.startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return this.endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}