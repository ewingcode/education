package com.web.model;

import java.sql.Timestamp;

/**
 * OrderRelHis entity. @author MyEclipse Persistence Tools
 */

public class OrderRelHis implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private String taskName;
	private String chargerType;
	private Integer operator;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer taskId;

	// Constructors

	/** default constructor */
	public OrderRelHis() {
	}

	/** minimal constructor */
	public OrderRelHis(Integer orderId, Timestamp createTime,
			Timestamp lastUpdate, Integer taskId) {
		this.orderId = orderId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.taskId = taskId;
	}

	/** full constructor */
	public OrderRelHis(Integer orderId, String taskName, String chargerType,
			Integer operator, Timestamp createTime, Timestamp lastUpdate,
			Integer taskId) {
		this.orderId = orderId;
		this.taskName = taskName;
		this.chargerType = chargerType;
		this.operator = operator;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.taskId = taskId;
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

	public String getTaskName() {
		return this.taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getChargerType() {
		return this.chargerType;
	}

	public void setChargerType(String chargerType) {
		this.chargerType = chargerType;
	}

	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
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

	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

}