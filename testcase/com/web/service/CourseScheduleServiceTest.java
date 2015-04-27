package com.web.service;

import java.util.ArrayList;
import java.util.Date;
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

	//@Test
	public void testComputeScheduleDetailList() throws CourseScheduleException {
		List<Date> filterDateList = new ArrayList<Date>();
		filterDateList.add(DateFormat.stringToDate("2015-06-01"));
		CourseSchedule courseSchedule = new CourseSchedule();
		courseSchedule.setCourseType("2");
		courseSchedule.setEndDate(DateFormat.stringToDate("2015-06-07"));
		courseSchedule.setStartDate(DateFormat.stringToDate("2015-06-01"));
		courseSchedule.setStartTime(900);
		courseSchedule.setEndTime(1000);
		courseSchedule.setStudentId(1);
		courseSchedule.setTeacherId(19);
		courseSchedule.setWeekDays("2");
		List<CourseScheduleDetail> list = courseScheduleService
				.computeScheduleDetailList(courseSchedule, filterDateList,
						false);
		for (CourseScheduleDetail c : list) {
			System.out.println(c);
		}
	}
	@Test
	public void testComputeScheduleEndDate() {
		List<Date> filterDateList = new ArrayList<Date>();
		//filterDateList.add(DateFormat.stringToDate("2015-06-01"));
		CourseSchedule courseSchedule = new CourseSchedule();
		courseSchedule.setCourseType("2");
		courseSchedule.setStartDate(DateFormat.stringToDate("2015-06-01"));
		courseSchedule.setStartTime(900);
		courseSchedule.setEndTime(1000);
		courseSchedule.setTotalCourseHour(2);
		courseSchedule.setTeacherId(19);
		courseSchedule.setWeekDays("2");
		Date endDate = courseScheduleService.computeScheduleEndDate(
				courseSchedule, filterDateList);
		System.out.println(endDate);
	}

	// @Test
	public void testAddScheduleDetail() throws Exception {
		List<Date> filterDateList = new ArrayList<Date>();
		CourseSchedule courseSchedule = new CourseSchedule();
		courseSchedule.setCourseType("2");
		courseSchedule.setStartDate(DateFormat.stringToDate("2015-04-20"));
		courseSchedule.setEndDate(DateFormat.stringToDate("2015-04-24"));
		courseSchedule.setStartTime(900);
		courseSchedule.setEndTime(1000);
		courseSchedule.setStudentId(1);
		courseSchedule.setTeacherId(19);
		courseSchedule.setWeekDays("2,3");
		courseScheduleService.addScheduleDetail(courseSchedule, filterDateList);
	}

}
