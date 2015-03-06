package com.core.app.jbpm;

import java.util.List;

import org.jbpm.api.ProcessInstance;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.core.factory.SpringCtx;
import com.core.jbpm.JbpmTemplate;
import com.web.constant.OrderConstant;
import com.web.model.OrderInfo;
import com.web.service.OrderService;

public class OrderProcessTest extends BaseTest { 
	OrderService orderService;
	/**
	 * 部署流程
	 */
	@Before
	public void testOrderDeploy() {
		try {
			String resourceName = "com/core/jbpm/jpdl/order.jpdl.xml";
			//jbpmTemplate.Deploy(resourceName);
			orderService = (OrderService) SpringCtx
			.getByBeanName("orderService");
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		}
	}

	@Test
	public void startProcess() {
		try {
		
			OrderInfo orderInfo = new OrderInfo(); 
//			orderInfo.setStatus(OrderConstant.Status.MARKING_APPROVAL
//					.getStatus());
			//orderService.add(orderInfo);
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		}
	}
	
	 
	@Test
	public void markingAccpet() {
		try {
 		//	List<OrderInfo> orderList = orderService.findGroupTask(groupId);
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		}
	}

	public static void main(String[] args) throws Exception {
		JbpmTemplate jbpmTemplate = (JbpmTemplate) SpringCtx
		.getByBeanName("jbpmTemplate");
		ProcessInstance execution = jbpmTemplate.findProcessInstanceById("orderProcess.16");
		System.out.println();
		List<String> list = jbpmTemplate.getRepositoryService().getStartActivityNames("orderProcess");
		System.out.println();
	}
}
