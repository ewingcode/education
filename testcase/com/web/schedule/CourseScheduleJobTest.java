package com.web.schedule;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.jbpm.BaseTest;
import com.core.factory.SpringCtx;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年4月20日
 */
public class CourseScheduleJobTest extends BaseTest {

	static CourseScheduleJob courseScheduleJob;

	@BeforeClass
	public static void init() {
		courseScheduleJob = (CourseScheduleJob) SpringCtx
				.getByBeanName("courseScheduleJob");
	}

	@Test
	public void testExecute() {
		courseScheduleJob.execute();
	}
}
