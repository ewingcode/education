package com.core.app.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.bean.CheckTreeObject;
import com.core.app.model.SysMenu;
import com.core.jdbc.DaoException;
import com.core.json.JsonUtil;

public class CommonAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysMenuAction.class);

	public void queryMenuTree() throws ActionException {
		try {
			String menuId = "0";
			CheckTreeObject treeObject = new CheckTreeObject();
			treeObject.setId(Integer.valueOf(menuId));
			queryChildTree(treeObject, treeObject.getId());
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

	private void queryChildTree(CheckTreeObject parentTree, int parentId)
			  {
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
			CheckTreeObject treeObject = copy2TreeObject(sysMenu);
			queryChildTree(treeObject, menuId);
			childList.add(treeObject);
		}
		parentTree.setChildren(childList);

	}

	private CheckTreeObject copy2TreeObject(SysMenu sysMenu) {
		CheckTreeObject treeObject = new CheckTreeObject();
		treeObject.setId(sysMenu.getId());
		treeObject.setText(sysMenu.getName());
		treeObject.setChecked(false);
		treeObject.setHrefTarget(sysMenu.getUrl());
		return treeObject;
	}

	private List queryTreeData(String sql)   {
		SysMenu dao = new SysMenu();
		// return baseDao.find("from "+SysMenu.class.getName()+" where " + sql);
		return baseModelService.find(sql, SysMenu.class);
	}
}
