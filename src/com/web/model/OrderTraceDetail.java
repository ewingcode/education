package com.web.model;

import java.sql.Timestamp;

/**
 * OrderTraceDetail entity. @author MyEclipse Persistence Tools
 */

public class OrderTraceDetail implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderAttachId;
	private String status;
	private String commet;
	private Timestamp createTime;

	// Constructors

	/** default constructor */
	public OrderTraceDetail() {
	}

	/** minimal constructor */
	public OrderTraceDetail(Integer orderAttachId, String commet,
			Timestamp createTime) {
		this.orderAttachId = orderAttachId;
		this.commet = commet;
		this.createTime = createTime;
	}

	/** full constructor */
	public OrderTraceDetail(Integer orderAttachId, String status,
			String commet, Timestamp createTime) {
		this.orderAttachId = orderAttachId;
		this.status = status;
		this.commet = commet;
		this.createTime = createTime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOrderAttachId() {
		return this.orderAttachId;
	}

	public void setOrderAttachId(Integer orderAttachId) {
		this.orderAttachId = orderAttachId;
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

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

}