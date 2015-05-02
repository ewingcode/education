/**
 * 
 */
package com.core.app.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.bean.CheckTreeObject;
import com.core.app.model.SysArea;
import com.core.jdbc.BaseDao;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年3月8日
 */
@Repository("sysAreaService")
public class SysAreaService {
	@Resource
	public BaseDao baseDao;

	public void queryAreaChildTree(CheckTreeObject parentTree, int parentId,
			Set<Integer> menuRelList)   {
		List menuList = baseDao.find("parentid=" + parentId, SysArea.class);
		if (menuList.isEmpty()) {
			parentTree.setLeaf(true);
			return;
		}
		parentTree.setLeaf(false);
		List childList = new ArrayList();
		for (int i = 0; i < menuList.size(); i++) {
			SysArea sysMenu = (SysArea) menuList.get(i);
			int menuId = sysMenu.getId();
			boolean isRel = menuRelList.contains(menuId) ? true : false;
			CheckTreeObject treeObject = copy2TreeObject(sysMenu, isRel);
			queryAreaChildTree(treeObject, menuId, menuRelList);
			childList.add(treeObject);
		}
		parentTree.setChildren(childList);

	}

	private CheckTreeObject copy2TreeObject(SysArea sysMenu, boolean isRel) {
		CheckTreeObject treeObject = new CheckTreeObject();
		treeObject.setId(sysMenu.getId());
		treeObject.setText(sysMenu.getName());
		treeObject.setChecked(isRel);
		//treeObject.setHrefTarget(sysMenu.getUrl());
		return treeObject;
	}

}