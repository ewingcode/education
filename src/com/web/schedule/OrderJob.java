/**
 * 
 */
package com.web.schedule;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.service.BaseModelService;
import com.web.constant.OrderRunStatus;
import com.web.model.OrderInfo;
import com.web.service.OrderService;

/**
 * 签单后台作业
 * 
 * @author a
 * 
 */
public class OrderJob {
	private static final Logger logger = Logger.getLogger(OrderJob.class);
	@Resource
	private BaseModelService baseModelService;
	@Resource
	private OrderService orderService;

	public void checkOutTimeOrder() {
		try {
			List<OrderInfo> orderList = baseModelService.find("run_status='"
					+ OrderRunStatus.INLEARN + "'", OrderInfo.class);
			for (OrderInfo orderInfo : orderList) {
				long endTime = orderInfo.getEndTime().getTime();
				long time = System.currentTimeMillis() - endTime;
				// 当超过了签单结束时间后，自动执行流程，更新状态到结束。
				if (time >= 0) {
					orderService.orderTransfer(0, 0, orderInfo.getId(),
							"判断授课时间");
				}
			}
			logger.info(orderList.size());
		} catch (Exception e) {
			logger.error("error in checkOutTimeOrder", e);
		}
	}
}
