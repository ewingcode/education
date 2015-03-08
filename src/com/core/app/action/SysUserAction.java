package com.core.app.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.constant.IsEff;
import com.core.app.control.SessionException;
import com.core.app.model.SysUser;
import com.core.app.service.SysRightRelService;
import com.util.SqlUtil;
import com.util.StringUtil;

public class SysUserAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysUserAction.class);
	@Resource
	private SysRightRelService sysRightRelService;
	public SysUserAction() {
		super(SysUser.class);
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
}
