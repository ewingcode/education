package com.web.action;

import java.util.ArrayList;
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
import com.web.bean.CourseScheduleListDto;
import com.web.model.CourseScheduleView;
import com.web.model.OrderCourse;
import com.web.model.TeacherInfo;
import com.web.service.CoursePeriodService;
import com.web.service.CourseScheduleDetailService;
import com.web.service.OrderCourseService;
import com.web.service.TeacherService;

/**
 * 排课计划
 * 
 * @author tanson lam
 * @creation 2015年3月15日
 */
public class CourseScheduleDetailAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);
	@Resource
	private TeacherService teacherService;
	@Resource
	private SysRightRelService sysRightRelService;
	@Resource
	private CoursePeriodService coursePeriodService;
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;
	@Resource
	private SysParamService sysParamService;
	@Resource
	private OrderCourseService orderCourseService;

	public CourseScheduleDetailAction() {
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
	 * 显示排课日程
	 * 
	 * @throws ActionException
	 */
	public void showCalendar() throws ActionException {
		ResponseData responseData = null;
		try {

			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			String[] startAndEndDate = DateFormat.monToStartEndDate("2015-03");
			String startTime = startAndEndDate[0];
			String endTime = startAndEndDate[1];
			Date startDate = DateFormat.stringToDate(startTime,
					DateFormat.DATETIME_FORMAT);
			Date endDate = DateFormat.stringToDate(endTime,
					DateFormat.DATETIME_FORMAT);
			PageBean pageBean = baseModelService.pageQuery(bulidConditionSql(),
					bulidOrderBySql(), Integer.valueOf(limit),
					Integer.valueOf(start), entityClass);
			List<CourseScheduleListDto> scheudleList = getCourseSchduleList(
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
			List<CourseScheduleListDto> scheudleList = getCourseSchduleList(
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

	private List<CourseScheduleListDto> getCourseSchduleList(
			List<TeacherInfo> teacherInfoList, Date startDate, Date endDate)
			throws DaoException {
		List<Integer> teacherIds = new ArrayList<Integer>();
		List<CourseScheduleListDto> scheudleList = new ArrayList<CourseScheduleListDto>();

		for (TeacherInfo t : teacherInfoList) {
			teacherIds.add(t.getId());
		}
		List<Date> scheduleDateList = DateFormat.getDateList(startDate, endDate);

		List<CourseScheduleView> scheduleHis = courseScheduleDetailService
				.getTeacherSchedule(teacherIds, startDate, endDate);
		for (TeacherInfo t : teacherInfoList) {
			CourseScheduleListDto dto = new CourseScheduleListDto();
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
					periodSb.append(DateFormat.cutTime(schedule.getStartTime()))
							.append("-")
							.append(DateFormat.cutTime(schedule.getEndTime()));
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

	

	/**
	 * 获取学生的签单课程信息
	 * 
	 * @throws ActionException
	 */
	public void getOrderCourseForStudent() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer studentId = Integer.valueOf(request
					.getParameter("studentId"));
			String courseType = request.getParameter("courseType");
			OrderCourse orderCourse = orderCourseService
					.getOrderCourseForStudent(studentId, courseType);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(orderCourse);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

}
