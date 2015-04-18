package com.web.schedule;

import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.service.BaseModelService;
import com.web.model.CourseScheduleDetail;
import com.web.service.CourseScheduleDetailService;
import com.web.service.OrderService;

/**
 * 排课课时计算作业
 * 
 * @author tanson lam
 * @creation 2015年4月9日
 */
public class CourseScheduleJob {
	private static final Logger logger = Logger
			.getLogger(CourseScheduleJob.class);
	@Resource
	private BaseModelService baseModelService;
	@Resource
	private OrderService orderService;
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;

	private static ReentrantLock lock = new ReentrantLock(false);

	public void execute() {
		try {
			lock.lock();
			List<CourseScheduleDetail> scheduleList = courseScheduleDetailService
					.getNotFinishSchedule();
			logger.info(scheduleList.size());
			if (scheduleList == null || scheduleList.isEmpty())
				return;
			for (CourseScheduleDetail courseSchedule : scheduleList) {
				courseScheduleDetailService.confirmCourseHour(courseSchedule);
			}
		} catch (Exception e) {
			logger.error("error in CourseScheduleJob", e);
		} finally {
			lock.unlock();
		}
	}

}
