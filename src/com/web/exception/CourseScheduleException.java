package com.web.exception;

/**
 * 排课异常
 * 
 * @author tanson lam
 * @creation 2015年4月2日
 */
public class CourseScheduleException extends Exception {

	private static final long serialVersionUID = 1L;

	public CourseScheduleException() {
		super();
	}

	public CourseScheduleException(String message) {
		super(message);
	}

	public CourseScheduleException(String message, Throwable cause) {
		super(message, cause);
	}

	public CourseScheduleException(Throwable cause) {
		super(cause);
	}
}
