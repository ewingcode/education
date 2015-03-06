package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.model.OrderTrace;

@Repository("orderTraceService")
public class OrderTraceService {
	@Resource
	private BaseDao baseDao;

	public List<OrderTrace> queryTraceList(int orderId) throws DaoException {
		List<OrderTrace> list = baseDao.find("order_id=" + orderId
				+ " order by id desc", OrderTrace.class);
		return list;
	}

	public OrderTrace queryLatestTrace(int orderId) throws DaoException {
		List<OrderTrace> list = baseDao.find("order_id=" + orderId
				+ " order by id desc", OrderTrace.class);
		if (list.isEmpty())
			return null;
		return list.get(0);
	}

	public OrderTrace getUnCompleteTrace(int orderId, int taskId)
			throws DaoException {
		List<OrderTrace> list = baseDao.find("order_id=" + orderId
				+ " and task_id=" + taskId + " and (operator =0 or operator is null)",
				OrderTrace.class);
		if (list.isEmpty())
			return null;
		return list.get(0);
	}
}
