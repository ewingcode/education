package com.web.action;

import org.apache.log4j.Logger;

import com.core.app.action.base.BaseAction;
import com.web.model.CourseScheduleTemplate;

/**
 * 排课计划的模板
 * 
 * @author tanson lam
 * @creation 2015年3月15日
 */
public class CourseScheduleTemplateAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);

	public CourseScheduleTemplateAction() {
		super(CourseScheduleTemplate.class);
	}

}
