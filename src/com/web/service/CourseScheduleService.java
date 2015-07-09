package com.web.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.app.constant.IsEff;
import com.core.jdbc.BaseDao;
import com.util.DateFormat;
import com.web.constant.CourseHourStatus;
import com.web.constant.CourseScheduleStatus;
import com.web.constant.OrderRunStatus;
import com.web.exception.CourseScheduleException;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleDetail;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseHourLog;
import com.web.model.OrderInfo;

@Repository("courseScheduleService")
public class CourseScheduleService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;
	@Resource
	private OrderCourseHourLogService orderCourseHourLogService;
	/**
	 * 计算出排课列表
	 * 
	 * @param scheduleTempldate
	 * @throws CourseScheduleException
	 */
	public List<CourseScheduleDetail> computeScheduleDetailList(
			CourseSchedule scheduleTempldate, List<Date> filterDateList,
			Boolean throwErr) throws CourseScheduleException {
		List<CourseScheduleDetail> scheduleList = new ArrayList<CourseScheduleDetail>();
		Integer teacherId = scheduleTempldate.getTeacherId();
		Integer studentId = scheduleTempldate.getStudentId();
		Integer startTime = scheduleTempldate.getStartTime();
		Integer endTime = scheduleTempldate.getEndTime();
		String courseType = scheduleTempldate.getCourseType();
		Date startDay = scheduleTempldate.getStartDate();
		Date endDay = scheduleTempldate.getEndDate();
		String weekDayStr = scheduleTempldate.getWeekDays();
		String[] weekDays = weekDayStr.split(",");
		List<Date> scheduleDateList = DateFormat.getDateList(startDay, endDay);
		// 获取学生所有的签单课程信息
		String sql = " order_id in  (select id from  "
				+ OrderInfo.class.getName() + " a where a.studentId="
				+ studentId + " and a.runStatus='" + OrderRunStatus.RUNNING
				+ "' ) and course_type='" + courseType
				+ "' order by order_id asc";
		List<OrderCourse> orderCourseList = baseDao
				.find(sql, OrderCourse.class);
		Calendar cal = Calendar.getInstance();
		for (Date d : scheduleDateList) {
			if (filterDateList != null && filterDateList.contains(d))
				continue;
			cal.setTime(d);
			int week = cal.get(Calendar.DAY_OF_WEEK);
			for (String weekday : weekDays) {
				if (week == Integer.valueOf(weekday)) {
					CourseScheduleDetail courseSchedule = courseScheduleDetailService
							.validateCourseSchedule(teacherId, studentId, d,
									courseType, startTime, endTime,
									orderCourseList, throwErr);
					scheduleList.add(courseSchedule);
				}
			}
		}
		return scheduleList;
	}

	/**
	 * 批量创建的排课计划
	 * 
	 * @param scheduleTempldate
	 * @return
	 * @throws CourseScheduleException
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 */

	@Transactional(rollbackFor = Exception.class)
	public List<CourseScheduleDetail> addScheduleDetail(
			CourseSchedule scheduleTempldate, List<Date> filterDateList)
			throws Exception {
		List<CourseScheduleDetail> scheduleList;

		scheduleList = computeScheduleDetailList(scheduleTempldate,
				filterDateList, true);
		Integer totalCourseHour = 0;
		for (CourseScheduleDetail schedule : scheduleList) {
			totalCourseHour += courseScheduleDetailService.computeScheduleHour(
					schedule.getEndTime(), schedule.getStartTime());
		}
		scheduleTempldate.setTotalCourseHour(totalCourseHour);
		scheduleTempldate.setIseff(IsEff.EFFECTIVE);
		scheduleTempldate.setStatus(CourseScheduleStatus.NOTBEGIN.getValue());
		baseDao.save(scheduleTempldate);

		for (CourseScheduleDetail schedule : scheduleList) {
			schedule.setScheduleId(scheduleTempldate.getId());
			courseScheduleDetailService.addSchedule(schedule);
		}
		return scheduleList;
	}

	public CourseSchedule findOne(Integer templateId) {
		return baseDao.findOne(templateId, CourseSchedule.class);
	}

	/**
	 * 更新模板消耗的课时
	 * 
	 * @param orderId
	 */
	public void updateScheduleCostHour(Integer scheduleId) {
		CourseSchedule scheduleTemplate = findOne(scheduleId);
		if (scheduleTemplate == null)
			return;
		Integer totalCosthour = orderCourseHourLogService
				.getTotalCostHour(scheduleId);
		Integer totalSchedulehour = courseScheduleDetailService
				.getTotalScheduleHour(scheduleId);
		scheduleTemplate.setTotalCostHour(totalCosthour.intValue());
		scheduleTemplate.setTotalCourseHour(totalSchedulehour);
		if (scheduleTemplate.getTotalCourseHour() > scheduleTemplate
				.getTotalCostHour() && scheduleTemplate.getTotalCostHour() > 0)
			scheduleTemplate.setStatus(CourseScheduleStatus.RUNNING.getValue());
		else if (scheduleTemplate.getTotalCourseHour() == scheduleTemplate
				.getTotalCostHour())
			scheduleTemplate
					.setStatus(CourseScheduleStatus.FINISHED.getValue());
		else if (totalCosthour == 0)
			scheduleTemplate
					.setStatus(CourseScheduleStatus.NOTBEGIN.getValue());
		baseDao.update(scheduleTemplate);
	}

	/**
	 * 计算计划结束日期
	 * 
	 * @param courseSchedule
	 * @param filterDateList
	 * @return
	 */
	public Date computeScheduleEndDate(CourseSchedule courseSchedule,
			List<Date> filterDateList) {
		Integer endTime = courseSchedule.getEndTime();
		Integer startTime = courseSchedule.getStartTime();
		Date startDate = courseSchedule.getStartDate();
		int costHour = courseScheduleDetailService.computeScheduleHour(endTime,
				startTime);
		String weekDayStr = courseSchedule.getWeekDays();
		String[] weekDays = weekDayStr.split(",");
		Integer totalHour = courseSchedule.getTotalCourseHour();
		Calendar cal = Calendar.getInstance();
		cal.setTime(startDate);
		while (true) {
			if (filterDateList != null
					&& filterDateList.contains(cal.getTime())) {
				cal.add(Calendar.DATE, 1);
				continue;
			}
			int week = cal.get(Calendar.DAY_OF_WEEK);
			for (String weekday : weekDays) {
				if (week == Integer.valueOf(weekday)) {
					totalHour -= costHour;
				}
			}
			if (totalHour == 0)
				break;
			cal.add(Calendar.DATE, 1);
		}
		return cal.getTime();
	}
}
