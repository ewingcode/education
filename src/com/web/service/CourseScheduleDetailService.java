package com.web.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.app.constant.IsEff;
import com.core.jdbc.BaseDao;
import com.util.DateFormat;
import com.util.SqlUtil;
import com.web.constant.CourseHourStatus;
import com.web.constant.CourseScheduleDetailIsFinish;
import com.web.constant.OrderRunStatus;
import com.web.exception.CourseScheduleException;
import com.web.exception.OrderException;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleDetail;
import com.web.model.CourseScheduleView;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseHourLog;
import com.web.model.OrderInfo;
import com.web.model.TeacherRefStudent;

@Repository("courseScheduleDetailService")
public class CourseScheduleDetailService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private OrderService orderService;
	@Resource
	private OrderCourseService orderCourseService;
	@Resource
	private CourseScheduleService courseScheduleService;

	/**
	 * 是否结束的排课计划
	 * 
	 * @param scheduleId
	 * @return
	 */
	public boolean isFinishSchedule(Integer scheduleId) {
		CourseScheduleDetail courseSchedule = baseDao.findOne(scheduleId,
				CourseScheduleDetail.class);
		return courseSchedule.getIsFinish().equals(
				CourseScheduleDetailIsFinish.FINISHED.getValue());
	}

	/**
	 * 验证排课的信息
	 * 
	 * @param teacherId
	 * @param studentId
	 * @param date
	 * @param courseType
	 * @param startTime
	 * @param endTime
	 * @return
	 * @throws CourseScheduleException
	 */
	public CourseScheduleDetail validateCourseSchedule(Integer teacherId,
			Integer studentId, Date date, String courseType, Integer startTime,
			Integer endTime, List<OrderCourse> orderCourseList, Boolean throwErr)
			throws CourseScheduleException {
		CourseScheduleDetail scheduleVo = new CourseScheduleDetail();
		scheduleVo.setCourseType(courseType);
		scheduleVo.setDate(date);
		scheduleVo.setEndTime(endTime);
		scheduleVo.setStartTime(startTime);
		scheduleVo.setStudentId(studentId);
		scheduleVo.setTeacherId(teacherId);
		scheduleVo.setIseff(IsEff.EFFECTIVE);
		scheduleVo.setIsFinish(CourseScheduleDetailIsFinish.NOTFINISH
				.getValue());
		String errMsg = "[日期:" + DateFormat.DateToString(date) + ",开始时间:"
				+ startTime + ",结束时间:" + endTime + "]";
		try {
			if (existSameScheduleForTeacher(teacherId, date, startTime, endTime))
				throw new CourseScheduleException("教学老师的课程时间安排有相同!" + errMsg);
			if (existSameScheduleForStudent(studentId, date, startTime, endTime))
				throw new CourseScheduleException("学生的课程时间安排有相同!" + errMsg);
			if (!isRelStudent(teacherId, studentId))
				throw new CourseScheduleException("不能关联该学生!");
			if (!hasPremitToTeach(teacherId, studentId, courseType))
				throw new CourseScheduleException("不能关联该科目!");
			Integer fitOrderId = null;
			Integer fitOrderCourseId = null;

			int costHour = computeScheduleHour(endTime, startTime);
			if (orderCourseList == null) {
				// 获取学生所有的签单课程信息
				String sql = " order_id in  (select id from  "
						+ OrderInfo.class.getName() + " a where a.studentId="
						+ studentId + " and a.runStatus='"
						+ OrderRunStatus.RUNNING + "' ) and course_type='"
						+ courseType + "' order by order_id asc";
				orderCourseList = baseDao.find(sql, OrderCourse.class);
			}
			// 挑选出合适的签单课程信息
			for (OrderCourse orderCourse : orderCourseList) {
				Integer coursehour = orderCourse.getHour();
				Integer costcourseHour = orderCourse.getCostHour() == null
						? 0
						: orderCourse.getCostHour();
				Integer leaveHour = coursehour - costcourseHour;
				// 如果有剩余的课时，则是合适的签单课程
				if (leaveHour >= costHour) {
					fitOrderCourseId = orderCourse.getId();
					fitOrderId = orderCourse.getOrderId();
					break;
				}
			}

			if (fitOrderCourseId == null) {
				throw new CourseScheduleException("学生签单课时不足");
			}
			// 新增排课信息
			scheduleVo.setOrderCourseId(fitOrderCourseId);
			scheduleVo.setOrderId(fitOrderId);
			scheduleVo.setDesc("通过");
		} catch (CourseScheduleException e) {
			if (throwErr)
				throw e;
			else
				scheduleVo.setDesc("不通过：" + e.getMessage());
		}
		return scheduleVo;
	}

	/**
	 * 为教师增加排课
	 * 
	 * @param teacherId
	 * @param studentId
	 * @param date
	 * @param courseType
	 * @param startTime
	 * @param endTime
	 * @return
	 * @throws OrderException
	 * @throws Exception
	 */
	@Transactional(rollbackFor = Exception.class)
	public boolean addSchedule(Integer teacherId, Integer studentId, Date date,
			String courseType, Integer startTime, Integer endTime)
			throws CourseScheduleException, OrderException {
		CourseScheduleDetail scheduleVo = validateCourseSchedule(teacherId,
				studentId, date, courseType, startTime, endTime, null, true);
		addSchedule(scheduleVo);
		return true;
	}

	public void addSchedule(CourseScheduleDetail scheduleVo)
			throws OrderException {
		baseDao.save(scheduleVo);
		// 更新签单课程的已经排课的课时
		orderCourseService.updateCourseScheduleHour(scheduleVo
				.getOrderCourseId());
		// 更新签单的已经排课的课时
		orderService.updateOrderScheduleHour(scheduleVo.getOrderId());
	}

	/**
	 * 删除排课模板，并且删除没有结束的排课计划
	 * 
	 * @param scheduleId
	 * @throws OrderException
	 */
	@Transactional(rollbackFor = Exception.class)
	public void deleteScheduleDetail(Integer scheduleId) throws OrderException {
		try {
			CourseSchedule scheduleTemplate = courseScheduleService
					.findOne(scheduleId);
			if (scheduleTemplate == null)
				return;
			List<CourseScheduleDetail> scheduleDetailList = baseDao
					.find("is_finish="
							+ CourseScheduleDetailIsFinish.NOTFINISH.getValue(),
							CourseScheduleDetail.class);
			for (CourseScheduleDetail scheduleDetail : scheduleDetailList) {
				baseDao.delete(scheduleDetail);
				// 更新签单科目的排课时间
				orderCourseService.updateCourseScheduleHour(scheduleDetail
						.getOrderCourseId());
				// 更新签单的已经排课的课时
				orderService.updateOrderScheduleHour(scheduleDetail
						.getOrderId());
			}
			scheduleTemplate.setIseff(IsEff.INEFFECTIVE);
			baseDao.update(scheduleTemplate);
		} catch (Exception e) {
			throw e;
		}
	}

	public void deleteScheduleByOrderId(Integer orderId) throws OrderException {
		List<CourseScheduleDetail> scheduleDetailList = baseDao.find(
				"order_id=" + orderId + " and is_finish="
						+ CourseScheduleDetailIsFinish.NOTFINISH.getValue(),
				CourseScheduleDetail.class);
		for (CourseScheduleDetail scheduleDetail : scheduleDetailList) {
			baseDao.delete(scheduleDetail);
			// 更新签单科目的排课时间
			orderCourseService.updateCourseScheduleHour(scheduleDetail
					.getOrderCourseId());
			// 更新签单的已经排课的课时
			orderService.updateOrderScheduleHour(scheduleDetail.getOrderId());
		}
	}

	/**
	 * 查找到目前为止没有结束的排课信息
	 * 
	 * @return
	 */
	public List<CourseScheduleDetail> getNotFinishSchedule() {
		String nowTimeStr = DateFormat.DateToString(new Date(),
				DateFormat.DATETIME_FORMAT2);
		return baseDao
				.find("is_finish="
						+ CourseScheduleDetailIsFinish.NOTFINISH.getValue()
						+ " and CONCAT(DATE_FORMAT(DATE,'%Y%m%d'),LPAD(END_TIME, 4, 0),'00')"
						+ " <= '" + nowTimeStr + "'",
						CourseScheduleDetail.class);
	}

	/**
	 * 是否对应的课程教师
	 * 
	 * @param teacherId
	 * @param studentId
	 * @return
	 */
	public boolean isRelStudent(Integer teacherId, Integer studentId) {
		String sql = "from " + TeacherRefStudent.class.getName()
				+ " where teacher_id=" + teacherId + " and student_id="
				+ studentId;
		List<TeacherRefStudent> relList = baseDao.find(sql,
				TeacherRefStudent.class);
		if (relList == null || relList.isEmpty())
			return false;
		return true;
	}

	/**
	 * 是否对应的课程教师
	 * 
	 * @param teacherId
	 * @param studentId
	 * @param courseType
	 * @return
	 */
	public boolean hasPremitToTeach(Integer teacherId, Integer studentId,
			String courseType) {
		String sql = "from " + TeacherRefStudent.class.getName()
				+ " where teacher_id=" + teacherId + " and student_id="
				+ studentId + " " + "and course_type='" + courseType + "'";
		List<TeacherRefStudent> relList = baseDao.find(sql,
				TeacherRefStudent.class);
		if (relList == null || relList.isEmpty())
			return false;
		return true;
	}

	/**
	 * 判断老师的排课是否有冲突
	 * 
	 * @param teacherId
	 * @param date
	 * @param startTime
	 * @param endTime
	 * @return @
	 */
	public boolean existSameScheduleForTeacher(Integer teacherId, Date date,
			Integer startTime, Integer endTime) {
		String sql = "from " + CourseScheduleDetail.class.getName()
				+ " where teacher_id=" + teacherId + " and date='"
				+ DateFormat.DateToString(date, DateFormat.DATE_FORMAT) + "'";
		List<CourseScheduleDetail> scheduleList = baseDao.find(sql,
				CourseScheduleDetail.class);
		for (CourseScheduleDetail scheduleVo : scheduleList) {
			boolean isLegalTime = isLegalNewTime(
					new Integer[]{scheduleVo.getStartTime(),
							scheduleVo.getEndTime()}, new Integer[]{startTime,
							endTime});
			if (!isLegalTime)
				return true;
		}
		return false;
	}

	public boolean existSameScheduleForStudent(Integer studentId, Date date,
			Integer startTime, Integer endTime) {
		String sql = "from " + CourseScheduleDetail.class.getName()
				+ " where student_id=" + studentId + " and date='"
				+ DateFormat.DateToString(date, DateFormat.DATE_FORMAT) + "'";
		List<CourseScheduleDetail> scheduleList = baseDao.find(sql,
				CourseScheduleDetail.class);
		for (CourseScheduleDetail scheduleVo : scheduleList) {
			boolean isLegalTime = isLegalNewTime(
					new Integer[]{scheduleVo.getStartTime(),
							scheduleVo.getEndTime()}, new Integer[]{startTime,
							endTime});
			if (!isLegalTime)
				return true;
		}
		return false;
	}

	/**
	 * 获取教师指定时间内的排课信息
	 * 
	 * @param teacherId
	 * @param startScheldueDate
	 * @param endScheduleDate
	 * @return @
	 */
	public List<CourseScheduleView> getTeacherSchedule(
			List<Integer> teacherIds, Date startScheldueDate,
			Date endScheduleDate) {
		String sql = "from "
				+ CourseScheduleView.class.getName()
				+ " where teacher_id in ("
				+ SqlUtil.array2InCondition(teacherIds)
				+ ")"
				+ " and date between '"
				+ DateFormat.DateToString(startScheldueDate,
						DateFormat.DATE_FORMAT)
				+ "' and '"
				+ DateFormat.DateToString(endScheduleDate,
						DateFormat.DATE_FORMAT) + "' order by date,start_time";
		return baseDao.find(sql, CourseScheduleView.class);
	}

	public static void main(String[] args) {
		System.out.println(isLegalNewTime(new Integer[]{900, 1000},
				new Integer[]{1000, 1100}));
		System.out.println(isLegalNewTime(new Integer[]{1000, 1100},
				new Integer[]{900, 1000}));
		System.out.println(isLegalNewTime(new Integer[]{900, 1000},
				new Integer[]{930, 1000}));
		System.out.println(isLegalNewTime(new Integer[]{900, 1000},
				new Integer[]{2200, 2300}));
		System.out.println(isLegalNewTime(new Integer[]{2200, 2300},
				new Integer[]{900, 1000}));
		System.out.println(isLegalNewTime(new Integer[]{800, 2300},
				new Integer[]{900, 1000}));
		System.out.println(isLegalNewTime(new Integer[]{900, 1000},
				new Integer[]{900, 1000}));

		System.out.println(930 % 831);
	}

	/**
	 * 是否合法没有冲突的新排课时间
	 * 
	 * @param oldTime
	 * @param newTime
	 * @return
	 */
	public static boolean isLegalNewTime(Integer[] oldTime, Integer[] newTime) {
		if (oldTime == null || newTime == null || oldTime.length != 2
				|| newTime.length != 2)
			throw new IllegalArgumentException("wrong parameter!");
		int start1 = oldTime[0];
		int end1 = oldTime[1];
		int start2 = newTime[0];
		int end2 = newTime[1];

		if (start1 == start2 && end1 == end2)
			return false;

		if (start1 <= start2 && end1 >= end2)
			return false;

		if (start1 >= start2 && end1 <= end2)
			return false;

		if (start1 < start2 && end1 <= start2)
			return true;

		if (start1 >= end2 && start1 > start1)
			return true;

		return true;
	}

	public Integer computeScheduleHour(Integer endTime, Integer startTime) {
		return (endTime - startTime) / 100;
	}

	@Transactional(rollbackFor = Exception.class)
	public void confirmCourseHour(CourseScheduleDetail scheduleDetail) {
		Integer orderCourseId = scheduleDetail.getOrderCourseId();
		// 更新排课的课程已经结束
		scheduleDetail.setIsFinish(CourseScheduleDetailIsFinish.FINISHED
				.getValue());
		baseDao.update(scheduleDetail);
		// 计算消耗的课时，并且记录课时消耗记录到ordercoursehour
		int costHour = computeScheduleHour(scheduleDetail.getEndTime(),
				scheduleDetail.getStartTime());
		OrderCourseHourLog courseHourLog = new OrderCourseHourLog();
		courseHourLog.setCostHour(costHour);
		courseHourLog.setCourseType(scheduleDetail.getCourseType());
		courseHourLog.setStudentId(scheduleDetail.getStudentId());
		courseHourLog.setTeacherId(scheduleDetail.getTeacherId());
		courseHourLog.setTeachTime(scheduleDetail.getDate());
		courseHourLog.setScheduleId(scheduleDetail.getId());
		courseHourLog.setStatus(CourseHourStatus.ALL_SETTLE.getValue());
		courseHourLog.setOrderId(scheduleDetail.getOrderId());
		courseHourLog.setOrderCourseId(scheduleDetail.getOrderCourseId());
		courseHourLog.setScheduleDetailId(scheduleDetail.getId());
		courseHourLog.setScheduleId(scheduleDetail.getScheduleId());
		baseDao.save(courseHourLog);
		// 更新签单课程的消耗课时
		orderCourseService.updateCourseCostHour(orderCourseId);
		// 更新签单的总消耗课时
		orderService.updateOrderCostHour(scheduleDetail.getOrderId());
		if (scheduleDetail.getScheduleId() != null)
			courseScheduleService.updateScheduleCostHour(scheduleDetail
					.getScheduleId());
	}

	/**
	 * 根据计划id查询计划详细列表
	 * 
	 * @param scheduleId
	 * @return
	 */
	public List<CourseScheduleDetail> getCourseScheduleDetailList(
			Integer scheduleId) {
		String sql = "schedule_id = " + scheduleId + " order by is_finish asc,id asc";
		return baseDao.find(sql, CourseScheduleDetail.class);
	}

	/**
	 * 手工取消课时记录，并且更新签单课时信息
	 * 
	 * @param courseHourLogId
	 * @throws CourseScheduleException
	 */
	@Transactional(rollbackFor = Exception.class)
	public void rollbackCourseHour(Integer courseHourLogId, String desc,
			Integer operator) throws CourseScheduleException {
		OrderCourseHourLog courseHourLog = baseDao.findOne(courseHourLogId,
				OrderCourseHourLog.class);
		if (courseHourLog == null)
			throw new CourseScheduleException("没有匹配的课时记录");
		if (courseHourLog.getStatus()
				.equals(CourseHourStatus.CANCEL.getValue()))
			throw new CourseScheduleException("课时记录已为取消状态");
		// 更新课时记录日志状态
		courseHourLog.setDesc(desc);
		courseHourLog.setStatus(CourseHourStatus.CANCEL.getValue());
		courseHourLog.setOperator(operator);
		// 更新签单课程的消耗课时
		orderCourseService.updateCourseCostHour(courseHourLog
				.getOrderCourseId());
		// 更新签单的总消耗课时
		orderService.updateOrderCostHour(courseHourLog.getOrderId());

	}

}
