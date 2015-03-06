package com.web.service;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.model.CoursePeriod;
import com.web.util.DateFormat;

@Repository("coursePeriodService")
public class CoursePeriodService {
	@Resource
	private BaseDao baseDao;

	public boolean existSamePeriod(Date startTime, Date endTime)
			throws DaoException {
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
