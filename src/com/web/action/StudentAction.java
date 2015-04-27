package com.web.action;

import javax.annotation.Resource;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.control.SessionException;
import com.core.app.service.SysRightRelService;
import com.util.SqlUtil;
import com.util.StringUtil;
import com.web.model.StudentInfo;
import com.web.service.StudentService;

public class StudentAction extends BaseAction {
	@Resource
	private StudentService studentService;
	@Resource
	private SysRightRelService sysRightRelService;
	public StudentAction() {
		super(StudentInfo.class);
	}

	@Override
	public String getCondition() {
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = sysRightRelService.getAreaRightSql(request);
			if (!StringUtil.isEmpty(relAreaSql))
				return SqlUtil.combine(condition , relAreaSql);
		} catch (SessionException e) {
			e.printStackTrace();
		}
		return condition;
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
