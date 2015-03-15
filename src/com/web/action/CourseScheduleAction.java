/**
 * 
 */
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
import com.core.app.control.SessionException;
import com.core.app.service.SysParamService;
import com.core.app.service.SysRightRelService;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.util.DateFormat;
import com.util.SqlUtil;
import com.util.StringUtil;
import com.web.bean.CourseScheduleDto;
import com.web.model.CourseScheduleView;
import com.web.model.TeacherInfo;
import com.web.service.CoursePeriodService;
import com.web.service.CourseScheduleService;
import com.web.service.TeacherService;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年3月15日
 */
public class CourseScheduleAction extends BaseAction {
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
	public CourseScheduleAction() {
		super(TeacherInfo.class);
	}

	@Override
	public String getCondition() {
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = sysRightRelService.getAreaRightSql(request);
			if (!StringUtil.isEmpty(relAreaSql))
				return SqlUtil.combine(condition, relAreaSql);
		} catch (SessionException e) {
			e.printStackTrace();
		}
		return condition;
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void pageQuery() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			String startTime = request
					.getParameter("_QUERY_schedule_startTime");
			String endTime = request.getParameter("_QUERY_schedule_endTime");
			Date startDate = DateFormat.stringToDate(
					startTime.replace("T", " "), DateFormat.DATETIME_FORMAT);
			Date endDate = DateFormat.stringToDate(endTime.replace("T", " "),
					DateFormat.DATETIME_FORMAT);
			PageBean pageBean = baseModelService.pageQuery(bulidConditionSql(),
					bulidOrderBySql(), Integer.valueOf(limit),
					Integer.valueOf(start), entityClass);
			List<CourseScheduleDto> scheudleList = getCourseSchduleList(
					(List<TeacherInfo>) pageBean.getResult(), startDate,
					endDate);
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

	private List<CourseScheduleDto> getCourseSchduleList(
			List<TeacherInfo> teacherInfoList, Date startDate, Date endDate)
			throws DaoException {
		List<Integer> teacherIds = new ArrayList<Integer>();
		List<CourseScheduleDto> scheudleList = new ArrayList<CourseScheduleDto>();

		for (TeacherInfo t : teacherInfoList) {
			teacherIds.add(t.getId());
		}
		List<Date> scheduleDateList = getDateList(startDate, endDate);

		List<CourseScheduleView> scheduleHis = courseScheduleService
				.getTeacherSchedule(teacherIds, startDate, endDate);
		for (TeacherInfo t : teacherInfoList) {
			CourseScheduleDto dto = new CourseScheduleDto();
			dto.setTeacherId(t.getId());
			dto.setTeacherName(t.getUserName());
			dto.setContents(mergeScheduleContent(t.getId(), scheduleHis,
					scheduleDateList));
			scheudleList.add(dto);
		}

		return scheudleList;
	}

	private List<String> mergeScheduleContent(Integer teacherId,
			List<CourseScheduleView> scheduleHis, List<Date> scheduleDateList) {
		List<String> scheduleContents = new ArrayList<String>();
		for (Date d : scheduleDateList) {
			StringBuffer periodSb = new StringBuffer();
			for (CourseScheduleView schedule : scheduleHis) {
				if (schedule.getTeacherId().equals(teacherId)
						&& schedule.getDate().compareTo(d) == 0) {
					String courseName = schedule.getCourseName();
					String studentName = schedule.getStudentName();
					periodSb.append(cutTime(schedule.getStartTime()))
							.append("-").append(cutTime(schedule.getEndTime()));
					periodSb.append(" ").append(courseName).append(" ")
							.append(studentName);
					periodSb.append("<br>");
				}
			}
			if (periodSb.length() > 0) {
				scheduleContents.add(periodSb.toString());
			} else {
				scheduleContents.add("无安排");
			}
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
