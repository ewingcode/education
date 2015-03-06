package com.web.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.web.model.OrderCourseSchedule;
import com.web.model.TeacherInfo;
import com.web.util.DateFormat;

@Repository("orderCourseScheduleService")
public class OrderCourseScheduleService {
	@Resource
	private BaseDao baseDao;

	public void addSchedule(int userId, int studentId, int orderId,
			String courseType, int coursePeriodId, Date startDate, Date endDate)
			throws DaoException {
		if (this.existSameSchedule(userId, coursePeriodId, startDate, endDate))
			return;
		OrderCourseSchedule scheduleVo = new OrderCourseSchedule();
		scheduleVo.setCoursePeriodId(coursePeriodId);
		scheduleVo.setCourseType(courseType);
		scheduleVo.setEndDate(endDate);
		scheduleVo.setStartDate(startDate);
		scheduleVo.setOrderId(orderId);
		scheduleVo.setStudentId(studentId);
		scheduleVo.setUserId(userId);
		baseDao.save(scheduleVo);
	}

	public boolean existSameSchedule(int userId, int coursePeriodId,
			Date startDate, Date endDate) throws DaoException {
		String sql = "from " + OrderCourseSchedule.class.getName()
				+ " where user_id=" + userId + " and course_period_id="
				+ coursePeriodId;
		List<OrderCourseSchedule> scheduleList = baseDao.find(sql,
				OrderCourseSchedule.class);
		for (OrderCourseSchedule scheduleVo : scheduleList) {
			if (scheduleVo.getStartDate().compareTo(startDate) <= 0
					&& scheduleVo.getEndDate().compareTo(startDate) >= 0) {
				return true;
			}
			if (scheduleVo.getStartDate().compareTo(endDate) <= 0
					&& scheduleVo.getEndDate().compareTo(endDate) >= 0) {
				return true;
			}

			if (scheduleVo.getStartDate().compareTo(startDate) >= 0
					&& scheduleVo.getEndDate().compareTo(endDate) <= 0) {
				return true;
			}
		}
		return false;
	}

	public PageBean findFreeTeacher(int coursePeriodId, Date startDate,
			Date endDate, int pageSize, int startIndex) {
		String _startDate = DateFormat.DateToString(startDate,
				DateFormat.DATE_FORMAT);
		String _endDate = DateFormat.DateToString(endDate,
				DateFormat.DATE_FORMAT);
		PageBean list = baseDao.pageQuery(
				"from " + TeacherInfo.class.getName()
						+ " a where  id.id not in (SELECT userId FROM "
						+ OrderCourseSchedule.class.getName()
						+ " o where  (start_date <='" + _startDate
						+ "' and end_date>='" + _startDate + "' ) "
						+ "or (start_date <='" + _endDate + "' and end_date>='"
						+ _endDate + "' ) and course_period_id="
						+ coursePeriodId + ")", pageSize, startIndex,
				TeacherInfo.class);
		return list;
	}
}
