package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.service.SysUserService;
import com.web.model.OrderCourse;

public class OrderCourseAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderCourseAction.class);
	@Resource
	private SysUserService sysUserService;

	public OrderCourseAction() {
		super(OrderCourse.class);
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void findOrderCourse() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer orderCourseId = Integer.valueOf(request
					.getParameter("orderCourseId"));
			OrderCourse orderCourse = baseModelService.findOne(orderCourseId,
					OrderCourse.class);
			orderCourse.setChargerName(sysUserService.findOne(
					orderCourse.getChargerId()).getUserName());
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(orderCourse);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

}
