package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.web.constant.OrderRunStatus;
import com.web.exception.OrderException;
import com.web.model.OrderInfo;
import com.web.model.OrderRelHis;
import com.web.model.OrderTrace;

/**
 * 签单信息查询服務
 */
@Repository("orderQueryService")
public class OrderQueryService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderRoleService orderRoleService;

	/**
	 * 待处理的任务
	 * 
	 * @param userId
	 * @return
	 * @throws DaoException
	 * @throws OrderException
	 */
	public PageBean findPersonalTasks(int userId, int roleId, int pageSize,
			int startIndex) throws DaoException, OrderException {
		int chargerType = orderRoleService.getChargerType(roleId);
		String sql = " from " + OrderInfo.class.getName()
				+ " where id in ( select orderId from "
				+ OrderTrace.class.getName() + " a2 where (user_id=" + userId
				+ " or role_id=" + chargerType + " ) and a2.operator is null) ";
		return baseDao.pageQuery(sql, pageSize, startIndex, OrderInfo.class);
	}

	/**
	 * 获取正在进行的签单
	 * 
	 * @param studentId
	 * @return
	 * @throws DaoException
	 */
	public OrderInfo findLearnOrder(int studentId) throws DaoException {
		List<OrderInfo> orderList = baseDao.find("student_id=" + studentId
				+ " and run_status='" + OrderRunStatus.INLEARN + "'",
				OrderInfo.class);
		if (orderList == null || orderList.isEmpty()) {
			return null;
		}
		return orderList.get(0);
	}

	/**
	 * 已完成的历史人物
	 * 
	 * @param userId
	 * @return
	 * @throws DaoException
	 */
	public PageBean findPersonalTaskHis(String conditon, String orderBy,
			int userId, int pageSize, int startIndex) throws DaoException {
		String sql = " from " + OrderInfo.class.getName()
				+ " where id in ( select orderId from "
				+ OrderTrace.class.getName() + " a2 where a2.operator ="
				+ userId + ") " + conditon;
		return baseDao.pageQuery(sql, orderBy, pageSize, startIndex,
				OrderInfo.class);
	}

	/**
	 * 查找与学生和操作员（如老师）相关的签单信息
	 * 
	 * @param userId
	 * @param studentId
	 * @return
	 * @throws DaoException
	 */
	public List<OrderInfo> queryRelOrder(int userId, int studentId)
			throws DaoException {
		String sql = " from  " + OrderInfo.class.getName()
				+ " where student_id=" + studentId;
		if (userId != 0) {
			sql += " and id in (SELECT orderId FROM ";
			sql += OrderRelHis.class.getName() + " o where operator=" + userId;
			sql += ")";
		}
		sql += "order by id desc";

		return baseDao.find(sql, OrderInfo.class);
	}

	/**
	 * 查找评价或者分数关联的编辑的有效签单
	 * 
	 * @param userId
	 * @param studentId
	 * @return
	 * @throws DaoException
	 */
	public OrderInfo queryLastestOrder(int userId, int studentId)
			throws DaoException {
		List<OrderInfo> orderlist = queryRelOrder(userId, studentId);
		OrderInfo lastestOrder = null;
		for (OrderInfo orderInfo : orderlist) {
			if (orderInfo.getRunStatus().equals(OrderRunStatus.INLEARN))
				lastestOrder = orderInfo;
		}
		if (lastestOrder == null)
			lastestOrder = orderlist.get(0);
		return lastestOrder;
	}

}
