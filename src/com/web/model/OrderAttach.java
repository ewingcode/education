package com.web.model;

import java.sql.Timestamp;

/**
 * OrderAttach entity. @author MyEclipse Persistence Tools
 */

public class OrderAttach implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private String name;
	private String type;
	private String path;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private String status;
	private String commet;
	private String swfpath;

	// Constructors

	/** default constructor */
	public OrderAttach() {
	}

	/** minimal constructor */
	public OrderAttach(Integer orderId, String name, String path,
			Timestamp createTime, Timestamp lastUpdate, String status,
			String swfpath) {
		this.orderId = orderId;
		this.name = name;
		this.path = path;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.status = status;
		this.swfpath = swfpath;
	}

	/** full constructor */
	public OrderAttach(Integer orderId, String name, String type, String path,
			Timestamp createTime, Timestamp lastUpdate, String status,
			String commet, String swfpath) {
		this.orderId = orderId;
		this.name = name;
		this.type = type;
		this.path = path;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.status = status;
		this.commet = commet;
		this.swfpath = swfpath;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderId() {
		return this.orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
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

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCommet() {
		return this.commet;
	}

	public void setCommet(String commet) {
		this.commet = commet;
	}

	public String getSwfpath() {
		return this.swfpath;
	}

	public void setSwfpath(String swfpath) {
		this.swfpath = swfpath;
	}

}