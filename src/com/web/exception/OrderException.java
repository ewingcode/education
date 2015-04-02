package com.web.exception;

public class OrderException extends Exception {

	private static final long serialVersionUID = 1L;

	public OrderException() {
		super();
	}

	public OrderException(String message) {
		super(message);
	}

	public OrderException(String message, Throwable cause) {
		super(message, cause);
	}

	public OrderException(Throwable cause) {
		super(cause);
	}
}
