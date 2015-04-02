package com.core.jdbc;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;

import com.core.factory.SpringCtx;
import com.core.jdbc.annotation.Table;
import com.core.jdbc.util.BomcRowMapper;
import com.core.jdbc.util.GenericsUtil;
import com.core.jdbc.util.Page;
import com.core.log.LogHelper;

public class MysqlDaoImp implements BaseDao {
	private static final Logger log = LogHelper.getLog(MysqlDaoImp.class);

	private Table table;

	JdbcTemplate jdbcTemplate;

	public MysqlDaoImp() {
		try {
			setJdbcTemplate();
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	@Override
	public void delete(Object entity)   {
		String sql = null;
		try {
			this.table = GenericsUtil.getTable(entity.getClass());
			hasPrimaryKey(entity);
			sql = "delete from " + this.table.name() + " where 1=1 "
					+ GenericsUtil.getWhereSql(entity);
			log.info(sql);
			this.jdbcTemplate.execute(sql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DaoException(e);
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public List find(String condiction, String orderBy, boolean isAsc,
			Class entityClass)   {
		try {
			this.table = GenericsUtil.getTable(entityClass);
			String order = " desc ";
			if (isAsc) {
				order = " asc ";
			}
			String sql = "";
			if (StringUtils.isNotBlank(condiction)) {
				if (!condiction.trim().toLowerCase().startsWith("and")) {
					condiction = " and " + condiction;
				}
				sql = "select * from " + this.table.name() + " where 1=1 "
						+ condiction;
			} else {
				sql = "select * from " + this.table.name();
			}
			if (StringUtils.isNotBlank(orderBy)) {
				sql = sql + " order by " + orderBy + order;
			}
			log.info(sql);
			return this.jdbcTemplate.query(sql, new BomcRowMapper(entityClass));
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DaoException(e);
		}
	}

	public JdbcTemplate getJdbcTemplate() {
		return this.jdbcTemplate;
	}

	private void hasPrimaryKey(Object entity) throws Exception {
		boolean hasPrimaryKey = GenericsUtil.hasPrimaryKey(entity);
		if (!hasPrimaryKey)
			throw new DaoException(
					"fail to operator the object that is in need of primarykey");
	}

	@SuppressWarnings("unchecked")
	@Override
	public Page paginationQuery(String condition, int pageNo, int pageSize,
			Class entityClass)   {
		return paginationQuery(condition, pageNo, pageSize, null, true,
				entityClass);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Page paginationQuery(String condition, int pageNo, int pageSize,
			String orderBy, boolean isAsc, Class entityClass)
			  {
		try {
			this.table = GenericsUtil.getTable(entityClass);
			String order = " desc ";
			if (isAsc) {
				order = " asc ";
			}
			String sql = "select *";
			String tableSql = " from " + this.table.name();
			String conditionSql = " where 1=1";
			String orderSql = "";
			String paginationSql = "";
			if (StringUtils.isNotBlank(condition)) {
				if (!condition.trim().toLowerCase().startsWith("and")) {
					conditionSql = " and " + condition;
				}
			}

			if (StringUtils.isNotBlank(orderBy)) {
				orderSql = " order by " + orderBy + order;
			}

			if (pageNo != 0 && pageSize != 0) {
				pageNo = pageNo - 1;
				paginationSql = " limit " + pageNo + "," + pageSize;
			}
			sql += tableSql + conditionSql + orderSql;
			log.info(sql);

			int count = this.jdbcTemplate.queryForInt("select count(*) from ("
					+ sql + ") a");
			sql += paginationSql;
			List list = this.jdbcTemplate.query(sql, new BomcRowMapper(
					entityClass));
			return new Page(pageNo + 1, count, pageSize, list);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DaoException(e);
		}
	}

	@Override
	public void save(Object entity)   {
		try {
			String sql = GenericsUtil.getSaveSql(entity);
			log.info(sql);
			this.jdbcTemplate.execute(sql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DaoException(e);
		}
	}

	public void setJdbcTemplate() {
		this.jdbcTemplate = (JdbcTemplate) SpringCtx
				.getClassBean(JdbcTemplate.class);

	}

	@Override
	public void update(Object entity)   {
		String sql = "";
		try {
			hasPrimaryKey(entity);
			sql = GenericsUtil.getUpdateSql(entity);
			log.info(sql);
			this.jdbcTemplate.execute(sql);
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());
			throw new DaoException(e);
		}
	}

	@Override
	public void executeUpdate(String sql) {
		this.jdbcTemplate.execute(sql);

	}

	@SuppressWarnings("unchecked")
	@Override
	public List excuteQuery(String sql) {
		return this.jdbcTemplate.queryForList(sql);
	}

}