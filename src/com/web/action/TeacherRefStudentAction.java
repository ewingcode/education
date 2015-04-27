/**
 * 
 */
package com.web.action;

import javax.annotation.Resource;

import com.core.app.action.base.BaseAction;
import com.core.app.control.SessionException;
import com.core.app.service.SysRightRelService;
import com.util.SqlUtil;
import com.util.StringUtil;
import com.web.model.TeacherRefStudent;

/**
 * @author Administrator
 * 
 */
public class TeacherRefStudentAction extends BaseAction {
	@Resource
	private SysRightRelService sysRightRelService;
	public TeacherRefStudentAction() {
		super(TeacherRefStudent.class);
	}
	
	@Override
	public String getCondition() {
		if (StringUtil.isEmpty(condition))
			condition = "";
		try {
			String relAreaSql = sysRightRelService.getAreaRightSql(request);
			if (!StringUtil.isEmpty(relAreaSql))
				return SqlUtil.combine(condition , relAreaSql);
		} catch (SessionException e) {
			e.printStackTrace();
		}
		return condition;
	}
}
