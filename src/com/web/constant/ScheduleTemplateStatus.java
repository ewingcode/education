package com.web.constant;

/**
 * 排課模板狀態
 * 
 * @author tanson lam
 * @creation 2015年4月10日
 */
public enum ScheduleTemplateStatus {
	/**
	 * 未开始
	 */
	NOTBEGIN("0"),
	/**
	 * 开始中
	 */
	RUNNING("1"),
	/**
	 * 结束
	 */
	END("2");

	private String value;

	private ScheduleTemplateStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}

}
