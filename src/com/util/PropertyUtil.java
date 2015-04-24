package com.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

/**
 * 类/接口注释
 * 
 * @author tanson lam
 * @createDate 2014年9月11日
 * 
 */
public class PropertyUtil {
	private static Properties prop;
	static {
		try {

			String propFile = PropertyUtil.class.getResource(
					"/config/properties/system.properties").getFile();
			prop = new Properties();// 属性集合对象
			FileInputStream fis = new FileInputStream(propFile);// 属性文件流
			prop.load(fis);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getProperty(String key) {
		return prop.getProperty(key);
	}
}
