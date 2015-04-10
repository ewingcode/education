package com.web.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.jbpm.FlowTaskService;
import com.core.jbpm.constant.TransitionArrangeType;
import com.core.jbpm.model.FlowTask;
import com.core.jbpm.model.FlowTaskTransition;
import com.core.jdbc.BaseDao;
import com.web.constant.NoticeWay;
import com.web.constant.OrderIsLast;
import com.web.constant.OrderProcess;
import com.web.constant.OrderRunStatus;
import com.web.constant.OrderType;
import com.web.model.OrderAttach;
import com.web.model.OrderCourse;
import com.web.model.OrderInfo;

@Repository("orderLastService")
public class OrderLastService {
	@Resource
	private FlowTaskService flowTaskService;
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderCourseService orderCourseService;
	@Resource
	private OrderService orderService;
	@Resource
	private OrderAttachService orderAttachService;
	public final static String PROCESS_NAME = OrderProcess.LAST_PROCESSNAME;

	@Transactional
	public boolean lastOrder(int operator, OrderInfo orderInfo,
			Map<OrderAttach, File> attachMap, List<OrderCourse> courseList,
			boolean isOnlyEdit) throws Exception {
		int studentId = orderInfo.getStudentId(); 
		orderInfo.setIsLast(OrderIsLast.NOTLAST);
		orderInfo.setRunStatus(OrderRunStatus.INAPPLY);
		orderInfo.setOrderType(OrderType.LAST);
		if (!isOnlyEdit) {
			baseDao.save(orderInfo);
			OrderInfo parentOrder = orderService.findOne(orderInfo
					.getParentOrderId());
			parentOrder.setIsLast(OrderIsLast.LASTED);
			baseDao.save(parentOrder);
			this.processFlow(orderInfo, operator);
		} else {
			baseDao.update(orderInfo);
		}
		orderAttachService.processParentAttach(orderInfo, attachMap);
		orderCourseService.processCourse(orderInfo, courseList);
		return true;
	}

 
 

	private void processFlow(OrderInfo orderInfo, int operator)
			throws Exception {
		FlowTask startFlowTask = flowTaskService.getStartTask(PROCESS_NAME);
		orderInfo.setStatus(startFlowTask.getTaskName());
		String curTaskName = null;
		List<FlowTaskTransition> transition = flowTaskService
				.getTaskTransition(PROCESS_NAME, startFlowTask.getTaskName());
		orderService.logOrderTrace(PROCESS_NAME, NoticeWay.NOSEND,
				TransitionArrangeType.UNARRANGE, null, startFlowTask,
				orderInfo, operator, operator,null);
		String preTaskName = orderInfo.getStatus();
		if (transition != null && transition.size() == 1) {
			curTaskName = transition.get(0).getTo();
		}
		FlowTask curTask = flowTaskService.getTask(PROCESS_NAME, curTaskName);
		orderInfo.setStatus(curTask.getTaskName());
		baseDao.update(orderInfo);
		orderService.logOrderTrace(PROCESS_NAME, NoticeWay.SEND,
				TransitionArrangeType.UNARRANGE, startFlowTask, curTask,
				orderInfo, operator, 0,null);
	}
}