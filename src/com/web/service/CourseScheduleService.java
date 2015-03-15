package com.web.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.util.DateFormat;
import com.util.SqlUtil;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleView;

@Repository("courseScheduleService")
public class CourseScheduleService {
	@Resource
	private BaseDao baseDao;

	/**
	 * 为老师增加排课
	 * 
	 * @param teacherId
	 * @param studentId
	 * @param date
	 * @param courseType
	 * @param startTime
	 * @param endTime
	 * @return
	 * @throws DaoException
	 */
	public boolean addSchedule(Integer teacherId, Integer studentId, Date date,
			String courseType, Integer startTime, Integer endTime)
			throws DaoException {
		if (this.existSameSchedule(teacherId, date, startTime, endTime))
			return false;
		CourseSchedule scheduleVo = new CourseSchedule();
		scheduleVo.setCourseType(courseType);
		scheduleVo.setEndTime(endTime);
		scheduleVo.setStartTime(startTime);
		scheduleVo.setStudentId(studentId);
		scheduleVo.setTeacherId(teacherId);
		baseDao.save(scheduleVo);
		return true;
	}

	/**
	 * 判断老师的排课是否有冲突
	 * 
	 * @param teacherId
	 * @param date
	 * @param startTime
	 * @param endTime
	 * @return
	 * @throws DaoException
	 */
	public boolean existSameSchedule(Integer teacherId, Date date,
			Integer startTime, Integer endTime) throws DaoException {
		String sql = "from " + CourseSchedule.class.getName()
				+ " where teacher_id=" + teacherId + " and date='"
				+ DateFormat.DateToString(date, DateFormat.DATE_FORMAT) + "'";
		List<CourseSchedule> scheduleList = baseDao.find(sql,
				CourseSchedule.class);
		for (CourseSchedule scheduleVo : scheduleList) {
			if (scheduleVo.getStartTime().compareTo(startTime) <= 0
					&& scheduleVo.getEndTime().compareTo(startTime) >= 0) {
				return true;
			}
			if (scheduleVo.getStartTime().compareTo(endTime) <= 0
					&& scheduleVo.getEndTime().compareTo(endTime) >= 0) {
				return true;
			}
			if (scheduleVo.getStartTime().compareTo(startTime) >= 0
					&& scheduleVo.getEndTime().compareTo(endTime) <= 0) {
				return true;
			}
		}
		return false;
	}
	/**
	 * 获取教师指定时间内的排课信息
	 * 
	 * @param teacherId
	 * @param startScheldueDate
	 * @param endScheduleDate
	 * @return
	 * @throws DaoException
	 */
	public List<CourseScheduleView> getTeacherSchedule(List<Integer> teacherIds,
			Date startScheldueDate, Date endScheduleDate) throws DaoException {
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
						DateFormat.DATE_FORMAT) + "'";
		return baseDao.find(sql, CourseScheduleView.class);
	}
}
