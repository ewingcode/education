package com.web.constant;

/**
 * 课时记录状态
 * 
 * @author tanson lam
 * @creation 2015年4月10日
 */
public enum CourseHourStatus {
	/**
	 * 全部清算
	 */
	ALL_SETTLE("0"),
	/**
	 * 取消
	 */
	CANCEL("1");

	private String value;

	private CourseHourStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}

}
