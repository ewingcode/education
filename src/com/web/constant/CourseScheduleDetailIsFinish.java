package com.web.constant;

public enum CourseScheduleDetailIsFinish {
	NOTFINISH(0), FINISHED(1);
	private Integer value;

	private CourseScheduleDetailIsFinish(Integer value) {
		this.value = value;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}
