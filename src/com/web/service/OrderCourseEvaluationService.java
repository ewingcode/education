package com.web.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.web.model.OrderCourseEvaluation;

@Repository("orderCourseEvaluationService")
public class OrderCourseEvaluationService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderAttachService orderAttachService;
	@Resource
	private OrderService orderService;

	public void saveExchange(OrderCourseEvaluation orderCourseEvaluation)
			throws Exception {
		if (orderCourseEvaluation.getId() == null) {
			baseDao.save(orderCourseEvaluation);
		} else {
			baseDao.update(orderCourseEvaluation);
		}
	}

}
