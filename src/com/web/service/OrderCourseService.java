package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.constant.OrderAttachStatus;
import com.web.constant.OrderCourseStatus;
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

	/**
	 * 创建签单的课程信息
	 * 
	 * @param courseTypes
	 * @param orderId
	 * @throws DaoException
	 */
	public void saveOrderCourse(int orderId, String[] courseTypes)
			throws DaoException {
		if (courseTypes == null || courseTypes.length == 0)
			return;
		baseDao
				.executeSql("delete from order_course where order_id="
						+ orderId);
		for (String courseType : courseTypes) {
			OrderCourse orderCourse = new OrderCourse();
			orderCourse.setOrderId(orderId);
			orderCourse.setCourseType(courseType);
			orderCourse.setStatus(OrderCourseStatus.WAIT);
			baseDao.save(orderCourse);
		}
	}

	/**
	 * 创建签单的课程信息
	 * 
	 * @param courseTypes
	 * @param orderId
	 * @throws DaoException
	 */
	public void saveOrderCourse(int orderId, List<OrderCourse> courses)
			throws DaoException {
		if (courses == null || courses.size() == 0)
			return;
		baseDao
				.executeSql("delete from order_course where order_id="
						+ orderId);
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
	 * @throws DaoException
	 */
	public void chooseCourseCharger(int orderId, String courseType,
			int chargerId) throws DaoException {
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
	 * @return
	 * @throws DaoException
	 */
	public OrderCourse getOrderCourse(int orderId, String courseType)
			throws DaoException {
		List<OrderCourse> courseList = baseDao.find("order_id=" + orderId
				+ " and course_type='" + courseType + "'", OrderCourse.class);
		return courseList.isEmpty() ? null : courseList.get(0);
	}

	/**
	 * 批量更新课程
	 * 
	 * @param courseList
	 * @throws DaoException
	 */
	public void batchUpdate(List<OrderCourse> courseList) throws DaoException {
		for (OrderCourse orderCourse : courseList) {
			baseDao.update(orderCourse);
		}
	}

	public void processCourse(OrderInfo orderInfo, List<OrderCourse> courseList)
			throws DaoException {
		for (OrderCourse orderCourse : courseList) {
			orderCourse.setOrderId(orderInfo.getId());
			orderCourse.setStatus(OrderAttachStatus.ACCEPT);
		}
		if (courseList != null && !courseList.isEmpty())
			saveOrderCourse(orderInfo.getId(), courseList);
	}

}
