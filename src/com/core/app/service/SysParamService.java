package com.core.app.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.model.SysParam;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.googlecode.ehcache.annotations.Cacheable;

@Repository("sysParamService")
public class SysParamService {
	@Resource
	public BaseDao baseDao;

	@Cacheable(cacheName = "cacheManager")
	public List<SysParam> getSysParam(String rootCode)   {
		return baseDao.find("root_code='" + rootCode + "'", SysParam.class);
	}
	
	@Cacheable(cacheName = "cacheManager")
	public List<SysParam> getAllSysParam()   {
		return baseDao.find("", SysParam.class);
	}
}
