package com.core.jbpm;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.core.jbpm.model.FlowTask;
import com.core.jbpm.model.FlowTaskTransition;
import com.core.jdbc.BaseDao;
import com.core.jdbc.DaoException;

/**
 * 流程任务定义服务类
 * 
 */
@Repository("flowTaskService")
public class FlowTaskService {
	@Resource
	private BaseDao baseDao;

	/**
	 * 获取流程中所有任务
	 * 
	 * @param processName
	 * @return
	 * @ 
	 */
	public List<FlowTask> queryAllFlow(String processName)   {
		return baseDao.find("process_name='" + processName + "'",
				FlowTask.class);
	}

	/**
	 * 获取流程定义的任务设置
	 * 
	 * @param processName
	 * @return
	 * @ 
	 */
	public FlowTask getTask(String processName, int taskId)   {
		List<FlowTask> list = baseDao.find("process_name='" + processName
				+ "' and id=" + taskId, FlowTask.class);
		if (list.isEmpty())
			return null;
		return list.get(0);
	}

	/**
	 * 获取流程定义的任务设置
	 * 
	 * @param processName
	 * @return
	 * @ 
	 */
	public FlowTask getTask(String processName, String taskName)
			  {
		List<FlowTask> list = baseDao.find("process_name='" + processName
				+ "' and task_name='" + taskName + "'", FlowTask.class);
		if (list.isEmpty())
			return null;
		return list.get(0);
	}

	/**
	 * 获取流程定义的任务设置
	 * 
	 * @param processName
	 * @return
	 * @ 
	 */
	public FlowTask getStartTask(String processName)   {
		List<FlowTask> list = baseDao.find(" id = (select min(id) from "
				+ FlowTask.class.getName() + " a where a.processName='"
				+ processName + "')", FlowTask.class);
		if (list.isEmpty())
			return null;
		return list.get(0);
	}

	/**
	 * 获取流程任务的执行转变设置
	 * 
	 * @param processName
	 * @param taskName
	 * @return
	 * @ 
	 */
	public List<FlowTaskTransition> getTaskTransition(String processName,
			int taskId)   {
		FlowTask flowTask = getTask(processName, taskId);
		if (flowTask == null)
			return null;
		List<FlowTaskTransition> transList = baseDao.find("task_id=" + taskId,
				FlowTaskTransition.class);
		return transList;
	}

	/**
	 * 获取流程任务的执行转变设置
	 * 
	 * @param processName
	 * @param taskName
	 * @return
	 * @ 
	 */
	public List<FlowTaskTransition> getTaskTransition(String processName,
			String taskName)   {
		FlowTask flowTask = getTask(processName, taskName);
		if (flowTask == null)
			return null;
		List<FlowTaskTransition> transList = baseDao.find("task_id="
				+ flowTask.getId(), FlowTaskTransition.class);
		return transList;
	}

	public FlowTaskTransition getTaskTransition(String processName, int taskId,
			String transitionName)   {
		FlowTask flowTask = getTask(processName, taskId);
		if (flowTask == null)
			return null;
		List<FlowTaskTransition> transList = baseDao.find("task_id=" + taskId
				+ " and name='" + transitionName + "'",
				FlowTaskTransition.class);
		if (transList.isEmpty())
			return null;
		return transList.get(0);
	}

	public FlowTask getTask(String processName, int taskId,
			String transitionName)   {
		FlowTaskTransition flowTaskTransition = this.getTaskTransition(
				processName, taskId, transitionName);
		return getTask(processName, flowTaskTransition.getToId());
	}

	public FlowTask getTask(String processName, String taskName,
			String transitionName)   {
		FlowTask curTask = this.getTask(processName, taskName);
		FlowTaskTransition flowTaskTransition = this.getTaskTransition(
				processName, curTask.getId(), transitionName);
		return getTask(processName, flowTaskTransition.getToId());
	}

}
