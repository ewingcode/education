/**
 * 
 */
package com.core.app.action;

import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.CheckTreeObject;
import com.core.app.constant.SysRelRight;
import com.core.app.service.SysAreaService;
import com.core.app.service.SysMenuService;
import com.core.app.service.SysRightRelService;
import com.core.json.JsonUtil;

/**
 * @author Administrator
 * 
 */
public class SysRightRelAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysMenuAction.class);
	@Resource
	private SysRightRelService sysRightRelService;
	@Resource
	private SysMenuService sysMenuService;
	@Resource
	private SysAreaService sysAreaService;
	/**
	 * 查找菜单权限关联树,并会显示已经关联的菜单
	 * 
	 * @throws ActionException
	 */
	public void querySettingTree() throws ActionException {
		try {
			String menuId = "0";
			String right = request.getParameter("right");
			String relId = request.getParameter("relId");
			String type = request.getParameter("type");

			SysRelRight relRight = SysRelRight
					.fromValue(Integer.valueOf(right));
			CheckTreeObject parentTree = new CheckTreeObject();
			Set<Integer> menuRelList = sysRightRelService.queryRelMenu(type,
					Integer.valueOf(right), Integer.valueOf(relId));
			parentTree.setId(Integer.valueOf(menuId));
			if (relRight.equals(SysRelRight.MENU)) {
				sysMenuService.queryMenuChildTree(parentTree,
						parentTree.getId(), menuRelList);
			} else if (relRight.equals(SysRelRight.AREA)) {
				sysAreaService.queryAreaChildTree(parentTree,
						parentTree.getId(), menuRelList);
			}
			String json = JsonUtil.tranBean2String(parentTree.getChildren())
					.toString();
			if (!json.startsWith("[") && !json.endsWith("]")) {
				json += "[" + json + "]";
			}
			logger.debug(json);
			response.getWriter().write(json);

		} catch (Exception e) {
			logger.error(e, e);
			throw new ActionException(e);
		}

	}

	/**
	 * 设置角色的权限
	 * 
	 * @throws ActionException
	 */
	public void roleSetting() throws ActionException {
		ResponseData responseData = null;
		try {
			String relId = request.getParameter("relId");
			String type = request.getParameter("type");
			String menuId = request.getParameter("menuIds");
			String right = request.getParameter("right");
			String[] menuArrayStr = StringUtils.split(menuId, ",");
			Integer[] menuArrayInt = new Integer[menuArrayStr.length];
			for (int i = 0; i < menuArrayStr.length; i++) {
				menuArrayInt[i] = Integer.valueOf(menuArrayStr[i].trim());
			}
			sysRightRelService.rightRelSetting(type, relId,
					Integer.valueOf(right), menuArrayInt);
			responseData = ResponseUtils.success("保存成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

}
