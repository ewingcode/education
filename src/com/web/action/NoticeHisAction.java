package com.web.action;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.control.SessionControl;
import com.web.model.NoticeHis;
import com.web.service.NoticeService;

public class NoticeHisAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderAttchAction.class);
	@Resource
	private NoticeService noticeService;

	public NoticeHisAction() {
		super(NoticeHis.class);
	}

	public void addNotice() throws ActionException {
		ResponseData responseData = null;
		try {
			UserInfo userInfo = SessionControl.getUserInfo(request);
			int senderId = userInfo.getId();
			String receiverType = request.getParameter("receiverType");
			String receiverIds = request.getParameter("receiverIds");
			String content = request.getParameter("content");
			List<String> receiverIdList = Arrays.asList(receiverIds.split(","));
			noticeService.addNotice(senderId, receiverType, receiverIdList,
					content);
			responseData = ResponseUtils.success("发送成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("发送失败！");
		}
		this.outResult(responseData);
	}
}
