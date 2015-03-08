/**
 * 
 */
package com.core.app.constant;

/**
 * 
 * 
 * @author tanson lam
 * @creation 2015年3月8日
 */
public enum SysRelRight {
	MENU(0), AREA(1);
	private int value;
	SysRelRight(int value) {
		this.value = value;
	}
	public int getValue() {
		return value;
	}

	public static SysRelRight fromValue(int value) {
		for (SysRelRight t : SysRelRight.values()) {
			if (t.getValue() == value)
				return t;
		}
		throw new IllegalArgumentException(
				"can not find match SysRelRight for value[" + value + "]");
	}
}
