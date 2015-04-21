package com.web.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.web.model.StudentInfo;

@Repository("studentService")
public class StudentService {
	@Resource
	private BaseDao baseDao;

	public StudentInfo getStudent(int studentId) {
		return baseDao.findOne(studentId, StudentInfo.class);
	}

	/**
	 * 获取学生名称
	 * 
	 * @param studentId
	 * @return @
	 */
	public String getStudentName(int studentId) {
		StudentInfo studentInfo = getStudent(studentId);
		return studentInfo != null ? studentInfo.getName() : "";
	}
	
	/**
	 * 根据名称获取学生信息
	 * @param studentName
	 * @return
	 */
	public StudentInfo findByName(String studentName) {
		String sql = "name='" + studentName + "'";
		return baseDao.findOne(sql, StudentInfo.class);
	}

}
