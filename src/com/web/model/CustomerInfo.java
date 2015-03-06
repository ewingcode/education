package com.web.model;

import java.sql.Timestamp;

/**
 * CustomerInfo entity. @author MyEclipse Persistence Tools
 */

public class CustomerInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String sex;
	private String school;
	private String classes;
	private String brithday;
	private String age;
	private String studentType;
	private String residentType;
	private String parentName;
	private String phone;
	private String addr;
	private String iseff;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private String email;
	private String class_;

	// Constructors

	/** default constructor */
	public CustomerInfo() {
	}

	/** minimal constructor */
	public CustomerInfo(String name, String iseff, Timestamp createTime,
			Timestamp lastUpdate) {
		this.name = name;
		this.iseff = iseff;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
	}

	/** full constructor */
	public CustomerInfo(String name, String sex, String school, String classes,
			String brithday, String age, String studentType,
			String residentType, String parentName, String phone, String addr,
			String iseff, Timestamp createTime, Timestamp lastUpdate,
			String email, String class_) {
		this.name = name;
		this.sex = sex;
		this.school = school;
		this.classes = classes;
		this.brithday = brithday;
		this.age = age;
		this.studentType = studentType;
		this.residentType = residentType;
		this.parentName = parentName;
		this.phone = phone;
		this.addr = addr;
		this.iseff = iseff;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.email = email;
		this.class_ = class_;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getSchool() {
		return this.school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getClasses() {
		return this.classes;
	}

	public void setClasses(String classes) {
		this.classes = classes;
	}

	public String getBrithday() {
		return this.brithday;
	}

	public void setBrithday(String brithday) {
		this.brithday = brithday;
	}

	public String getAge() {
		return this.age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getStudentType() {
		return this.studentType;
	}

	public void setStudentType(String studentType) {
		this.studentType = studentType;
	}

	public String getResidentType() {
		return this.residentType;
	}

	public void setResidentType(String residentType) {
		this.residentType = residentType;
	}

	public String getParentName() {
		return this.parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return this.addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getIseff() {
		return this.iseff;
	}

	public void setIseff(String iseff) {
		this.iseff = iseff;
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

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getClass_() {
		return this.class_;
	}

	public void setClass_(String class_) {
		this.class_ = class_;
	}

}