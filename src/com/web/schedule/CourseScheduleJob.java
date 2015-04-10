package com.web.schedule;

import java.util.Date;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.service.BaseModelService;
import com.util.DateFormat;
import com.web.model.CourseSchedule;
import com.web.service.CourseScheduleService;
import com.web.service.OrderService;

/**
 * 课时作业
 * 
 * @author tanson lam
 * @creation 2015年4月9日
 */
public class CourseScheduleJob {
	private static final Logger logger = Logger.getLogger(OrderJob.class);
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
			String nowTimeStr = DateFormat.DateToString(new Date(),
					DateFormat.DATETIME_FORMAT2);
			List<CourseSchedule> scheduleList = baseModelService
					.find("is_finish='0' and CONCAT(DATE_FORMAT(DATE,'%Y%m%d'),LPAD(END_TIME, 4, 0),'00')"
							+ " <= '" + nowTimeStr + "'", CourseSchedule.class);
			logger.info(scheduleList.size());
			if (scheduleList == null || scheduleList.isEmpty())
				return;
			for (CourseSchedule courseSchedule : scheduleList) {
				courseScheduleService.confirmCourseHour(courseSchedule);
			}
		} catch (Exception e) {
			logger.error("error in checkOutTimeOrder", e);
		}finally{
			lock.unlock();
		}
	}

}
