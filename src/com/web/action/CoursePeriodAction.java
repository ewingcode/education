package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.util.DateFormat;
import com.web.model.CoursePeriod;
import com.web.service.CoursePeriodService;

public class CoursePeriodAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderAttchAction.class);
	@Resource
	private CoursePeriodService coursePeriodService;

	public CoursePeriodAction() {
		super(CoursePeriod.class);
	}

	/**
	 * 是否有相同的课程时间设置
	 * 
	 * @throws ActionException
	 */
	public void existSamePeriod() throws ActionException {
		ResponseData responseData = null;
		try {
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			boolean existSamePeriod = coursePeriodService.existSamePeriod(
					DateFormat.stringToDate(startDate), DateFormat
							.stringToDate(endDate));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(existSamePeriod);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}
}
