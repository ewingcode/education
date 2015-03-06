package com.core.app.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.BaseAction;
import com.core.app.model.SysLogTrace;
import com.core.app.service.SysLogTraceService;

public class SysLogTraceAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysMenuAction.class);

	public SysLogTraceAction() {
		super(SysLogTrace.class);
	}

	@Resource
	private SysLogTraceService sysLogTraceService;

	public void logTrace() {

		try {
			String userId = request.getParameter("userId");
			String moduleName = request.getParameter("moduleName");
			sysLogTraceService.logTrace(Integer.valueOf(userId), moduleName);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}

	}
}
