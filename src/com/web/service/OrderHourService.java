package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.constant.OrderRunStatus;
import com.web.model.OrderCourseHour;
import com.web.model.OrderInfo;

@Repository("orderHourService")
public class OrderHourService {
	@Resource
	private BaseDao baseDao;

	@Transactional
	public void save(OrderCourseHour orderCourseHour)   {
		baseDao.save(orderCourseHour);
		updateCostHour(orderCourseHour.getStudentId());
	}

	@Transactional
	public void update(OrderCourseHour orderCourseHour)   {
		baseDao.update(orderCourseHour);
		updateCostHour(orderCourseHour.getStudentId());
	}

	@Transactional
	public void delete(OrderCourseHour orderCourseHour)   {
		orderCourseHour = baseDao.findOne(orderCourseHour.getId(),
				OrderCourseHour.class);
		baseDao.delete(orderCourseHour);
		updateCostHour(orderCourseHour.getStudentId());
	}

	public void updateCostHour(int studentId)   {
		List<OrderInfo> orderInfoList = baseDao.find("student_id=" + studentId
				+ " order by id ", OrderInfo.class);
		String sql = "select sum(costHour) from  "
				+ OrderCourseHour.class.getName()
				+ " where order_id in  (select id from "
				+ OrderInfo.class.getName() + " a where a.studentId="
				+ studentId + " )";
		Long hour = baseDao.queryObject(sql, Long.class);
		if (hour == null)
			hour = 0l;
		boolean stopWaiting = false;
		for (int i = 0; i < orderInfoList.size(); i++) {
			OrderInfo orderInfo = orderInfoList.get(i);
			//当消耗课时是0，排列不在第一的更新INWAITING
			if (hour == 0 && i > 0) {
				orderInfo.setCostCourseHour(Integer.valueOf(hour.toString()));
				orderInfo.setRunStatus(OrderRunStatus.INWAITING);
			}
			//当消耗课时是0，排列在第一 或者  需要停止等待 的更新INLEARN
			if ((hour == 0 && stopWaiting) || (hour == 0 && i == 0)) {
				orderInfo.setCostCourseHour(Integer.valueOf(hour.toString()));
				orderInfo.setRunStatus(OrderRunStatus.INLEARN);
				stopWaiting = false;
			}
			if (hour == 0)
				continue;
			if (orderInfo.getCourseHour() > hour) {
				// 少于签单课时的更新。
				orderInfo.setCostCourseHour(Integer.valueOf(hour.toString()));
				orderInfo.setRunStatus(OrderRunStatus.INLEARN);
				hour = 0l;
			} else {
				// 大于签单课时的更新为结束。
				orderInfo.setCostCourseHour(orderInfo.getCourseHour());
				orderInfo.setRunStatus(OrderRunStatus.OVER);
				if (i == orderInfoList.size() - 1)
					orderInfo.setCostCourseHour(Integer
							.valueOf(hour.toString()));
				hour = hour - orderInfo.getCourseHour();
				stopWaiting = true;
			}
			baseDao.update(orderInfo);
		}

	}
}
