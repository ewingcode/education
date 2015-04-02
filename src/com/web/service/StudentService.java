package com.web.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.model.OrderInfo;
import com.web.model.StudentInfo;

@Repository("studentService")
public class StudentService {
	@Resource
	private BaseDao baseDao;

	public StudentInfo getStudent(int studentId)   {
		return baseDao.findOne(studentId, StudentInfo.class);
	}

	/**
	 * 获取学生名称
	 * 
	 * @param studentId
	 * @return
	 * @ 
	 */
	public String getStudentName(int studentId)   {
		StudentInfo studentInfo = getStudent(studentId);
		return studentInfo != null ? studentInfo.getName() : "";
	}

	@Transactional
	public void testTx()   {
		OrderInfo order = new OrderInfo();
		order.setFlowInsId("1");
		order.setStudentId(1);
		baseDao.save(order);
		OrderInfo order2 = new OrderInfo();
		order2.setFlowInsId("1");
		order2.setStudentId(1);
		order2.setOrderType("2");
		baseDao.save(order2);
	}
}
