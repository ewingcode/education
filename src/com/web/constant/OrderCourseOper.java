package com.web.constant;

/**
 * 课程操作
 * 
 */
public enum OrderCourseOper {
	CHARGER("0"), // 选择负责人
	APPLY("1"); // 审批
	private String oper;

	private OrderCourseOper(String oper) {
		this.oper = oper;
	}
	public String getValue(){
		 return oper;
	}
	public static OrderCourseOper getOrderCourseOper(String oper) { 
		for(OrderCourseOper courseOper : OrderCourseOper.values()){
			if(courseOper.getValue().equals(oper))
				return courseOper;
		}
		return null;
	}
	public static void main(String[] args) {
		System.out.println(OrderCourseOper.APPLY.getValue());
		OrderCourseOper  orderCourseOper = getOrderCourseOper("1");
		System.out.println(orderCourseOper);
	}
}
