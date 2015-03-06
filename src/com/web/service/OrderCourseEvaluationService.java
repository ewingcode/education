package com.web.service;

import java.io.File;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.web.model.OrderAttach;
import com.web.model.OrderCourseEvaluation;
import com.web.model.OrderInfo;

@Repository("orderCourseEvaluationService")
public class OrderCourseEvaluationService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderAttachService orderAttachService;
	@Resource
	private OrderService orderService;

	public void saveExchange(OrderCourseEvaluation orderCourseEvaluation,
			Map<OrderAttach, File> attachMap) throws Exception {
		OrderInfo orderInfo = orderService.findOne(orderCourseEvaluation
				.getOrderId());
		OrderAttach orderAttach = new OrderAttach();
		if (attachMap != null) {
			Iterator<OrderAttach> itor = attachMap.keySet().iterator();
			while (itor.hasNext()) {
				OrderAttach attach = itor.next();
				File file = attachMap.get(attach);
				if (orderCourseEvaluation != null
						&& orderCourseEvaluation.getOrderAttachId() != null
						&& orderCourseEvaluation.getOrderAttachId() != 0)
					attach.setId(orderCourseEvaluation.getOrderAttachId());
				orderAttach = orderAttachService.saveExchangeAttach(orderInfo,
						attach, file);
				if (orderAttach != null) {
					orderCourseEvaluation.setOrderAttachId(orderAttach.getId());
				}
				break;
			}
		}
		if (orderCourseEvaluation.getId() == null) {
			baseDao.save(orderCourseEvaluation);
		} else {
			baseDao.update(orderCourseEvaluation);
		}
	}

}
