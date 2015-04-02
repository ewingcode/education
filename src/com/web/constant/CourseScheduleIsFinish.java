package com.web.constant;

public enum CourseScheduleIsFinish {
	NOTFINISH(0), FINISHED(1);
	private Integer value;

	private CourseScheduleIsFinish(Integer value) {
		this.value = value;
	}

	public Integer getValue() {
		return value;
	}

	public void setValue(Integer value) {
		this.value = value;
	}
}
