package com.web.model;

/**
 * TeacherRefStudent entity. @author MyEclipse Persistence Tools
 */

public class TeacherRefStudent implements java.io.Serializable {

	private Long id;
	private Integer teacherId;
	private Integer studentId;
	private Integer orderId;
	private String courseType;
	private String name;
	private String grade;
	private String sex;
	private String age;
	private String runStatus;
	private Integer areaId;

	// Constructors
	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getAreaId() {
		return areaId;
	}

	public void setAreaId(Integer areaId) {
		this.areaId = areaId;
	}

	/** default constructor */
	public TeacherRefStudent() {
	}

	/** full constructor */
	public TeacherRefStudent(Integer teacherId, Integer studentId,
			String courseType, String name, String grade, String sex,
			String age, String runStatus) {
		this.teacherId = teacherId;
		this.studentId = studentId;
		this.courseType = courseType;
		this.name = name;
		this.grade = grade;
		this.sex = sex;
		this.age = age;
		this.runStatus = runStatus;
	}

	// Property accessors

	public Integer getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(Integer teacherId) {
		this.teacherId = teacherId;
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getStudentId() {
		return this.studentId;
	}

	public void setStudentId(Integer studentId) {
		this.studentId = studentId;
	}

	public String getCourseType() {
		return this.courseType;
	}

	public void setCourseType(String courseType) {
		this.courseType = courseType;
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

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getAge() {
		return this.age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getRunStatus() {
		return this.runStatus;
	}

	public void setRunStatus(String runStatus) {
		this.runStatus = runStatus;
	}

}