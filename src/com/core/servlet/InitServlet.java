package com.core.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.core.factory.SysParamFactory;
import com.core.tool.fileshow.FileServer;
import com.core.tool.trace.SysLogTraceThread;

public class InitServlet extends HttpServlet {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(InitServlet.class);

	public void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public void destroy() {
		super.destroy();
	}

	public void init() throws ServletException {
		try {
			SysParamFactory.WEB_REAL_PATH = super.getServletContext()
					.getRealPath("/"); 
			new FileServer().start(); 
			logger.info("init successfully");
		} catch (Exception e) {
			logger.error(e, e);
		}
	}
}