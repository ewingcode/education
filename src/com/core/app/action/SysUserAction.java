package com.core.app.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.constant.IsEff;
import com.core.app.control.SessionControl;
import com.core.app.model.SysUser;
import com.core.app.service.SysRightRelService;
import com.core.app.service.SysUserService;
import com.util.SqlUtil;
import com.util.StringUtil;

public class SysUserAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysUserAction.class);
	@Resource
	private SysRightRelService sysRightRelService;
	@Resource
	private SysUserService sysUserService;

	public SysUserAction() {
		super(SysUser.class);
	}

	@Override
	public String getCondition() {
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = null;
			try {
				relAreaSql = sysRightRelService.getAreaRightSql(request);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if (!StringUtil.isEmpty(relAreaSql))
				return SqlUtil.combine(condition, relAreaSql);
		} catch (Exception e) {
			logger.error(e);
		}
		return condition;
	}

	public void queryAll() throws ActionException {
		ResponseData responseData = null;
		try {
			StringBuffer condition = new StringBuffer();
			condition.append(" iseff='").append(IsEff.EFFECTIVE).append("'");
			List list = cacheModelService.find(condition.toString(),
					entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}
	
	/**
	 * 自动重设密码
	 * @throws ActionException
	 */
	public void resetPwd() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer userId = Integer.valueOf(request.getParameter("userId"));
			sysUserService.resetPwd(userId);
			responseData = ResponseUtils.success("重置密码成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("重置密码查询失败！");
		}
		outResult(responseData);
	}
	/**
	 * 设置新密码
	 * @throws ActionException
	 */
	public void setPwd() throws ActionException {
		ResponseData responseData = null;
		try {
			String oldPassword = request.getParameter("oldPassword");
			String newPassword = request.getParameter("newPassword");
			UserInfo userInfo = SessionControl.getUserInfo(request);
			sysUserService.setPwd(userInfo.getId(), oldPassword, newPassword);
			responseData = ResponseUtils.success("重置密码成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail(e.getMessage());
		}
		outResult(responseData);
	}
}
