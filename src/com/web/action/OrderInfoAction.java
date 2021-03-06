package com.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.control.SessionControl;
import com.core.jdbc.util.PageBean;
import com.web.model.OrderInfo;
import com.web.service.OrderQueryService;

public class OrderInfoAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderInfoAction.class);
	@Resource
	private OrderQueryService orderQueryService;

	public OrderInfoAction() {
		super(OrderInfo.class);
	}

	/**
	 * 待处理的任务
	 * 
	 * @throws ActionException
	 */
	public void findPersonalTasks() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = orderQueryService.findPersonalTasks(userInfo
					.getId(), userInfo.getRoleId(), Integer.valueOf(limit),
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

	/**
	 * 已处理的历史任务
	 * 
	 * @throws ActionException
	 */
	public void findPersonalTasksHis() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = orderQueryService.findPersonalTaskHis(
					bulidConditionSql(), bulidOrderBySql(), userInfo.getId(),
					Integer.valueOf(limit), Integer.valueOf(start));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	/**
	 * 已处理的历史任务
	 * 
	 * @throws ActionException
	 */
	public void queryRelOrder() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			String studentId = request.getParameter("studentId");
			List<OrderInfo> orderList = orderQueryService.queryRelOrder(
					userInfo.getId(), Integer.valueOf(studentId));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(orderList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	/**
	 * 显示学生关联的签单信息。
	 * 
	 * @throws ActionException
	 */
	public void queryStudentRelOrder() throws ActionException {
		ResponseData responseData = null;
		try {
			String userId = request.getParameter("userId");
			String studentId = request.getParameter("studentId");
			OrderInfo orderInfo = orderQueryService.queryLastestOrder(Integer
					.valueOf(userId), Integer.valueOf(studentId));
			List list = new ArrayList();
			if (orderInfo != null) {
				list.add(orderInfo);
			}
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		

		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

}
