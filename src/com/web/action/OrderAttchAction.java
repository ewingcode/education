/**
 * 
 */
package com.web.action;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.web.model.OrderAttach;
import com.web.service.OrderAttachService;

public class OrderAttchAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderAttchAction.class);
	
	public OrderAttchAction() {
		super(OrderAttach.class);
	}
	@Resource
	private OrderAttachService orderAttachService;

	public void updateStatus() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId_str = request.getParameter("orderId");
			String status = request.getParameter("status");
			String commet = request.getParameter("attach_commet");
			orderAttachService.updateStatus(Integer.valueOf(orderId_str),
					status, commet);
			responseData = ResponseUtils.success("更新成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("更新失败！");
		}
		outResult(responseData);
	}

}
