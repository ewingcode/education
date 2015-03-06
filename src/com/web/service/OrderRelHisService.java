package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.model.OrderRelHis;

/**
 * 签单负责人
 * 
 */
@Repository("orderRelHisService")
public class OrderRelHisService {
	@Resource
	private BaseDao baseDao;

	public List<OrderRelHis> getOrderRelHis(int orderId, String chargerType)
			throws DaoException {
		List<OrderRelHis> list = baseDao.find("orderId=" + orderId
				+ " and chargerType='" + chargerType + "'", OrderRelHis.class);
		return list;
	}
	
	@Transactional
	public void batchUpdate(List<OrderRelHis> list) throws DaoException {
		for (OrderRelHis orderRelHis : list) {
			baseDao.update(orderRelHis);
		}
	}

}
