package com.web.action;

import org.apache.log4j.Logger;

import com.core.app.action.base.BaseAction;
import com.web.model.OrderCourse;

public class OrderCourseAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderCourseAction.class);

	public OrderCourseAction() {
		super(OrderCourse.class);
	}

}
