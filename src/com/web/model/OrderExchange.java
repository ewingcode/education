package com.web.model;

import java.sql.Timestamp;

/**
 * OrderExchange entity. @author MyEclipse Persistence Tools
 */

public class OrderExchange implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private Integer userId;
	private String content;
	private Integer orderAttachId;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer studentId;

	// Constructors

	/** default constructor */
	public OrderExchange() {
	}

	/** minimal constructor */
	public OrderExchange(Integer orderId, Integer userId, String content,
			Timestamp createTime, Timestamp lastUpdate) {
		this.orderId = orderId;
		this.userId = userId;
		this.content = content;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
	}

	/** full constructor */
	public OrderExchange(Integer orderId, Integer userId, String content,
			Integer orderAttachId, Timestamp createTime, Timestamp lastUpdate,
			Integer studentId) {
		this.orderId = orderId;
		this.userId = userId;
		this.content = content;
		this.orderAttachId = orderAttachId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.studentId = studentId;
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

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getOrderAttachId() {
		return this.orderAttachId;
	}

	public void setOrderAttachId(Integer orderAttachId) {
		this.orderAttachId = orderAttachId;
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

	public Integer getStudentId() {
		return this.studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

}