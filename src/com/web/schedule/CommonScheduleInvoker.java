package com.web.schedule;

import org.apache.log4j.Logger;

/**
 * 计划任务执行器<br>
 * 每一个方法对应一个计划任务<br>
 * 具体的计划任务在applicationContext-schedule.xml中配置
 * 
 * @Title: CommonScheduleInvoker.java
 * @Description: TODO
 * @author linjs
 * @date Sep 13, 2010
 */
public class CommonScheduleInvoker {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(CommonScheduleInvoker.class);

	/**
	 * 統一接口心跳
	 */
	public void registbeat() {
		logger.info("调用心跳接口");
	 
	}

}
