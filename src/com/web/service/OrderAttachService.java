package com.web.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.core.factory.SysParamFactory;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.tool.fileshow.FileData;
import com.core.tool.fileshow.FileProcessor;
import com.util.SqlUtil;
import com.web.constant.OrderAttachStatus;
import com.web.model.OrderAttach;
import com.web.model.OrderInfo;

/**
 * 签单附件业务类
 * 
 */
@Repository("orderAttachService")
public class OrderAttachService {
	@Resource
	private BaseDao baseDao;

	public List<OrderAttach> queryOrderAttach(int orderId) throws DaoException {
		return baseDao.find("order_id=" + orderId, OrderAttach.class);
	}

	public OrderAttach getOrderAttach(int orderId, String type)
			throws DaoException {
		List<OrderAttach> list = baseDao.find("order_id=" + orderId
				+ " and type='" + type + "'", OrderAttach.class);
		if (list.isEmpty())
			return null;
		return list.get(0);
	}

	public List<OrderAttach> queryOrderAttach(int orderId, String... type)
			throws DaoException {
		List<OrderAttach> list = baseDao.find("order_id=" + orderId
				+ " and type in (" + SqlUtil.array2InCondition(type) + ")",
				OrderAttach.class);
		return list;
	}

	/**
	 * 保存签单附件
	 * 
	 * @param orderInfo
	 * @param orderAttach
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public OrderAttach saveOrderAttach(OrderInfo orderInfo,
			OrderAttach orderAttach, File file) throws Exception {
		String fileAbsolutePath = "";
		File destFile = null;
		if (file != null) {
			destFile = this.uploadFileProcess(orderInfo.getStudentId(),
					orderInfo.getId(), file, orderAttach.getName(), orderAttach
							.getType());
			fileAbsolutePath = destFile.getAbsolutePath();
			orderAttach.setPath(getAttachAbsolutePath(fileAbsolutePath));
		}
		orderAttach.setOrderId(orderInfo.getId());
		String type = orderAttach.getType();
		OrderAttach oldVo = getOrderAttach(orderAttach.getOrderId(), type);
		if (oldVo != null) {
			if (!StringUtils.isEmpty(orderAttach.getPath()))
				oldVo.setPath(orderAttach.getPath());
			if (!StringUtils.isEmpty(orderAttach.getName()))
				oldVo.setName(orderAttach.getName());
			if (!StringUtils.isEmpty(orderAttach.getStatus()))
				oldVo.setStatus(orderAttach.getStatus());
			if (!StringUtils.isEmpty(orderAttach.getCommet()))
				oldVo.setCommet(orderAttach.getCommet());
			baseDao.update(oldVo);
			orderAttach=oldVo;
		} else {
			baseDao.save(orderAttach);
		}
		FileProcessor.getFileProcessor().addToQueue(
				new FileData(destFile, orderAttach));
		return orderAttach;
	}

	public OrderAttach saveExchangeAttach(OrderInfo orderInfo,
			OrderAttach orderAttach, File file) throws Exception {
		String fileAbsolutePath = "";
		File destFile;
		if (file != null) {
			destFile = this.uploadFileProcess(orderInfo.getStudentId(),
					orderInfo.getId(), file, orderAttach.getName(), orderAttach
							.getType());
			fileAbsolutePath = destFile.getAbsolutePath();
			orderAttach.setPath(getAttachAbsolutePath(fileAbsolutePath));
			orderAttach.setOrderId(orderInfo.getId());
			if (orderAttach.getId() != null && orderAttach.getId() != 0) {
				OrderAttach oldVo = baseDao.findOne(orderAttach.getId(),
						OrderAttach.class);
				oldVo.setPath(orderAttach.getPath());
				oldVo.setName(orderAttach.getName());
				baseDao.update(oldVo);
				orderAttach = oldVo;
			} else {
				baseDao.save(orderAttach);
			}
			FileProcessor.getFileProcessor().addToQueue(
					new FileData(destFile, orderAttach));
		}

		return orderAttach;
	}

	public void batchSaveOrderAttach(OrderInfo orderInfo,
			Map<OrderAttach, File> attachMap) throws Exception {
		Iterator<OrderAttach> iter = attachMap.keySet().iterator();
		while (iter.hasNext()) {
			OrderAttach orderAttach = (OrderAttach) iter.next();
			File file = attachMap.get(orderAttach);
			saveOrderAttach(orderInfo, orderAttach, file);
		}
	}

	private String getAttachAbsolutePath(String fileAbsolutePath) {
		return fileAbsolutePath.replace(SysParamFactory.WEB_REAL_PATH, "")
				.replace(File.separator, "/");
	}

	/**
	 * 上传文件处理
	 * 
	 * @param file
	 * @param fileName
	 * @param type
	 * @throws FileNotFoundException
	 */
	private File uploadFileProcess(int studentId, int orderId, File file,
			String fileName, String fileType) throws Exception {
		String attachPath = SysParamFactory.WEB_REAL_PATH + "fileupload"
				+ File.separator;
		String savePath = attachPath + "s" + studentId + File.separator + "o"
				+ orderId + File.separator + "f" + fileType;
		File rootPath = new File(savePath);
		if (!rootPath.exists()) {
			rootPath.mkdirs();
		}

		InputStream in = null;
		OutputStream out = null;
		int typeInd = fileName.lastIndexOf(".");
		if (typeInd > 0) {
			fileName = fileName.substring(0, typeInd)
					+ System.currentTimeMillis() + fileName.substring(typeInd);
		}

		File detfile = new File(savePath + File.separator + fileName);
		int BUFFER_SIZE = 99999;
		try {
			in = new BufferedInputStream(new FileInputStream(file), BUFFER_SIZE);
			out = new BufferedOutputStream(new FileOutputStream(detfile),
					BUFFER_SIZE);
			byte[] buffer = new byte[BUFFER_SIZE];
			while (in.read(buffer) > 0) {
				out.write(buffer);
			}
			return detfile;
		} finally {
			if (null != in) {
				in.close();
			}
			if (null != out) {
				out.close();
			}
		}

	}

