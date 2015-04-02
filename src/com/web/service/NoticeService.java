package com.web.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.app.model.SysUser;
import com.core.app.service.SysUserService;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.constant.NoticeReceiverType;
import com.web.constant.NoticeStatusType;
import com.web.model.Notice;
import com.web.model.NoticeHis;

@Repository("noticeService")
public class NoticeService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private SysUserService sysUserService;

	public void addNotice(int senderId, String receiverType,
			List<String> receiverIdList, String content)   {
		if (receiverIdList.isEmpty())
			return;
		String receiverIds = "";
		for (String receiverId : receiverIdList) {
			Notice notice = new Notice();
			notice.setSenderId(senderId);
			notice.setReceiverId(Integer.valueOf(receiverId));
			notice.setContent(content);
			notice.setStatus(NoticeStatusType.NOTREAD);
			baseDao.save(notice);
			receiverIds += receiverId;
			receiverIds += ",";
		}
		NoticeHis noticeHis = new NoticeHis();
		noticeHis.setSenderId(senderId);
		noticeHis.setReceiverType(receiverType);
		noticeHis.setContent(content);
		noticeHis.setReceiverId(receiverIds.substring(0,
				receiverIds.length() - 1));
		baseDao.save(noticeHis);
	}

	public void AddSysNotice(int senderId, String receiverType, int receiverId,
			String content)   {
		List<SysUser> userList = new ArrayList<SysUser>();
		List<String> receiverIdList = new ArrayList<String>();
		if (NoticeReceiverType.ROLE.equals(receiverType)) {
			userList = sysUserService.findUserByRole(receiverId);
		} else if (NoticeReceiverType.DEPARTMENT.equals(receiverType)) {
			userList = sysUserService.findUserByDepartment(receiverId);
		} else if (NoticeReceiverType.PERSONAL.equals(receiverType)) {
			userList.add(sysUserService.findOne(receiverId));
		}
		for (SysUser sysUser : userList) {
			receiverIdList.add(sysUser.getId().toString());
		}
		addNotice(senderId, receiverType, receiverIdList, content);
	}

	public List<Notice> getPersonalNotices(int receiverId)   {
		String sql = "receiver_id=" + receiverId;
		return baseDao.find(sql, Notice.class);

	}

	public List<Notice> getAllNoReadNotices()   {
		return baseDao.find("is_read='" + NoticeStatusType.NOTREAD + "'",
				Notice.class);
	}

	public List getUserNoReadNoticesTotal()   {
		return baseDao
				.noMappedObjectQuery("select receiver_id,count(*) as total from notice where  status='"
						+ NoticeStatusType.NOTREAD + "' group by receiver_id");
	}

	public List<Notice> getAllNoReadPersonalNotices(int receiverId)
			  {
		return baseDao.find(" receiver_id=" + receiverId + " and status='"
				+ NoticeStatusType.NOTREAD + "'", Notice.class);
	}

	public void updateToReaded(int noticeId)   {
		Notice notice = baseDao.findOne(noticeId, Notice.class);
		if (NoticeStatusType.READED.equals(notice.getStatus()))
			return;
		notice.setStatus(NoticeStatusType.READED);
		baseDao.update(notice);
	}
}
