package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.Notice;
import com.web.service.NoticeService;

public class NoticeAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderAttchAction.class);
	@Resource
	private NoticeService noticeService;
	public NoticeAction() {
		super(Notice.class);
	}
	
	public void updateToReaded() throws ActionException {
		ResponseData responseData = null;
		try { 
			String noticeId = request.getParameter("noticeId"); 
			noticeService.updateToReaded(Integer.valueOf(noticeId));
			responseData = ResponseUtils.success("发送成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("发送失败！");
		}
		this.outResult(responseData);
	}
}
