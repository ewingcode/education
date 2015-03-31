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
import com.core.app.service.SysParamService;
import com.core.app.service.SysRightRelService;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.util.DateFormat;
import com.web.bean.CourseScheduleDto;
import com.web.model.CourseScheduleView;
import com.web.model.TeacherInfo;
import com.web.service.CoursePeriodService;
import com.web.service.CourseScheduleService;
import com.web.service.TeacherService;

public class CourseCalenderAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);
	@Resource
	private TeacherService teacherService;
	@Resource
	private SysRightRelService sysRightRelService;
	@Resource
	private CoursePeriodService coursePeriodService;
	@Resource
	private CourseScheduleService courseScheduleService;
	@Resource
	private SysParamService sysParamService;
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
			List<CourseScheduleDto> scheudleList = getCourseSchduleList(
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

	private List<CourseScheduleDto> getCourseSchduleList(Integer teacherId,
			String month) throws DaoException {
		String[] startAndEndDate = DateFormat.monToStartEndDate(month);
		String startTime = startAndEndDate[0];
		String endTime = startAndEndDate[1];
		Date startDateOfmonth = DateFormat.stringToDate(startTime,
				DateFormat.DATE_FORMAT);
		Date endDateOfmonth = DateFormat.stringToDate(endTime,
				DateFormat.DATE_FORMAT);
		List<Integer> teacherIds = new ArrayList<Integer>();
		List<CourseScheduleDto> scheudleList = new ArrayList<CourseScheduleDto>();
		teacherIds.add(teacherId);
		List<List<Date>> calendarList = DateFormat.getCalendarWeekTime(month);

		List<CourseScheduleView> scheduleHis = courseScheduleService
				.getTeacherSchedule(teacherIds, startDateOfmonth,
						endDateOfmonth);
		for (List<Date> t : calendarList) {
			CourseScheduleDto dto = new CourseScheduleDto();
			dto.setContents(mergeScheduleContent(month, scheduleHis, t));
			scheudleList.add(dto);
		}

		return scheudleList;
	}

	private List<String> mergeScheduleContent(String month,
			List<CourseScheduleView> scheduleHis, List<Date> scheduleDateList) {
		List<String> scheduleContents = new ArrayList<String>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(DateFormat
				.stringToDate(month, DateFormat.YEAR_MONTH_FORMAT));
		int curMonth = cal.get(Calendar.MONTH);
		String backgroudColor = null;
		for (Date d : scheduleDateList) {
			StringBuffer periodSb = new StringBuffer();
			for (CourseScheduleView schedule : scheduleHis) {
				if (schedule.getDate().compareTo(d) == 0) {
					String courseName = schedule.getCourseName();
					String studentName = schedule.getStudentName();
					periodSb.append(cutTime(schedule.getStartTime()))
							.append("-").append(cutTime(schedule.getEndTime()));
					periodSb.append(" ").append(courseName).append(" ")
							.append(studentName);
					periodSb.append("<br>");
				}
			}
			cal.setTime(d);

			String day = DateFormat.DateToString(cal.getTime(),
					DateFormat.DAY_FORMAT);
			if (periodSb.length() > 0) {
				periodSb.insert(0, "<p align='center' >" + day + "</p><br>");

			} else {
				periodSb.append("<p align='center'>" + day + "</p><br>"
						+ "无安排<br><br><br><br><br><br><br>");
			}

			if (cal.get(Calendar.MONTH) != curMonth) {

				backgroudColor = "#BEBEBE";
			}

			periodSb.insert(0, "<div style='background-color: "
					+ backgroudColor + ";'>");
			periodSb.append("</div>");
			scheduleContents.add(periodSb.toString());
		}

		return scheduleContents;
	}
	private List<Date> getDateList(Date startDate, Date endDate) {
		List<Date> dateList = new ArrayList<Date>();
		Calendar cal = Calendar.getInstance();
		while (startDate.compareTo(endDate) <= 0) {
			cal.setTime(startDate);
			dateList.add(cal.getTime());
			cal.add(Calendar.DAY_OF_YEAR, 1);
			startDate = cal.getTime();
		}
		return dateList;
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
