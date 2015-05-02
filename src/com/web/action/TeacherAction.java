package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.control.SessionException;
import com.core.app.model.SysUser;
import com.core.app.service.SysRightRelService;
import com.util.SqlUtil;
import com.util.StringUtil;
import com.web.model.TeacherAbility;
import com.web.model.TeacherInfo;
import com.web.service.TeacherService;

public class TeacherAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);
	@Resource
	private TeacherService teacherService;
	@Resource
	private SysRightRelService sysRightRelService;
	public TeacherAction() {
		super(TeacherInfo.class);
	}

	/**
	 * 删除教师信息
	 * 
	 * @throws ActionException
	 */
	@Override
	public void delete() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer teacherId = Integer.valueOf(request
					.getParameter("teacherId"));
			teacherService.deleteTeacher(teacherId);
			responseData = ResponseUtils.success("删除成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("删除失败！");
		}
		this.outResult(responseData);
	}
	@Override
	public String getCondition() {
		condition = super.getCondition();
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = sysRightRelService.getAreaRightSql(request);
			if (!StringUtil.isEmpty(relAreaSql))
				return SqlUtil.combine(condition, relAreaSql);
		} catch (SessionException e) {
			e.printStackTrace();
		}
		return condition;
	}

	public void addNewTeacher() throws ActionException {
		ResponseData responseData = null;
		try {
			SysUser sysUser = new SysUser();
			super.buildPageData(sysUser);
			TeacherAbility teacherAbility = new TeacherAbility();
			super.buildPageData(teacherAbility);
			teacherService.addNewTeacher(sysUser, teacherAbility);
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		this.outResult(responseData);
	}

	public void editTeacher() throws ActionException {
		ResponseData responseData = null;
		try {
			SysUser sysUser = new SysUser();
			super.buildPageData(sysUser);
			TeacherAbility teacherAbility = new TeacherAbility();
			super.buildPageData(teacherAbility);
			teacherService.editTeacher(sysUser, teacherAbility);
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		this.outResult(responseData);
	}

}
