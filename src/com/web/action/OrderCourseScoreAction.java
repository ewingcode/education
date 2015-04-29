package com.web.action;

import javax.annotation.Resource;

import com.core.app.action.base.BaseAction;
import com.core.app.control.SessionException;
import com.core.app.service.SysRightRelService;
import com.util.SqlUtil;
import com.util.StringUtil;
import com.web.model.OrderCourseScore;
import com.web.model.StudentInfo;

public class OrderCourseScoreAction extends BaseAction {
	public OrderCourseScoreAction() {
		super(OrderCourseScore.class);
	}
	@Resource
	private SysRightRelService sysRightRelService;
	@Override
	public String getCondition() {
		condition = super.getCondition();
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = sysRightRelService.getAreaRightSql2(request);
			if (!StringUtil.isEmpty(relAreaSql)) {
				condition = SqlUtil.combine(" studentId in (select id from "
						+ StudentInfo.class.getName() + " where " + relAreaSql
						+ ")", condition);
				return condition;
			}
		} catch (SessionException e) {
			e.printStackTrace();
		}
		return condition;
	}
}
