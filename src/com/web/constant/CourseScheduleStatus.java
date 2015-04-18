package com.web.constant;

public enum CourseScheduleStatus {
	// 0:未开始 1:开始中 2:结束
	NOTBEGIN("0"), RUNNING("1"), FINISHED("2");
	private String value;

	private CourseScheduleStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
