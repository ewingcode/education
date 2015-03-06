package com.web.service;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.core.factory.SpringCtx;

public class OrderViewServiceTest {
	private OrderViewService orderViewService;

	@Before
	public void testOrderDeploy() {
		try {
			orderViewService = (OrderViewService) SpringCtx
					.getByBeanName("orderViewService");
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		}
	}

	@Test
	public void testGetUserEditedTaskPage() {
		int orderId = 62;
		int userId = 10;
		try {
//			String busiPage = orderViewService.getUserEditedTaskPage(userId,
//					orderId);
			//System.out.println(busiPage);
		} catch (Exception e) {
			e.printStackTrace();
			Assert.fail(e.getMessage());
		}
	}
}
