package com.core.app.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.junit.BeforeClass;
import org.junit.Test;

import com.core.app.model.SysParam;
import com.core.app.service.SysParamService;
import com.core.factory.SpringCtx;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.web.constant.OrderRunStatus;
import com.web.model.OrderCourse;
import com.web.model.OrderCourseHour;
import com.web.model.OrderInfo;
import com.web.model.OrderRelHis;
import com.web.model.StudentInfo;
import com.web.model.TeacherInfo;

public class BasDaoTest {
	private static BaseDao baseDao;
	private static SysParamService sysParamService;

	@BeforeClass
	public static void init() {
		baseDao = (BaseDao) SpringCtx.getByBeanName("baseDao");
		sysParamService = (SysParamService) SpringCtx
				.getByBeanName("sysParamService");
	}

	// @Test
	public void testQuery() throws DaoException {
		String sql = "select sum(costHour) from  "
				+ OrderCourseHour.class.getName()
				+ " where order_id in  (select id from "
				+ OrderInfo.class.getName()
				+ " a where a.studentId=1 and a.runStatus='"
				+ OrderRunStatus.INLEARN + "')";
		Long hour = baseDao.queryObject(sql, Long.class);
		System.out.print(hour);

	}

	// @Test
	// @Transactional
	public void deleteSQL() throws DaoException {
		baseDao.executeSql("delete from order_course where order_id=666");

	}

	  @Test
	public void testQuery2() throws DaoException {

		/*String sql = "select * from  " + OrderCourse.class.getName()
				+ " where order_id in  (select id from  " + OrderInfo.class.getName()
				+ " a where a.studentId="
				+ 1 + " ) order by id asc";*/
		String sql = "  order_id in  (select id from  " + OrderInfo.class.getName()
				+ " a where a.studentId="
				+ 1 + " ) order by id asc";
		List<OrderCourse> orderCourseList = baseDao.find(sql,
				OrderCourse.class);
		System.out.println(orderCourseList);
	}

	// @Test

	public void testTeacher2() throws DaoException {
		try {
			// SELECT * FROM teacher_info t where not exists
			// (SELECT * FROM order_course_schedule o where ( start_date <=
			// '2012-09-09' and end_date >='2012-09-09' )or
			// ( start_date <= '2012-10-09' and end_date >='2012-10-09' ) and
			// user_id=t.id);
			PageBean list = baseDao.pageQuery("", 10, 0, TeacherInfo.class);
			Object o = list.getResult();

			Object object = list.getResult();
			List list2 = baseDao.find("", TeacherInfo.class);
			System.out.println(1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// @Test
	public void testCache() throws DaoException {
		try {

			List list = baseDao.find("", SysParam.class);
			for (int i = 0; i < 10; i++) {
				list = baseDao.find("", SysParam.class);
				System.out.println("no:" + i);
			}

			System.out.println(1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// @Test
	public void testCache2() throws DaoException {
		try {
			System.out.println(222);
			List list = sysParamService.getSysParam("ORDER_COURSE");
			for (int i = 0; i < 10; i++) {
				list = sysParamService.getSysParam("ORDER_COURSE");
				System.out.println("no:" + i);
			}

			System.out.println(1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//@Test
	public void noObjectSql() throws SQLException, DaoException {
		BaseDao baseDao = (BaseDao) SpringCtx.getByBeanName("baseDao");
		Connection connection = baseDao.getConnection();
		String sql = "select * from order_info_daily";
		ResultSet rs = connection.createStatement().executeQuery(sql);
		while(rs.next()){
			System.out.println(rs.getDate("create_date"));
		}
		List list = baseDao.noMappedObjectQuery(sql);
		System.out.println(0);
	}
}
