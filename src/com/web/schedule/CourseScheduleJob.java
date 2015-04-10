package com.web.schedule;

import java.util.Date;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.service.BaseModelService;
import com.util.DateFormat;
import com.web.constant.CourseScheduleIsFinish;
import com.web.model.CourseSchedule;
import com.web.service.CourseScheduleService;
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
	private CourseScheduleService courseScheduleService;

	private static ReentrantLock lock = new ReentrantLock(false);

	public void execute() {
		try {
			lock.lock();
			List<CourseSchedule> scheduleList = courseScheduleService
					.getNotFinishSchedule();
			logger.info(scheduleList.size());
			if (scheduleList == null || scheduleList.isEmpty())
				return;
			for (CourseSchedule courseSchedule : scheduleList) {
				courseScheduleService.confirmCourseHour(courseSchedule);
			}
		} catch (Exception e) {
			logger.error("error in CourseScheduleJob", e);
		} finally {
			lock.unlock();
		}
	}

}
