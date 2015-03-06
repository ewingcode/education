package com.web.action;

import java.io.IOException;

import javax.servlet.ServletException;

import com.core.app.action.base.BaseAction;
import com.web.model.CustomerInfo;

public class CustomerAction extends BaseAction {
	public CustomerAction() {
		super(CustomerInfo.class);
	}

	public void setField() throws IOException, ServletException {
		String s = "{" + "	header : '是否有效'," + "	dataIndex : 'iseff',"
				+ "	 renderer: function(value) { "
				+ "		return  SysParam.translate(iseffStore,value);  " + "	}"
				+ "},";
		request.setAttribute("ffff", s); 
		String actionUrl="/page/market/customer/info.jsp";
		request.getRequestDispatcher(actionUrl).forward(request, response);
		//response.sendRedirect(actionUrl);
	}
}
