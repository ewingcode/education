package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * CustomerExchange entity. @author MyEclipse Persistence Tools
 */

public class CustomerExchange implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer customerId;
	private String custStatus;
	private String sourceType;
	private String isBook;
	private Integer userId;
	private String content;
	private String customerAttachId;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private Timestamp bookTime;

	// Constructors

	/** default constructor */
	public CustomerExchange() {
	}

	/** minimal constructor */
	public CustomerExchange(Integer customerId, String custStatus,
			String sourceType, String isBook, Integer userId, String content,
			Timestamp createTime, Timestamp lastUpdate, Timestamp bookTime) {
		this.customerId = customerId;
		this.custStatus = custStatus;
		this.sourceType = sourceType;
		this.isBook = isBook;
		this.userId = userId;
		this.content = content;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.bookTime = bookTime;
	}

	/** full constructor */
	public CustomerExchange(Integer customerId, String custStatus,
			String sourceType, String isBook, Integer userId, String content,
			String customerAttachId, Timestamp createTime,
			Timestamp lastUpdate, Timestamp bookTime) {
		this.customerId = customerId;
		this.custStatus = custStatus;
		this.sourceType = sourceType;
		this.isBook = isBook;
		this.userId = userId;
		this.content = content;
		this.customerAttachId = customerAttachId;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.bookTime = bookTime;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCustomerId() {
		return this.customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getCustStatus() {
		return this.custStatus;
	}

	public void setCustStatus(String custStatus) {
		this.custStatus = custStatus;
	}

	public String getSourceType() {
		return this.sourceType;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	public String getIsBook() {
		return this.isBook;
	}

	public void setIsBook(String isBook) {
		this.isBook = isBook;
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

	public String getCustomerAttachId() {
		return this.customerAttachId;
	}

	public void setCustomerAttachId(String customerAttachId) {
		this.customerAttachId = customerAttachId;
	}

	public Timestamp getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
		this.setLastUpdate(new java.sql.Timestamp(new Date().getTime()));
	}

	public Timestamp getLastUpdate() {
		return this.lastUpdate;
	}

	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public Timestamp getBookTime() {
		return this.bookTime;
	}

	public void setBookTime(Timestamp bookTime) {
		this.bookTime = bookTime;
	}

}