package com.web.comet;

import java.util.List;
import java.util.Map;

import nl.justobjects.pushlet.core.Event;
import nl.justobjects.pushlet.core.EventPullSource;

import org.apache.log4j.Logger;

import com.core.factory.SpringCtx;
import com.core.jdbc.DaoException;
import com.web.service.NoticeService;

public class NoticeCenter {
	private static Logger logger = Logger.getLogger(NoticeCenter.class);

	static public class NoticeEventPullSource extends EventPullSource {

		private static NoticeService noticeService;
		static {
			noticeService = (NoticeService) SpringCtx
					.getByBeanName("noticeService");
		}

		@Override
		protected long getSleepTime() {
			return 3000;
		}

		@Override
		protected Event pullEvent() {
			Event event = Event.createDataEvent("/notice");
			// 公告通知
			try {
				List notReadList = noticeService.getUserNoReadNoticesTotal();
				for (int i = 0; i < notReadList.size(); i++) {
					Map map = (Map) notReadList.get(i);
					String receiver_id = String.valueOf(map.get("receiver_id"));
					String total = String.valueOf(map.get("total"));
					event.setField("notice_" + receiver_id + "_notreadcount",
							total); 
					
				}
			} catch (DaoException e) {
				logger.error(e, e);
			}
		 
			return event;
		}
	}

}
