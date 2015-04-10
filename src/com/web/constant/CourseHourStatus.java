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
	 * 部分清算
	 */
	PART_SETTLE("1"),
	/**
	 * 取消
	 */
	CANCEL("2");

	private String value;

	private CourseHourStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}
	
	
}
