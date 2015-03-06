package com.web.action;

import java.io.File;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.control.SessionControl;
import com.core.jdbc.util.PageBean;
import com.web.constant.OrderAttachStatus;
import com.web.model.OrderAttach;
import com.web.model.OrderExchange;
import com.web.model.OrderInfo;
import com.web.service.OrderExchangeService;
import com.web.service.OrderQueryService;

public class OrderExchangeAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderExchangeAction.class);

	public OrderExchangeAction() {
		super(OrderExchange.class);
	}

	private File uploadfile20;
	private String uploadfile20FileName;
	private String uploadfile20ContentType;
	@Resource
	private OrderExchangeService orderExchangeService;
	@Resource
	private OrderQueryService orderQueryService;

	public File getUploadfile20() {
		return uploadfile20;
	}

	public void setUploadfile20(File uploadfile20) {
		this.uploadfile20 = uploadfile20;
	}

	public String getUploadfile20FileName() {
		return uploadfile20FileName;
	}

	public void setUploadfile20FileName(String uploadfile20FileName) {
		this.uploadfile20FileName = uploadfile20FileName;
	}

	public String getUploadfile20ContentType() {
		return uploadfile20ContentType;
	}

	public void setUploadfile20ContentType(String uploadfile20ContentType) {
		this.uploadfile20ContentType = uploadfile20ContentType;
	}

	public void findEditableStudents() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = orderExchangeService.findEditableStudents(
					userInfo.getId(), Integer.valueOf(limit), Integer
							.valueOf(start), bulidConditionSql(),
					bulidOrderBySql());
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	public void findEditableOrders() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = orderExchangeService.findEditableOrders(
					userInfo.getId(), Integer.valueOf(limit), Integer
							.valueOf(start));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	public void findStudentExchange() throws ActionException {
		ResponseData responseData = null;
		try {
			String studentId = request.getParameter("studentId");
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			PageBean pageBean = orderExchangeService.findStudentExchange(
					Integer.valueOf(studentId), Integer.valueOf(limit), Integer
							.valueOf(start));
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(pageBean.getTotalCount());
			responseData.setResult(pageBean.getResult());
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	public void saveExchange() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			String content = request.getParameter("content");
			String studentId = request.getParameter("studentId");
			int orderId = 0;
			OrderInfo orderInfo = orderQueryService.queryLastestOrder(userInfo
					.getId(), Integer.valueOf(studentId));
			if (orderInfo != null)
				orderId = orderInfo.getId();
			Map<OrderAttach, File> attachMap = uploadAttachFile(this);
			orderExchangeService.saveExchange(orderId, userInfo.getId(),
					content, attachMap);
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		outResult(responseData);
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

	public void editExchange() throws ActionException {
		ResponseData responseData = null;
		try {
			Map<OrderAttach, File> attachMap = uploadAttachFile(this);
			orderExchangeService.editExchange((OrderExchange) this
					.buildPageData(super.entityBean), attachMap);
			responseData = ResponseUtils.success("更新成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("更新失败！");
		}
		outResult(responseData);
	}

}
