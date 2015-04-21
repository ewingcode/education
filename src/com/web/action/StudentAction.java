package com.web.action;

import javax.annotation.Resource;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.StudentInfo;
import com.web.service.StudentService;

public class StudentAction extends BaseAction {
	@Resource
	private StudentService studentService;

	public StudentAction() {
		super(StudentInfo.class);
	}

	/**
	 * 验证学生
	 * 
	 * @throws ActionException
	 */
	public void validateStudent() throws ActionException {
		ResponseData responseData = null;
		try {

			String studentName = getUTFParameter("studentName");
			StudentInfo studentInfo = studentService.findByName(studentName);
			responseData = ResponseUtils.success("查询成功！");
			if (studentInfo != null)
				responseData.setResult(studentInfo);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}
}
