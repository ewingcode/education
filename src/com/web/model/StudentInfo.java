package com.web.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * StudentInfo entity. @author MyEclipse Persistence Tools
 */

public class StudentInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private String name;
	private String grade;
	private String school;
	private String age;
	private String brithday;
	private String sex;
	private String homephone;
	private String phone;
	private String addr;
	private String fatherName;
	private String fatherPhone;
	private String fatherUnit;
	private String fatherPosition;
	private String motherName;
	private String motherPhone;
	private String motherUnit;
	private String motherPosition;
	private String interest;
	private Date lastExamDate;
	private String scoreYuwen;
	private String scoreShuxue;
	private String scoreYingwen;
	private String scoreZhengzhi;
	private String scoreWuli;
	private String scoreHuaxue;
	private String scoreLishi;
	private String scoreShengwu;
	private String selfevaluation;
	private Timestamp createTime;
	private Timestamp lastUpdate;
	private String liketeacherstyle;
	private String likecoursestyle;
	private String livehabit;
	private Integer areaId;

	// Constructors

	public Integer getAreaId() {
		return areaId;
	}

	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}

	/** default constructor */
	public StudentInfo() {
	}

	/** minimal constructor */
	public StudentInfo(String name, Timestamp createTime, Timestamp lastUpdate) {
		this.name = name;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
	}

	/** full constructor */
	public StudentInfo(String name, String grade, String school, String age,
			String brithday, String sex, String homephone, String phone,
			String addr, String fatherName, String fatherPhone,
			String fatherUnit, String fatherPosition, String motherName,
			String motherPhone, String motherUnit, String motherPosition,
			String interest, Date lastExamDate, String scoreYuwen,
			String scoreShuxue, String scoreYingwen, String scoreZhengzhi,
			String scoreWuli, String scoreHuaxue, String scoreLishi,
			String scoreShengwu, String selfevaluation, Timestamp createTime,
			Timestamp lastUpdate, String liketeacherstyle,
			String likecoursestyle, String livehabit) {
		this.name = name;
		this.grade = grade;
		this.school = school;
		this.age = age;
		this.brithday = brithday;
		this.sex = sex;
		this.homephone = homephone;
		this.phone = phone;
		this.addr = addr;
		this.fatherName = fatherName;
		this.fatherPhone = fatherPhone;
		this.fatherUnit = fatherUnit;
		this.fatherPosition = fatherPosition;
		this.motherName = motherName;
		this.motherPhone = motherPhone;
		this.motherUnit = motherUnit;
		this.motherPosition = motherPosition;
		this.interest = interest;
		this.lastExamDate = lastExamDate;
		this.scoreYuwen = scoreYuwen;
		this.scoreShuxue = scoreShuxue;
		this.scoreYingwen = scoreYingwen;
		this.scoreZhengzhi = scoreZhengzhi;
		this.scoreWuli = scoreWuli;
		this.scoreHuaxue = scoreHuaxue;
		this.scoreLishi = scoreLishi;
		this.scoreShengwu = scoreShengwu;
		this.selfevaluation = selfevaluation;
		this.createTime = createTime;
		this.lastUpdate = lastUpdate;
		this.liketeacherstyle = liketeacherstyle;
		this.likecoursestyle = likecoursestyle;
		this.livehabit = livehabit;
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

	public String getGrade() {
		return this.grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getSchool() {
		return this.school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getAge() {
		return this.age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getBrithday() {
		return this.brithday;
	}

	public void setBrithday(String brithday) {
		this.brithday = brithday;
	}

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getHomephone() {
		return this.homephone;
	}

	public void setHomephone(String homephone) {
		this.homephone = homephone;
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

	public String getFatherName() {
		return this.fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getFatherPhone() {
		return this.fatherPhone;
	}

	public void setFatherPhone(String fatherPhone) {
		this.fatherPhone = fatherPhone;
	}

	public String getFatherUnit() {
		return this.fatherUnit;
	}

	public void setFatherUnit(String fatherUnit) {
		this.fatherUnit = fatherUnit;
	}

	public String getFatherPosition() {
		return this.fatherPosition;
	}

	public void setFatherPosition(String fatherPosition) {
		this.fatherPosition = fatherPosition;
	}

	public String getMotherName() {
		return this.motherName;
	}

	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}

	public String getMotherPhone() {
		return this.motherPhone;
	}

	public void setMotherPhone(String motherPhone) {
		this.motherPhone = motherPhone;
	}

	public String getMotherUnit() {
		return this.motherUnit;
	}

	public void setMotherUnit(String motherUnit) {
		this.motherUnit = motherUnit;
	}

	public String getMotherPosition() {
		return this.motherPosition;
	}

	public void setMotherPosition(String motherPosition) {
		this.motherPosition = motherPosition;
	}

	public String getInterest() {
		return this.interest;
	}

	public void setInterest(String interest) {
		this.interest = interest;
	}

	public Date getLastExamDate() {
		return this.lastExamDate;
	}

	public void setLastExamDate(Date lastExamDate) {
		this.lastExamDate = lastExamDate;
	}

	public String getScoreYuwen() {
		return this.scoreYuwen;
	}

	public void setScoreYuwen(String scoreYuwen) {
		this.scoreYuwen = scoreYuwen;
	}

	public String getScoreShuxue() {
		return this.scoreShuxue;
	}

	public void setScoreShuxue(String scoreShuxue) {
		this.scoreShuxue = scoreShuxue;
	}

	public String getScoreYingwen() {
		return this.scoreYingwen;
	}

	public void setScoreYingwen(String scoreYingwen) {
		this.scoreYingwen = scoreYingwen;
	}

	public String getScoreZhengzhi() {
		return this.scoreZhengzhi;
	}

	public void setScoreZhengzhi(String scoreZhengzhi) {
		this.scoreZhengzhi = scoreZhengzhi;
	}

	public String getScoreWuli() {
		return this.scoreWuli;
	}

	public void setScoreWuli(String scoreWuli) {
		this.scoreWuli = scoreWuli;
	}

	public String getScoreHuaxue() {
		return this.scoreHuaxue;
	}

	public void setScoreHuaxue(String scoreHuaxue) {
		this.scoreHuaxue = scoreHuaxue;
	}

	public String getScoreLishi() {
		return this.scoreLishi;
	}

	public void setScoreLishi(String scoreLishi) {
		this.scoreLishi = scoreLishi;
	}

	public String getScoreShengwu() {
		return this.scoreShengwu;
	}

	public void setScoreShengwu(String scoreShengwu) {
		this.scoreShengwu = scoreShengwu;
	}

	public String getSelfevaluation() {
		return this.selfevaluation;
	}

	public void setSelfevaluation(String selfevaluation) {
		this.selfevaluation = selfevaluation;
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

	public String getLiketeacherstyle() {
		return this.liketeacherstyle;
	}

	public void setLiketeacherstyle(String liketeacherstyle) {
		this.liketeacherstyle = liketeacherstyle;
	}

	public String getLikecoursestyle() {
		return this.likecoursestyle;
	}

	public void setLikecoursestyle(String likecoursestyle) {
		this.likecoursestyle = likecoursestyle;
	}

	public String getLivehabit() {
		return this.livehabit;
	}

	public void setLivehabit(String livehabit) {
		this.livehabit = livehabit;
	}

}