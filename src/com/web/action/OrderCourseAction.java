package com.web.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.service.SysUserService;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseView;
import com.web.service.OrderCourseService;

public class OrderCourseAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderCourseAction.class);
	@Resource
	private SysUserService sysUserService;
	@Resource
	private OrderCourseService orderCourseService;

	public OrderCourseAction() {
		super(OrderCourseView.class);
	}

	/**
	 * dao查询
	 * 
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

	/**
	 * 查询学生参与的科目
	 * 
	 * @throws ActionException
	 */
	public void findCourseByStudent() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer studentId = Integer.valueOf(request
					.getParameter("studentId"));
			List<OrderCourseView> courseList = orderCourseService
					.findCourseByStudent(studentId);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(courseList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * 查询学生的科目负责人
	 * 
	 * @throws ActionException
	 */
	public void findChargerForCourse() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer studentId = Integer.valueOf(request
					.getParameter("studentId"));
			Integer courseType = Integer.valueOf(request
					.getParameter("courseType"));
			List<OrderCourseView> courseList = orderCourseService
					.findChargerForCourse(studentId, courseType);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(courseList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

}
