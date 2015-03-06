package com.web.action;

import java.io.File;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.OrderAttach;
import com.web.model.OrderCourseEvaluation;
import com.web.service.OrderCourseEvaluationService;

public class OrderCourseEvaluationAction extends BaseAction {
	private static Logger logger = Logger
			.getLogger(OrderCourseEvaluationAction.class);
	@Resource
	private OrderCourseEvaluationService orderCourseEvaluationService;
	private File uploadfile19;
	private String uploadfile19FileName;
	private String uploadfile19ContentType;

	public File getUploadfile19() {
		return uploadfile19;
	}

	public void setUploadfile19(File uploadfile19) {
		this.uploadfile19 = uploadfile19;
	}

	public String getUploadfile19FileName() {
		return uploadfile19FileName;
	}

	public void setUploadfile19FileName(String uploadfile19FileName) {
		this.uploadfile19FileName = uploadfile19FileName;
	}

	public String getUploadfile19ContentType() {
		return uploadfile19ContentType;
	}

	public void setUploadfile19ContentType(String uploadfile19ContentType) {
		this.uploadfile19ContentType = uploadfile19ContentType;
	}

	public OrderCourseEvaluationAction() {
		super(OrderCourseEvaluation.class);
	}

	public void saveExchange() throws ActionException {
		ResponseData responseData = null;
		try {

			Map<OrderAttach, File> attachMap = this.uploadAttachFile(this);
			orderCourseEvaluationService.saveExchange(
					(OrderCourseEvaluation) this
							.buildPageData(super.entityBean), attachMap);
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！");
		}
		outResult(responseData);
	}

	public void editExchange() throws ActionException {
		ResponseData responseData = null;
		try {
			Map<OrderAttach, File> attachMap = this.uploadAttachFile(this);
			orderCourseEvaluationService.saveExchange(
					(OrderCourseEvaluation) this
							.buildPageData(super.entityBean), attachMap);
			responseData = ResponseUtils.success("更新成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("更新失败！");
		}
		outResult(responseData);
	}

}
