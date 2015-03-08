package com.core.app.action;

import org.apache.log4j.Logger;

import com.core.app.action.base.BaseAction;
import com.core.app.model.SysArea;

public class SysAreaAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysAreaAction.class);
	public SysAreaAction() {
		super(SysArea.class);
	}
}
