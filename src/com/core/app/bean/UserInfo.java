package com.core.app.bean;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class UserInfo {
	private Integer id;
	private String userName;
	private Integer depId;
	private Integer roleId;
	private Integer areaId;
	private Set<Integer> relAreas = new HashSet<Integer>();
	private String password;
	private String sex;
	private String position;
	private String phone;
	private String addr;
	private String zipcode;
	private Set<Integer> relMenus = new HashSet<Integer>();

	public Set<Integer> getRelAreas() {
		return relAreas;
	}

	public void setRelAreas(Set<Integer> relAreas) {
		this.relAreas = relAreas;
	}

	public Set<Integer> getRelMenus() {
		return relMenus;
	}

	public void setRelMenus(Set<Integer> relMenus) {
		this.relMenus = relMenus;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getDepId() {
		return depId;
	}

	public void setDepId(Integer depId) {
		this.depId = depId;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public Integer getAreaId() {
		return areaId;
	}

	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}
}
