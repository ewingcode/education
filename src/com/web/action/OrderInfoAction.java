package com.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.axis.utils.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.constant.YesOrNo;
import com.core.app.control.SessionControl;
import com.core.app.control.SessionException;
import com.core.app.service.SysRightRelService;
import com.core.jdbc.util.PageBean;
import com.util.SqlUtil;
import com.util.StringUtil;
import com.web.model.OrderInfoView;
import com.web.model.StudentInfo;
import com.web.service.OrderQueryService;
import com.web.service.StudentService;

public class OrderInfoAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderInfoAction.class);
	@Resource
	private OrderQueryService orderQueryService;
	@Resource
	private StudentService studentService;
	@Resource
	private SysRightRelService sysRightRelService;

	public OrderInfoAction() {
		super(OrderInfoView.class);
	}

	@Override
	public String getCondition() {
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = sysRightRelService.getAreaRightSql(request);
			if (!StringUtil.isEmpty(relAreaSql))
				return SqlUtil.combine(condition, relAreaSql);
		} catch (SessionException e) {
			e.printStackTrace();
		}
		return condition;
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void findOrderInfo() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer orderId = Integer.valueOf(request.getParameter("orderId"));
			OrderInfoView orderInfo = baseModelService.findOne(orderId,
					OrderInfoView.class);
			orderInfo.setStudentName(studentService.getStudentName(orderInfo
					.getStudentId()));
			orderInfo.setFeeFloat(Float.valueOf(orderInfo.getFee() / 100f)
					.toString());
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(orderInfo);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
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
			PageBean pageBean = orderQueryService.findPersonalTasks(
					userInfo.getId(), userInfo.getRoleId(),
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
			List<OrderInfoView> orderList = orderQueryService.queryRelOrder(
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
			OrderInfoView orderInfo = orderQueryService.queryLastestOrder(
					Integer.valueOf(userId), Integer.valueOf(studentId));
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

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void pageQuery() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			String isSchedule = request.getParameter("QUERY_isSchedule");
			String conditionSql = bulidConditionSql();
			if (!StringUtils.isEmpty(isSchedule)) {
				String sql2 = "";
				if (isSchedule.equals(YesOrNo.YES.getValue())) {
					sql2 = " (course_hour - adjust_hour ) <= schedule_hour";
				} else if (isSchedule.equals(YesOrNo.NO.getValue())) {
					sql2 = " (course_hour - adjust_hour ) > schedule_hour";
				}
				conditionSql = SqlUtil.combine(conditionSql, sql2);
			}
			PageBean pageBean = baseModelService.pageQuery(conditionSql,
					bulidOrderBySql(),
					limit == null ? 20 : Integer.valueOf(limit),
					start == null ? 0 : Integer.valueOf(start), entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}
}
