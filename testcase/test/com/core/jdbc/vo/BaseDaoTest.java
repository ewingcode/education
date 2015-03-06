package test.com.core.jdbc.vo;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.model.SysUser;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;
import com.core.jdbc.util.PageBean;
import com.core.json.JsonUtil;
import com.web.model.TeacherRefStudent;

public class BaseDaoTest {
	@Resource
	public static BaseDao baseDao;
	private Class entityClass = SysUser.class;

	@BeforeClass
	public static void before() {
		ApplicationContext ctx = new ClassPathXmlApplicationContext(
				"config/spring/applicationContext.xml");
		baseDao = (BaseDao) ctx.getBean("baseDao");
	}

	 @Test
	public void query() throws DaoException {
		List list = baseDao.find("student_id is not null", TeacherRefStudent.class);
		Assert.assertNotNull(list);
	}

//	@Test
	public void findPage() {
		String sql = "userName='tanson'";
		PageBean pageBean = baseDao.pageQuery(sql, 2, 0, entityClass);
		String json = JsonUtil.tranBean2String(pageBean).toString();
		System.out.println(json);
		ResponseData responseData = ResponseUtils.success("查询成功！");
		responseData.setTotalProperty(pageBean.getTotalCount());
		responseData.setResult(pageBean.getResult());
		json = JsonUtil.tranBean2String(responseData).toString();
		System.out.println(json);
		Assert.assertNotNull(pageBean);
	}
	
 //   @Test 
	public void save() throws DaoException {
		SysUser sysUser= new SysUser();
		sysUser.setAddr("111");
		sysUser.setUserName("2121");
		sysUser.setPassword("111");
		sysUser.setUserName("tanson1");
		sysUser.setIseff("0");
		sysUser.setPhone("212112");
		sysUser.setLastUpdate(new java.sql.Timestamp((new java.util.Date()).getTime()));
		sysUser.setCreateTime(new java.sql.Timestamp((new java.util.Date()).getTime()));
		baseDao.save(sysUser);
		Assert.assertNotNull(sysUser.getId());
	}
  //  @Test 
	public void delete() throws DaoException {
		SysUser sysUser= new SysUser();
		sysUser.setId(2); 
		baseDao.delete(sysUser);
	}
}
