Ext.ns("Public");

/**
 * 相反按钮
 * 
 * @param obj
 * @param other
 * @return
 */
Public.toggleClick = function(obj, other) {

	if (obj.attr("disabled") == 'disabled' || obj.attr("disabled") == 'true') {

		obj.attr("disabled", false);
		obj.attr("disabled", false);
		other.attr("disabled", true);
		other.attr("disabled", true);
	} else {
		obj.attr("disabled", true);
		obj.attr("disabled", true);
		other.attr("disabled", false);
		other.attr("disabled", false);
	}

}

/**
 * 隐藏属性
 * 
 * @param fieldName
 * @param needValidate
 *            是否需要修改验证
 * @return
 */
Public.hideField = function(fieldName, needValidate) {
	Ext.getCmp(fieldName).setValue("");
	Ext.getCmp(fieldName).hide();
	Ext.getCmp(fieldName).allowBlank = true;
}

/**
 * 隐藏属性
 * 
 * @param fieldName
 * @param needValidate
 *            是否需要修改验证
 * @return
 */
Public.showField = function(fieldName, needValidate) {
	Ext.getCmp(fieldName).show();
	Ext.getCmp(fieldName).allowBlank = false;
}

/**
 * 获取多个checkbox选中的值
 * 
 * @return "xxx,xxxx,xxx"
 */
Public.getCheckList = function(fieldId) {
	var checkList = Ext.getCmp(fieldId).getValue();
	var check = '';

	for (i = 0; i < checkList.length; i++) {
		check += checkList[i].inputValue;
		if (i < checkList.length - 1)
			check += ",";
	}
	return check;
}