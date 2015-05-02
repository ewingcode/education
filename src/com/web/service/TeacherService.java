package com.web.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.core.app.model.SysUser;
import com.core.app.service.SysUserService;
import com.core.jdbc.BaseDao;
import com.web.model.TeacherAbility;

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

}
