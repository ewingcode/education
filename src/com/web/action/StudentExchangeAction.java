package com.web.action;

import org.apache.log4j.Logger;

import com.core.app.action.base.BaseAction;
import com.web.model.StudentExchange;

public class StudentExchangeAction extends BaseAction {
	private static Logger logger = Logger
			.getLogger(StudentExchangeAction.class);

	public StudentExchangeAction() {
		super(StudentExchange.class);
	}

}
