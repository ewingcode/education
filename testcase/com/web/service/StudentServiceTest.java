package com.web.service;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.jbpm.BaseTest;
import com.core.factory.SpringCtx;

public class StudentServiceTest extends BaseTest {
	private static StudentService studentService;

	@BeforeClass
	public static void init() {
		studentService = (StudentService) SpringCtx
				.getByBeanName("studentService");
	}

}