package com.core.tool.fileshow;

import java.io.File;

import com.web.model.OrderAttach;

public class FileData {
	private File file;

	private OrderAttach orderAttach;

	public FileData(File file, OrderAttach orderAttach) {
		super();
		this.file = file;
		this.orderAttach = orderAttach;
	}

	public File getFile() {
		return file;
	}

	public OrderAttach getOrderAttach() {
		return orderAttach;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public void setOrderAttach(OrderAttach orderAttach) {
		this.orderAttach = orderAttach;
	}
}
