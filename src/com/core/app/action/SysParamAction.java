package com.core.app.action;

import java.util.List;

import org.apache.axis.utils.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.constant.IsEff;
import com.core.app.model.SysParam;

public class SysParamAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);
	public String rootCode;

	public SysParamAction() {
		super(SysParam.class);
	}

	public String getRootCode() {
		return rootCode;
	}

	public void setRootCode(String rootCode) {
		this.rootCode = rootCode;
	}

	public void queryByRootCode() throws ActionException {
		ResponseData responseData = null;
		try {
			if (StringUtils.isEmpty(rootCode))
				throw new ActionException("rootCode should not be null!");
			StringBuffer condition = new StringBuffer();
			condition.append(" root_code='").append(rootCode).append("'");
			condition.append(" and iseff='").append(IsEff.EFFECTIVE).append("'");
			condition.append(" order by CONVERT(seq, SIGNED)");
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
