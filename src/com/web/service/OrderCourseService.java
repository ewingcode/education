package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.model.SysParam;
import com.core.app.service.SysParamService;
import com.core.jdbc.BaseDao;
import com.web.constant.CourseHourStatus;
import com.web.constant.OrderAttachStatus;
import com.web.constant.OrderCourseStatus;
import com.web.constant.OrderRunStatus;
import com.web.constant.SysParamConstant;
import com.web.exception.OrderException;
import com.web.model.CourseScheduleDetail;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseHourLog;
import com.web.model.OrderInfo;

/**
 * 签单课程
 * 
 */
@Repository("orderCourseService")
public class OrderCourseService {
	@Resource
	private BaseDao baseDao;

	@Resource
	private SysParamService sysParamService;

	public OrderCourse findOrderCourse(Integer orderCourseId) {
		return baseDao.findOne(orderCourseId, OrderCourse.class);
	}

	/**
	 * 更新签单课程的消耗课时
	 * 
	 * @param orderCourseId
	 */
	public void updateCourseCostHour(Integer orderCourseId) {
		OrderCourse orderCourse = findOrderCourse(orderCourseId);
		String sql = "select sum(costHour) from  "
				+ OrderCourseHourLog.class.getName()
				+ " where order_course_id=" + orderCourseId + " and status='"
				+ CourseHourStatus.ALL_SETTLE.getValue() + "'";
		Long totalCosthour = baseDao.queryObject(sql, Long.class);

		orderCourse.setCostHour(totalCosthour == null ? 0 : totalCosthour
				.intValue());
		baseDao.update(orderCourse);
	}

	/**
	 * 更新签单课程的已经排课的课时
	 * 
	 * @param orderCourseId
	 * @throws OrderException
	 */
	public void updateCourseScheduleHour(Integer orderCourseId)
			throws OrderException {
		OrderCourse orderCourse = findOrderCourse(orderCourseId);
		String sql = "select sum((endTime - startTime)/100)  from  "
				+ CourseScheduleDetail.class.getName()
				+ " where order_course_id=" + orderCourseId;
		Long totalSchedulehour = baseDao.queryObject(sql, Long.class);
		if (totalSchedulehour != null
				&& totalSchedulehour.intValue() > orderCourse.getHour()) {
			SysParam courseTypeSysParam = sysParamService.getParamByValue(
					SysParamConstant.ORDER_COURSE.name(),
					orderCourse.getCourseType());
			throw new OrderException("计划时间不能大于科目["
					+ courseTypeSysParam.getParamName() + "]总课时!");
		}
		orderCourse.setScheduleHour(totalSchedulehour == null ? 0
				: totalSchedulehour.intValue());
		baseDao.update(orderCourse);
	}

	/**
	 * 创建签单的课程信息
	 * 
	 * @param courseTypes
	 * @param orderId
	 *            @
	 */
	public void saveOrderCourse(int orderId, String[] courseTypes) {
		if (courseTypes == null || courseTypes.length == 0)
			return;
		baseDao.executeSql("delete from order_course where order_id=" + orderId);
		for (String coursestr : courseTypes) {
			String[] courseArr = coursestr.split("_");
			String courseName = courseArr[0];
			String courseHour = courseArr[1];
			SysParam sysParam = sysParamService.getParamByName(
					SysParamConstant.ORDER_COURSE.name(), courseName);
			OrderCourse orderCourse = new OrderCourse();
			orderCourse.setOrderId(orderId);
			orderCourse.setCourseType(sysParam.getParamValue());
			orderCourse.setHour(Integer.valueOf(courseHour));
			orderCourse.setStatus(OrderCourseStatus.WAIT);
			baseDao.save(orderCourse);
		}
	}

	/**
	 * 创建签单的课程信息
	 * 
	 * @param courseTypes
	 * @param orderId
	 */
	public void saveOrderCourse(int orderId, List<OrderCourse> courses) {
		if (courses == null || courses.size() == 0)
			return;
		baseDao.executeSql("delete from order_course where order_id=" + orderId);
		for (OrderCourse course : courses) {
			baseDao.save(course);
		}
	}

	/**
	 * 选择课程的负责授课老师
	 * 
	 * @param orderId
	 * @param courseType
	 * @param chargerId
	 * 
	 */
	public void chooseCourseCharger(int orderId, String courseType,
			int chargerId) {
		OrderCourse orderCourse = getOrderCourse(orderId, courseType);
		orderCourse.setChargerId(chargerId);
		orderCourse.setStatus(OrderCourseStatus.WAIT);
		baseDao.update(orderCourse);
	}

	/**
	 * 
	 * 获取课程信息
	 * 
	 * @param orderId
	 * @param courseType
	 * @return @
	 */
	public OrderCourse getOrderCourse(int orderId, String courseType) {
		List<OrderCourse> courseList = baseDao.find("order_id=" + orderId
				+ " and course_type='" + courseType + "'", OrderCourse.class);
		return courseList.isEmpty() ? null : courseList.get(0);
	}

	/**
	 * 批量更新课程
	 * 
	 * @param courseList
	 * 
	 */
	public void batchUpdate(List<OrderCourse> courseList) {
		for (OrderCourse orderCourse : courseList) {
			baseDao.update(orderCourse);
		}
	}

	public void processCourse(OrderInfo orderInfo, List<OrderCourse> courseList) {
		for (OrderCourse orderCourse : courseList) {
			orderCourse.setOrderId(orderInfo.getId());
			orderCourse.setStatus(OrderAttachStatus.ACCEPT);
		}
		if (courseList != null && !courseList.isEmpty())
			saveOrderCourse(orderInfo.getId(), courseList);
	}

	/**
	 * 获取学生的签单课程信息
	 * 
	 * @param studentId
	 * @param courseType
	 * @return
	 */
	public OrderCourse getOrderCourseForStudent(Integer studentId,
			String courseType) {
		OrderCourse totalOrderCourse = new OrderCourse();
		String sql = " order_id in  (select id from  "
				+ OrderInfo.class.getName() + " a where a.studentId="
				+ studentId + " and a.runStatus='" + OrderRunStatus.RUNNING
				+ "' )  and course_type='" + courseType
				+ "' order by order_id asc";
		List<OrderCourse> orderCourseList = baseDao
				.find(sql, OrderCourse.class);
		Integer hour = 0;
		Integer costHour = 0;
		Integer scheduleHour = 0;
		// 挑选出合适的签单课程信息
		for (OrderCourse orderCourse : orderCourseList) {
			hour += orderCourse.getHour();
			costHour += orderCourse.getCostHour() == null ? 0 : orderCourse
					.getCostHour();
			scheduleHour += orderCourse.getScheduleHour() == null ? 0
					: orderCourse.getScheduleHour();
		}

		totalOrderCourse.setCostHour(costHour);
		totalOrderCourse.setHour(hour);
		totalOrderCourse.setScheduleHour(scheduleHour);
		return totalOrderCourse;
	}
}
