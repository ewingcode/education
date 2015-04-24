package com.core.app.service;

import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.apache.axis.utils.StringUtils;
import org.springframework.stereotype.Repository;

import com.core.app.model.SysUser;
import com.core.jdbc.BaseDao;

/**
 * 系统用户
 * 
 */
@Repository("sysUserService")
public class SysUserService {
	@Resource
	public BaseDao baseDao;

	/**
	 * 查找系统用户
	 * 
	 * @param userName
	 * @return @
	 */
	public List<SysUser> findUser(String userName) {
		if (StringUtils.isEmpty(userName))
			throw new IllegalArgumentException("userName should not be null");
		return baseDao.find(" user_name='" + userName + "'", SysUser.class);
	}

	public List<SysUser> findUserByRole(int roleId) {
		return baseDao.find(" role_id=" + roleId, SysUser.class);
	}

	public List<SysUser> findUserByDepartment(int depId) {
		return baseDao.find(" dep_id=" + depId, SysUser.class);
	}

	public List<SysUser> findAllUser() {
		return baseDao.find("", SysUser.class);
	}

	public SysUser findOne(Integer userId) {
		if (userId == 0)
			throw new IllegalArgumentException("userId should not be null");
		return baseDao.findOne(userId, SysUser.class);
	}
	/**
	 * 重置密码
	 * @param userId
	 * @return
	 */
	public Boolean resetPwd(Integer userId) {
		Random r = new Random();
		Integer newPwd = r.nextInt(1000000);
		SysUser sysUser = findOne(userId);
		sysUser.setPassword(String.valueOf(newPwd));
		baseDao.save(sysUser);
		if (!StringUtils.isEmpty(sysUser.getEmail()))
			MailService.asyncSendMail(sysUser.getEmail(),
					MailService.MAIL_TITLE, "你的登陆密码已经重置,新密码:" + newPwd);
		return true;
	}

	public static void main(String[] args) {
		Random r = new Random();
		for (int i = 0; i < 10; i++) {
			System.out.println(r.nextInt(1000000));
		}

	}
}
