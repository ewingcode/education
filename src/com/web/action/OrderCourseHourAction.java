package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.OrderCourseHour;
import com.web.service.OrderHourService;

public class OrderCourseHourAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderCourseAction.class);
	@Resource
	private OrderHourService orderHourService;

	public OrderCourseHourAction() {
		super(OrderCourseHour.class);
	}

	/**
	 * dao新增
	 * 
	 * @throws ActionException
	 */
	@Override
	public void save() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			this.buildPageData(entityBean);
			orderHourService.save((OrderCourseHour) entityBean);
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * dao修改
	 * 
	 * @throws ActionException
	 */
	public void update() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			this.buildPageData(entityBean);
			orderHourService.update((OrderCourseHour) entityBean);
			responseData = ResponseUtils.success("更新成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("更新失败！");
		}
		this.outResult(responseData);
	}
	

	/**
	 * dao删除
	 * 
	 * @throws ActionException
	 */
	public void delete() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			this.buildPageData(entityBean);
			orderHourService.delete((OrderCourseHour) entityBean);
			responseData = ResponseUtils.success("删除成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("删除失败！");
		}
		this.outResult(responseData);
	}

}
