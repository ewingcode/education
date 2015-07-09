/**
 * 
 */
package com.web.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.web.constant.CourseHourStatus;
import com.web.model.OrderCourseHourLog;

/**
 * 签单课时日志
 * 
 * @author tanson lam
 * @creation 2015年7月9日
 */
@Repository("orderCourseHourLogService")
public class OrderCourseHourLogService {
	@Resource
	private BaseDao baseDao;
	/**
	 * 获取指定计划的总消耗课时数
	 * 
	 * @param scheduleId
	 * @return
	 */
	public Integer getTotalCostHour(Integer scheduleId) {
		String sql = "select sum(costHour) from  "
				+ OrderCourseHourLog.class.getName() + " where schedule_id ="
				+ scheduleId + " and status='"
				+ CourseHourStatus.ALL_SETTLE.getValue() + "'";
		Long totalCosthour = baseDao.queryObject(sql, Long.class);
		if (totalCosthour == null)
			totalCosthour = 0l;
		return totalCosthour.intValue();
	}

	/**
	 * 获取指定计划的总消耗课时数
	 * 
	 * @param scheduleId
	 * @return
	 */
	public Integer getTotalCostHourForCourse(Integer orderCourseId) {
		String sql = "select sum(costHour) from  "
				+ OrderCourseHourLog.class.getName()
				+ " where order_course_id=" + orderCourseId + " and status='"
				+ CourseHourStatus.ALL_SETTLE.getValue() + "'";
		Long totalCosthour = baseDao.queryObject(sql, Long.class);
		if (totalCosthour == null)
			totalCosthour = 0l;
		return totalCosthour.intValue();
	}
}
