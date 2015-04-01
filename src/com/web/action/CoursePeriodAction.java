package com.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.util.DateFormat;
import com.web.bean.CoursePeriodDto;
import com.web.model.CoursePeriod;
import com.web.service.CoursePeriodService;

public class CoursePeriodAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderAttchAction.class);
	@Resource
	private CoursePeriodService coursePeriodService;

	public CoursePeriodAction() {
		super(CoursePeriod.class);
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void queryByCache() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			List<CoursePeriod> list = cacheModelService.find(getCondition(),
					entityClass);
			List<CoursePeriodDto> dtoList = new ArrayList<CoursePeriodDto>();
			for (CoursePeriod coursePeriod : list) {
				CoursePeriodDto dto = new CoursePeriodDto();
				dto.setEndTime(DateFormat.cutTime(coursePeriod.getEndTime()));
				dto.setStartTime(DateFormat.cutTime(coursePeriod.getStartTime()));
				dto.setId(coursePeriod.getId());
				dtoList.add(dto);
			}
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(dtoList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * 是否有相同的课程时间设置
	 * 
	 * @throws ActionException
	 */
	public void existSamePeriod() throws ActionException {
		ResponseData responseData = null;
		try {
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			boolean existSamePeriod = coursePeriodService.existSamePeriod(
					DateFormat.stringToDate(startDate),
					DateFormat.stringToDate(endDate));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(existSamePeriod);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}
}
