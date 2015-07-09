package com.web.service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.constant.IsEff;
import com.core.app.model.SysParam;
import com.core.app.service.SysParamService;
import com.core.jdbc.BaseDao;
import com.web.constant.CourseHourStatus;
import com.web.constant.OrderCourseStatus;
import com.web.constant.OrderRunStatus;
import com.web.constant.SysParamConstant;
import com.web.exception.OrderException;
import com.web.model.CourseScheduleDetail;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseHourLog;
import com.web.model.OrderCourseView;
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

	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;
	@Resource
	private OrderCourseHourLogService orderCourseHourLogService;

	public OrderCourse findOrderCourse(Integer orderCourseId) {
		return baseDao.findOne(orderCourseId, OrderCourse.class);
	}

	public List<OrderCourse> findByOrderId(Integer orderId) {
		return baseDao.find("order_id=" + orderId, OrderCourse.class);
	}

	/**
	 * 更新签单课程的消耗课时
	 * 
	 * @param orderCourseId
	 */
	public void updateCourseCostHour(Integer orderCourseId) {
		OrderCourse orderCourse = findOrderCourse(orderCourseId);

		Integer totalCosthour = orderCourseHourLogService
				.getTotalCostHourForCourse(orderCourseId);
		orderCourse.setCostHour(totalCosthour.intValue());
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
		Integer totalSchedulehour = courseScheduleDetailService
				.getTotalScheduleHourForCourse(orderCourseId);

		if (totalSchedulehour != null
				&& totalSchedulehour.intValue() > orderCourse.getHour()) {
			SysParam courseTypeSysParam = sysParamService.getParamByValue(
					SysParamConstant.ORDER_COURSE.name(),
					orderCourse.getCourseType());
			throw new OrderException("计划时间不能大于科目["
					+ courseTypeSysParam.getParamName() + "]总课时!");
		}
		orderCourse.setScheduleHour(totalSchedulehour);
		baseDao.update(orderCourse);
	}

	/**
	 * 创建签单的课程信息
	 * 
	 * @param courseTypes
	 * @param orderId
	 * @throws OrderException
	 *             @
	 */
	public void saveOrderCourse(int orderId, String[] courseTypes)
			throws OrderException {
		if (courseTypes == null || courseTypes.length == 0)
			return;

		List<OrderCourse> orderCourseList = findByOrderId(orderId);
		Set<Integer> existCourseIds = new HashSet<Integer>();
		for (String coursestr : courseTypes) {
			OrderCourse orderCourse = new OrderCourse();
			orderCourse.setOrderId(orderId);
			boolean isUpdate = false;
			String[] courseArr = coursestr.split("_");
			Integer orderCourseId = courseArr[0] == null
					|| (courseArr[0] != null && courseArr[0]
							.equals("undefined")) ? null : Integer
					.valueOf(courseArr[0]);
			String courseType = courseArr[1] == null
					|| (courseArr[1] != null && courseArr[1]
							.equals("undefined")) ? null : String
					.valueOf(courseArr[1]);
			Integer courseHour = courseArr[2] == null
					|| (courseArr[2] != null && courseArr[2]
							.equals("undefined")) ? null : Integer
					.valueOf(courseArr[2]);
			Integer chargerId = courseArr[3] == null
					|| (courseArr[3] != null && courseArr[3]
							.equals("undefined")) ? null : Integer
					.valueOf(courseArr[3]);
			if (orderCourseId != null)
				isUpdate = true;
			if (isUpdate) {
				existCourseIds.add(orderCourseId);
				orderCourse = findOrderCourse(orderCourseId);
				if (orderCourse == null)
					throw new OrderException("没有对应的签单课程记录[" + orderCourseId
							+ "]");
				if (courseHour < orderCourse.getCostHour())
					throw new OrderException("修改的课程时间不能低于已花课时");
				if (courseHour < orderCourse.getScheduleHour())
					throw new OrderException("修改的课程时间不能低于已设置排课课时");
				if (chargerId != null)
					orderCourse.setChargerId(chargerId);
				orderCourse.setHour(courseHour);
				baseDao.update(orderCourse);
			} else {
				orderCourse.setCourseType(courseType);
				orderCourse.setCostHour(0);
				orderCourse.setScheduleHour(0);
				orderCourse.setStatus(OrderCourseStatus.WAIT);
				orderCourse.setHour(courseHour);
				if (chargerId != null)
					orderCourse.setChargerId(chargerId);
				baseDao.save(orderCourse);
			}
		}
		// 处理删除的课程信息
		for (OrderCourse orderCourse : orderCourseList) {
			if (!existCourseIds.contains(orderCourse.getId())
					&& orderCourse.getCostHour() == 0) {
				baseDao.delete(orderCourse);
			}
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
			scheduleHour += orderCourse.getScheduleHour() == null
					? 0
					: orderCourse.getScheduleHour();
		}

		totalOrderCourse.setCostHour(costHour);
		totalOrderCourse.setHour(hour);
		totalOrderCourse.setScheduleHour(scheduleHour);
		return totalOrderCourse;
	}

	/**
	 * 获取学生所有的签单科目信息
	 * 
	 * @param studentId
	 * @return
	 */
	public List<OrderCourseView> findCourseByStudent(Integer studentId) {
		String sql = "student_id=" + studentId + " and order_run_status!='"
				+ OrderRunStatus.INAPPLY + "'  order by id desc";
		return baseDao.find(sql, OrderCourseView.class);
	}

	/**
	 * 获取学生所有的签单科目信息
	 * 
	 * @param studentId
	 * @param courseType
	 * @return
	 */
	public List<OrderCourseView> findChargerForCourse(Integer studentId,
			Integer courseType) {
		String sql = "student_id=" + studentId + " and course_type='"
				+ courseType + "' and order_run_status!='"
				+ OrderRunStatus.INAPPLY + "'  order by id desc";
		return baseDao.find(sql, OrderCourseView.class);
	}

}
