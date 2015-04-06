package com.web.action;

import java.math.BigDecimal;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.jbpm.model.FlowTaskTransition;
import com.core.jdbc.util.PageBean;
import com.web.model.OrderAttach;
import com.web.model.OrderInfo;
import com.web.model.OrderTrace;
import com.web.service.OrderAttachService;
import com.web.service.OrderService;
import com.web.service.OrderTraceService;
import com.web.service.OrderViewService;

public class OrderViewAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderControlAction.class);
	@Resource
	private OrderViewService orderViewService;
	@Resource
	private OrderService orderService;
	@Resource
	private OrderAttachService orderAttachService;
	@Resource
	private OrderTraceService orderTraceService;

	/**
	 * 显示任务的业务页面
	 * 
	 * @throws ActionException
	 */
	public void showTaskPage() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			OrderInfo orderInfo = orderService
					.findOne(Integer.valueOf(orderId));
			String taskPage = orderViewService.getTaskPage(orderInfo);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setPage(taskPage);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	/**
	 * 显示任务的业务页面
	 * 
	 * @throws ActionException
	 */
	public void showUserEditedTaskPage() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			String userId = request.getParameter("userId");
			String taskPage = orderViewService.showUserEditedTaskPage(
					Integer.valueOf(userId), Integer.valueOf(orderId));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setPage(taskPage);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	/**
	 * 显示附件,并且根据传入的typelist的类型范围作查询条件
	 * 
	 * @throws ActionException
	 */
	public void showOrderAttach() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId_str = request.getParameter("orderId");
			String typeList = request.getParameter("typeList");
			String[] typeArray = StringUtils.split(typeList, ",");
			List<OrderAttach> list = orderAttachService.queryOrderAttach(
					Integer.valueOf(orderId_str), typeArray);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}
	
	 
	/**
	 * 显示签单信息
	 * 
	 * @throws ActionException
	 */
	public void showOrderInfo() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId_str = request.getParameter("orderId");
			OrderInfo orderInfo = orderService.findOne(Integer
					.valueOf(orderId_str)); 
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(orderInfo);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	/**
	 * 显示签单最近历史轨迹
	 * 
	 * @throws ActionException
	 */
	public void showLatestOrderTrace() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId_str = request.getParameter("orderId");
			OrderTrace orderTrace = orderTraceService.queryLatestTrace(Integer
					.valueOf(orderId_str));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(orderTrace);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	/**
	 * 显示任务可操作的方式
	 * 
	 * @throws ActionException
	 */
	public void showPageAction() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			OrderInfo orderInfo = orderService
					.findOne(Integer.valueOf(orderId));
			List<FlowTaskTransition> transList = orderViewService
					.getPageActions(orderInfo);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(transList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	/**
	 * 获取签单步骤的人，分页查询
	 * 
	 * @throws ActionException
	 */
	@Deprecated
	public void showAssigerList() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			String transitionName = request.getParameter("transitionName");
			transitionName = new String(transitionName.getBytes("ISO8859-1"),
					"UTF-8");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = orderViewService.getTaskAssignerList(
					Integer.valueOf(orderId), Integer.valueOf(limit),
					Integer.valueOf(start), transitionName);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	/**
	 * 获取签单步骤的指派人
	 * 
	 * @throws ActionException
	 */
	public void getAssigner() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			String transitionName = request.getParameter("transitionName");
			transitionName = new String(transitionName.getBytes("ISO8859-1"),
					"UTF-8");
			String assigner = orderViewService.getTaskAssigner(
					Integer.valueOf(orderId), transitionName);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(assigner);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}
}
