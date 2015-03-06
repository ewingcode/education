package com.web.service;

import java.util.List;

import com.core.app.jbpm.BaseTest;
import com.core.factory.SpringCtx;
import com.web.model.OrderInfo;

public class OrderServiceTest extends BaseTest {
	private static OrderService orderService; 
	private static OrderInfo orderInfo;
	private static List<String> actionList;

	public static void createNewOrder() {
		try {
			orderInfo = new OrderInfo();
			orderInfo.setStudentId(22);
			orderInfo.setOrderNo("212121");
			orderInfo.setOrderType("0");
			orderService.createNewOrder(orderInfo, 11,null,null);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void deploy() {
		String resourceName = "com/core/jbpm/jpdl/order.jpdl.xml";
		jbpmTemplate.Deploy(resourceName);
	}

	public static void init() {

		orderService = (OrderService) SpringCtx.getByBeanName("orderService"); 
	}

	public static void transfer(String action) {
		try {
			//orderService.transferToAssiger(11, 222,Integer.valueOf(orderInfo.getFlowInsId()), action, null,null,null);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}

	private static void showAction() throws Exception {
		orderInfo = orderService.findOne(orderInfo.getId());
		//actionList = orderControlService.getPageActions(orderInfo);
		System.out.println("==========orderInfo:" + orderInfo.getStatus());
		System.out.println("==========ActionList:");
		for (String action : actionList) {
			System.out.println(action);
		}
	}

	public static void main(String[] args) throws Exception {
		deploy();
	}
}
