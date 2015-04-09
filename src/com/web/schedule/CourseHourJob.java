package com.web.schedule;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.service.BaseModelService;
import com.util.DateFormat;
import com.web.model.CourseSchedule;
import com.web.model.OrderInfo;
import com.web.service.OrderService;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年4月9日
 */
public class CourseHourJob {
	private static final Logger logger = Logger.getLogger(OrderJob.class);
	@Resource
	private BaseModelService baseModelService;
	@Resource
	private OrderService orderService;

	public void execute() {
		try {
			String nowTimeStr = DateFormat.DateToString(new Date(), DateFormat.DATETIME_FORMAT2);
			List<CourseSchedule> orderList = baseModelService
					.find("is_finish='0' and CONCAT(DATE_FORMAT(DATE,'%Y%m%d'),LPAD(END_TIME, 4, 0),'00')"
							+ " <= '"+nowTimeStr+"'",
							CourseSchedule.class);
		 
			 
			logger.info(orderList.size());
		} catch (Exception e) {
			logger.error("error in checkOutTimeOrder", e);
		}
	}
}
