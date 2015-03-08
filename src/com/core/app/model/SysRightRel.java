package com.core.app.model;

import java.sql.Timestamp;

/**
 * SysRightRel entity. @author MyEclipse Persistence Tools
 */

public class SysRightRel implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer relRight;
	private String type;
	private String relId;
	private Integer targetId;
	private Timestamp createTime;
	private Timestamp lastUpdate;

	// Constructors

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRelId() {
		return this.relId;
	}

	public void setRelId(String relId) {
		this.relId = relId;
	}

	public Integer getRelRight() {
		return relRight;
	}

	public void setRelRight(Integer relRight) {
		this.relRight = relRight;
	}

	public Integer getTargetId() {
		return targetId;
	}

	public void setTargetId(Integer targetId) {
		this.targetId = targetId;
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

}