package test.com.core.jdbc.vo;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
@Transactional 
public interface MyUserDAO {
	public void createMyUser(MyUser myUser);

	public void deleteMyUser(MyUser myUser);

	public void updateMyUser(MyUser myUser);

	public List<MyUser> queryMyUser(String queryString);

	public List<MyUser> queryAll();

}
