package com.core.app.action;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.bean.OrgStructTreeObject;
import com.core.app.model.SysRole;
import com.core.app.service.SysRoleService;
import com.core.json.JsonUtil;
import com.util.CommonUtil;

public class SysRoleAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysRoleAction.class);

	public SysRoleAction() {
		super(SysRole.class);
	}

	@Resource
	private SysRoleService sysRoleService;

	/**
	 * 查找组织架构的树
	 * 
	 * @throws ActionException
	 */
	public void queryRoleStructTree() throws ActionException {
		try {
			String roleIds = request.getParameter("roleIds");
			String singleCheck = request.getParameter("singleCheck");
			String roleArray[] = roleIds != null ? StringUtils.split(roleIds,
					",") : null;
			OrgStructTreeObject treeObject = sysRoleService
					.queryRoleStructTree(CommonUtil.strArray2InArray(roleArray));
			String json = JsonUtil.tranBean2String(treeObject.getChildren())
					.toString();
			if (!json.startsWith("[") && !json.endsWith("]")) {
				json += "[" + json + "]";
			}
			if (singleCheck != null && singleCheck.equals("true"))
				json = json.replace(",\"checked\":false", "").replace(",\"checked\":true", "");
			logger.debug(json);
			response.getWriter().write(json);

		} catch (Exception e) {
			logger.error(e, e);
			throw new ActionException(e);
		}
	}
	public static void main(String[] args) {
		String ss="\"checked\":false";
		ss=ss.replace("\"checked\":false", "");
		System.out.print("sss"+ss);
	}
}
