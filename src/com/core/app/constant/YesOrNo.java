package com.core.app.constant;

/**
 * 
 * 
 */
public enum YesOrNo {
	NO("0"), YES("1");
	private String type;

	private YesOrNo(String type) {
		this.type = type;
	}

	public String getValue() {
		return type;
	}

}
