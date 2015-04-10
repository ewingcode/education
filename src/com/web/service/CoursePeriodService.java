package com.web.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.util.DateFormat;
import com.web.model.CoursePeriod;

@Repository("coursePeriodService")
public class CoursePeriodService {
	@Resource
	private BaseDao baseDao;

	/**
	 * 查找设置课程时间段
	 */
	public List<CoursePeriod> getCoursePeriod() {
		String sql = " from " + CoursePeriod.class.getName();
		return baseDao.find(sql, CoursePeriod.class);
	}

	public boolean existSamePeriod(Date startTime, Date endTime) {
		String sql = " from " + CoursePeriod.class.getName();
		String startTimeStr = DateFormat.DateToString(startTime);
		String endTimeStr = DateFormat.DateToString(endTime);
		List<CoursePeriod> periodList = baseDao.find(sql, CoursePeriod.class);
		for (CoursePeriod coursePeriod : periodList) {
			if (Integer.valueOf(coursePeriod.getStartTime()) <= Integer
					.valueOf(startTimeStr)
					&& Integer.valueOf(coursePeriod.getEndTime()) >= Integer
							.valueOf(startTimeStr)) {
				return true;
			}
			if (Integer.valueOf(coursePeriod.getStartTime()) <= Integer
					.valueOf(endTimeStr)
					&& Integer.valueOf(coursePeriod.getEndTime()) >= Integer
							.valueOf(endTimeStr)) {
				return true;
			}

			if (Integer.valueOf(coursePeriod.getStartTime()) > Integer
					.valueOf(endTimeStr)
					&& Integer.valueOf(coursePeriod.getEndTime()) < Integer
							.valueOf(endTimeStr)) {
				return true;
			}
		}
		return false;
	}
}
