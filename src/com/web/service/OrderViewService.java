package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.core.app.model.SysParam;
import com.core.app.model.SysUser;
import com.core.app.service.SysParamService;
import com.core.jbpm.FlowTaskService;
import com.core.jbpm.constant.AssignType;
import com.core.jbpm.model.FlowTask;
import com.core.jbpm.model.FlowTaskTransition;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.util.StringUtil;
import com.web.constant.OrderProcess;
import com.web.constant.OrderType;
import com.web.constant.SysParamConstant;
import com.web.exception.OrderException;
import com.web.model.OrderInfo;
import com.web.model.OrderRelHis;

/**
 * @author Administrator
 * 
 */
@Repository("orderViewService")
public class OrderViewService {
	private static Logger logger = Logger.getLogger(OrderViewService.class);
	private final static String PROCESSNAME = "orderProcess";
	@Resource
	private FlowTaskService flowTaskService;
	@Resource
	private SysParamService sysParamService;
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderRoleService orderRoleService;

	/**
	 * 获取任务可执行人列表,可分页
	 * 
	 * @param taskName
	 * @param pageSize
	 * @param startIndex
	 * 
	 * @return
	 * @ 
	 * @throws OrderException
	 * @throws NumberFormatException
	 */
	public PageBean getTaskAssignerList(int orderId, int pageSize,
			int startIndex, String transitionName) throws
			NumberFormatException, OrderException {
		List<OrderInfo> orderList = baseDao.find("id=" + orderId,
				OrderInfo.class);
		OrderInfo order = orderList.get(0);

		FlowTask task = flowTaskService.getTask(OrderService.PROCESS_NAME,
				order.getStatus(), transitionName);
		String type = task.getAssignType();
		String assignerId = task.getAssigner();
		String sql = "";
		if (AssignType.ROLE.equals(type)) {
			sql = " role_id="
					+ orderRoleService.getRoleId(Integer.valueOf(assignerId));
		} else if (AssignType.USER.equals(type)) {
			sql = " id=" + assignerId;
		} else if (AssignType.DEPARTMENT.equals(type)) {
			sql = " dep_id=" + assignerId;
		}
		return baseDao.pageQuery(sql, "", pageSize, startIndex, SysUser.class);
	}

	/**
	 * 获取任务可执行人
	 * 
	 * @param taskName
	 * @param pageSize
	 * @param startIndex
	 * 
	 * @return
	 * @ 
	 * @throws OrderException
	 * @throws NumberFormatException
	 */
	public String getTaskAssigner(int orderId, String transitionName)
			throws NumberFormatException, OrderException {
		List<OrderInfo> orderList = baseDao.find("id=" + orderId,
				OrderInfo.class);
		OrderInfo order = orderList.get(0);
		FlowTask task = flowTaskService.getTask(OrderService.PROCESS_NAME,
				order.getStatus(), transitionName);
		return task.getAssigner();
	}

	/**
	 * 获取页面可执行的动作列表
	 * 
	 * @param order
	 * @return
	 * @ 
	 */
	public List<FlowTaskTransition> getPageActions(OrderInfo order)
			throws Exception {
		List<FlowTaskTransition> tranList = getTaskTransitionList(order);
		return tranList;
	}

	/**
	 * 获取流程定义的任务业务页面
	 * 
	 * @param order
	 * @return
	 * @throws OrderException
	 * @ 
	 */
	public String getTaskPage(OrderInfo order) throws Exception {
		String taskName = order.getStatus();
		return flowTaskService.getTask(PROCESSNAME, taskName).getBusiPageName();
	}

	/**
	 * 获取本人已经编辑的的任务业务页面
	 * 
	 * @param order
	 * @return
	 * @throws OrderException
	 * @ 
	 */
	public String showUserEditedTaskPage(int userId, int orderId)
			throws Exception {
		OrderRelHis orderRelHis = baseDao.findOne("id =(select max(id) from "
				+ OrderRelHis.class.getName() + " where operator=" + userId
				+ " and order_id=" + orderId + ")", OrderRelHis.class);
		String processName = getProceeName(orderId);
		FlowTask flowTask = flowTaskService.getTask(processName, orderRelHis
				.getTaskName());
		if (flowTask != null && !StringUtil.isEmpty(flowTask.getBusiPageName()))
			return flowTask.getBusiPageName();
		return "";
	}

	/**
	 * 获取系统定义的签单状态
	 * 
	 * @return
	 * @throws Exception
	 */
	public List<SysParam> getOrderStatus() throws Exception {
		return sysParamService.getSysParam(SysParamConstant.CONTRACT_STATUS
				.name());
	}

	/**
	 * 获取流程定义的任务
	 * 
	 * @param order
	 * @return
	 * @throws Exception
	 */
	public FlowTask getFlowTask(String taskName) throws Exception {
		return flowTaskService.getTask(PROCESSNAME, taskName);
	}

	/**
	 * 获取流程定义的执行转变设置
	 * 
	 * @param order
	 * @return
	 * @throws Exception
	 */
	private List<FlowTaskTransition> getTaskTransitionList(OrderInfo order)
			throws Exception {
		String taskName = order.getStatus();
		return flowTaskService.getTaskTransition(PROCESSNAME, taskName);
	}

	public String getProceeName(int orderId)   {
		OrderInfo orderInfo = baseDao.findOne(orderId, OrderInfo.class);
		if (orderInfo.getOrderType().equals(OrderType.APPLY))
			return OrderProcess.APPLY_PROCESSNAME;
		if (orderInfo.getOrderType().equals(OrderType.LAST))
			return OrderProcess.LAST_PROCESSNAME;
		return null;
	}
}
