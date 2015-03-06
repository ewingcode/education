package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.jdbc.util.PageBean;
import com.web.service.OrderCourseScheduleService;
import com.web.util.DateFormat;

public class OrderCourseSchedule extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderAttchAction.class);
	@Resource
	private OrderCourseScheduleService orderCourseScheduleService;

	public OrderCourseSchedule() {
		super(OrderCourseSchedule.class);
	}

	/**
	 * 查找空闲的老师
	 * 
	 * @throws ActionException
	 */
	public void findFreeTeacher() throws ActionException {
		ResponseData responseData = null;
		try {
			String coursePeriodId = request.getParameter("coursePeriodId");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			PageBean pageBean = orderCourseScheduleService.findFreeTeacher(
					Integer.valueOf(coursePeriodId), DateFormat
							.stringToDate(startDate), DateFormat
							.stringToDate(endDate), Integer.valueOf(limit),
					Integer.valueOf(start));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

}
