/**
 * 
 */
package com.core.app.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.CheckTreeObject;
import com.core.app.model.SysMenu;
import com.core.app.service.SysRightRelService;
import com.core.jdbc.DaoException;
import com.core.json.JsonUtil;

/**
 * @author Administrator
 * 
 */
public class SysRightRelAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysMenuAction.class);
	@Resource
	private SysRightRelService sysRightRelService;

	/**
	 * 查找菜单权限关联树,并会显示已经关联的菜单
	 * 
	 * @throws ActionException
	 */
	public void querySettingTree() throws ActionException {
		try {
			String menuId = "0";
			String relId = request.getParameter("relId");
			String type = request.getParameter("type");
			List<Integer> menuRelList = sysRightRelService.queryRelMenu(type,
					Integer.valueOf(relId));
			CheckTreeObject treeObject = new CheckTreeObject();
			treeObject.setId(Integer.valueOf(menuId));
			queryChildTree(treeObject, treeObject.getId(), menuRelList);
			String json = JsonUtil.tranBean2String(treeObject.getChildren())
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
			String[] menuArrayStr = StringUtils.split(menuId, ",");
			Integer[] menuArrayInt = new Integer[menuArrayStr.length];
			for (int i = 0; i < menuArrayStr.length; i++) {
				menuArrayInt[i] = Integer.valueOf(menuArrayStr[i].trim());
			}
			sysRightRelService.rightRelSetting(type, relId, menuArrayInt);
			responseData = ResponseUtils.success("保存成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	private void queryChildTree(CheckTreeObject parentTree, int parentId,
			List<Integer> menuRelList) throws DaoException {
		List menuList = queryTreeData("parentid=" + parentId);
		if (menuList.isEmpty()) {
			parentTree.setLeaf(true);
			return;
		}
		parentTree.setLeaf(false);
		List childList = new ArrayList();
		for (int i = 0; i < menuList.size(); i++) {
			SysMenu sysMenu = (SysMenu) menuList.get(i);
			int menuId = sysMenu.getId();
			boolean isRel = menuRelList.contains(menuId) ? true : false;
			CheckTreeObject treeObject = copy2TreeObject(sysMenu, isRel);
			queryChildTree(treeObject, menuId, menuRelList);
			childList.add(treeObject);
		}
		parentTree.setChildren(childList);

	}

	private CheckTreeObject copy2TreeObject(SysMenu sysMenu, boolean isRel) {
		CheckTreeObject treeObject = new CheckTreeObject();
		treeObject.setId(sysMenu.getId());
		treeObject.setText(sysMenu.getName());
		treeObject.setChecked(isRel);
		treeObject.setHrefTarget(sysMenu.getUrl());
		return treeObject;
	}

	private List queryTreeData(String sql) throws DaoException {
		return baseModelService.find(sql, SysMenu.class);
	}
}
