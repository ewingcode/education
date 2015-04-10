package com.web.constant;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年4月10日
 */
public enum CourseScheduleFinish {

	NOTFINISHED(0),

	FINISHED(1);

	private int value;

	private CourseScheduleFinish(int value) {
		this.value = value;
	}

	public int getValue() {
		return this.value;
	}
}
