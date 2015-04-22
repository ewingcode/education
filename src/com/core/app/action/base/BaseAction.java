package com.core.app.action.base;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.core.app.service.BaseModelService;
import com.core.app.service.CacheModelService;
import com.core.jdbc.util.PageBean;
import com.core.json.JsonUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.util.DateFormat;
import com.util.StringUtil;
import com.web.constant.OrderAttachStatus;
import com.web.model.OrderAttach;

/**
 * @author tanson lin
 * 
 * @create:2012-2-23
 * @description: action的父类，实现了构造器传入的Dao的增删改查的基本操作。
 */

public class BaseAction extends ActionSupport implements ServletRequestAware,
		ServletResponseAware {
	protected static Logger logger = Logger.getLogger(BaseAction.class);
	private static final long serialVersionUID = 1L;
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Object entityBean;
	protected Class entityClass;
	protected String condition;
	private final static String SEARCH_CODE = "_QUERY";
	private final static String SEARCH_ORDER_CODE = "_ORDERBY";
	@Resource
	protected BaseModelService baseModelService;
	@Resource
	protected CacheModelService cacheModelService;

	public BaseAction() {

	}

	public BaseAction(Class entityClass) {
		try {
			this.entityClass = entityClass;
			this.entityBean = entityClass.newInstance();
		} catch (Exception e) {
			logger.error(e, e);
		}
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		this.response.setContentType("text/html;charset=UTF-8");
	}

	public String getUTFParameter(String key) {
		String value = request.getParameter(key);
		try {
			return StringUtil.iso2Utf8(value);
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}
		return null;
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void pageQuery() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = baseModelService.pageQuery(bulidConditionSql(),
					bulidOrderBySql(),
					limit == null ? 20 : Integer.valueOf(limit),
					start == null ? 0 : Integer.valueOf(start), entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	public String getCondition() {
		try {
			condition = StringUtil.iso2Utf8(condition);
		} catch (UnsupportedEncodingException e) {
			logger.error(e);
		}
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void query() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			List list = baseModelService.find(getCondition(), entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void noMappedObjectQuery() throws ActionException {
		ResponseData responseData = null;
		try {
			String sql = request.getParameter("sql");
			List list = baseModelService.noMappedObjectQuery(sql);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * dao查询
	 * 
	 * @throws ActionException
	 */
	public void queryByCache() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			List list = cacheModelService.find(getCondition(), entityClass);
			responseData = ResponseUtils.success("查询成功！");
			responseData.setResult(list);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * dao新增
	 * 
	 * @throws ActionException
	 */

	public void save() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			this.buildPageData(entityBean);
			baseModelService.save(entityBean);
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * dao修改
	 * 
	 * @throws ActionException
	 */
	public void update() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			this.buildPageData(entityBean);
			baseModelService.update(entityBean);
			responseData = ResponseUtils.success("更新成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("更新失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * dao删除
	 * 
	 * @throws ActionException
	 */
	public void delete() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			this.buildPageData(entityBean);
			baseModelService.delete(entityBean);
			responseData = ResponseUtils.success("删除成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("删除失败！");
		}
		this.outResult(responseData);
	}

	/**
	 * 从页面拷贝数据值到dao中.
	 * 
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 */
	public Object buildPageData(Object entityBean)
			throws IllegalArgumentException, IllegalAccessException {
		Field[] fields = entityBean.getClass().getDeclaredFields();
		Map paramMap = request.getParameterMap();
		// Map paramMap = new HashMap();
		// paramMap.put("name", "dada");
		for (Field f : fields) {
			f.setAccessible(true);
			String fieldType = f.getType().getName();
			String fName = f.getName();
			if (!paramMap.containsKey(fName))
				continue;
			Object fValue = paramMap.get(fName);
			if (fValue.getClass().isArray()) {

				Object[] sValue = (Object[]) fValue;
				String value = sValue[0].toString();
				// If empty ,set null to field.
				if (value.trim().isEmpty())
					f.set(entityBean, null);
				if (value.trim().isEmpty())
					continue;
				if (fieldType.equals("java.lang.String")) {
					f.set(entityBean, value);
				} else if (fieldType.equals("java.lang.Integer")) {
					f.set(entityBean, Integer.valueOf(value));
				} else if (fieldType.equals("java.util.Date")) {
					if (value.length() == 10) {
						f.set(entityBean, DateFormat.stringToDate(value,
								DateFormat.DATE_FORMAT));
					} else if (value.length() == 19) {
						f.set(entityBean, DateFormat.stringToDate(value,
								DateFormat.DATETIME_FORMAT));
					}
				} else if (fieldType.equals("java.sql.Timestamp")) {
					if (value.length() == 10) {
						f.set(entityBean, new java.sql.Timestamp(DateFormat
								.stringToDate(value, DateFormat.DATE_FORMAT)
								.getTime()));
					} else if (value.length() == 19) {
						f.set(entityBean,
								new java.sql.Timestamp(DateFormat.stringToDate(
										value, DateFormat.DATETIME_FORMAT)
										.getTime()));
					}
				}

			}

		}
		return entityBean;
	}

	protected String bulidConditionSql() {
		StringBuffer sql = new StringBuffer();
		Map<String, String> queryMap = new HashMap<String, String>();
		String orderSql = "";
		Map paramMap = request.getParameterMap();
		for (Iterator itor = paramMap.keySet().iterator(); itor.hasNext();) {
			Object key = itor.next();
			Object object = paramMap.get(key);
			if (key instanceof String && key.toString().startsWith(SEARCH_CODE)
					&& object != null) {
				String queryKey = String.valueOf(key).substring(
						SEARCH_CODE.length());
				if (object.getClass().isArray()) {
					Object[] sValue = (Object[]) object;
					String value = sValue[0].toString();
					if (value.trim().isEmpty())
						continue;
					queryMap.put(queryKey, value);
				}

			}
			if (key instanceof String
					&& key.toString().startsWith(SEARCH_ORDER_CODE)
					&& object != null) {
				if (object.getClass().isArray()) {
					Object[] sValue = (Object[]) object;
					String value = sValue[0].toString();
					if (value.trim().isEmpty())
						continue;
					orderSql = value;
				}
			}
		}
		String queryMapSql = baseModelService.buildSQLWhere(queryMap);
		if (!StringUtil.isEmpty(getCondition())) {
			sql.append(getCondition());
		}
		if (!StringUtil.isEmpty(queryMapSql)) {
			sql.append(queryMapSql);
		}

		return sql.toString();
	}

	protected String bulidOrderBySql() {
		String orderSql = "";
		Map paramMap = request.getParameterMap();
		for (Iterator itor = paramMap.keySet().iterator(); itor.hasNext();) {
			Object key = itor.next();
			Object object = paramMap.get(key);

			if (key instanceof String
					&& key.toString().startsWith(SEARCH_ORDER_CODE)
					&& object != null) {
				if (object.getClass().isArray()) {
					Object[] sValue = (Object[]) object;
					String value = sValue[0].toString();
					if (value.trim().isEmpty())
						continue;
					orderSql = value;
				}
			}
		}
		return orderSql;
	}

	/**
	 * 返回組裝的JSON信息到页面
	 * 
	 * @param responseData
	 * @throws ActionException
	 */
	public void outResult(ResponseData responseData) throws ActionException {
		if (responseData == null)
			throw new IllegalArgumentException(
					"responseData should not be null");
		try {
			String json = JsonUtil.tranBean2String(responseData).toString();
			logger.debug(json);
			response.getWriter().write(json);
		} catch (IOException e) {
			throw new ActionException(e);
		}
	}

	protected Map<OrderAttach, File> uploadAttachFile(Object instance)
			throws Exception {
		Map<OrderAttach, File> attachMap = new HashMap<OrderAttach, File>();
		Class actionClazz = instance.getClass();
		Field[] fields = actionClazz.getDeclaredFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			if (fieldName.startsWith("uploadfile")) {
				try {
					String type = fieldName.replace("uploadfile", "");
					Field fileField = actionClazz.getDeclaredField("uploadfile"
							+ type);
					fileField.setAccessible(true);
					Object fileObject = fileField.get(this);
					if (fileObject == null)
						continue;
					if (!(fileObject instanceof File))
						continue;
					File uploadFile = (File) fileObject;
					Field fileNameField = actionClazz
							.getDeclaredField("uploadfile" + type + "FileName");
					fileNameField.setAccessible(true);
					String uploadFileName = (String) fileNameField
							.get(instance);
					OrderAttach orderAttach = new OrderAttach();
					orderAttach.setName(uploadFileName);
					orderAttach.setType(type);
					orderAttach.setStatus(OrderAttachStatus.WAIT);
					attachMap.put(orderAttach, uploadFile);
				} catch (Exception e) {
					logger.error(e, e);
					throw e;
				}
			}

		}
		return attachMap;
	}

}
