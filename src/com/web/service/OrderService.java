package com.web.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.jbpm.FlowTaskService;
import com.core.jbpm.constant.FlowTaskType;
import com.core.jbpm.constant.TransitionArrangeType;
import com.core.jbpm.model.FlowTask;
import com.core.jbpm.model.FlowTaskTransition;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.constant.NoticeReceiverType;
import com.web.constant.NoticeWay;
import com.web.constant.OrderIsLast;
import com.web.constant.OrderProcess;
import com.web.constant.OrderRunStatus;
import com.web.constant.OrderType;
import com.web.exception.OrderException;
import com.web.model.OrderAttach;
import com.web.model.OrderCourse;
import com.web.model.OrderInfo;
import com.web.model.OrderRelHis;
import com.web.model.OrderTrace;

@Repository("orderService")
public class OrderService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private FlowTaskService flowTaskService;
	@Resource
	private OrderTraceService orderTraceService;
	@Resource
	private OrderCourseService orderCourseService;
	@Resource
	private OrderAttachService orderAttachService;
	@Resource
	private OrderViewService orderViewService;
	@Resource
	private OrderRoleService orderRoleService;
	@Resource
	private NoticeService noticeService;
	public final static String PROCESS_NAME = OrderProcess.APPLY_PROCESSNAME;

	public OrderInfo findOne(int id) throws DaoException {
		Object object = baseDao.findOne(id, OrderInfo.class);
		if (object == null) {
			return null;
		}
		return (OrderInfo) object;
	}

	public boolean existLearnOrder(int studentId) throws DaoException {
		List<OrderInfo> orderList = baseDao.find("student_id=" + studentId
				+ " and run_status='" + OrderRunStatus.INLEARN + "'",
				OrderInfo.class);
		if (orderList == null || orderList.isEmpty()) {
			return false;
		}
		return true;
	}

	private Map<String, Object> creatVariables(int userId) {
		Map<String, Object> variable = new HashMap<String, Object>();
		variable.put("userid", String.valueOf(userId));
		return variable;
	}

	/**
	 * 创建新的签单
	 * 
	 * @param orderInfo
	 * @throws DaoException
	 */
	@Transactional
	public boolean createNewOrder(OrderInfo orderInfo, int operator,
			Map<OrderAttach, File> attachMap, String[] courses)
			throws Exception {
		orderInfo.setRunStatus(OrderRunStatus.INAPPLY);
		orderInfo.setOrderType(OrderType.APPLY);
		orderInfo.setIsLast(OrderIsLast.NOTLAST);
		baseDao.save(orderInfo);
		FlowTask startFlowTask = flowTaskService.getStartTask(PROCESS_NAME);
		orderInfo.setStatus(startFlowTask.getTaskName());
		baseDao.update(orderInfo);
		orderAttachService.batchSaveOrderAttach(orderInfo, attachMap);
		orderCourseService.saveOrderCourse(orderInfo.getId(), courses);
		logOrderTrace(PROCESS_NAME, NoticeWay.NOSEND,
				TransitionArrangeType.UNARRANGE, null, startFlowTask,
				orderInfo, operator, operator);
		// 直接提交到销售部主管
		List<FlowTaskTransition> actionList = orderViewService
				.getPageActions(orderInfo);
		if (actionList != null && !actionList.isEmpty()) {
			FlowTaskTransition transition = actionList.get(0);
			if (TransitionArrangeType.UNARRANGE.getType().equals(
					transition.getNeedArrange())) {
				orderTransfer(operator, 0, orderInfo.getId(), transition
						.getName());
			}
		}
		return true;
	}

	@Transactional
	public boolean orderTransfer(int operator, int assignerId, int orderId,
			String transitionName) throws Exception {
		OrderInfo order = findOne(orderId);
		String preTaskName = order.getStatus();
		this.transfer(assignerId, orderId, transitionName);
		// 重新查询一次orderInfo.
		order = this.findOne(orderId);
		String curTaskName = order.getStatus();
		FlowTask preTask = flowTaskService.getTask(PROCESS_NAME, preTaskName);
		FlowTask curTask = flowTaskService.getTask(PROCESS_NAME, curTaskName);
		FlowTaskTransition flowTaskTransition = flowTaskService
				.getTaskTransition(PROCESS_NAME, preTask.getId(),
						transitionName);
		this.logOrderTrace(PROCESS_NAME, NoticeWay.SEND, TransitionArrangeType
				.getArrangeType(flowTaskTransition.getNeedArrange()), preTask,
				curTask, order, operator, assignerId);

		return true;
	}

	@Transactional
	public boolean orderEdit(OrderInfo orderInfo, String[] courses,
			int operator, int orderId, List<OrderCourse> courseList,
			Map<OrderAttach, File> attachMap) throws Exception {
		if (orderInfo != null) {
			baseDao.update(orderInfo);
		}
		if (courses != null)
			orderCourseService.saveOrderCourse(orderInfo.getId(), courses);
		this.processOrderInfo(orderInfo, courseList, attachMap);
		return true;
	}

	public void processOrderInfo(OrderInfo order, List<OrderCourse> courseList,
			Map<OrderAttach, File> attachMap) throws Exception {
		if (courseList != null && !courseList.isEmpty())
			orderCourseService.batchUpdate(courseList);
		if (attachMap != null && !attachMap.isEmpty())
			orderAttachService.batchSaveOrderAttach(order, attachMap);
	}

	private boolean transfer(int assignerId, int orderId, String transitionName)
			throws Exception {
		List<OrderInfo> orderList = baseDao.find("id=" + orderId,
				OrderInfo.class);
		OrderInfo order = orderList.get(0);
		String curTaskName = order.getStatus();
		FlowTask curTask = flowTaskService.getTask(PROCESS_NAME, curTaskName);
		String nextTaskName = flowTaskService.getTaskTransition(PROCESS_NAME,
				curTask.getId(), transitionName).getTo();
		order.setStatus(nextTaskName); 
		baseDao.update(order);

		return true;
	}

	/**
	 * 记录任务跟踪历史
	 * 
	 * @param preTaskName
	 * @param curTaskName
	 * @param operator
	 * @param comment
	 * @throws Exception
	 */
	public void logOrderTrace(String procssName, NoticeWay noticeWay,
			TransitionArrangeType arrangeType, FlowTask preTask,
			FlowTask curTask, OrderInfo order, int operator, int assignerId)
			throws Exception {
		int orderId = order.getId();
		int preTaskId = preTask != null ? preTask.getId() : 0; 
		OrderTrace preOrderTrace = new OrderTrace(); 
		if (preTask != null) {
			preOrderTrace = orderTraceService.getUnCompleteTrace(orderId,
					preTaskId);
			if (preOrderTrace != null) {
				if (preTask.getId() < curTask.getId()) {
					preOrderTrace.setOper("0");// forward operation.
					logOrderRelHis(procssName, preTaskId, orderId, operator);
				} else {
					preOrderTrace.setOper("1");// backward operation.
					delOrderRelHis(preTaskId, orderId, operator);
				}
				preOrderTrace.setOperator(operator);
				baseDao.update(preOrderTrace);
			}
		}
		order.setCurOperator(operator);
		if (curTask.getType() != null
				&& curTask.getType().equals(FlowTaskType.END)) {
			boolean existOrder = existLearnOrder(order.getStudentId());
			if (existOrder) {
				order.setRunStatus(OrderRunStatus.INWAITING);
			} else {
				order.setRunStatus(OrderRunStatus.INLEARN);
			}
		}
		baseDao.update(order);
		OrderTrace curOrderTrace = new OrderTrace();
		curOrderTrace.setTaskId(curTask.getId());
		curOrderTrace.setOrderId(orderId);
		curOrderTrace.setTaskName(curTask.getTaskName());
		int lastRollBackOperator = this.getOperatorInRollbackOrderTrace(
				orderId, curTask.getTaskName());
		// if (curTask != null) {
		if (preOrderTrace != null) {
			if (preOrderTrace.getOper() == null
					|| preOrderTrace.getOper().equals("0")) {// forward
				// operation.
				if (arrangeType.equals(TransitionArrangeType.UNARRANGE)) {
					if (lastRollBackOperator > 0) {
						curOrderTrace.setUserId(lastRollBackOperator);
					} else {
						if (!StringUtils.isEmpty(curTask.getAssigner()))
							curOrderTrace.setRoleId(Integer.valueOf(curTask
									.getAssigner()));
					}

				} else if (arrangeType.equals(TransitionArrangeType.ARRANGE)) {
					curOrderTrace.setUserId(assignerId);

				} else if (arrangeType.equals(TransitionArrangeType.CONFIRM)) {
					curOrderTrace.setUserId(preOrderTrace.getUserId());
				}
			} else if (preOrderTrace.getOper().equals("1")) {
				// backward operation.
				curOrderTrace.setUserId(getOperatorInOrderRelHis(orderId,
						curOrderTrace.getTaskName()));

			}
		} else {
			curOrderTrace.setUserId(operator);
		}

		if (NoticeWay.SEND.equals(noticeWay)) {
			if (curOrderTrace.getRoleId() != null
					&& curOrderTrace.getUserId() == null) {
				noticeService.AddSysNotice(operator, NoticeReceiverType.ROLE,
						orderRoleService.getRoleId(curOrderTrace.getRoleId()),
						"你有1条新的未办签单信息，请查看签单编号【" + order.getId() + "】");
			} else if (curOrderTrace.getRoleId() == null
					&& curOrderTrace.getUserId() != null) {
				noticeService.AddSysNotice(operator,
						NoticeReceiverType.PERSONAL, curOrderTrace.getUserId(),
						"你有1条新的未办签单信息，请查看签单编号【" + order.getId() + "】");

			}
		}
		baseDao.save(curOrderTrace);
	}

	/**
	 * 记录任务关系历史
	 * 
	 * @param taskName
	 * @param orderId
	 * @param roleId
	 * @param userId
	 * @throws DaoException
	 */
	private void logOrderRelHis(String procesName, int taskId, int orderId,
			int operator) throws DaoException {
		FlowTask task = flowTaskService.getTask(procesName, taskId);
		OrderRelHis orderRelHis = new OrderRelHis();
		orderRelHis.setOrderId(orderId);
		orderRelHis.setOperator(operator);
		orderRelHis.setTaskName(task.getTaskName());
		orderRelHis.setTaskId(taskId);
		orderRelHis.setChargerType(task.getAssigner());
		baseDao.save(orderRelHis);
	}

	/**
	 * 获取任务的执行者历史信息
	 * 
	 * @param taskName
	 * @param orderId
	 * @param roleId
	 * @param userId
	 * @throws DaoException
	 */
	private int getOperatorInOrderRelHis(int orderId, String taskName)
			throws DaoException, OrderException {
		List<OrderRelHis> orderRelHisList = baseDao.find(" order_id=" + orderId
				+ " and task_name='" + taskName + "'", OrderRelHis.class);
		if (orderRelHisList.isEmpty()) {
			return 0;
		}
		return orderRelHisList.get(0).getOperator();

	}

	/**
	 * 获取后退流程中的发起者。
	 * 
	 * @param taskName
	 * @param orderId
	 * @param roleId
	 * @param userId
	 * @throws DaoException
	 */
	private int getOperatorInRollbackOrderTrace(int orderId, String taskName)
			throws DaoException, OrderException {
		List<OrderTrace> orderTraceList = baseDao.find(" order_id=" + orderId
				+ " and task_name='" + taskName + "' and oper='1'",
				OrderTrace.class);
		if (orderTraceList.isEmpty()) {
			return 0;
		}
		return orderTraceList.get(0).getOperator();

	}

	public boolean editOrder(int operator, OrderInfo orderInfo,
			Map<OrderAttach, File> attachMap, List<OrderCourse> courseList,
			boolean isOnlyEdit) throws Exception {
		orderInfo.setIsLast(OrderIsLast.NOTLAST);
		orderInfo.setRunStatus(OrderRunStatus.INAPPLY);
		orderInfo.setOrderType(OrderType.LAST);
		if (isOnlyEdit) {
			baseDao.update(orderInfo);
		}
		orderAttachService.processAttach(orderInfo, attachMap);
		orderCourseService.processCourse(orderInfo, courseList);
		return true;
	}

	/**
	 * 记录任务关系历史
	 * 
	 * @param taskName
	 * @param orderId
	 * @param roleId
	 * @param userId
	 * @throws DaoException
	 */
	private void delOrderRelHis(int curTaskId, int orderId, int operator)
			throws DaoException {
		List<OrderRelHis> relList = baseDao.find("task_id=" + curTaskId
				+ " and orderId=" + orderId + " and operator=" + operator,
				OrderRelHis.class);
		if (!relList.isEmpty()) {
			OrderRelHis orderRelHis = new OrderRelHis();
			orderRelHis.setId(relList.get(0).getId());
			baseDao.delete(orderRelHis);
		}
	}

	/**
	 * 删除相关的签单信息。
	 * 
	 * @param orderId
	 * @throws DaoException
	 */
	public void cancelOrder(int orderId) throws DaoException {
		baseDao.executeSql("delete from order_info where id=" + orderId);
		baseDao
				.executeSql("delete from order_course where order_id="
						+ orderId);
		baseDao
				.executeSql("delete from order_course where order_id="
						+ orderId);
		baseDao
				.executeSql("delete from order_attach where order_id="
						+ orderId);
		baseDao.executeSql("delete from order_rel_his where order_id="
				+ orderId);
		baseDao.executeSql("delete from order_trace where order_id=" + orderId);
	}
}