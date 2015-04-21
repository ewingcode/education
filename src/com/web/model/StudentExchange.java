package com.web.model;

import java.sql.Timestamp;

/**
 * StudentExchange entity. @author MyEclipse Persistence Tools
 */

public class StudentExchange implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer operator;
	private String content;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer studentId;

	/** default constructor */
	public StudentExchange() {
	}

	public String getContent() {
		return content;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public Integer getId() {
		return id;
	}

	public Timestamp getLastUpdate() {
		return lastUpdate;
	}

	public Integer getOperator() {
		return operator;
	}

	public Integer getStudentId() {
		return studentId;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	// Constructors

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

}