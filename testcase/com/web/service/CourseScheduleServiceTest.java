package com.web.service;

import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.jbpm.BaseTest;
import com.core.factory.SpringCtx;
import com.util.DateFormat;
import com.web.exception.CourseScheduleException;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleDetail;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年4月14日
 */
public class CourseScheduleServiceTest extends BaseTest {

	static CourseScheduleService courseScheduleService;

	@BeforeClass
	public static void init() {
		courseScheduleService = (CourseScheduleService) SpringCtx
				.getByBeanName("courseScheduleService");
	}

	// @Test
	public void testComputeScheduleDetailList() throws CourseScheduleException {
		CourseSchedule courseSchedule = new CourseSchedule();
		courseSchedule.setCourseType("3");
		courseSchedule.setEndDate(DateFormat.stringToDate("2015-04-24"));
		courseSchedule.setStartDate(DateFormat.stringToDate("2015-04-14"));
		courseSchedule.setStartTime(900);
		courseSchedule.setEndTime(1000);
		courseSchedule.setStudentId(1);
		courseSchedule.setTeacherId(19);
		courseSchedule.setWeekDays("2");
		List<CourseScheduleDetail> list = courseScheduleService
				.computeScheduleDetailList(courseSchedule, false);
		for (CourseScheduleDetail c : list) {
			System.out.println(c);
		}
	}

	@Test
	public void testAddScheduleDetail() throws Exception {
		CourseSchedule courseSchedule = new CourseSchedule();
		courseSchedule.setCourseType("2");
		courseSchedule.setStartDate(DateFormat.stringToDate("2015-04-20"));
		courseSchedule.setEndDate(DateFormat.stringToDate("2015-04-24"));
		courseSchedule.setStartTime(900);
		courseSchedule.setEndTime(1000);
		courseSchedule.setStudentId(1);
		courseSchedule.setTeacherId(19);
		courseSchedule.setWeekDays("2,3");
		courseScheduleService.addScheduleDetail(courseSchedule); 
	}

}
