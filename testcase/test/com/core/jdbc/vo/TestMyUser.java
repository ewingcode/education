package test.com.core.jdbc.vo;

import javax.annotation.Resource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

@Service("userService")
public class TestMyUser {
	// @Resource
	// MyUserDAO myUserDAO;

	public void createUser() {
		ApplicationContext ctx = new ClassPathXmlApplicationContext(
				"config/spring/jpa-spring.xml");
		MyUserDAO myUserDAO = (MyUserDAO) ctx.getBean("myUserDAO");
		MyUser myUser = new MyUser();
		myUser.setUserName("JohnXa2");
		myUserDAO.createMyUser(myUser);
	}

	public static void main(String[] args) {
		try {

			TestMyUser vv = new TestMyUser();
			vv.createUser();

			// ApplicationContext ctx = new ClassPathXmlApplicationContext(
			// "config/spring/jpa-spring.xml");
			// MyUserDAO myUserDAO = (MyUserDAO) ctx.getBean("userDao");
			// MyUserDAO myUserDAO = new MyUserDAOImpl();
			// TestMyUser vv = new TestMyUser();
			// MyUser myUser = new MyUser();
			// myUser.setId(2);
			// myUser.setUserName("JohnXa2");
			// myUser.setPassword("123456");
			// myUser.setGender("男");
			// myUser.setAge(new Integer(25));
			// myUser.setAddr("New York");
			// myUser.setEmail("john@hotmail.com");
			// vv.myUserDAO.createMyUser(myUser);
			// myUserDAO.deleteMyUser(myUser);
			// List<MyUser> list = myUserDAO.queryAll();
			// for (MyUser user : list) {
			// myUserDAO.deleteMyUser(user);
			// System.out.println(user.getUserName());
			// }
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}