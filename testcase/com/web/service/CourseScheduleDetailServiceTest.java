package com.web.service;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.jbpm.BaseTest;
import com.core.factory.SpringCtx;
import com.web.exception.CourseScheduleException;

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
		courseScheduleDetailService.deleteScheduleDetail(23);
	}

	@Test
	public void testRollbackCourseHour() throws CourseScheduleException {
		courseScheduleDetailService.rollbackCourseHour(10, 1);
	}

}
