package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.BaseAction;
import com.web.model.OrderRelHis;
import com.web.service.OrderQueryService;

public class OrderRelHisAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderRelHisAction.class);
	@Resource
	private OrderQueryService orderQueryService;

	public OrderRelHisAction() {
		super(OrderRelHis.class);
	}

}
