package com.web.service;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.web.model.OrderAttach;
import com.web.model.OrderExchange;
import com.web.model.OrderInfo;
import com.web.model.OrderRelHis;
import com.web.model.StudentInfo;

@Repository("orderExchangeService")
public class OrderExchangeService {
	private static Logger logger = Logger.getLogger(OrderExchangeService.class);
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderAttachService orderAttachService;
	@Resource
	private OrderService orderService;

	/**
	 * 查找编辑交流信息的列表
	 * 
	 * @param userId
	 * @param pageSize
	 * @param startIndex
	 * @return
	 */
	public PageBean findEditableStudents(int userId, int pageSize,
			int startIndex, String condition, String orderBy) {
		String sql = " from " + StudentInfo.class.getName()
				+ " where id in( select studentId from "
				+ OrderInfo.class.getName()
				+ " a1 where id in ( select orderId from "
				+ OrderRelHis.class.getName() + " a2 where a2.operator ="
				+ userId + ")) ";

		return baseDao.pageQuery(sql, condition, orderBy, pageSize, startIndex,
				StudentInfo.class);
	}

	/**
	 * 查找编辑交流信息的签单列表
	 * 
	 * @param userId
	 * @param pageSize
	 * @param startIndex
	 * @return
	 */
	public PageBean findEditableOrders(int userId, int pageSize, int startIndex) {
		String sql = " from " + OrderInfo.class.getName()
				+ " where id in ( select orderId from "
				+ OrderRelHis.class.getName() + " a2 where a2.operator ="
				+ userId + ") ";
		return baseDao.pageQuery(sql, pageSize, startIndex, OrderInfo.class);
	}

	/**
	 * 查找学生的交流记录
	 * 
	 * @param userId
	 * @param pageSize
	 * @param startIndex
	 * @return
	 */
	public PageBean findStudentExchange(int studentId, int pageSize,
			int startIndex) {
		String sql = " from " + OrderExchange.class.getName()
				+ " where order_id in ( select id from "
				+ OrderInfo.class.getName() + " a2 where a2.studentId ="
				+ studentId + "  ) order by create_time desc  ";
		return baseDao.pageQuery(sql, pageSize, startIndex, OrderInfo.class);
	}

	public void saveExchange(int orderId, int userId, String content,
			Map<OrderAttach, File> attachMap) throws Exception {
		OrderInfo orderInfo = orderService.findOne(orderId);
		OrderAttach orderAttach = new OrderAttach();
		if (attachMap != null) {
			Iterator<OrderAttach> itor = attachMap.keySet().iterator();
			while (itor.hasNext()) {
				OrderAttach attach = itor.next();
				File file = attachMap.get(attach);
				orderAttach = orderAttachService.saveExchangeAttach(orderInfo,
						attach, file);
				break;
			}
		}
		OrderExchange orderExchange = new OrderExchange();
		orderExchange.setContent(content);
		orderExchange.setOrderId(orderId);
		orderExchange.setUserId(userId);
		orderExchange.setOrderAttachId(orderAttach.getId());
		baseDao.save(orderExchange);
	}

	public void editExchange(OrderExchange orderExchange,
			Map<OrderAttach, File> attachMap) throws Exception {

		OrderInfo orderInfo = orderService.findOne(orderExchange.getOrderId());
		OrderAttach orderAttach = new OrderAttach();
		if (attachMap != null) {
			Iterator<OrderAttach> itor = attachMap.keySet().iterator();
			while (itor.hasNext()) {
				OrderAttach attach = itor.next();
				if (orderExchange.getOrderAttachId() == null)
					attach.setId(orderExchange.getOrderAttachId());
				File file = attachMap.get(attach);
				orderAttach = orderAttachService.saveExchangeAttach(orderInfo,
						attach, file);
				if (orderAttach != null) {
					orderExchange.setOrderAttachId(orderAttach.getId());
				}

				break;
			}
		}
		baseDao.update(orderExchange);
	}

	public List<OrderExchange> findPersonalEditHis(int orderId, int userId)
			throws DaoException {
		String sql = " order_id=" + orderId + " and user_id=" + userId;
		return baseDao.find(sql, OrderExchange.class);
	}
}
