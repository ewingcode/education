package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.app.model.SysUser;
import com.core.app.service.SysUserService;
import com.core.jdbc.BaseDao;
import com.core.jdbc.util.PageBean;
import com.util.SqlUtil;
import com.web.model.OrderTrace;
import com.web.model.TeacherAbility;
import com.web.model.TeacherInfo;
import com.web.model.TeacherRefStudent;

@Repository("teacherService")
public class TeacherService {
	@Resource
	private BaseDao baseDao;
	@Resource
	private SysUserService sysUserService;

	@Transactional(rollbackFor = Exception.class)
	public void addNewTeacher(SysUser sysUser, TeacherAbility teacherAbility) {
		baseDao.save(sysUser);
		int userId = sysUser.getId();
		teacherAbility.setUserId(userId);
		baseDao.save(teacherAbility);
	}

	@Transactional(rollbackFor = Exception.class)
	public void deleteTeacher(Integer teacherId) {
		SysUser sysUser = sysUserService.findOne(teacherId);
		if (sysUser != null) {
			List<TeacherAbility> list = baseDao.find(
					"user_id=" + sysUser.getId(), TeacherAbility.class);
			if (!list.isEmpty()) {
				baseDao.delete(list.get(0));
			}
			baseDao.delete(sysUser);
		}

	}

	@Transactional(rollbackFor = Exception.class)
	public void editTeacher(SysUser sysUser, TeacherAbility teacherAbility) {
		baseDao.update(sysUser);
		int userId = sysUser.getId();
		List<TeacherAbility> list = baseDao.find("user_id=" + userId,
				TeacherAbility.class);
		if (!list.isEmpty()) {
			TeacherAbility old = list.get(0);
			old.setCourseType(teacherAbility.getCourseType());
			old.setGradeType(teacherAbility.getGradeType());
			old.setTeacherType(teacherAbility.getTeacherType());
			baseDao.update(old);
		}
	}

	/**
	 * 查询班主任负责的老师
	 * 
	 * @param userId
	 * @return @
	 */
	public PageBean findTeacherForMainTeacher(String conditon, String orderBy,
			int userId, int pageSize, int startIndex) {
		String sql = " from " + TeacherInfo.class.getName()
				+ " where id in ( select t.teacherId from "
				+ TeacherRefStudent.class.getName() + " t,"
				+ OrderTrace.class.getName()
				+ " o where t.orderId = o.orderId and o.userId =" + userId
				+ ") ";
		sql = SqlUtil.combine(sql, conditon);
		return baseDao.pageQuery(sql, orderBy, pageSize, startIndex,
				TeacherInfo.class);
	}

}
