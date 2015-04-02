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
import com.core.app.bean.TreeObject;
import com.core.app.bean.UserInfo;
import com.core.app.control.SessionControl;
import com.core.app.control.SessionException;
import com.core.app.model.SysMenu;
import com.core.app.service.SysRightRelService;
import com.core.jdbc.DaoException;
import com.core.json.JsonUtil;

public class SysMenuAction extends BaseAction {

	private static Logger logger = Logger.getLogger(SysMenuAction.class);

	@Resource
	private SysRightRelService sysRightRelService;

	public SysMenuAction() {
		super(SysMenu.class);
	}

	public void queryMenuTree() throws ActionException {
		try {
			String isAll = request.getParameter("isAll");
			boolean isShowAll = StringUtils.isEmpty(isAll) ? false : true;
			String menuId = request.getParameter("menuId");
			TreeObject treeObject = new TreeObject();
			treeObject.setId(Integer.valueOf(menuId));
			queryChildTree(treeObject, treeObject.getId(), isShowAll);
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

	public void queryAllMenuTree() throws ActionException {
		try {

			String isAll = request.getParameter("isAll");
			boolean isShowAll = StringUtils.isEmpty(isAll) ? false : true;
			String menuId = "0";
			TreeObject treeObject = new TreeObject();
			treeObject.setId(Integer.valueOf(menuId));
			queryChildTree(treeObject, treeObject.getId(), isShowAll);
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

	public void queryModuleTree() throws ActionException, SessionException {
		UserInfo userInfo = SessionControl.getUserInfo(request);
		try {
			List<SysMenu> menuList = queryTreeData("level='1' and parentid=0 and iseff='0' order by sort");
			List<TreeObject> moduleList = new ArrayList<TreeObject>();
			for (int i = 0; i < menuList.size(); i++) {
				SysMenu sysMenu = (SysMenu) menuList.get(i);
				int menuId = sysMenu.getId();
				if (sysRightRelService.containRelMenu(userInfo, menuId)) {
					TreeObject treeObject = copy2TreeObject(sysMenu);
					moduleList.add(treeObject);
				}
			}
			String json = JsonUtil.tranBean2String(moduleList).toString();
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

	private void queryChildTree(TreeObject parentTree, int parentId,
			boolean isShowAll) throws SessionException {
		UserInfo userInfo = SessionControl.getUserInfo(request);
		List<SysMenu> menuList = queryTreeData("parentid=" + parentId
				+ " and iseff='0' order by sort");
		if (menuList.isEmpty()) {
			parentTree.setLeaf(true);
			return;
		}
		parentTree.setLeaf(false);
		List<TreeObject> childList = new ArrayList<TreeObject>();
		for (int i = 0; i < menuList.size(); i++) {
			SysMenu sysMenu = (SysMenu) menuList.get(i);
			int menuId = sysMenu.getId();
			if (sysRightRelService.containRelMenu(userInfo, menuId)
					|| isShowAll) {
				TreeObject treeObject = copy2TreeObject(sysMenu);
				queryChildTree(treeObject, menuId, isShowAll);
				childList.add(treeObject);
			}
		}
		parentTree.setChildren(childList);
	}

	/**
	 * 创建新菜单节点
	 * 
	 * @
	 * 
	 * @throws ActionException
	 */
	public void createNewMenu() throws ActionException {
		ResponseData responseData = null;
		try {
			Integer parentId = Integer
					.valueOf(request.getParameter("parentid"));
			String maxSortSql = "select max(sort) from  "
					+ SysMenu.class.getName() + " where parentid=" + parentId;
			String maxIdSql = "select max(id) from  " + SysMenu.class.getName();
			SysMenu parentMenu = new SysMenu();
			parentMenu.setId(parentId);
			parentMenu = (SysMenu) cacheModelService.findOne(
					parentMenu.getId(), SysMenu.class);
			Integer maxSort = cacheModelService.queryObject(maxSortSql,
					Integer.class);
			Integer maxId = cacheModelService.queryObject(maxIdSql,
					Integer.class);
			int nextSort = maxSort != null ? maxSort + 1 : 0;
			int nextLevel = Integer.valueOf(parentMenu.getLevel()) + 1;
			int nextId = maxId != null ? maxId + 1 : 0;
			SysMenu newMenu = new SysMenu();
			newMenu.setId(nextId);
			newMenu.setSort(nextSort);
			newMenu.setLevel(String.valueOf(nextLevel));
			newMenu.setParentid(parentMenu.getId());
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(newMenu);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);

	}

	private TreeObject copy2TreeObject(SysMenu sysMenu) {
		TreeObject treeObject = new TreeObject();
		treeObject.setId(sysMenu.getId());
		treeObject.setText(sysMenu.getName());
		treeObject.setHrefTarget(sysMenu.getUrl());
		return treeObject;
	}

	private List<SysMenu> queryTreeData(String sql) {
		return cacheModelService.find(sql, SysMenu.class);
	}
}
