package com.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.constant.IsEff;
import com.core.app.service.SysParamService;
import com.core.app.service.SysRightRelService;
import com.util.DateFormat;
import com.web.bean.CourseScheduleDto;
import com.web.model.CoursePeriod;
import com.web.model.CourseSchedule;
import com.web.model.CourseScheduleView;
import com.web.service.CoursePeriodService;
import com.web.service.CourseScheduleService;
import com.web.service.TeacherService;

/**
 * 排課設置管理
 * 
 * @author tanson lam
 * @creation 2015年4月2日
 */
public class CourseScheduleManageAction extends BaseAction {
	private static Logger logger = Logger.getLogger(BaseAction.class);
	@Resource
	private TeacherService teacherService;
	@Resource
	private SysRightRelService sysRightRelService;
	@Resource
	private CoursePeriodService coursePeriodService;
	@Resource
	private CourseScheduleService courseScheduleService;
	@Resource
	private SysParamService sysParamService;

	public CourseScheduleManageAction() {
		super(CourseSchedule.class);
	}

	@Override
	public void save() throws ActionException {
		ResponseData responseData = null;
		try {
			CourseSchedule courseSchedule = new CourseSchedule();
			super.buildPageData(courseSchedule);
			Integer coursePeriod = Integer.valueOf(request
					.getParameter("coursePeriod"));
			List<CoursePeriod> periodList = coursePeriodService
					.getCoursePeriod();
			for (CoursePeriod periodEntity : periodList) {
				if (periodEntity.getId().equals(coursePeriod)) {
					courseSchedule.setStartTime(periodEntity.getStartTime());
					courseSchedule.setEndTime(periodEntity.getEndTime());
					break;
				}
			}

			courseScheduleService.addSchedule(courseSchedule.getTeacherId(),
					courseSchedule.getStudentId(), courseSchedule.getDate(),
					courseSchedule.getCourseType(),
					courseSchedule.getStartTime(), courseSchedule.getEndTime());
			responseData = ResponseUtils.success("新增成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("新增失败！" + e.getMessage());
		}
		this.outResult(responseData);
	}

	/**
	 * 显示整日的课程安排
	 * 
	 * @throws ActionException
	 */
	public void listDailySchedule() throws ActionException {
		ResponseData responseData = null;
		try {
			if (entityBean == null)
				throw new ActionException(
						"entityClass must be defined in Action");
			List<CourseScheduleDto> dtoList = new ArrayList<CourseScheduleDto>();
			List<CourseScheduleView> scheudleList = baseModelService.find(
					bulidConditionSql() + bulidOrderBySql(),
					CourseScheduleView.class);
			for (CourseScheduleView scheduleEntity : scheudleList) {
				CourseScheduleDto dto = new CourseScheduleDto();
				dtoList.add(dto);
				dto.setCourseType(scheduleEntity.getCourseType());
				dto.setCreateTime(scheduleEntity.getCreateTime());
				dto.setDate(scheduleEntity.getDate());
				dto.setEndTime(DateFormat.cutTime(scheduleEntity.getEndTime()));
				dto.setId(scheduleEntity.getId());
				dto.setIseff(scheduleEntity.getIseff());
				dto.setLastUpdate(scheduleEntity.getLastUpdate());
				dto.setStartTime(DateFormat.cutTime(scheduleEntity
						.getStartTime()));
				dto.setStudentId(scheduleEntity.getStudentId());
				dto.setTeacherId(scheduleEntity.getTeacherId());
				dto.setStudentName(scheduleEntity.getStudentName());
				dto.setTeacherName(scheduleEntity.getTeacherName());
				dto.setCourseName(scheduleEntity.getCourseName());
			}
			responseData = ResponseUtils.success("查询成功！");
			responseData.setTotalProperty(dtoList.size());
			responseData.setResult(dtoList);
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("查询失败！");
		}
		this.outResult(responseData);
	}

}
