package com.web.model;

import java.sql.Timestamp;

/**
 * NoticeHis entity. @author MyEclipse Persistence Tools
 */

public class NoticeHis implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer senderId;
	private String receiverType;
	private String receiverId;
	private String content;
	private Timestamp createTime;
	private Timestamp lastUpdate;

	// Constructors

	/** default constructor */
	public NoticeHis() {
	}

	/** full constructor */
	public NoticeHis(Integer senderId, String receiverType, String receiverId,
			String content, Timestamp createTime, Timestamp lastUpdate) {
		this.senderId = senderId;
		this.receiverType = receiverType;
		this.receiverId = receiverId;
		this.content = content;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSenderId() {
		return this.senderId;
	}

	public void setSenderId(Integer senderId) {
		this.senderId = senderId;
	}

	public String getReceiverType() {
		return this.receiverType;
	}

	public void setReceiverType(String receiverType) {
		this.receiverType = receiverType;
	}

	public String getReceiverId() {
		return this.receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
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