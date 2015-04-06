package com.web.model;

import java.sql.Timestamp;

/**
 * OrderTrace entity. @author MyEclipse Persistence Tools
 */

public class OrderTrace implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer orderId;
	private String taskName;
	private Integer roleId;
	private Integer userId;
	private Integer operator;
	private String oper;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Integer operSort;
	private Integer taskId;
	private String transition;
	// Constructors

	public String getTransition() {
		return transition;
	}

	public void setTransition(String transition) {
		this.transition = transition;
	}

	/** default constructor */
	public OrderTrace() {
	}

	/** minimal constructor */
	public OrderTrace(Integer orderId, Timestamp createTime,
			Timestamp lastUpdate, Integer taskId) {
		this.orderId = orderId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.taskId = taskId;
	}

	/** full constructor */
	public OrderTrace(Integer orderId, String taskName, Integer roleId,
			Integer userId, Integer operator, String oper,
			Timestamp createTime, Timestamp lastUpdate, Integer operSort,
			Integer taskId) {
		this.orderId = orderId;
		this.taskName = taskName;
		this.roleId = roleId;
		this.userId = userId;
		this.operator = operator;
		this.oper = oper;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.operSort = operSort;
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

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getOperator() {
		return this.operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	public String getOper() {
		return this.oper;
	}

	public void setOper(String oper) {
		this.oper = oper;
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

	public Integer getOperSort() {
		return this.operSort;
	}

	public void setOperSort(Integer operSort) {
		this.operSort = operSort;
	}

	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

}