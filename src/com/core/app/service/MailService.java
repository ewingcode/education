package com.core.app.service;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.log4j.Logger;

import com.util.PropertyUtil;

public class MailService {
	private static Logger logger = Logger.getLogger(MailService.class);

	private final static String MAIL_HOST = PropertyUtil
			.getProperty("mail.smtp.host");
	private final static String MAIL_SMTP_USER = PropertyUtil
			.getProperty("mail.smtp.user");
	private final static String MAIL_USER_PASS = PropertyUtil
			.getProperty("mail.smtp.pass");
	private final static String MAIL_DEBUG_RECEIVER = PropertyUtil
			.getProperty("mail.smtp.debugreceiver");
	private static final ExecutorService postExecutor = Executors
			.newFixedThreadPool(10);
	public static final String MAIL_TITLE = "华实培训系统通知";

	/**
	 * 发送email
	 * 
	 * @param toMail
	 *            收件人email地址
	 * @param subject
	 *            主题
	 * @param msg
	 *            内容
	 * @return 
	 */
	public static Boolean asyncSendMail(final String toMail,
			final String subject, final String msg)   {
		postExecutor.execute(new Runnable() {
			@Override
			public void run() {
				try {
					HtmlEmail email = new HtmlEmail();
					email.setHostName(MAIL_HOST);
					DefaultAuthenticator defaultAuthenticator = new DefaultAuthenticator(
							MAIL_SMTP_USER, MAIL_USER_PASS);
					email.setAuthenticator(defaultAuthenticator);
					email.setCharset("UTF-8");
					email.setFrom(MAIL_SMTP_USER);
					if (MAIL_DEBUG_RECEIVER != null)
						email.addTo(MAIL_DEBUG_RECEIVER);
					else
						email.addTo(toMail);
					email.setSubject(subject);
					email.setHtmlMsg(msg);
					email.send();
				} catch (EmailException e) {
					logger.error(e.getMessage(), e);
				}
			}

		});

		return true;
	}

}
