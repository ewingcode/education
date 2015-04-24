package com.web.action;

import javax.annotation.Resource;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.control.SessionControl;
import com.web.model.OrderCourseHourLog;
import com.web.service.CourseScheduleDetailService;

/**
 * 课时记录
 * 
 * @author tanson lam
 * @creation 2015年4月20日
 */
public class OrderCourseHourLogAction extends BaseAction {
	@Resource
	private CourseScheduleDetailService courseScheduleDetailService;

	public OrderCourseHourLogAction() {
		super(OrderCourseHourLog.class);
	}

	/**
	 * 取消课时记录，并且更新签单课时信息
	 * 
	 * @throws ActionException
	 */
	public void rollbackCourseHour() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer courseHourLogId = Integer.valueOf(request
					.getParameter("courseHourLogId"));
			String desc = request.getParameter("desc");
			UserInfo userInfo = SessionControl.getUserInfo(request);
			courseScheduleDetailService.rollbackCourseHour(courseHourLogId,
					desc, userInfo.getId());
			responseData = ResponseUtils.success("删除成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("删除失败！");
		}
		this.outResult(responseData);
	}
}
