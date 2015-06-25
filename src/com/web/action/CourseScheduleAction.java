package com.web.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.axis.utils.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.util.DateFormat;
import com.web.constant.CourseScheduleDetailIsFinish;
import com.web.model.CoursePeriod;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleDetail;
import com.web.service.CoursePeriodService;
import com.web.service.CourseScheduleDetailService;
import com.web.service.CourseScheduleService;

/**
 * 排课计划的模板
 * 
 * @author tanson lam
 * @creation 2015年3月15日
 */
public class CourseScheduleAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);

	public CourseScheduleAction() {
		super(CourseSchedule.class);
	}

	@Resource
	private CoursePeriodService coursePeriodService;
	@Resource
	private CourseScheduleService courseScheduleService;
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;

	/**
	 * 计算出排课列表
	 * 
	 * @throws ActionException
	 */
	public void computeScheduleList() throws ActionException {
		ResponseData responseData = null;
		try {
			CourseSchedule courseSchedule = new CourseSchedule();
			super.buildPageData(courseSchedule);
			Integer coursePeriod = Integer.valueOf(request
					.getParameter("coursePeriod"));
			List<CoursePeriod> periodList = coursePeriodService
					.getCoursePeriod();
			String deleteScheduleDates = request
					.getParameter("deleteScheduleDates");
			List<Date> filterDateList = new ArrayList<Date>();
			if (!StringUtils.isEmpty(deleteScheduleDates)) {
				String[] deleteScheduleDateArr = deleteScheduleDates.split(",");
				for (String dateStr : deleteScheduleDateArr)
					filterDateList.add(DateFormat.stringToDate(dateStr));
			}
			for (CoursePeriod periodEntity : periodList) {
				if (periodEntity.getId().equals(coursePeriod)) {
					courseSchedule.setStartTime(periodEntity.getStartTime());
					courseSchedule.setEndTime(periodEntity.getEndTime());
					break;
				}
			}
			List<CourseScheduleDetail> scheduleList = courseScheduleService
					.computeScheduleDetailList(courseSchedule, filterDateList,
							false);
			long totalScheduleHour = 0l;
			for (int i = 0; i < scheduleList.size(); i++) {
				scheduleList.get(i).setId(i);
				totalScheduleHour += courseScheduleDetailService
						.computeScheduleHour(scheduleList.get(i).getEndTime(),
								scheduleList.get(i).getStartTime());
			}
			if (scheduleList != null && !scheduleList.isEmpty()) {
				scheduleList.get(0).setTotalScheduleHour(totalScheduleHour);
			}
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(scheduleList.size());
			responseData.setResult(scheduleList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！" + e.getMessage());
		}
		this.outResult(responseData);
	}

	/**
	 * 显示排课计划的详细列表
	 * 
	 * @throws ActionException
	 */
	public void showScheduleDetailList() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer scheduleId = Integer.valueOf(request
					.getParameter("scheduleId"));

			List<CourseScheduleDetail> scheduleList = courseScheduleDetailService
					.getCourseScheduleDetailList(scheduleId);
			long totalScheduleHour = 0l;
			long totalCostScheduleHour = 0l;
			for (int i = 0; i < scheduleList.size(); i++) {
				CourseScheduleDetail courseScheduleDetail = scheduleList.get(i);
				//courseScheduleDetail.setId(i);
				Integer hour = courseScheduleDetailService.computeScheduleHour(
						courseScheduleDetail.getEndTime(),
						courseScheduleDetail.getStartTime());
				totalScheduleHour += hour;
				if (courseScheduleDetail.getIsFinish().equals(
						CourseScheduleDetailIsFinish.FINISHED.getValue())) {
					totalCostScheduleHour += hour;
				}
			}
			if (scheduleList != null && !scheduleList.isEmpty()) {
				scheduleList.get(0).setTotalScheduleHour(totalScheduleHour);
				scheduleList.get(0).setTotalCostScheduleHour(
						totalCostScheduleHour);
			}
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(scheduleList.size());
			responseData.setResult(scheduleList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！" + e.getMessage());
		}
		this.outResult(responseData);
	}

	public void saveSchedule() throws ActionException {
		ResponseData responseData = null;
		try {
			CourseSchedule courseSchedule = new CourseSchedule();
			super.buildPageData(courseSchedule);
			Integer coursePeriod = Integer.valueOf(request
					.getParameter("coursePeriod"));
			List<CoursePeriod> periodList = coursePeriodService
					.getCoursePeriod();
			String deleteScheduleDates = request
					.getParameter("deleteScheduleDates");
			List<Date> filterDateList = new ArrayList<Date>();
			if (!StringUtils.isEmpty(deleteScheduleDates)) {
				String[] deleteScheduleDateArr = deleteScheduleDates.split(",");
				for (String dateStr : deleteScheduleDateArr)
					filterDateList.add(DateFormat.stringToDate(dateStr));
			}
			for (CoursePeriod periodEntity : periodList) {
				if (periodEntity.getId().equals(coursePeriod)) {
					courseSchedule.setStartTime(periodEntity.getStartTime());
					courseSchedule.setEndTime(periodEntity.getEndTime());
					break;
				}
			}
			courseScheduleService.addScheduleDetail(courseSchedule,
					filterDateList);
			responseData = ResponseUtils.success("成功新建排课计划！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新建失败！" + e.getMessage());
		}
		this.outResult(responseData);
	}
	/**
	 * 计算计划结束日期
	 * 
	 * @throws ActionException
	 */
	public void computeScheduleEndDate() throws ActionException {
		ResponseData responseData = null;
		try {
			CourseSchedule courseSchedule = new CourseSchedule();
			super.buildPageData(courseSchedule);
			Integer coursePeriod = Integer.valueOf(request
					.getParameter("coursePeriod"));
			List<CoursePeriod> periodList = coursePeriodService
					.getCoursePeriod();
			String deleteScheduleDates = request
					.getParameter("deleteScheduleDates");
			List<Date> filterDateList = new ArrayList<Date>();
			if (!StringUtils.isEmpty(deleteScheduleDates)) {
				String[] deleteScheduleDateArr = deleteScheduleDates.split(",");
				for (String dateStr : deleteScheduleDateArr)
					filterDateList.add(DateFormat.stringToDate(dateStr));
			}
			for (CoursePeriod periodEntity : periodList) {
				if (periodEntity.getId().equals(coursePeriod)) {
					courseSchedule.setStartTime(periodEntity.getStartTime());
					courseSchedule.setEndTime(periodEntity.getEndTime());
					break;
				}
			}
			Date date = courseScheduleService.computeScheduleEndDate(
					courseSchedule, filterDateList);
			responseData = ResponseUtils.success("成功计算计划结束日期！");
			responseData.setResult(DateFormat.DateToString(date));
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail( e.getMessage());
		}
		this.outResult(responseData);
	}

	/**
	 * 删除排课计划
	 * 
	 * @throws ActionException
	 */
	@Override
	public void delete() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer scheduleId = Integer.valueOf(request
					.getParameter("scheduleId"));
			courseScheduleDetailService.deleteScheduleDetailByScheduleId(scheduleId);
			responseData = ResponseUtils.success("删除成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("删除失败！");
		}
		this.outResult(responseData);
	}
}
