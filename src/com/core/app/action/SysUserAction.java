package com.core.app.action;

import java.util.List;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.constant.IsEff;
import com.core.app.model.SysUser;

public class SysUserAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysUserAction.class);
	public String s_phone;

	public String getS_phone() {
		return s_phone;
	}

	public void setS_phone(String sPhone) {
		s_phone = sPhone;
	}

	public SysUserAction() {
		super(SysUser.class);
	}
	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void pageQuery() throws ActionException {
		String phone =s_phone;
		super.pageQuery();
	}
	
	public void queryAll() throws ActionException {
		ResponseData responseData = null;
		try { 
			StringBuffer condition = new StringBuffer(); 
			condition.append(" iseff='").append(IsEff.EFFECTIVE)
					.append("'"); 
			List list = cacheModelService
					.find(condition.toString(), entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}
}
