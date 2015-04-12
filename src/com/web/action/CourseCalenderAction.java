package com.web.action;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.jdbc.util.PageBean;
import com.util.DateFormat;
import com.web.bean.CourseScheduleListDto;
import com.web.model.CourseScheduleView;
import com.web.model.TeacherInfo;
import com.web.service.CoursePeriodService;
import com.web.service.CourseScheduleDetailService;
import com.web.service.TeacherService;

/**
 * 排课日程列表，以月历的形式展示排课信息
 * 
 * @author tanson lam
 * @creation 2015年4月2日
 */
public class CourseCalenderAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);
	@Resource
	private TeacherService teacherService;
	@Resource
	private CoursePeriodService coursePeriodService;
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;

	public CourseCalenderAction() {
		super(TeacherInfo.class);
	}

	/**
	 * 单个教师的整月排课
	 * 
	 * @throws ActionException
	 */
	public void showMonthSchedule() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			Integer teacherId = Integer.valueOf(request
					.getParameter("teacherId"));
			String month = request.getParameter("month");
			List<CourseScheduleListDto> scheudleList = getCourseSchduleList(
					teacherId, month);
			PageBean pageBean = new PageBean();
			pageBean.setResult(scheudleList);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * 按照月份关联获取每天已经排课的信息，如当日没有排课记录的则以“无排课”字符占空。
	 * 
	 * @param teacherId
	 * @param month
	 * @return
	 */
	private List<CourseScheduleListDto> getCourseSchduleList(Integer teacherId,
			String month) {
		String[] startAndEndDate = DateFormat.monToStartEndDate(month);
		String startTime = startAndEndDate[0];
		String endTime = startAndEndDate[1];
		Date startDateOfmonth = DateFormat.stringToDate(startTime,
				DateFormat.DATE_FORMAT);
		Date endDateOfmonth = DateFormat.stringToDate(endTime,
				DateFormat.DATE_FORMAT);
		List<Integer> teacherIds = new ArrayList<Integer>();
		List<CourseScheduleListDto> scheudleList = new ArrayList<CourseScheduleListDto>();
		teacherIds.add(teacherId);
		List<List<Date>> calendarList = DateFormat.getCalendarWeekTime(month);

		List<CourseScheduleView> scheduleHis = courseScheduleDetailService
				.getTeacherSchedule(teacherIds, startDateOfmonth,
						endDateOfmonth);
		for (List<Date> t : calendarList) {
			CourseScheduleListDto dto = new CourseScheduleListDto();
			dto.setContents(mergeScheduleContent(teacherId, month, scheduleHis,
					t));
			scheudleList.add(dto);
		}

		return scheudleList;
	}

	/**
	 * 合并排课的内容展示在页面，内容会包含html，js的
	 * 
	 * @param teacherId
	 * @param month
	 * @param scheduleHis
	 * @param scheduleDateList
	 * @return
	 */
	private List<String> mergeScheduleContent(Integer teacherId, String month,
			List<CourseScheduleView> scheduleHis, List<Date> scheduleDateList) {
		List<String> scheduleContents = new ArrayList<String>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(DateFormat
				.stringToDate(month, DateFormat.YEAR_MONTH_FORMAT));
		int curMonth = cal.get(Calendar.MONTH);
		String backgroudColor = null;
		StringBuffer periodSb = null;
		StringBuffer jsSb = null;
		boolean hasRel;
		for (Date d : scheduleDateList) {
			cal.setTime(d);
			String day = DateFormat.DateToString(cal.getTime(),
					DateFormat.DAY_FORMAT);
			hasRel = false;
			periodSb = new StringBuffer();
			jsSb = new StringBuffer();
			for (CourseScheduleView schedule : scheduleHis) {
				if (schedule.getDate().compareTo(d) == 0) {
					String courseName = schedule.getCourseName();
					String studentName = schedule.getStudentName();
					periodSb.append(cutTime(schedule.getStartTime()))
							.append("-").append(cutTime(schedule.getEndTime()));
					periodSb.append(" ").append(courseName).append(" ")
							.append(studentName);
					periodSb.append("<br>");
					hasRel = true;
				}
			}

			if (hasRel)
				jsSb.append("<a href='#' onclick=\"new Schedule.showDailySchedule('"
						+ teacherId
						+ "','"
						+ DateFormat.DateToString(cal.getTime(),
								DateFormat.DATE_FORMAT) + "')\" >");

			if (periodSb.length() > 0) {
				periodSb.insert(0, jsSb.toString() + "<p align='center' >"
						+ day + "</p><br>");
				periodSb.append("</a>");
			} else {
				periodSb.append("<p align='center'>" + day + "</p><br>"
						+ "无安排<br><br><br><br><br><br><br>");
			}

			if (cal.get(Calendar.MONTH) == curMonth) {
				backgroudColor = "#FFFFFF";
				periodSb.insert(0, "<div style='background-color: "
						+ backgroudColor + ";'>");
				periodSb.append("</div>");
				scheduleContents.add(periodSb.toString());
			} else {
				scheduleContents.add("");
			}

		}

		return scheduleContents;
	}

	private String cutTime(Integer time) {
		String timeStr = time.toString();
		if (timeStr.length() == 4)
			return timeStr.substring(0, 2) + ":" + timeStr.substring(2, 4);
		if (timeStr.length() == 3)
			return "0" + timeStr.substring(0, 1) + ":"
					+ timeStr.substring(1, 3);
		if (timeStr.length() < 3)
			return "00:" + timeStr;
		return "";
	}
}
