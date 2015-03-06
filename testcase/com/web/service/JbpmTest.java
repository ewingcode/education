package com.web.service;

import java.util.List;

import org.junit.Test;

import com.core.factory.SpringCtx;
import com.core.jbpm.JbpmTemplate;
import com.core.jbpm.model.FlowTaskTransition;
import com.web.model.OrderInfo;

public class JbpmTest {
	//@Test
	public void init() {
		try {
			JbpmTemplate jbpmTemplate = (JbpmTemplate) SpringCtx
					.getByBeanName("jbpmTemplate");
			System.out.println(jbpmTemplate.getActivityName("orderProcess.96"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Test
	public void getName() throws Exception{ 
		OrderViewService orderViewService = (OrderViewService) SpringCtx
		.getByBeanName("orderViewService");
		OrderInfo order= new OrderInfo();
		order.setFlowInsId("orderProcess.96"); 
		List<FlowTaskTransition> list =orderViewService.getPageActions(order);
		
	}
}
