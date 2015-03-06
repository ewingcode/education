package com.web.model;

/**
 * OrderRole entity. @author MyEclipse Persistence Tools
 */

public class OrderRole implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer charger;
	private Integer roleId;

	// Constructors

	/** default constructor */
	public OrderRole() {
	}

	/** full constructor */
	public OrderRole(Integer charger, Integer roleId) {
		this.charger = charger;
		this.roleId = roleId;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCharger() {
		return this.charger;
	}

	public void setCharger(Integer charger) {
		this.charger = charger;
	}

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

}