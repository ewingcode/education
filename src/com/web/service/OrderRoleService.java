package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.exception.OrderException;
import com.web.model.OrderRole;

/**
 * 
 * 签单角色负责人配置服務
 * 
 */
@Repository("orderRoleService")
public class OrderRoleService {
	@Resource
	private BaseDao baseDao;

	public int getChargerType(int roleId) throws OrderException {
		List<OrderRole> list = baseDao
				.find("roleId=" + roleId, OrderRole.class);
		/*
		 * if (list.isEmpty()) { throw new
		 * OrderException("could not found charger for roleid:" + roleId); }
		 */
		if (!list.isEmpty() && list.size() == 1)
			return list.get(0).getCharger();
		return 0;
	}

	public int getRoleId(int chargerType) throws OrderException {
		List<OrderRole> list = baseDao.find("charger=" + chargerType,
				OrderRole.class);
		/*
		 * if (list.isEmpty()) { throw new
		 * OrderException("could not found roleid for chargerType:" +
		 * chargerType); } return list.get(0).getRoleId();
		 */
		if (!list.isEmpty() && list.size() == 1)
			return list.get(0).getRoleId();
		return 0;

	}
}
