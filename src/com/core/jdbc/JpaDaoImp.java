package com.core.jdbc;

import java.lang.reflect.Field;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.jpa.JpaCallback;
import org.springframework.orm.jpa.support.JpaDaoSupport;
import org.springframework.stereotype.Repository;

import com.core.jdbc.util.PageBean;


public class JpaDaoImp extends JpaDaoSupport implements BaseDao {

	private static Logger logger = Logger.getLogger(JpaDaoImp.class);

	@Autowired
	public JpaDaoImp(EntityManagerFactory entityManagerFactory) {
		setEntityManagerFactory(entityManagerFactory);
	}

	public JpaDaoImp() {

	}

	@Override
	public void delete(Object entity)   {
		getJpaTemplate().remove(getJpaTemplate().merge(entity));

	}

	@Override
	public List excuteQuery(String sql)   {
		return getJpaTemplate().find(sql.toString());
	}

	@Override
	public void executeUpdate(String sql)   {

	}

	@Override
	public List find(String condition, Class entityClass)   {
		return getJpaTemplate().find(generateQuerySql(condition, entityClass));
	}

	@Override
	public Object findOne(Object id, Class entityClass)   {
		return getJpaTemplate().find(entityClass, id);
	}

	/**
	 * 根本查询条件创建SQL
	 * 
	 * @param condition
	 * @param entityClass
	 * @return
	 */
	private String generateQuerySql(String condition, Class entityClass) {
		StringBuffer sql = new StringBuffer();
		sql.append(" from ").append(entityClass.getName());
		if (!StringUtils.isEmpty(condition)) {
			sql.append(" where 1=1 ");
			if (!(condition.trim().startsWith("and") || condition.trim()
					.startsWith("AND"))) {
				sql.append(" and ");
			}
			sql.append(condition);
		}
		return sql.toString();
	}

	/**
	 * 根本查询条件创建SQL
	 * 
	 * @param condition
	 * @param entityClass
	 * @return
	 */
	private String generateQueryCountSql(String condition, Class entityClass) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(entityClass.getName());
		if (!StringUtils.isEmpty(condition))
			sql.append(" where ").append(condition);
		return "select count(*) from ( " + sql.toString() + " )";
	}

	@Override
	public void save(Object entity)   {
		bulidEntityTime(entity, true);
		getJpaTemplate().persist(entity);
	}

	@Override
	public void update(Object entity)   {
		bulidEntityTime(entity, false);
		getJpaTemplate().merge(entity);
	}

	@Override
	public PageBean pageQuery(final String condition, int pageSize,
			int startIndex, Class entityClass) {
		final int start = startIndex;
		final int limit = pageSize;
		final Class entity = entityClass;
		JpaCallback jc = new JpaCallback() {
			public Object doInJpa(EntityManager em) throws HibernateException {
				// Query rowCountQuery = em.createQuery(generateQueryCountSql(
				// condition, entityClass)); // NOI18N
				Query rowCountQuery = em.createQuery(generateQuerySql(
						condition, entity));
				int totalCount = rowCountQuery.getResultList().size();
				final Query getRowsQuery = em.createQuery(generateQuerySql(
						condition, entity));
				Query query = getRowsQuery.setMaxResults(limit).setFirstResult(
						start);
				PageBean ps = new PageBean(start, totalCount, limit, query
						.getResultList());
				return ps;

			}
		};
		return (PageBean) getJpaTemplate().execute(jc, true);
	}

	private void bulidEntityTime(Object entity, boolean isNew) {

		try {
			Class zzz = entity.getClass();
			Field createtime = entity.getClass().getDeclaredField("createTime");
			Field last_update = entity.getClass()
					.getDeclaredField("lastUpdate");
			last_update.setAccessible(true);
			last_update.set(entity, new java.sql.Timestamp(
					(new java.util.Date()).getTime()));
			if (isNew) {
				createtime.setAccessible(true);
				createtime.set(entity, new java.sql.Timestamp(
						(new java.util.Date()).getTime()));
			}
		} catch (SecurityException e) {
			logger.warn("not existed createtime or last_update in "
					+ entity.getClass().toString());
		} catch (NoSuchFieldException e) {
			logger.warn("not existed createtime or last_update in "
					+ entity.getClass().toString());
		} catch (IllegalAccessException e) {
			logger.warn("failed to bulidEntityTime in "
					+ entity.getClass().toString());
		}

	}
}
