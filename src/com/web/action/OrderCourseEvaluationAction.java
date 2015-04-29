package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.OrderCourseEvaluation;
import com.web.service.OrderCourseEvaluationService;

public class OrderCourseEvaluationAction extends BaseAction {
	private static Logger logger = Logger
			.getLogger(OrderCourseEvaluationAction.class);
	@Resource
	private OrderCourseEvaluationService orderCourseEvaluationService;

	public OrderCourseEvaluationAction() {
		super(OrderCourseEvaluation.class);
	}

	public void saveExchange() throws ActionException {
		ResponseData responseData = null;
		try {
			orderCourseEvaluationService
					.saveExchange((OrderCourseEvaluation) this
							.buildPageData(super.entityBean));
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		outResult(responseData);
	}

	public void editExchange() throws ActionException {
		ResponseData responseData = null;
		try {
			orderCourseEvaluationService
					.saveExchange((OrderCourseEvaluation) this
							.buildPageData(super.entityBean));
			responseData = ResponseUtils.success("更新成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("更新失败！");
		}
		outResult(responseData);
	}

}
