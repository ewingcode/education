package com.core.app.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.TreeObject;
import com.core.app.constant.IsEff;
import com.core.app.model.SysDepartment;
import com.core.jdbc.DaoException;
import com.core.json.JsonUtil;

public class SysDepartmentAction extends BaseAction {
	private static Logger logger = Logger.getLogger(SysDepartmentAction.class);
	private Integer depId;

	public Integer getDepId() {
		return depId;
	}

	public void setDepId(Integer depId) {
		this.depId = depId;
	}

	public SysDepartmentAction() {
		super(SysDepartment.class);
	}

	public void queryAll() throws ActionException {
		ResponseData responseData = null;
		try {
			if (depId!=null && depId>0)
				throw new ActionException("depId should not be null!");
			StringBuffer condition = new StringBuffer(); 
			condition.append(" iseff='").append(IsEff.EFFECTIVE)
					.append("'"); 
			List list = baseModelService
					.find(condition.toString(), entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		outResult(responseData);
	}

	public void queryDepartmentTree() throws ActionException {
		try {
			List rootList = queryTreeData("level='1' and rootid=0");
			List childList = new ArrayList();
			for (int i = 0; i < rootList.size(); i++) {
				SysDepartment sysDepartment = (SysDepartment) rootList.get(i);
				TreeObject treeObject = copy2TreeObject(sysDepartment);
				childList.add(treeObject);
			}
			String json = JsonUtil.tranBean2String(childList).toString();
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

	private void queryChildTree(TreeObject parentTree, int parentId)
			  {
		List menuList = queryTreeData("parentid=" + parentId);
		if (menuList.isEmpty()) {
			parentTree.setLeaf(true);
			return;
		}
		parentTree.setLeaf(false);
		List childList = new ArrayList();
		for (int i = 0; i < menuList.size(); i++) {
			SysDepartment sysMenu = (SysDepartment) menuList.get(i);
			int depId = sysMenu.getId();
			TreeObject treeObject = copy2TreeObject(sysMenu);
			queryChildTree(treeObject, depId);
			childList.add(treeObject);
		}
		parentTree.setChildren(childList);

	}

	private TreeObject copy2TreeObject(SysDepartment sysDepartment) {
		TreeObject treeObject = new TreeObject();
		treeObject.setId(sysDepartment.getId());
		treeObject.setText(sysDepartment.getName());
		return treeObject;
	}

	private List queryTreeData(String sql)   {
		return baseModelService.find(sql, SysDepartment.class);
	}
}
