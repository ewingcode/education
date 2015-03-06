package com.core.app.jbpm;

import com.core.factory.SpringCtx;
import com.core.jbpm.JbpmTemplate;

public class BaseTest {

	 
	protected static JbpmTemplate jbpmTemplate; 
	
	static{
		try {
			jbpmTemplate =  (JbpmTemplate)SpringCtx.getByBeanName("jbpmTemplate");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}
}
