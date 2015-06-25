package com.web.service;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.jbpm.BaseTest;
import com.core.factory.SpringCtx;
import com.web.exception.CourseScheduleException;
import com.web.exception.OrderException;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年4月20日
 */
public class CourseScheduleDetailServiceTest extends BaseTest {

	static CourseScheduleDetailService courseScheduleDetailService;

	@BeforeClass
	public static void init() {
		courseScheduleDetailService = (CourseScheduleDetailService) SpringCtx
				.getByBeanName("courseScheduleDetailService");
	}

	// @Test
	public void testDeleteScheduleDetail() throws Exception {
		courseScheduleDetailService.deleteScheduleDetailByScheduleId(23);
	}

	@Test
	public void testRollbackCourseHour() throws CourseScheduleException, OrderException {
		courseScheduleDetailService.rollbackCourseHour(10,"无上课", 1);
	}

}
