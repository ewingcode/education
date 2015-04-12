package com.web.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.CoursePeriod;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleDetail;
import com.web.service.CoursePeriodService;
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

	private CourseScheduleService courseScheduleService;
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
			for (CoursePeriod periodEntity : periodList) {
				if (periodEntity.getId().equals(coursePeriod)) {
					courseSchedule.setStartTime(periodEntity.getStartTime());
					courseSchedule.setEndTime(periodEntity.getEndTime());
					break;
				}
			}
			List<CourseScheduleDetail> scheduleList = courseScheduleService
					.computeScheduleDetailList(courseSchedule);
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
	 * 计算出排课的总课时
	 * 
	 * @throws ActionException
	 */
	public void computeScheduleCourseHour() throws ActionException {
		ResponseData responseData = null;
		try {
			CourseSchedule courseSchedule = new CourseSchedule();
			super.buildPageData(courseSchedule);
			Integer coursePeriod = Integer.valueOf(request
					.getParameter("coursePeriod"));
			List<CoursePeriod> periodList = coursePeriodService
					.getCoursePeriod();
			for (CoursePeriod periodEntity : periodList) {
				if (periodEntity.getId().equals(coursePeriod)) {
					courseSchedule.setStartTime(periodEntity.getStartTime());
					courseSchedule.setEndTime(periodEntity.getEndTime());
					break;
				}
			}
			courseSchedule = courseScheduleService
					.computeScheduleCourseHour(courseSchedule);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(courseSchedule);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！" + e.getMessage());
		}
		this.outResult(responseData);
	}

}
