package com.web.service;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.jbpm.BaseTest;
import com.core.app.model.SysUser;
import com.core.factory.SpringCtx;
import com.core.jdbc.BaseDao;
import com.web.model.OrderInfo;
import com.web.model.TeacherAbility;
import com.web.model.TeacherInfo;

public class TeacherServiceTest extends BaseTest {
	private static TeacherService teacherService;
	private static BaseDao baseDao;

	@BeforeClass
	public static void init() {
		teacherService = (TeacherService) SpringCtx
				.getByBeanName("teacherService");
		baseDao = (BaseDao) SpringCtx.getByBeanName("baseDao");
	}

	// @Test
	public void testAddTeacher() throws InterruptedException {
		while (true) {
			// baseDao.executeSql("select * from order_info");
			baseDao.executeSql("select * from order_info");
			TimeUnit.SECONDS.sleep(1);
		}
		/*
		 * baseDao.noMappedObjectQuery("select * from order_info");
		 * 
		 * SysUser sysUser = new SysUser(); sysUser.setUserName("test111");
		 * sysUser.setPassword("111"); sysUser.setAreaId(1); TeacherAbility
		 * teacherAbility = new TeacherAbility();
		 * teacherAbility.setCourseType("1"); teacherAbility.setGradeType("1");
		 * teacherAbility.setTeacherType("1");
		 * teacherService.addNewTeacher(sysUser, teacherAbility);
		 */
	}

	@Test
	public void queryTeacherAbility() {
		List<TeacherInfo> list = baseDao
				.noMappedObjectQuery("SELECT * FROM teacher_info WHERE FIND_IN_SET('5',grade_type)");
		System.out.println(list.size());
	}
}
