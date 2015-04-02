package com.core.app.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.bean.CheckTreeObject;
import com.core.app.model.SysMenu;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;

@Repository("sysMenuService")
public class SysMenuService {
	@Resource
	public BaseDao baseDao;

	public void queryMenuChildTree(CheckTreeObject parentTree, int parentId,
			Set<Integer> menuRelList)   {
		List menuList = baseDao.find("parentid=" + parentId, SysMenu.class);
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
			queryMenuChildTree(treeObject, menuId, menuRelList);
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

}
