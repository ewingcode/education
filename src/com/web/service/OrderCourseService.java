package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.model.SysParam;
import com.core.app.service.SysParamService;
import com.core.jdbc.BaseDao;
import com.web.constant.OrderAttachStatus;
import com.web.constant.OrderCourseStatus;
import com.web.constant.SysParamConstant;
import com.web.model.OrderCourse;
import com.web.model.OrderInfo;

/**
 * 签单课程业务类
 * 
 */
@Repository("orderCourseService")
public class OrderCourseService {
	@Resource
	private BaseDao baseDao;

	@Resource
	private SysParamService sysParamService;
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
	 *            @
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
	 *            @
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
	 *            @
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

}
