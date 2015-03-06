package com.core.tool.fileshow;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

import org.apache.log4j.Logger;

public class FileServer extends Thread {

	private static Logger logger = Logger.getLogger(FileServer.class);
	final static String BATFILE = PdfToSwf.class.getResource("/").getPath()
			.toString()
			+ "FileServer.bat";
	private static Socket socket;

	public void run() {
		try {
			startServer();
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (InterruptedException e) {
			logger.error(e.getMessage(), e);
		}
	}

	void startServer() throws IOException, InterruptedException {
		logger.info("start:");
		if (isStarted())
			return;
		String command = BATFILE;
		logger.info("command:" + command);
		Process pro = Runtime.getRuntime().exec(command);
		BufferedReader bufferedReader = new BufferedReader(
				new InputStreamReader(pro.getInputStream()));
		while (bufferedReader.readLine() != null) {
			String text = bufferedReader.readLine();
			logger.info(text);
		}

	}

	boolean isStarted() {
		try {
			if (socket == null)
				socket = new Socket("127.0.0.1", 8100);
			if (socket.isClosed())
				return false;
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public static void main(String[] args) throws IOException,
			InterruptedException {
		new FileServer().start();
	}
}
