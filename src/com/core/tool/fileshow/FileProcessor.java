package com.core.tool.fileshow;

import java.io.File;
import java.util.concurrent.LinkedBlockingQueue;

import org.apache.log4j.Logger;

import com.core.factory.SpringCtx;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.web.model.OrderAttach;

public class FileProcessor extends Thread {
	private static Logger logger = Logger.getLogger(FileProcessor.class);
	private static LinkedBlockingQueue<FileData> fileDataQueue = new LinkedBlockingQueue<FileData>();
	private static final FileProcessor fileProcessor = new FileProcessor();
	private BaseDao baseDao;
	private static boolean isStarted;
	FileToSwfTool fileToSwfTool = FileToSwfTool.getFileToSwfTool();

	private FileProcessor() {
		baseDao = (BaseDao) SpringCtx.getByBeanName("baseDao");
		this.start();
	}

	public static FileProcessor getFileProcessor() {
		return fileProcessor;
	}
 

	public void run() {

		while (true) {

			try {
				logger.info("  fileQueue size :" + fileDataQueue.size());
				FileData file = fileDataQueue.take();
				logger.info("  process file :"
						+ file.getOrderAttach().getPath() + " start");
				File swfFile = fileToSwfTool.convert(file.getFile());
				updateOrderAttach(swfFile, file.getOrderAttach());
				logger.info("  process file :"
						+ file.getOrderAttach().getPath() + " end");
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
		}
	}

	private void updateOrderAttach(File swfFile, OrderAttach orderAttach)
			  {

		if (orderAttach.getPath() != null) {
			String[] str = orderAttach.getPath().split("/");
			String fileName = str[str.length - 1];
			String swfPath = orderAttach.getPath().replace(fileName,
					swfFile.getName());
			orderAttach.setSwfpath(swfPath);
			baseDao.update(orderAttach);
		}
	}

	public void addToQueue(FileData sourceFile) {
		fileDataQueue.add(sourceFile);
	}

	public static void main(String[] args) throws InterruptedException {
		FileProcessor processor = FileProcessor.getFileProcessor();

	}
}
