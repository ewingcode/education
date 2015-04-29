package com.util;

import java.util.List;

import antlr.StringUtils;

/**
 * Sql工具类
 */
public class SqlUtil {

	/**
	 * 字符数组转成in查询条件
	 * 
	 * @param array
	 * @return
	 */
	public static <T> String array2InCondition(List<T> array) {
		StringBuffer sb = new StringBuffer();
		for (T str : array) {
			sb.append("'").append(str).append("'").append(",");
		}
		return sb.length() == 0 ? "" : sb.substring(0, sb.length() - 1)
				.toString();
	}
	/**
	 * 字符数组转成in查询条件
	 * 
	 * @param array
	 * @return
	 */
	public static String array2InCondition(String[] array) {
		StringBuffer sb = new StringBuffer();
		for (String str : array) {
			sb.append("'").append(str).append("'").append(",");
		}
		return sb.length() == 0 ? "" : sb.substring(0, sb.length() - 1)
				.toString();
	}
	/**
	 * 整形数组转成in查询条件
	 * 
	 * @param array
	 * @return
	 */
	public static String array2InCondition(Integer[] array) {
		StringBuffer sb = new StringBuffer();
		for (Integer str : array) {
			sb.append(str).append(",");
		}
		return sb.length() == 0 ? "" : sb.substring(0, sb.length() - 1)
				.toString();
	}

	/**
	 * 合并sql
	 * 
	 * @param sql1
	 * @param sql2
	 * @return
	 */
	public static String combine(String sql1, String sql2) {
		StringBuffer sql = new StringBuffer();
		if(StringUtil.isEmpty(sql1))
			return sql2;
		if(StringUtil.isEmpty(sql2))
			return sql1;
		if (!(sql1.trim().endsWith("and") || sql1.trim().endsWith("AND"))
				&& !(sql2.trim().startsWith("and") || sql2.trim().startsWith(
						"AND"))) {
			sql.append(sql1).append(" AND ").append(sql2);
		}

		return sql.toString();
	}
}
