package com.core.app.jbpm;

import org.jbpm.api.ProcessInstance;
import org.jbpm.api.task.Task;
import org.junit.Test;
public class LeaveTest extends BaseTest {

	/**
	 * 第一步
	 */
	// @Test 
	public void testDeploy(){
		try {
			String resourceName="com/core/jbpm/jpdl/leave.jpdl.xml";
			jbpmTemplate.Deploy(resourceName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 第一步
	 */
	 @Test 
	public void testOrderDeploy(){
		try {
			String resourceName="com/core/jbpm/jpdl/order.jpdl.xml";
			jbpmTemplate.Deploy(resourceName);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	 
	//@Test 
	public void testStart(){
		try {
			ProcessInstance processInstance = jbpmTemplate.addProcessInstance("order", null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//@Test 
	public void testTask1(){
		try {
			Task task = jbpmTemplate.getTask("270001");
			System.out.println(task.getId());
			jbpmTemplate.completeTask(task.getId());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
