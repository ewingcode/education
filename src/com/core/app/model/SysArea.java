package com.core.app.model;

import java.sql.Timestamp;

/**
 * SysArea entity. @author MyEclipse Persistence Tools
 */

public class SysArea implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private Integer parentid;
	private String des;
	private String iseff;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	/** default constructor */
	public SysArea() {
	}
	/** minimal constructor */
	public SysArea(String name, String iseff, Timestamp createTime,
			Timestamp lastUpdate) {
		this.name = name;
		this.iseff = iseff;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
	}

	// Constructors

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public String getDes() {
		return this.des;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public String getIseff() {
		return this.iseff;
	}

	public Timestamp getLastUpdate() {
		return this.lastUpdate;
	}

	public String getName() {
		return this.name;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setIseff(String iseff) {
		this.iseff = iseff;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

}