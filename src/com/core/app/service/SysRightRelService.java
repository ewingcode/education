package com.core.app.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.app.bean.UserInfo;
import com.core.app.constant.SysRelRight;
import com.core.app.control.SessionControl;
import com.core.app.control.SessionException;
import com.core.app.model.SysRightRel;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.util.SqlUtil;
/**
 * 权限关联设置
 * 
 */
@Repository("sysRightRelService")
public class SysRightRelService {
	/**
	 * 权限关联类型
	 * 
	 */
	public enum RelType {
		User(0), role(1), Department(2);
		private int type;

		private RelType(int type) {
			this.type = type;
		}

		public int getType() {
			return this.type;
		}
	}

	@Resource
	public BaseDao baseDao;

	/**
	 * 获取用户下所有的权限菜单
	 * 
	 * @param userInfo
	 * @return
	 * @ 
	 */
	public Set<Integer> getUserAllRelMenu(UserInfo userInfo)
			  {
		Set<Integer> allRelList = new HashSet<Integer>();
		Set<Integer> userRelList = getRelTargetList(userInfo.getId(),
				RelType.User, SysRelRight.MENU);
		Set<Integer> roleRelList = getRelTargetList(userInfo.getRoleId(),
				RelType.role, SysRelRight.MENU);
		Set<Integer> depRelList = getRelTargetList(userInfo.getDepId(),
				RelType.Department, SysRelRight.MENU);
		allRelList.addAll(userRelList);
		allRelList.addAll(roleRelList);
		allRelList.addAll(depRelList);
		userInfo.setRelMenus(allRelList);
		return allRelList;
	}

	/**
	 * 获取用户下所有的权限菜单
	 * 
	 * @param userInfo
	 * @return
	 * @ 
	 */
	public Set<Integer> getUserAllRelArea(UserInfo userInfo)
			  {
		Set<Integer> allRelList = new HashSet<Integer>();
		Set<Integer> userRelList = getRelTargetList(userInfo.getId(),
				RelType.User, SysRelRight.AREA);
		Set<Integer> roleRelList = getRelTargetList(userInfo.getRoleId(),
				RelType.role, SysRelRight.AREA);
		Set<Integer> depRelList = getRelTargetList(userInfo.getDepId(),
				RelType.Department, SysRelRight.AREA);
		allRelList.addAll(userRelList);
		allRelList.addAll(roleRelList);
		allRelList.addAll(depRelList);
		userInfo.setRelAreas(allRelList);
		if (userInfo.getAreaId() != null && userInfo.getAreaId()>0)
			userInfo.getRelAreas().add(userInfo.getAreaId());
		return allRelList;
	}
	/**
	 * 用户是否有该菜单的访问权限
	 * 
	 * @param userInfo
	 * @param menuId
	 * @return
	 */
	public boolean containRelMenu(UserInfo userInfo, Integer menuId) {
		for (Integer id : userInfo.getRelMenus()) {
			if (id.equals(menuId))
				return true;
		}
		return false;
	}

	/**
	 * 获取关联的权限对象列表
	 * 
	 * @param userInfo
	 * @return
	 * @ 
	 */
	public Set<Integer> getRelTargetList(Integer relId, RelType role,
			SysRelRight right)   {
		Set<Integer> targetIds = new HashSet<Integer>();
		List<SysRightRel> userRelList = baseDao.find(
				"rel_right=" + right.getValue() + " and type='"
						+ role.getType() + "' and rel_id=" + relId,
				SysRightRel.class);
		for (SysRightRel sysRightRel : userRelList) {
			targetIds.add(sysRightRel.getTargetId());
		}
		return targetIds;
	}

	/**
	 * 权限设置
	 * 
	 * @param type
	 * @param relId
	 * @param menuIds
	 * @ 
	 */
	@Transactional
	public void rightRelSetting(String type, String relId, Integer right,
			Integer[] menuIds)   {
		baseDao.executeSql("delete from sys_right_rel where rel_right=" + right
				+ " and type='" + type + "' and rel_id=" + relId);
		for (Integer menuId : menuIds) {
			SysRightRel sysRightRel = new SysRightRel();
			sysRightRel.setRelRight(right);
			sysRightRel.setType(type);
			sysRightRel.setTargetId(menuId);
			sysRightRel.setRelId(relId);
			baseDao.save(sysRightRel);
		}

	}

	/**
	 * 查询关联的对象
	 * 
	 * @param type
	 * @param relId
	 * @param menuIds
	 * @ 
	 */
	@Transactional
	public Set<Integer> queryRelMenu(String type, Integer right, Integer relId)
			  {
		Set<Integer> targetList = new HashSet<Integer>();
		List<SysRightRel> relList = baseDao.find(" rel_right=" + right
				+ " and type='" + type + "' and rel_id=" + relId,
				SysRightRel.class);
		for (SysRightRel sysRightRel : relList) {
			targetList.add(sysRightRel.getTargetId());
		}
		return targetList;

	}

	/**
	 * 获取区域权限查询的sql查询条件
	 * 
	 * @param request
	 * @return
	 * @throws SessionException
	 */
	public String getAreaRightSql(HttpServletRequest request)
			throws SessionException {
		UserInfo userInfo = SessionControl.getUserInfo(request);
		String sql = null;
		Set<Integer> relArea = userInfo.getRelAreas();
		if (userInfo.getAreaId() != null)
			sql = " area_id in ("
					+ SqlUtil.array2InCondition(relArea
							.toArray(new Integer[relArea.size()])) + ")";
		return sql;
	}
}