	public void updateStatus(int attachId, String status, String commet)
			throws DaoException {
		OrderAttach orderAttach = baseDao.findOne(attachId, OrderAttach.class);
		orderAttach.setStatus(status);
		orderAttach.setCommet(commet);
		baseDao.update(orderAttach);
	}

	public void processAttach(OrderInfo orderInfo,
			Map<OrderAttach, File> attachMap) throws Exception {
		List<OrderAttach> oldOrderAttachList = queryOrderAttach(orderInfo.getId(), "1", "2", "3", "4", "5");
		for (OrderAttach orderAttach : oldOrderAttachList) {
			OrderAttach newAttach = new OrderAttach();
			newAttach.setCommet("");
			newAttach.setType(orderAttach.getType());
			newAttach.setName(orderAttach.getName());
			newAttach.setPath(orderAttach.getPath());
			newAttach.setStatus(OrderAttachStatus.ACCEPT);
			newAttach.setOrderId(orderInfo.getId());
			newAttach.setSwfpath(orderAttach.getSwfpath());
			if (getOrderAttach(orderInfo.getId(), orderAttach.getType()) == null) {
				baseDao.save(newAttach);
			}
		}
		Iterator<OrderAttach> itor = attachMap.keySet().iterator();
		while (itor.hasNext()) {
			OrderAttach orderAttach = itor.next();
			orderAttach.setStatus(OrderAttachStatus.ACCEPT);
		}
		batchSaveOrderAttach(orderInfo, attachMap);
	}
	
	public void processParentAttach(OrderInfo orderInfo,
			Map<OrderAttach, File> attachMap) throws Exception {
		List<OrderAttach> parentOrderAttachList = queryOrderAttach(orderInfo.getParentOrderId(), "1", "2", "3", "4", "5");
		for (OrderAttach orderAttach : parentOrderAttachList) {
			OrderAttach newAttach = new OrderAttach();
			newAttach.setCommet("");
			newAttach.setType(orderAttach.getType());
			newAttach.setName(orderAttach.getName());
			newAttach.setPath(orderAttach.getPath());
			newAttach.setStatus(OrderAttachStatus.ACCEPT);
			newAttach.setOrderId(orderInfo.getId());
			newAttach.setSwfpath(orderAttach.getSwfpath());
			if (getOrderAttach(orderInfo.getId(), orderAttach.getType()) == null) {
				baseDao.save(newAttach);
			}
		}
		Iterator<OrderAttach> itor = attachMap.keySet().iterator();
		while (itor.hasNext()) {
			OrderAttach orderAttach = itor.next();
			orderAttach.setStatus(OrderAttachStatus.ACCEPT);
		}
		batchSaveOrderAttach(orderInfo, attachMap);
	}
}
