package com.web.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.constant.IsEff;
import com.core.jdbc.BaseDao;
import com.util.DateFormat;
import com.util.SqlUtil;
import com.web.constant.CourseScheduleIsFinish;
import com.web.exception.CourseScheduleException;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleView;
import com.web.model.TeacherRefStudent;

@Repository("courseScheduleService")
public class CourseScheduleService {
	@Resource
	private BaseDao baseDao;
	/**
	 * 是否结束的排课计划
	 * 
	 * @param scheduleId
	 * @return
	 */
	public boolean isFinishSchedule(Integer scheduleId) {
		CourseSchedule courseSchedule = baseDao.findOne(scheduleId,
				CourseSchedule.class);
		return courseSchedule.getIsFinish().equals(
				CourseScheduleIsFinish.FINISHED.getValue());
	}
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
	 * @throws Exception
	 */
	public boolean addSchedule(Integer teacherId, Integer studentId, Date date,
			String courseType, Integer startTime, Integer endTime)
			throws Exception {
		if (existSameScheduleForTeacher(teacherId, date, startTime, endTime))
			throw new CourseScheduleException("教学老师的课程时间安排有相同!");
		if (existSameScheduleForStudent(studentId, date, startTime, endTime))
			throw new CourseScheduleException("学生的课程时间安排有相同!");
		if (!isRelStudent(teacherId, studentId))
			throw new CourseScheduleException("不能关联该学生!");
		if (!hasPremitToTeach(teacherId, studentId, courseType))
			throw new CourseScheduleException("不能关联该科目!");
		CourseSchedule scheduleVo = new CourseSchedule();
		scheduleVo.setCourseType(courseType);
		scheduleVo.setDate(date);
		scheduleVo.setEndTime(endTime);
		scheduleVo.setStartTime(startTime);
		scheduleVo.setStudentId(studentId);
		scheduleVo.setTeacherId(teacherId);
		scheduleVo.setIseff(IsEff.EFFECTIVE);
		scheduleVo.setIsFinish(CourseScheduleIsFinish.NOTFINISH.getValue());
		baseDao.save(scheduleVo);
		return true;
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
		String sql = "from " + CourseSchedule.class.getName()
				+ " where teacher_id=" + teacherId + " and date='"
				+ DateFormat.DateToString(date, DateFormat.DATE_FORMAT) + "'";
		List<CourseSchedule> scheduleList = baseDao.find(sql,
				CourseSchedule.class);
		for (CourseSchedule scheduleVo : scheduleList) {
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
		String sql = "from " + CourseSchedule.class.getName()
				+ " where student_id=" + studentId + " and date='"
				+ DateFormat.DateToString(date, DateFormat.DATE_FORMAT) + "'";
		List<CourseSchedule> scheduleList = baseDao.find(sql,
				CourseSchedule.class);
		for (CourseSchedule scheduleVo : scheduleList) {
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
}
