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
import com.web.constant.CourseScheduleIsFinish;
import com.web.constant.OrderRunStatus;
import com.web.exception.CourseScheduleException;
import com.web.model.CourseScheduleDetail;
import com.web.model.CourseSchedule;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseHourLog;
import com.web.model.OrderInfo;

@Repository("courseScheduleService")
public class CourseScheduleService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;

	/**
	 * 计算出排课的总课时
	 * 
	 * @param scheduleTempldate
	 * @throws CourseScheduleException
	 * @throws InvocationTargetException
	 * @throws IllegalAccessException
	 */
	public CourseSchedule computeScheduleCourseHour(
			CourseSchedule scheduleTempldate) throws Exception {
		// 总课时
		Integer totalCourseHour = 0;
		List<CourseScheduleDetail> scheduleList = computeScheduleDetailList(scheduleTempldate);
		for (CourseScheduleDetail schedule : scheduleList) {
			totalCourseHour += courseScheduleDetailService.computeScheduleHour(
					schedule.getEndTime(), schedule.getStartTime());
		}
		scheduleTempldate.setTotalCourseHour(totalCourseHour);
		return scheduleTempldate;
	}

	/**
	 * 计算出排课列表
	 * 
	 * @param scheduleTempldate
	 * @throws CourseScheduleException
	 */
	public List<CourseScheduleDetail> computeScheduleDetailList(
			CourseSchedule scheduleTempldate) throws CourseScheduleException {
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
			int week = cal.get(Calendar.WEEK_OF_YEAR);
			for (String weekday : weekDays) {
				if (week == Integer.valueOf(weekday)) {
					CourseScheduleDetail courseSchedule = courseScheduleDetailService
							.validateCourseSchedule(teacherId, studentId, d,
									courseType, startTime, endTime,
									orderCourseList);
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
	@Transactional
	public List<CourseScheduleDetail> addScheduleDetail(
			CourseSchedule scheduleTempldate) throws Exception {
		List<CourseScheduleDetail> scheduleList = computeScheduleDetailList(scheduleTempldate);
		Integer totalCourseHour = 0;
		for (CourseScheduleDetail schedule : scheduleList) {
			courseScheduleDetailService.addSchedule(schedule);
			totalCourseHour += courseScheduleDetailService.computeScheduleHour(
					schedule.getEndTime(), schedule.getStartTime());
		}
		scheduleTempldate.setTotalCourseHour(totalCourseHour);
		scheduleTempldate.setIseff(IsEff.EFFECTIVE);
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
		String sql = "select sum(costHour) from  "
				+ OrderCourseHourLog.class.getName() + " where schedule_id ="
				+ scheduleId;
		Long totalCosthour = baseDao.queryObject(sql, Long.class);
		scheduleTemplate.setTotalCostHour(totalCosthour.intValue());
		baseDao.update(scheduleTemplate);
	}

	/**
	 * 删除排课模板，并且删除没有结束的排课计划
	 * 
	 * @param scheduleId
	 */
	@Transactional
	public void deleteScheduleDetail(Integer scheduleId) {
		CourseSchedule scheduleTemplate = findOne(scheduleId);
		if (scheduleTemplate == null)
			return;
		String deleteSql = "delete from course_schedule_detail  where schedule_id ="
				+ scheduleId
				+ " and is_finish="
				+ CourseScheduleIsFinish.NOTFINISH.getValue();
		baseDao.executeSql(deleteSql);
		baseDao.delete(scheduleTemplate);
	}

}
